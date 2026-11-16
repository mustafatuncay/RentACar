import type { FastifyInstance } from 'fastify';
import { z } from 'zod';
import { requireAuth } from '../auth.js';
import { exec, insertClause, one, q, setClause } from '../db.js';
import { badRequest, HttpError, idParam, notFound, parse, zs } from '../lib/http.js';
import { T } from '../tables.js';
import { CURRENCIES } from './reservations.js';

const seat = z.coerce.string().regex(/^\d{0,2}$/).optional().default('0');

/** Airport transfers (UntTransfers.pas). Arrival = from airport, Departure = to airport. */
const transferSchema = z.object({
  Customerid: z.coerce.number().int().min(0).optional().default(0),
  Name: z.string().trim().min(1, 'required').max(100),
  Surname: z.string().trim().min(1, 'required').max(100),
  ContactNumber: zs.text(50), PassportId: zs.text(50), LicenseNo: zs.text(50), PlaceofBirth: zs.text(100),

  CheckedArrival: zs.yn(),
  ArrivalDate: zs.optDate(), ArrivalTime: zs.time().optional().default('00:00:00'), ArrivalTimeChecked: zs.yn(),
  ArrivalFlightNo: zs.text(50), ArrivalCollectFrom: zs.text(150), ArrivalDestination: zs.text(150),
  ArrivalPax: zs.money(), ArrivalCase: zs.money(), ArrivalBabySeat: seat, ArrivalBoosterSeat: seat, Arrivalinfant: seat,
  ArrivalPrice: zs.money(), ArrivalPaid: zs.yn(), ArrivalPaidTo: zs.text(100), ArrivalNotes: zs.text(2000),

  CheckedDeparture: zs.yn(),
  DepartureDate: zs.optDate(), DepartureTime: zs.time().optional().default('00:00:00'), DepartureTimeChecked: zs.yn(),
  DepartureCollectFrom: zs.text(150), DepartureDestination: zs.text(150),
  DeparturePax: zs.money(), DepartureCase: zs.money(), DepartureBabySeat: seat, DepartureBoosterSeat: seat, Departureinfant: seat,
  DeparturePrice: zs.money(), DeparturePaid: zs.yn(), PaidTo: zs.text(100), DepartureNotes: zs.text(2000),

  Driver: zs.text(100), Driver2: zs.text(100), AgencyName: zs.text(100),
  Currency: z.enum(CURRENCIES).optional().default('STERLIN'),
  Carid: z.coerce.number().int().min(0).optional().default(0),
  /** Linked reservation id (the original program stored it in Transfer.RegNo). */
  RegNo: zs.text(20),
  confirmBlacklist: z.boolean().optional().default(false),
});
const COLS = [...Object.keys(transferSchema.shape).filter((k) => k !== 'confirmBlacklist'), 'CarModel', 'CarRegNo', 'CarGroup', 'CarType'];

async function build(body: unknown) {
  const d: Record<string, any> = parse(transferSchema, body);
  if (d.CheckedArrival !== 'Y' && d.CheckedDeparture !== 'Y') throw badRequest('Tick arrival and/or departure');
  if (d.CheckedArrival === 'Y' && !d.ArrivalDate) throw badRequest('Enter the arrival date');
  if (d.CheckedDeparture === 'Y' && !d.DepartureDate) throw badRequest('Enter the departure date');
  // Black list warning for transfers too (requested in yapilacaklar.txt).
  if (d.Customerid) {
    const c = await one(`SELECT BlackList, BlackNote FROM ${T.customer} WHERE id = ?`, [d.Customerid]);
    if (c?.BlackList === 'Y' && !d.confirmBlacklist) {
      throw new HttpError(409, 'The customer is on the black list', { code: 'BLACKLIST', note: c.BlackNote ?? '' });
    }
  }
  Object.assign(d, { CarModel: '', CarRegNo: '', CarGroup: '', CarType: '' });
  if (d.Carid) {
    const car = await one(`SELECT Model, RegNo, Grup, Type FROM ${T.car} WHERE id = ?`, [d.Carid]);
    if (car) Object.assign(d, { CarModel: car.Model, CarRegNo: car.RegNo, CarGroup: car.Grup, CarType: car.Type });
  }
  delete d.confirmBlacklist;
  return d;
}

