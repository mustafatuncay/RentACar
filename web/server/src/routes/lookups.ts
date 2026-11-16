import type { FastifyInstance } from 'fastify';
import { z } from 'zod';
import { requireAuth, type Permission } from '../auth.js';
import { exec, one, q, tx } from '../db.js';
import { conflict, idParam, notFound, parse } from '../lib/http.js';
import { T } from '../tables.js';

/**
 * Simple name lists: agencies (UntAgency), companies (UntCompany) and the fixed
 * pick-up / drop-off places (UntSabitDegerler: kriterno 0 = Car Deliver, 1 = Car Collect).
 */
export async function lookupRoutes(app: FastifyInstance) {
  const read = { preHandler: requireAuth() };
  const nameBody = z.object({ name: z.string().trim().min(1, 'required').max(150) });

  const lists: { path: string; table: string; col: string; perm: Permission; cascade: [string, string][] }[] = [
    { path: 'agencies', table: T.agency, col: 'AgencyName', perm: 'agency',
      cascade: [[T.reservation, 'Agency'], [T.transfer, 'AgencyName']] },
    { path: 'companies', table: T.company, col: 'CompanyName', perm: 'admin',
      cascade: [[T.reservation, 'Company']] },
  ];

  for (const l of lists) {
    const write = { preHandler: requireAuth(l.perm) };

    app.get(`/api/${l.path}`, read, async () => q(`SELECT id, ${l.col} AS name FROM ${l.table} ORDER BY ${l.col}`));

    app.post(`/api/${l.path}`, write, async (req) => {
      const { name } = parse(nameBody, req.body);
      if (await one(`SELECT id FROM ${l.table} WHERE ${l.col} = ?`, [name])) throw conflict('This name already exists');
      const r = await exec(`INSERT INTO ${l.table} (${l.col}) VALUES (?)`, [name]);
      return { id: r.insertId };
    });

    app.put(`/api/${l.path}/:id`, write, async (req) => {
      const { id } = parse(idParam, req.params);
      const { name } = parse(nameBody, req.body);
      return tx(async (c) => {
        const old = await one(`SELECT ${l.col} AS name FROM ${l.table} WHERE id = ?`, [id], c);
        if (!old) throw notFound();
        if (await one(`SELECT id FROM ${l.table} WHERE id <> ? AND ${l.col} = ?`, [id, name], c)) throw conflict('This name already exists');
        await exec(`UPDATE ${l.table} SET ${l.col} = ? WHERE id = ?`, [name, id], c);
        // The name is stored as text on reservations/transfers: rename it there too (as UntAgency did).
        for (const [table, col] of l.cascade) await exec(`UPDATE ${table} SET ${col} = ? WHERE ${col} = ?`, [name, old.name], c);
        return { id };
      });
    });

    app.delete(`/api/${l.path}/:id`, write, async (req) => {
      const { id } = parse(idParam, req.params);
      const res = await exec(`DELETE FROM ${l.table} WHERE id = ?`, [id]);
      if (!res.affectedRows) throw notFound();
      return { ok: true };
    });
  }

  // ---- fixed places ----
  const adminWrite = { preHandler: requireAuth('admin') };
  app.get('/api/places', read, async () =>
    q(`SELECT id, kriterno, kriter, aciklama FROM ${T.sabitDegerler} ORDER BY kriterno, aciklama`),
  );
  app.post('/api/places', adminWrite, async (req) => {
    const d = parse(z.object({ kriterno: z.coerce.number().int().min(0).max(1), aciklama: z.string().trim().min(1).max(150) }), req.body);
    const kriter = d.kriterno === 0 ? 'Car Deliver' : 'Car Collect';
    const r = await exec(`INSERT INTO ${T.sabitDegerler} (kriterno, kriter, aciklama) VALUES (?, ?, ?)`, [d.kriterno, kriter, d.aciklama]);
    return { id: r.insertId };
  });
  app.delete('/api/places/:id', adminWrite, async (req) => {
    const { id } = parse(idParam, req.params);
    await exec(`DELETE FROM ${T.sabitDegerler} WHERE id = ?`, [id]);
    return { ok: true };
  });
}
