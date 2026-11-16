import type { FastifyInstance } from 'fastify';
import type { PoolConnection } from 'mysql2/promise';
import { z } from 'zod';
import { requireAuth } from '../auth.js';
import { exec, insertClause, one, q, setClause, tx, type Row } from '../db.js';
import { badRequest, conflict, HttpError, idParam, notFound, parse, zs } from '../lib/http.js';
import { datePart, overlaps, timePart, todayLocal, toMs } from '../rules/dates.js';
import { calculatePrice, countDays } from '../rules/pricing.js';
import { T } from '../tables.js';

const seat = z.coerce.string().regex(/^\d{0,2}$/).optional().default('0');
const paymentMethod = z.enum(['', 'Cash', 'Credit Card']).optional().default('');
const paidNote = z.enum(['', 'Deposit', 'Ext. Deposit']).optional().default('');
export const CURRENCIES = ['TL', 'EURO', 'STERLIN', 'DOLLAR'] as const;

/** Fields the user can enter on the reservation screen (UntReservation2.dfm). DB column names are kept. */
export const reservationInput = z.object({
  Carid: z.coerce.number().int().positive('select a car'),
  Customerid: z.coerce.number().int().min(0).optional().default(0),
  Name: z.string().trim().min(1, 'required').max(100),
  Surname: z.string().trim().min(1, 'required').max(100),
  ContactNumber: zs.text(50),
  PassportId: zs.text(50),
  LicenseNo: zs.text(50),
  PlaceofBirth: zs.text(100),

  // Delivery = rental start, Collection = rental end
  BirakilacakTarih: zs.date(),
  BirakilacakSaat: zs.time(),
  birakilacakYer: zs.text(150),
  BirakilacakNotlar: zs.text(2000),
  DeliverTimeChecked: zs.yn(),
  AlinacakTarih: zs.date(),
  AlinacakSaat: zs.time(),
  AlinacakYer: zs.text(150),
  AlinacakNotlar: zs.text(2000),
  CollectTimeChecked: zs.yn(),

  FlightNumber: zs.text(50),
  ChkFlightTime: zs.yn(),
  FlightTime: zs.time().optional().default('00:00:00'),
  ChkFlightTime2: zs.yn(),
  DtFlightTime2: zs.time().optional().default('00:00:00'),

  BabySeat: seat,
  BoosterSeat: seat,
  infantSeat: seat,
  Agency: zs.text(100),
  Company: zs.text(100),
  Companyincome: zs.money(),
  currency: z.enum(CURRENCIES).optional().default('STERLIN'),

  LowSeasonRate: zs.money(), LowSeasonDays: zs.money(),
  MidSeasonRate: zs.money(), MidSeasonDays: zs.money(),
  HighSeasonRate: zs.money(), HighSeasonDays: zs.money(),
  ExtensionRate: zs.money(), ExtensionDays: zs.money(),
  Dailyinsurance: zs.money(),
  Lessinsurance: zs.money(),
  Commission: zs.money(),
  Petrol: zs.money(),
  Extra: zs.money(),
  Discount: zs.money(),

  // Taxi / transfer part of the reservation
  TaxiDeliverFrom: zs.text(150), TaxiDeliverTo: zs.text(150),
  TaxiDateDeliver: zs.optDate(), TaxiTimeDeliver: zs.time().optional().default('00:00:00'), ChkTaxiTimeDeliver: zs.yn(),
  TaxiCollectFrom: zs.text(150), TaxiCollectTo: zs.text(150),
  TaxiDateCollect: zs.optDate(), TaxiTimeCollect: zs.time().optional().default('00:00:00'), ChkTaxiTimeCollect: zs.yn(),
  TaxiPickUp: zs.money(), TaxiDropOff: zs.money(),
  PaxsPickUp: zs.money(), PaxsDropOff: zs.money(), Cases: zs.money(),

  ContractNumber: zs.text(50),
  VoucherNo: zs.text(50),
  RoomNo: zs.text(50),
  Notes: zs.text(4000),

  PaymentMethod1: paymentMethod, PaidAmount1: zs.money(), PaidNote1: paidNote,
  PaymentMethod2: paymentMethod, PaidAmount2: zs.money(), PaidNote2: paidNote,
  PaymentMethod3: paymentMethod, PaidAmount3: zs.money(), PaidNote3: paidNote,
  PaymentMethod4: paymentMethod, PaidAmount4: zs.money(), PaidNote4: paidNote,

  /** The user saw the black-list warning and wants to continue. */
  confirmBlacklist: z.boolean().optional().default(false),
});
type ReservationInput = z.infer<typeof reservationInput>;