export async function transferRoutes(app: FastifyInstance) {
  const read = { preHandler: requireAuth() };
  const write = { preHandler: requireAuth('transfers') };

  app.get('/api/transfers', read, async (req) => {
    const f = req.query as Record<string, string | undefined>;
    const where: string[] = ['1=1'];
    const params: unknown[] = [];
    if (f.from) { where.push(`((CheckedArrival = 'Y' AND ArrivalDate >= ?) OR (CheckedDeparture = 'Y' AND DepartureDate >= ?))`); params.push(f.from, f.from); }
    if (f.to) { where.push(`((CheckedArrival = 'Y' AND ArrivalDate <= ?) OR (CheckedDeparture = 'Y' AND DepartureDate <= ?))`); params.push(f.to, f.to); }
    if (f.search) { const s = `%${f.search}%`; where.push('(Name LIKE ? OR Surname LIKE ? OR ArrivalFlightNo LIKE ? OR Driver LIKE ?)'); params.push(s, s, s, s); }
    if (f.reservationId) { where.push('RegNo = ?'); params.push(String(f.reservationId)); }
    return q(
      `SELECT id, Name, Surname, ContactNumber, CheckedArrival, ArrivalDate, ArrivalTime, ArrivalCollectFrom, ArrivalDestination, ArrivalPrice, ArrivalPaid,
              CheckedDeparture, DepartureDate, DepartureTime, DepartureCollectFrom, DepartureDestination, DeparturePrice, DeparturePaid,
              Driver, AgencyName, Currency, RegNo
       FROM ${T.transfer} WHERE ${where.join(' AND ')} ORDER BY COALESCE(ArrivalDate, DepartureDate) DESC, id DESC LIMIT 1000`,
      params,
    );
  });

  app.get('/api/transfers/suggestions', read, async () => {
    const pick = async (col: string) =>
      (await q<{ v: string }>(`SELECT DISTINCT ${col} AS v FROM ${T.transfer} WHERE ${col} <> '' ORDER BY v LIMIT 300`)).map((r) => r.v);
    const [drivers, drivers2, places, places2, paidTo, paidTo2] = await Promise.all([
      pick('Driver'), pick('Driver2'), pick('ArrivalCollectFrom'), pick('DepartureDestination'), pick('PaidTo'), pick('ArrivalPaidTo'),
    ]);
    const uniq = (...a: string[][]) => [...new Set(a.flat())].sort((x, y) => x.localeCompare(y));
    return {
      drivers: uniq(drivers, drivers2),
      places: uniq(['LARNACA AIRPORT', 'ERCAN AIRPORT'], places, places2),
      paidTo: uniq(paidTo, paidTo2),
    };
  });

  app.get('/api/transfers/:id', read, async (req) => {
    const { id } = parse(idParam, req.params);
    const r = await one(`SELECT * FROM ${T.transfer} WHERE id = ?`, [id]);
    if (!r) throw notFound();
    return r;
  });

  app.post('/api/transfers', write, async (req) => {
    const d = await build(req.body);
    const ins = insertClause(d, COLS);
    const res = await exec(`INSERT INTO ${T.transfer} ${ins.sql}`, ins.values);
    return { id: res.insertId };
  });

  app.put('/api/transfers/:id', write, async (req) => {
    const { id } = parse(idParam, req.params);
    const d = await build(req.body);
    const s = setClause(d, COLS);
    const res = await exec(`UPDATE ${T.transfer} SET ${s.sql} WHERE id = ?`, [...s.values, id]);
    if (!res.affectedRows) throw notFound();
    return { id };
  });

  app.delete('/api/transfers/:id', write, async (req) => {
    const { id } = parse(idParam, req.params);
    const res = await exec(`DELETE FROM ${T.transfer} WHERE id = ?`, [id]);
    if (!res.affectedRows) throw notFound();
    return { ok: true };
  });
}
