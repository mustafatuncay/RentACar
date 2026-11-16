import type { FastifyInstance } from 'fastify';
import { z } from 'zod';
import { requireAuth } from '../auth.js';
import { q, tableColumns } from '../db.js';
import { parse, zs } from '../lib/http.js';
import { T } from '../tables.js';

const range = z.object({ from: zs.date(), to: zs.date() });

/** Reports of UntReports.pas, rebuilt as parameterised queries. */
export async function reportRoutes(app: FastifyInstance) {
  const read = { preHandler: requireAuth('reports') };

  app.get('/api/reports/reservations', read, async (req) => {
    const f = parse(
      range.extend({
        dateField: z.enum(['delivery', 'collection', 'booked']).default('delivery'),
        carModel: z.string().max(100).optional(),
        carRegNo: z.string().max(50).optional(),
        agency: z.string().max(100).optional(),
        company: z.string().max(100).optional(),
        currency: z.string().max(20).optional(),
        customer: z.string().max(100).optional(),
        unpaid: z.enum(['0', '1']).optional(),
      }),
      req.query,
    );
    const col = { delivery: 'BirakilacakTarih', collection: 'AlinacakTarih', booked: 'ReservationDate' }[f.dateField];
    const where = ["Durum <> 'Deleted'", `${col} BETWEEN ? AND ?`];
    const params: unknown[] = [f.from, f.to];
    const add = (sql: string, v: unknown) => { where.push(sql); params.push(v); };
    if (f.carModel) add('CarModel = ?', f.carModel);
    if (f.carRegNo) add('CarRegNo = ?', f.carRegNo);
    if (f.agency) add('Agency = ?', f.agency);
    if (f.company) add('Company = ?', f.company);
    if (f.currency) add('currency = ?', f.currency);
    if (f.customer) { where.push("CONCAT(Name, ' ', Surname) LIKE ?"); params.push(`%${f.customer}%`); }
    if (f.unpaid === '1') where.push('OutstandingBalance <> 0');
    return q(
      `SELECT id, ReservationDate, Name, Surname, CarModel, CarRegNo, BirakilacakTarih, AlinacakTarih, TotalDays,
              Agency, Company, currency, GeneralTotal, Discount, Petrol, TaxiPickUp, TaxiDropOff, Totalinsurance,
              TotalComission, Companyincome, (PaidAmount1 + PaidAmount2 + PaidAmount3 + PaidAmount4) AS Paid, OutstandingBalance
       FROM ${T.reservation} WHERE ${where.join(' AND ')} ORDER BY ${col}, id`,
      params,
    );
  });

  app.get('/api/reports/agency-commission', read, async (req) => {
    const f = parse(range.extend({ agency: z.string().max(100).optional() }), req.query);
    return q(
      `SELECT id, Agency, TotalComission, currency, ReservationDate, Name, Surname, TotalDays, BirakilacakTarih, AlinacakTarih
       FROM ${T.reservation}
       WHERE Durum <> 'Deleted' AND Agency <> '' AND Agency LIKE ? AND BirakilacakTarih BETWEEN ? AND ?
       ORDER BY Agency, BirakilacakTarih`,
      [f.agency ? f.agency : '%', f.from, f.to],
    );
  });

  app.get('/api/reports/company-income', read, async (req) => {
    const f = parse(range.extend({ company: z.string().max(100).optional() }), req.query);
    return q(
      `SELECT id, Company, Companyincome, currency, ReservationDate, Name, Surname, TotalDays, BirakilacakTarih, AlinacakTarih,
              CarModel, CarRegNo, GeneralTotal
       FROM ${T.reservation}
       WHERE Durum <> 'Deleted' AND Company <> '' AND Company LIKE ? AND BirakilacakTarih BETWEEN ? AND ?
       ORDER BY Company, BirakilacakTarih`,
      [f.company ? f.company : '%', f.from, f.to],
    );
  });

  /** Rented days per car in the period (days are clipped to the period). */
  app.get('/api/reports/car-usage', read, async (req) => {
    const f = parse(range, req.query);
    return q(
      `SELECT Carid, CarModel, CarRegNo, COUNT(*) AS Rentals,
              SUM(GREATEST(DATEDIFF(LEAST(AlinacakTarih, ?), GREATEST(BirakilacakTarih, ?)), 0)) AS Days,
              DATEDIFF(?, ?) + 1 AS PeriodDays
       FROM ${T.reservation}
       WHERE Durum <> 'Deleted' AND AlinacakTarih >= ? AND BirakilacakTarih <= ?
       GROUP BY Carid, CarModel, CarRegNo ORDER BY Days DESC`,
      [f.to, f.from, f.to, f.from, f.from, f.to],
    );
  });

  app.get('/api/reports/customer-ranking', read, async (req) => {
    const f = parse(range, req.query);
    return q(
      `SELECT Customerid, Name, Surname, COUNT(*) AS Rentals, SUM(DATEDIFF(AlinacakTarih, BirakilacakTarih)) AS Days
       FROM ${T.reservation}
       WHERE Durum <> 'Deleted' AND BirakilacakTarih BETWEEN ? AND ?
       GROUP BY Customerid, Name, Surname ORDER BY Rentals DESC, Days DESC LIMIT 500`,
      [f.from, f.to],
    );
  });

  /** Expenses, insurance and road tax (seyrüsefer) per car in TL, Sterlin and Euro. */
  app.get('/api/reports/car-costs', read, async (req) => {
    const f = parse(range.extend({ carId: z.coerce.number().int().positive().optional() }), req.query);
    const car = f.carId ? ' AND Carid = ?' : '';
    const p = (extra: unknown[] = []) => [f.from, f.to, ...(f.carId ? [f.carId] : []), ...extra];
    return q(
      `SELECT 'Expense' AS Kind, Carid, CarModel, CarRegNo, ExpenseDate AS Date, expense AS Description, price AS TL, priceSterlin AS Sterlin, priceEuro AS Euro
         FROM ${T.carExpense} WHERE ExpenseDate BETWEEN ? AND ?${car}
       UNION ALL
       SELECT 'Insurance', Carid, CarModel, CarRegNo, startdate, company, totalprice, totalpriceSterlin, totalpriceEuro
         FROM ${T.carInsurance} WHERE startdate BETWEEN ? AND ?${car}
       UNION ALL
       SELECT 'Seyrusefer', Carid, CarModel, CarRegNo, startdate, Notes, price, PriceSterlin, PriceEuro
         FROM ${T.carSeyrusefer} WHERE startdate BETWEEN ? AND ?${car}
       ORDER BY CarRegNo, Date`,
      [...p(), ...p(), ...p()],
    );
  });

  app.get('/api/reports/taxi', read, async (req) => {
    const f = parse(range, req.query);
    return q(
      `SELECT id, Name, Surname, ContactNumber, Agency, currency, FlightNumber,
              TaxiDateDeliver, TaxiTimeDeliver, TaxiDeliverFrom, TaxiDeliverTo, PaxsPickUp, TaxiPickUp,
              TaxiDateCollect, TaxiTimeCollect, TaxiCollectFrom, TaxiCollectTo, PaxsDropOff, TaxiDropOff, Notes
       FROM ${T.reservation}
       WHERE Durum <> 'Deleted' AND ((TaxiDeliverFrom <> '' AND TaxiDateDeliver BETWEEN ? AND ?)
                                  OR (TaxiCollectFrom <> '' AND TaxiDateCollect BETWEEN ? AND ?))
       ORDER BY COALESCE(TaxiDateDeliver, TaxiDateCollect)`,
      [f.from, f.to, f.from, f.to],
    );
  });

  app.get('/api/reports/transfers', read, async (req) => {
    const f = parse(range, req.query);
    return q(
      `SELECT id, Name, Surname, ContactNumber, AgencyName, Driver, Currency,
              CheckedArrival, ArrivalDate, ArrivalTime, ArrivalFlightNo, ArrivalCollectFrom, ArrivalDestination, ArrivalPrice, ArrivalPaid,
              CheckedDeparture, DepartureDate, DepartureTime, DepartureCollectFrom, DepartureDestination, DeparturePrice, DeparturePaid
       FROM ${T.transfer}
       WHERE (CheckedArrival = 'Y' AND ArrivalDate BETWEEN ? AND ?) OR (CheckedDeparture = 'Y' AND DepartureDate BETWEEN ? AND ?)
       ORDER BY COALESCE(ArrivalDate, DepartureDate)`,
      [f.from, f.to, f.from, f.to],
    );
  });

  app.get('/api/reports/customers', read, async () =>
    q(`SELECT id, Name, Surname, Email, TelNo, LocalNumber, PassportId, LicenseNo, BirthDate, Address, LocalAddress, BlackList
       FROM ${T.customer} ORDER BY Surname, Name`),
  );

  /** Reservation log (UntLogReports). Columns depend on the existing LogReservation table. */
  app.get('/api/reports/log', { preHandler: requireAuth('admin') }, async (req) => {
    const f = parse(range.extend({ user: z.string().max(50).optional() }), req.query);
    const cols = await tableColumns(T.logReservation).catch(() => new Set<string>());
    if (!cols.size) return [];
    const where: string[] = [];
    const params: unknown[] = [];
    if (cols.has('tdate')) { where.push('TDate BETWEEN ? AND ?'); params.push(f.from, f.to); }
    if (f.user && cols.has('username')) { where.push('UserName = ?'); params.push(f.user); }
    return q(
      `SELECT * FROM ${T.logReservation} ${where.length ? 'WHERE ' + where.join(' AND ') : ''} ORDER BY id DESC LIMIT 2000`,
      params,
    );
  });
}
