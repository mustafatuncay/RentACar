import type { FastifyInstance } from 'fastify';
import { z } from 'zod';
import { requireAuth } from '../auth.js';
import { exec, insertClause, one, q, setClause, tx } from '../db.js';
import { conflict, idParam, notFound, parse, zs } from '../lib/http.js';
import { T } from '../tables.js';

export const CAR_GROUPS = ['Group 1', 'Group 2', 'Group 3', 'Group 4', 'Group 5', 'Group 6', 'Group 7'];

const carSchema = z.object({
  Model: z.string().trim().min(1, 'required').max(100),
  RegNo: z.string().trim().min(1, 'required').max(50),
  Grup: z.string().trim().max(50).default('Group 1'),
  Type: zs.text(50),
  SiraNo: zs.int(),
  Sold: z.coerce.number().int().min(0).max(1).default(0),
  Color: zs.text(30),
  FontColor: zs.text(30),
  MuayeneTarihi: zs.optDate(),
  Notes: zs.text(2000),
});
const CAR_COLS = ['Model', 'RegNo', 'Grup', 'Type', 'SiraNo', 'Sold', 'Color', 'FontColor', 'MuayeneTarihi', 'Notes'] as const;

const expenseSchema = z.object({
  ExpenseDate: zs.optDate(),
  expense: zs.text(255),
  price: zs.money(),
  priceEuro: zs.money(),
  priceSterlin: zs.money(),
  ServiceKm: zs.money(),
  NextServiceKm: zs.money(),
  Notes: zs.text(2000),
});
const insuranceSchema = z.object({
  company: zs.text(100),
  startdate: zs.optDate(),
  enddate: zs.optDate(),
  paymentdate: zs.optDate(),
  thirdpartyprice: zs.money(),
  kaskoprice: zs.money(),
  thirdpartypriceSterlin: zs.money(),
  kaskopriceSterlin: zs.money(),
  thirdpartypriceEuro: zs.money(),
  kaskopriceEuro: zs.money(),
  Notes: zs.text(2000),
});
const seyruseferSchema = z.object({
  startdate: zs.optDate(),
  enddate: zs.optDate(),
  odemetarihi: zs.optDate(),
  price: zs.money(),
  PriceEuro: zs.money(),
  PriceSterlin: zs.money(),
  Notes: zs.text(2000),
});

/** Sub tables of a car, with their own columns and how rows are ordered. */
const SUB = {
  expenses: { table: T.carExpense, schema: expenseSchema, order: 'ExpenseDate', dateCol: 'ExpenseDate' },
  insurance: { table: T.carInsurance, schema: insuranceSchema, order: 'kayittarihi', dateCol: 'startdate' },
  seyrusefer: { table: T.carSeyrusefer, schema: seyruseferSchema, order: 'kayittarihi', dateCol: 'startdate' },
} as const;
type SubKind = keyof typeof SUB;

function subData(kind: SubKind, body: unknown) {
  const d: Record<string, unknown> = parse(SUB[kind].schema, body);
  if (kind === 'insurance') {
    const n = (k: string) => Number(d[k] ?? 0);
    d.totalprice = n('thirdpartyprice') + n('kaskoprice');
    d.totalpriceSterlin = n('thirdpartypriceSterlin') + n('kaskopriceSterlin');
    d.totalpriceEuro = n('thirdpartypriceEuro') + n('kaskopriceEuro');
  }
  return d;
}

/** Make room for a car at position SiraNo inside its group (same as UntCar.pas). */
async function shiftOrder(c: Parameters<typeof q>[2], carId: number, grup: string, siraNo: number) {
  const rows = await q<{ id: number }>(
    `SELECT id FROM ${T.car} WHERE id <> ? AND Grup = ? AND SiraNo >= ? ORDER BY SiraNo ASC`,
    [carId, grup, siraNo],
    c,
  );
  let n = siraNo;
  for (const r of rows) await exec(`UPDATE ${T.car} SET SiraNo = ? WHERE id = ?`, [++n, r.id], c);
}

