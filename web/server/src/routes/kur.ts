import type { FastifyInstance } from 'fastify';
import { XMLParser } from 'fast-xml-parser';
import { z } from 'zod';
import { requireAuth } from '../auth.js';
import { config } from '../config.js';
import { exec, one, q } from '../db.js';
import { HttpError, idParam, parse, zs } from '../lib/http.js';
import { todayLocal } from '../rules/dates.js';
import { T } from '../tables.js';

/** Currency names as stored in the Kur table by the original program. */
const KUR_CODES = { STERLIN: 'GBP', EURO: 'EUR', DOLLAR: 'USD' } as const;
type KurName = keyof typeof KUR_CODES;

async function upsertKur(tarih: string, parabirimi: string, alis: number, satis: number) {
  const ex = await one(`SELECT id FROM ${T.kur} WHERE tarih = ? AND parabirimi = ?`, [tarih, parabirimi]);
  if (ex) await exec(`UPDATE ${T.kur} SET alis = ?, satis = ? WHERE id = ?`, [alis, satis, ex.id]);
  else await exec(`INSERT INTO ${T.kur} (tarih, parabirimi, alis, satis) VALUES (?, ?, ?, ?)`, [tarih, parabirimi, alis, satis]);
}

/** Parse the KKTC Merkez Bankası daily XML (format of gunluk.xml in the repository). */
export function parseKktcXml(xml: string) {
  const doc = new XMLParser({ parseTagValue: false }).parse(xml);
  const list = doc?.KKTCMB_Doviz_Kurlari?.Resmi_Kurlar?.Resmi_Kur;
  const arr: any[] = Array.isArray(list) ? list : list ? [list] : [];
  const out: Partial<Record<KurName, { alis: number; satis: number }>> = {};
  for (const [name, code] of Object.entries(KUR_CODES) as [KurName, string][]) {
    const r = arr.find((x) => String(x.Sembol).trim() === code);
    if (r) out[name] = { alis: Number(String(r.Doviz_Alis).replace(',', '.')), satis: Number(String(r.Doviz_Satis).replace(',', '.')) };
  }
  return { date: String(doc?.KKTCMB_Doviz_Kurlari?.Kur_Tarihi ?? ''), rates: out };
}

export async function kurRoutes(app: FastifyInstance) {
  const read = { preHandler: requireAuth() };
  const write = { preHandler: requireAuth() };

  app.get('/api/kur', read, async (req) => {
    const f = req.query as Record<string, string | undefined>;
    const where: string[] = [];
    const params: unknown[] = [];
    if (f.from) { where.push('tarih >= ?'); params.push(f.from); }
    if (f.to) { where.push('tarih <= ?'); params.push(f.to); }
    return q(
      `SELECT id, tarih, parabirimi, alis, satis FROM ${T.kur} ${where.length ? 'WHERE ' + where.join(' AND ') : ''}
       ORDER BY tarih DESC, parabirimi LIMIT 500`,
      params,
    );
  });

  app.get('/api/kur/latest', read, async () =>
    q(
      `SELECT k.parabirimi, k.alis, k.satis, k.tarih FROM ${T.kur} k
       JOIN (SELECT parabirimi, MAX(tarih) AS t FROM ${T.kur} GROUP BY parabirimi) m ON m.parabirimi = k.parabirimi AND m.t = k.tarih`,
    ),
  );

  app.post('/api/kur', write, async (req) => {
    const d = parse(
      z.object({
        tarih: zs.date(),
        parabirimi: z.enum(['STERLIN', 'EURO', 'DOLLAR']),
        alis: z.coerce.number().positive(),
        satis: z.coerce.number().positive(),
      }),
      req.body,
    );
    await upsertKur(d.tarih, d.parabirimi, d.alis, d.satis);
    return { ok: true };
  });

  app.delete('/api/kur/:id', { preHandler: requireAuth('admin') }, async (req) => {
    const { id } = parse(idParam, req.params);
    await exec(`DELETE FROM ${T.kur} WHERE id = ?`, [id]);
    return { ok: true };
  });

  /** Download today's rates from the central bank and store them for today (menu "Döviz" button). */
  app.post('/api/kur/fetch', write, async () => {
    let xml: string;
    try {
      const res = await fetch(config.kurXmlUrl, { signal: AbortSignal.timeout(15000) });
      if (!res.ok) throw new Error(`HTTP ${res.status}`);
      xml = await res.text();
    } catch (e) {
      throw new HttpError(502, `Can not reach the currency information (${(e as Error).message})`);
    }
    const parsed = parseKktcXml(xml);
    const today = todayLocal();
    for (const [name, v] of Object.entries(parsed.rates)) {
      if (v && v.alis > 0 && v.satis > 0) await upsertKur(today, name, v.alis, v.satis);
    }
    return { bankDate: parsed.date, saved: today, rates: parsed.rates };
  });
}