const calcInput = reservationInput
  .pick({
    BirakilacakTarih: true, BirakilacakSaat: true, AlinacakTarih: true, AlinacakSaat: true,
    LowSeasonRate: true, LowSeasonDays: true, MidSeasonRate: true, MidSeasonDays: true,
    HighSeasonRate: true, HighSeasonDays: true, ExtensionRate: true, ExtensionDays: true,
    Dailyinsurance: true, Lessinsurance: true, Commission: true, Petrol: true, Extra: true, Discount: true,
    TaxiPickUp: true, TaxiDropOff: true, PaidAmount1: true, PaidAmount2: true, PaidAmount3: true, PaidAmount4: true,
  })
  .partial()
  .extend({ autoDays: z.boolean().optional() });

const STORED_COLS = [
  ...Object.keys(reservationInput.shape).filter((k) => k !== 'confirmBlacklist'),
  'CarModel', 'CarRegNo', 'CarGroup', 'CarType', 'Name2', 'Surname2', 'email',
  'LowSeasonTotal', 'MidSeasonTotal', 'HighSeasonTotal', 'ExtensionTotal', 'GeneralTotal', 'TotalDays',
  'OutstandingBalance', 'TotalComission', 'Sigorta', 'Totalinsurance', 'Durum', 'Kontrol', 'ReservationDate',
];

function priceOf(d: Partial<ReservationInput>) {
  return calculatePrice({
    lowSeasonRate: d.LowSeasonRate, lowSeasonDays: d.LowSeasonDays,
    midSeasonRate: d.MidSeasonRate, midSeasonDays: d.MidSeasonDays,
    highSeasonRate: d.HighSeasonRate, highSeasonDays: d.HighSeasonDays,
    extensionRate: d.ExtensionRate, extensionDays: d.ExtensionDays,
    dailyInsurance: d.Dailyinsurance, taxiPickUp: d.TaxiPickUp, taxiDropOff: d.TaxiDropOff,
    petrol: d.Petrol, extra: d.Extra, discount: d.Discount,
    commission: d.Commission, lessInsurance: d.Lessinsurance,
    paid: [d.PaidAmount1 ?? 0, d.PaidAmount2 ?? 0, d.PaidAmount3 ?? 0, d.PaidAmount4 ?? 0],
  });
}

const fmt = (date: string, time: string) => `${date} ${timePart(time)}`;

/**
 * Throws 409 when the car already has an overlapping, not deleted reservation.
 * Run inside a transaction after locking the car row, so two users can not book the
 * same car at the same moment.
 */