export async function carRoutes(app: FastifyInstance) {
  const read = { preHandler: requireAuth() };
  const write = { preHandler: requireAuth('cars') };

  app.get('/api/cars', read, async (req) => {
    const { group, includeSold, search } = req.query as Record<string, string | undefined>;
    const where: string[] = [];
    const params: unknown[] = [];
    if (group) { where.push('Grup = ?'); params.push(group); }
    if (includeSold !== '1') where.push('(Sold IS NULL OR Sold <> 1)');
    if (search) { where.push('(Model LIKE ? OR RegNo LIKE ?)'); params.push(`%${search}%`, `%${search}%`); }
    return q(
      `SELECT id, Model, RegNo, Grup, Type, SiraNo, Sold, Color, FontColor, MuayeneTarihi, Notes FROM ${T.car}
       ${where.length ? 'WHERE ' + where.join(' AND ') : ''} ORDER BY Grup, SiraNo, Model`,
      params,
    );
  });

  app.get('/api/cars/models', read, async () =>
    (await q<{ Model: string }>(`SELECT DISTINCT Model FROM ${T.car} ORDER BY Model`)).map((r) => r.Model),
  );

  app.get('/api/cars/:id', read, async (req) => {
    const { id } = parse(idParam, req.params);
    const car = await one(`SELECT * FROM ${T.car} WHERE id = ?`, [id]);
    if (!car) throw notFound();
    return car;
  });

  app.post('/api/cars', write, async (req) => {
    const data = parse(carSchema, req.body);
    return tx(async (c) => {
      if (await one(`SELECT id FROM ${T.car} WHERE RegNo = ?`, [data.RegNo], c)) {
        throw conflict('A car with this registration number already exists');
      }
      const ins = insertClause(data, CAR_COLS);
      const res = await exec(`INSERT INTO ${T.car} ${ins.sql}`, ins.values, c);
      await shiftOrder(c, res.insertId, data.Grup, data.SiraNo);
      return { id: res.insertId };
    });
  });

  app.put('/api/cars/:id', write, async (req) => {
    const { id } = parse(idParam, req.params);
    const data = parse(carSchema, req.body);
    return tx(async (c) => {
      if (!(await one(`SELECT id FROM ${T.car} WHERE id = ? FOR UPDATE`, [id], c))) throw notFound();
      if (await one(`SELECT id FROM ${T.car} WHERE id <> ? AND RegNo = ?`, [id, data.RegNo], c)) {
        throw conflict('A car with this registration number already exists');
      }
      const s = setClause(data, CAR_COLS);
      await exec(`UPDATE ${T.car} SET ${s.sql} WHERE id = ?`, [...s.values, id], c);
      // Keep the copied car details on reservations and transfers in sync (as the Delphi program did).
      await exec(
        `UPDATE ${T.reservation} SET CarModel = ?, CarRegNo = ?, CarGroup = ?, CarType = ? WHERE Carid = ?`,
        [data.Model, data.RegNo, data.Grup, data.Type, id], c,
      );
      await exec(
        `UPDATE ${T.transfer} SET CarModel = ?, CarRegNo = ?, CarGroup = ?, CarType = ? WHERE Carid = ?`,
        [data.Model, data.RegNo, data.Grup, data.Type, id], c,
      );
      await shiftOrder(c, id, data.Grup, data.SiraNo);
      return { id };
    });
  });

  app.patch('/api/cars/:id/colors', write, async (req) => {
    const { id } = parse(idParam, req.params);
    const d = parse(z.object({ Color: zs.text(30), FontColor: zs.text(30) }), req.body);
    await exec(`UPDATE ${T.car} SET Color = ?, FontColor = ? WHERE id = ?`, [d.Color, d.FontColor, id]);
    return { ok: true };
  });

  /** Save the display order of a group (UntCarList). */
  app.put('/api/cars/order', write, async (req) => {
    const d = parse(z.object({ ids: z.array(z.number().int().positive()).max(1000) }), req.body);
    await tx(async (c) => {
      let n = 0;
      for (const id of d.ids) await exec(`UPDATE ${T.car} SET SiraNo = ? WHERE id = ?`, [++n, id], c);
    });
    return { ok: true };
  });

  app.delete('/api/cars/:id', write, async (req) => {
    const { id } = parse(idParam, req.params);
    const checks: [string, string][] = [
      [T.reservation, 'Reservation'],
      [T.transfer, 'Transfer'],
      [T.carInsurance, 'Insurance'],
      [T.carSeyrusefer, 'Seyrusefer'],
      [T.carExpense, 'Expense'],
    ];
    for (const [table, label] of checks) {
      if (await one(`SELECT id FROM ${table} WHERE Carid = ? LIMIT 1`, [id])) {
        throw conflict(`This car has records in ${label}, it can not be deleted. Mark it as sold instead.`);
      }
    }
    const res = await exec(`DELETE FROM ${T.car} WHERE id = ?`, [id]);
    if (!res.affectedRows) throw notFound();
    return { ok: true };
  });

  // ---- sub records: /api/cars/:id/expenses|insurance|seyrusefer ----
  for (const kind of Object.keys(SUB) as SubKind[]) {
    const { table, order } = SUB[kind];

    app.get(`/api/cars/:id/${kind}`, read, async (req) => {
      const { id } = parse(idParam, req.params);
      return q(`SELECT * FROM ${table} WHERE Carid = ? ORDER BY ${order}, id`, [id]);
    });

    app.post(`/api/cars/:id/${kind}`, write, async (req) => {
      const { id } = parse(idParam, req.params);
      const car = await one(`SELECT Model, RegNo FROM ${T.car} WHERE id = ?`, [id]);
      if (!car) throw notFound('Car not found');
      const d: Record<string, unknown> = { ...subData(kind, req.body), Carid: id, CarModel: car.Model, CarRegNo: car.RegNo };
      if (kind !== 'expenses') d.kayittarihi = new Date().toISOString().slice(0, 19).replace('T', ' ');
      const cols = Object.keys(d);
      const ins = insertClause(d, cols);
      const res = await exec(`INSERT INTO ${table} ${ins.sql}`, ins.values);
      return { id: res.insertId };
    });

    app.put(`/api/cars/:id/${kind}/:subId`, write, async (req) => {
      const p = parse(idParam.extend({ subId: z.coerce.number().int().positive() }), req.params);
      const d = subData(kind, req.body);
      const s = setClause(d, Object.keys(d));
      const res = await exec(`UPDATE ${table} SET ${s.sql} WHERE id = ? AND Carid = ?`, [...s.values, p.subId, p.id]);
      if (!res.affectedRows) throw notFound();
      return { ok: true };
    });

    app.delete(`/api/cars/:id/${kind}/:subId`, write, async (req) => {
      const p = parse(idParam.extend({ subId: z.coerce.number().int().positive() }), req.params);
      const res = await exec(`DELETE FROM ${table} WHERE id = ? AND Carid = ?`, [p.subId, p.id]);
      if (!res.affectedRows) throw notFound();
      return { ok: true };
    });
  }
}
