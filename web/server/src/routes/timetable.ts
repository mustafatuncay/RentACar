import type { FastifyInstance } from 'fastify';
import { z } from 'zod';
import { requireAuth } from '../auth.js';
import { q } from '../db.js';
import { parse, zs } from '../lib/http.js';
import { T } from '../tables.js';

/** Data for the time table grid (UntTimeTable.BtnListClick) and the daily movement lists. */
export async function timetableRoutes(app: FastifyInstance) {
  const read = { preHandler: requireAuth('timetable') };

  app.get('/api/timetable', read, async (req) => {
    const f = parse(
      z.object({
        from: zs.date(),
        to: zs.date(),
        group: z.string().max(50).optional(),
        car: z.string().max(100).optional(),
      }),
      req.query,
    );
    const where = ['(Sold IS NULL OR Sold <> 1)'];
    const params: unknown[] = [];
    if (f.group) { where.push('Grup = ?'); params.push(f.group); }
    if (f.car) { where.push('(RegNo LIKE ? OR Model LIKE ?)'); params.push(`${f.car}%`, `${f.car}%`); }
    const cars = await q(
      `SELECT id, Model, RegNo, Grup, Type, Color, FontColor, SiraNo FROM ${T.car} WHERE ${where.join(' AND ')} ORDER BY Grup, SiraNo, Model`,
      params,
    );
    const ids = cars.map((c) => c.id);
    const reservations = ids.length
      ? await q(
          `SELECT id, Carid, Name, Surname, ContactNumber, Notes, BirakilacakTarih, BirakilacakSaat, DeliverTimeChecked,
                  AlinacakTarih, AlinacakSaat, CollectTimeChecked, birakilacakYer, AlinacakYer,
                  LowSeasonDays, MidSeasonDays, HighSeasonDays, ExtensionDays, OutstandingBalance, currency
           FROM ${T.reservation}
           WHERE Durum <> 'Deleted' AND Carid IN (?) AND AlinacakTarih >= ? AND BirakilacakTarih <= ?
           ORDER BY BirakilacakTarih, BirakilacakSaat`,
          [ids, f.from, f.to],
        )
      : [];
    return { cars, reservations };
  });

  /** Daily lists: cars to deliver / collect, transfers and taxis for one day (time table tabs). */
  app.get('/api/timetable/day', read, async (req) => {
    const { date } = parse(z.object({ date: zs.date() }), req.query);
    const [deliveries, collections, arrivals, departures, taxiDeliver, taxiCollect] = await Promise.all([
      q(`SELECT id, Name, Surname, ContactNumber, CarModel, CarRegNo, BirakilacakSaat, DeliverTimeChecked, birakilacakYer, FlightNumber, FlightTime, ChkFlightTime, Notes, BirakilacakNotlar
         FROM ${T.reservation} WHERE Durum <> 'Deleted' AND BirakilacakTarih = ? ORDER BY BirakilacakSaat`, [date]),
      q(`SELECT id, Name, Surname, ContactNumber, CarModel, CarRegNo, AlinacakSaat, CollectTimeChecked, AlinacakYer, OutstandingBalance, currency, Notes, AlinacakNotlar
         FROM ${T.reservation} WHERE Durum <> 'Deleted' AND AlinacakTarih = ? ORDER BY AlinacakSaat`, [date]),
      q(`SELECT id, Name, Surname, ArrivalTime, ArrivalTimeChecked, Driver, ArrivalCollectFrom, ArrivalDestination, ArrivalPax, ArrivalFlightNo,
                ArrivalPrice, ArrivalPaid, ArrivalPaidTo, ArrivalBabySeat, ArrivalBoosterSeat, ArrivalNotes, AgencyName, CarRegNo, CarModel, Currency, ContactNumber
         FROM ${T.transfer} WHERE CheckedArrival = 'Y' AND ArrivalDate = ? ORDER BY ArrivalTime`, [date]),
      q(`SELECT id, Name, Surname, DepartureTime, DepartureTimeChecked, Driver, DepartureCollectFrom, DepartureDestination, DeparturePax,
                DeparturePrice, DeparturePaid, PaidTo, DepartureBabySeat, DepartureBoosterSeat, DepartureNotes, AgencyName, CarRegNo, CarModel, Currency, ContactNumber
         FROM ${T.transfer} WHERE CheckedDeparture = 'Y' AND DepartureDate = ? ORDER BY DepartureTime`, [date]),
      q(`SELECT id, Name, Surname, ContactNumber, TaxiTimeDeliver, ChkTaxiTimeDeliver, TaxiDeliverFrom, TaxiDeliverTo, PaxsPickUp, TaxiPickUp, Agency, CarRegNo, CarModel, currency, FlightNumber
         FROM ${T.reservation} WHERE Durum <> 'Deleted' AND TaxiDeliverFrom <> '' AND TaxiDateDeliver = ? ORDER BY TaxiTimeDeliver`, [date]),
      q(`SELECT id, Name, Surname, ContactNumber, TaxiTimeCollect, ChkTaxiTimeCollect, TaxiCollectFrom, TaxiCollectTo, PaxsDropOff, TaxiDropOff, Agency, CarRegNo, CarModel, currency
         FROM ${T.reservation} WHERE Durum <> 'Deleted' AND TaxiCollectFrom <> '' AND TaxiDateCollect = ? ORDER BY TaxiTimeCollect`, [date]),
    ]);
    return { deliveries, collections, arrivals, departures, taxiDeliver, taxiCollect };
  });
}
