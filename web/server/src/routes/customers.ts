import type { FastifyInstance } from 'fastify';
import { z } from 'zod';
import { requireAuth } from '../auth.js';
import { exec, insertClause, one, q, setClause, tx } from '../db.js';
import { conflict, idParam, notFound, parse, zs } from '../lib/http.js';
import { T } from '../tables.js';

const title = z.enum(['', 'Miss', 'Mrs', 'Mr']).optional().default('');

/** Up to three drivers per customer, as in UntCustomer.pas. */
const customerSchema = z.object({
  Name: z.string().trim().min(1, 'required').max(100),
  Surname: z.string().trim().min(1, 'required').max(100),
  BayBayan1: title,
  PassportId: zs.text(50),
  LicenseNo: zs.text(50),
  BirthDate: zs.optDate(),
  CheckedBirthDate: zs.yn(),
  Expire1: zs.optDate(),
  PlaceofBirth: zs.text(100),
  Email: zs.text(150),
  TelNo: zs.text(50),
  CyprusMobile: zs.text(50),
  LocalNumber: zs.text(50),
  Address: zs.text(500),
  LocalAddress: zs.text(500),
  CustNumber: zs.text(50),
  BlackList: zs.yn(),
  BlackNote: zs.text(2000),

  Name2: zs.text(100), Surname2: zs.text(100), BayBayan2: title, PassportId2: zs.text(50), LicenseNo2: zs.text(50),
  BirthDate2: zs.optDate(), CheckedBirthDate2: zs.yn(), Expire2: zs.optDate(), Email2: zs.text(150),

  Name3: zs.text(100), Surname3: zs.text(100), BayBayan3: title, PassportId3: zs.text(50), LicenseNo3: zs.text(50),
  BirthDate3: zs.optDate(), CheckedBirthDate3: zs.yn(), Expire3: zs.optDate(), Email3: zs.text(150),
});
const COLS = Object.keys(customerSchema.shape);

export async function customerRoutes(app: FastifyInstance) {
  const read = { preHandler: requireAuth() };
  const write = { preHandler: requireAuth('customers') };

  app.get('/api/customers', read, async (req) => {
    const { search, blacklist, limit } = req.query as Record<string, string | undefined>;
    const where: string[] = [];
    const params: unknown[] = [];
    if (search) {
      const s = `%${search}%`;
      where.push(`(Name LIKE ? OR Surname LIKE ? OR CONCAT(Name, ' ', Surname) LIKE ? OR PassportId LIKE ? OR TelNo LIKE ? OR LocalNumber LIKE ? OR CustNumber LIKE ? OR Email LIKE ?)`);
      params.push(s, s, s, s, s, s, s, s);
    }
    if (blacklist === 'Y') where.push("BlackList = 'Y'");
    const lim = Math.min(Number(limit) || 500, 5000);
    return q(
      `SELECT id, Name, Surname, PassportId, LicenseNo, PlaceofBirth, TelNo, LocalNumber, CyprusMobile, Email, CustNumber, BlackList, BirthDate
       FROM ${T.customer} ${where.length ? 'WHERE ' + where.join(' AND ') : ''}
       ORDER BY Surname, Name LIMIT ${lim}`,
      params,
    );
  });

  /** Customers whose birthday is within the next `days` days (UntBirthDayRemainder; the original query was broken). */
  app.get('/api/customers/birthdays', read, async (req) => {
    const days = Math.min(Math.max(Number((req.query as any).days) || 3, 0), 60);
    return q(
      `SELECT id, Name, Surname, BirthDate, TelNo, Email FROM ${T.customer}
       WHERE BirthDate IS NOT NULL AND YEAR(BirthDate) > 1900 AND
         MOD(DAYOFYEAR(DATE_ADD(BirthDate, INTERVAL (YEAR(CURDATE()) - YEAR(BirthDate)) YEAR)) - DAYOFYEAR(CURDATE()) + 366, 366) <= ?
       ORDER BY MONTH(BirthDate), DAY(BirthDate)`,
      [days],
    );
  });

  app.get('/api/customers/:id', read, async (req) => {
    const { id } = parse(idParam, req.params);
    const row = await one(`SELECT * FROM ${T.customer} WHERE id = ?`, [id]);
    if (!row) throw notFound();
    return row;
  });

  app.get('/api/customers/:id/history', read, async (req) => {
    const { id } = parse(idParam, req.params);
    return q(
      `SELECT id, BirakilacakTarih, AlinacakTarih, CarModel, CarRegNo, GeneralTotal, OutstandingBalance, Currency, Durum
       FROM ${T.reservation} WHERE Customerid = ? AND Durum <> 'Deleted' ORDER BY BirakilacakTarih DESC`,
      [id],
    );
  });

  app.post('/api/customers', write, async (req) => {
    const data = parse(customerSchema, req.body);
    if (await one(`SELECT id FROM ${T.customer} WHERE Name = ? AND Surname = ?`, [data.Name, data.Surname])) {
      throw conflict('A customer with this name and surname already exists');
    }
    const ins = insertClause(data, COLS);
    const res = await exec(`INSERT INTO ${T.customer} ${ins.sql}`, ins.values);
    return { id: res.insertId };
  });

  app.put('/api/customers/:id', write, async (req) => {
    const { id } = parse(idParam, req.params);
    const data = parse(customerSchema, req.body);
    return tx(async (c) => {
      if (!(await one(`SELECT id FROM ${T.customer} WHERE id = ?`, [id], c))) throw notFound();
      if (await one(`SELECT id FROM ${T.customer} WHERE id <> ? AND Name = ? AND Surname = ?`, [id, data.Name, data.Surname], c)) {
        throw conflict('A customer with this name and surname already exists');
      }
      const s = setClause(data, COLS);
      await exec(`UPDATE ${T.customer} SET ${s.sql} WHERE id = ?`, [...s.values, id], c);
      // Names are copied onto reservations and transfers; keep them in sync.
      await exec(`UPDATE ${T.reservation} SET Name = ?, Surname = ? WHERE Customerid = ?`, [data.Name, data.Surname, id], c);
      await exec(`UPDATE ${T.transfer} SET Name = ?, Surname = ? WHERE Customerid = ?`, [data.Name, data.Surname, id], c);
      return { id };
    });
  });

  app.delete('/api/customers/:id', write, async (req) => {
    const { id } = parse(idParam, req.params);
    // New safety check (the Delphi program deleted without checking).
    if (await one(`SELECT id FROM ${T.reservation} WHERE Customerid = ? AND Durum <> 'Deleted' LIMIT 1`, [id])) {
      throw conflict('This customer has reservations, it can not be deleted');
    }
    const res = await exec(`DELETE FROM ${T.customer} WHERE id = ?`, [id]);
    if (!res.affectedRows) throw notFound();
    return { ok: true };
  });
}