export async function assertNoClash(
  c: PoolConnection, carId: number, start: number, end: number, excludeId: number | null,
) {
  await one(`SELECT id FROM ${T.car} WHERE id = ? FOR UPDATE`, [carId], c);
  const rows = await q(
    `SELECT id, Name, Surname, BirakilacakTarih, BirakilacakSaat, AlinacakTarih, AlinacakSaat FROM ${T.reservation}
     WHERE Durum <> 'Deleted' AND Carid = ? ${excludeId ? 'AND id <> ?' : ''}
       AND BirakilacakTarih <= ? AND AlinacakTarih >= ?`,
    excludeId
      ? [carId, excludeId, new Date(end).toISOString().slice(0, 10), new Date(start).toISOString().slice(0, 10)]
      : [carId, new Date(end).toISOString().slice(0, 10), new Date(start).toISOString().slice(0, 10)],
    c,
  );
  for (const r of rows) {
    const d1 = datePart(r.BirakilacakTarih);
    const d2 = datePart(r.AlinacakTarih);
    if (!d1 || !d2) continue;
    const s = toMs(d1, timePart(r.BirakilacakSaat));
    const e = toMs(d2, timePart(r.AlinacakSaat));
    if (overlaps(start, end, s, e)) {
      throw conflict('This car is already booked for an overlapping period', {
        code: 'DOUBLE_BOOKING',
        clash: {
          id: r.id,
          customer: `${r.Name ?? ''} ${r.Surname ?? ''}`.trim(),
          from: fmt(d1, r.BirakilacakSaat),
          to: fmt(d2, r.AlinacakSaat),
        },
      });
    }
  }
}

async function buildRecord(c: PoolConnection, d: ReservationInput) {
  const start = toMs(d.BirakilacakTarih, d.BirakilacakSaat);
  const end = toMs(d.AlinacakTarih, d.AlinacakSaat);
  if (end < start) throw badRequest('Deliver date and time must be before or equal to collection date and time');

  const car = await one(`SELECT id, Model, RegNo, Grup, Type FROM ${T.car} WHERE id = ?`, [d.Carid], c);
  if (!car) throw badRequest('Selected car does not exist');

  let extra: Row = { Name2: '', Surname2: '', email: '' };
  if (d.Customerid) {
    const cust = await one(`SELECT BlackList, BlackNote, Name2, Surname2, Email FROM ${T.customer} WHERE id = ?`, [d.Customerid], c);
    if (!cust) throw badRequest('Selected customer does not exist');
    if (cust.BlackList === 'Y' && !d.confirmBlacklist) {
      throw new HttpError(409, 'The customer is on the black list', { code: 'BLACKLIST', note: cust.BlackNote ?? '' });
    }
    extra = { Name2: cust.Name2 ?? '', Surname2: cust.Surname2 ?? '', email: cust.Email ?? '' };
  }

  const p = priceOf(d);
  const rec: Row = {
    ...d,
    ...extra,
    CarModel: car.Model, CarRegNo: car.RegNo, CarGroup: car.Grup, CarType: car.Type,
    LowSeasonTotal: p.lowSeasonTotal, MidSeasonTotal: p.midSeasonTotal, HighSeasonTotal: p.highSeasonTotal,
    ExtensionTotal: p.extensionTotal, GeneralTotal: p.generalTotal, TotalDays: p.totalDays,
    OutstandingBalance: p.outstandingBalance, TotalComission: p.totalCommission,
    Totalinsurance: p.totalInsurance, Sigorta: p.totalInsurance,
  };
  delete rec.confirmBlacklist;
  return { rec, start, end };
}

export async function reservationRoutes(app: FastifyInstance) {
  const read = { preHandler: requireAuth() };
  const write = { preHandler: requireAuth('timetable') };

  /** Days and totals for the form ("Days" and "Calculate" buttons). Nothing is saved. */
  app.post('/api/reservations/calc', read, async (req) => {
    const d = parse(calcInput, req.body);
    let days = {
      LowSeasonDays: d.LowSeasonDays ?? 0, MidSeasonDays: d.MidSeasonDays ?? 0, HighSeasonDays: d.HighSeasonDays ?? 0,
    };
    if (d.autoDays) {
      if (!d.BirakilacakTarih || !d.AlinacakTarih) throw badRequest('Enter delivery and collection dates');
      try {
        const c = countDays(d.BirakilacakTarih, d.BirakilacakSaat ?? '00:00', d.AlinacakTarih, d.AlinacakSaat ?? '00:00');
        days = { LowSeasonDays: c.lowSeasonDays, MidSeasonDays: c.midSeasonDays, HighSeasonDays: c.highSeasonDays };
      } catch (e) {
        throw badRequest((e as Error).message);
      }
    }
    const p = priceOf({ ...d, ...days });
    return {
      ...days,
      TotalDays: p.totalDays,
      LowSeasonTotal: p.lowSeasonTotal, MidSeasonTotal: p.midSeasonTotal, HighSeasonTotal: p.highSeasonTotal,
      ExtensionTotal: p.extensionTotal, Totalinsurance: p.totalInsurance, GeneralTotal: p.generalTotal,
      TotalComission: p.totalCommission, OutstandingBalance: p.outstandingBalance,
    };
  });

  app.get('/api/reservations', read, async (req) => {
    const f = req.query as Record<string, string | undefined>;
    const where = ["Durum <> 'Deleted'"];
    const params: unknown[] = [];
    if (f.from) { where.push('AlinacakTarih >= ?'); params.push(f.from); }
    if (f.to) { where.push('BirakilacakTarih <= ?'); params.push(f.to); }
    if (f.carId) { where.push('Carid = ?'); params.push(Number(f.carId)); }
    if (f.customerId) { where.push('Customerid = ?'); params.push(Number(f.customerId)); }
    if (f.search) {
      const s = `%${f.search}%`;
      where.push('(Name LIKE ? OR Surname LIKE ? OR CarRegNo LIKE ? OR ContractNumber LIKE ? OR VoucherNo LIKE ? OR CAST(id AS CHAR) = ?)');
      params.push(s, s, s, s, s, f.search);
    }
    if (f.unpaid === '1') where.push('OutstandingBalance <> 0');
    return q(
      `SELECT id, Name, Surname, CarModel, CarRegNo, BirakilacakTarih, BirakilacakSaat, AlinacakTarih, AlinacakSaat,
              birakilacakYer, AlinacakYer, Agency, Company, currency, GeneralTotal, OutstandingBalance, TotalDays, Durum, ContractNumber
       FROM ${T.reservation} WHERE ${where.join(' AND ')}
       ORDER BY BirakilacakTarih DESC, BirakilacakSaat DESC LIMIT 1000`,
      params,
    );
  });

  /** Pick-up / drop-off place suggestions: fixed values (UntSabitDegerler) + previously used ones. */
  app.get('/api/reservations/places', read, async () => {
    const fixed = await q<{ kriterno: number; aciklama: string }>(
      `SELECT kriterno, aciklama FROM ${T.sabitDegerler} ORDER BY aciklama`,
    ).catch(() => []);
    const deliver = new Set<string>(['LARNACA AIRPORT', 'ERCAN AIRPORT']);
    const collect = new Set<string>(['LARNACA AIRPORT', 'ERCAN AIRPORT']);
    for (const r of fixed) (Number(r.kriterno) === 0 ? deliver : collect).add(r.aciklama);
    for (const r of await q<{ v: string }>(`SELECT DISTINCT birakilacakYer AS v FROM ${T.reservation} WHERE birakilacakYer <> '' LIMIT 300`)) deliver.add(r.v);
    for (const r of await q<{ v: string }>(`SELECT DISTINCT AlinacakYer AS v FROM ${T.reservation} WHERE AlinacakYer <> '' LIMIT 300`)) collect.add(r.v);
    const sort = (s: Set<string>) => [...s].filter(Boolean).sort((a, b) => a.localeCompare(b));
    return { deliver: sort(deliver), collect: sort(collect) };
  });

  app.get('/api/reservations/:id', read, async (req) => {
    const { id } = parse(idParam, req.params);
    const r = await one(`SELECT * FROM ${T.reservation} WHERE id = ?`, [id]);
    if (!r) throw notFound();
    return r;
  });

  app.post('/api/reservations', write, async (req) => {
    const d = parse(reservationInput, req.body);
    return tx(async (c) => {
      const { rec, start, end } = await buildRecord(c, d);
      await assertNoClash(c, d.Carid, start, end, null);
      Object.assign(rec, { Durum: 'Saved', Kontrol: 'N', ReservationDate: todayLocal() });
      const ins = insertClause(rec, STORED_COLS);
      const res = await exec(`INSERT INTO ${T.reservation} ${ins.sql}`, ins.values, c);
      return { id: res.insertId };
    });
  });

  app.put('/api/reservations/:id', write, async (req) => {
    const { id } = parse(idParam, req.params);
    const d = parse(reservationInput, req.body);
    return tx(async (c) => {
      const old = await one(`SELECT id, Durum FROM ${T.reservation} WHERE id = ? FOR UPDATE`, [id], c);
      if (!old || old.Durum === 'Deleted') throw notFound();
      const { rec, start, end } = await buildRecord(c, d);
      await assertNoClash(c, d.Carid, start, end, id);
      rec.Durum = 'Updated';
      const s = setClause(rec, STORED_COLS);
      await exec(`UPDATE ${T.reservation} SET ${s.sql} WHERE id = ?`, [...s.values, id], c);
      return { id };
    });
  });

  /** Soft delete, like the Delphi program (Durum = 'Deleted'). */
  app.delete('/api/reservations/:id', write, async (req) => {
    const { id } = parse(idParam, req.params);
    const res = await exec(`UPDATE ${T.reservation} SET Durum = 'Deleted' WHERE id = ? AND Durum <> 'Deleted'`, [id]);
    if (!res.affectedRows) throw notFound();
    return { ok: true };
  });

  /** Move a reservation to another car (time table "Copy / Paste"). */
  app.post('/api/reservations/:id/move', write, async (req) => {
    const { id } = parse(idParam, req.params);
    const { carId } = parse(z.object({ carId: z.coerce.number().int().positive() }), req.body);
    return tx(async (c) => {
      const r = await one(`SELECT * FROM ${T.reservation} WHERE id = ? AND Durum <> 'Deleted' FOR UPDATE`, [id], c);
      if (!r) throw notFound();
      const car = await one(`SELECT id, Model, RegNo, Grup, Type FROM ${T.car} WHERE id = ?`, [carId], c);
      if (!car) throw badRequest('Selected car does not exist');
      const start = toMs(datePart(r.BirakilacakTarih)!, timePart(r.BirakilacakSaat));
      const end = toMs(datePart(r.AlinacakTarih)!, timePart(r.AlinacakSaat));
      await assertNoClash(c, carId, start, end, id);
      const vals = [car.id, car.Model, car.RegNo, car.Grup, car.Type];
      await exec(`UPDATE ${T.reservation} SET Carid = ?, CarModel = ?, CarRegNo = ?, CarGroup = ?, CarType = ? WHERE id = ?`, [...vals, id], c);
      // Transfers are linked to a reservation through Transfer.RegNo = reservation id.
      await exec(`UPDATE ${T.transfer} SET Carid = ?, CarModel = ?, CarRegNo = ?, CarGroup = ?, CarType = ? WHERE RegNo = ?`, [...vals, String(id)], c);
      return { ok: true };
    });
  });

  /** Tick a reservation as checked on the unpaid-balance list (UntKontrol). */
  app.patch('/api/reservations/:id/kontrol', write, async (req) => {
    const { id } = parse(idParam, req.params);
    const { Kontrol } = parse(z.object({ Kontrol: z.enum(['Y', 'N']) }), req.body);
    await exec(`UPDATE ${T.reservation} SET Kontrol = ? WHERE id = ?`, [Kontrol, id]);
    return { ok: true };
  });

  /** Unpaid reservations whose rental has started and were not checked yet (UntKontrol). */
  app.get('/api/dashboard/unpaid', read, async () =>
    q(
      `SELECT id, Name, Surname, currency, OutstandingBalance, BirakilacakTarih, AlinacakTarih, CarRegNo FROM ${T.reservation}
       WHERE Durum <> 'Deleted' AND BirakilacakTarih < ? AND OutstandingBalance <> 0 AND (Kontrol = 'N' OR Kontrol IS NULL)
       ORDER BY BirakilacakTarih`,
      [todayLocal()],
    ),
  );
}
