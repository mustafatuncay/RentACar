import { addDays, monthOf, timePart, toMs } from './dates.js';

/**
 * Pricing rules carried over from UntReservation2.pas (BtnGunClick, BtnCalculateClick,
 * BtnCommissionClick).
 *
 * Wording of the original program:
 *   "Birakilacak" (deliver) = the car is handed to the customer -> rental START
 *   "Alinacak"   (collect) = the car is taken back             -> rental END
 */

export const SEASON_MONTHS = {
  low: [11, 12, 1, 2, 3],
  mid: [4, 5, 6],
  high: [7, 8, 9, 10],
} as const;

export type Season = keyof typeof SEASON_MONTHS;

export function seasonOf(month: number): Season {
  if ((SEASON_MONTHS.low as readonly number[]).includes(month)) return 'low';
  if ((SEASON_MONTHS.mid as readonly number[]).includes(month)) return 'mid';
  return 'high';
}

export interface DayCount {
  totalDays: number;
  lowSeasonDays: number;
  midSeasonDays: number;
  highSeasonDays: number;
}

/**
 * Number of rental days and their split over seasons.
 *
 * Original rule: whole 24-hour periods between delivery and collection, plus one day
 * when the car is collected after 12:59 (HourOf(collect) > 12).
 *
 * Fix: the original loop counted Date+1 .. Date+N, i.e. it skipped the first rental day
 * and counted one day after the rental instead. Here day i = start + i for i = 0..N-1.
 */
export function countDays(startDate: string, startTime: string, endDate: string, endTime: string): DayCount {
  const start = toMs(startDate, startTime);
  const end = toMs(endDate, endTime);
  if (end < start) throw new RangeError('Collection date/time must be after delivery date/time');

  let totalDays = Math.floor((end - start) / 86400000);
  const collectHour = Number(timePart(endTime).slice(0, 2));
  if (collectHour > 12) totalDays += 1;

  const res: DayCount = { totalDays, lowSeasonDays: 0, midSeasonDays: 0, highSeasonDays: 0 };
  for (let i = 0; i < totalDays; i++) {
    const s = seasonOf(monthOf(addDays(startDate, i)));
    if (s === 'low') res.lowSeasonDays++;
    else if (s === 'mid') res.midSeasonDays++;
    else res.highSeasonDays++;
  }
  return res;
}

export interface PriceInput {
  lowSeasonRate: number;
  lowSeasonDays: number;
  midSeasonRate: number;
  midSeasonDays: number;
  highSeasonRate: number;
  highSeasonDays: number;
  extensionRate: number;
  extensionDays: number;
  dailyInsurance: number;
  taxiPickUp: number;
  taxiDropOff: number;
  petrol: number;
  extra: number;
  discount: number;
  /** Commission percentage, e.g. 10 = 10 % */
  commission: number;
  /** Amount per day excluded from the commission base ("Less insurance") */
  lessInsurance: number;
  paid: [number, number, number, number];
}

export interface PriceResult {
  totalDays: number;
  lowSeasonTotal: number;
  midSeasonTotal: number;
  highSeasonTotal: number;
  extensionTotal: number;
  totalInsurance: number;
  generalTotal: number;
  totalCommission: number;
  outstandingBalance: number;
}

const round2 = (n: number) => Math.round((n + Number.EPSILON) * 100) / 100;
const num = (n: unknown) => (Number.isFinite(Number(n)) ? Number(n) : 0);

export function calculatePrice(input: Partial<PriceInput>): PriceResult {
  const i = {
    lowSeasonRate: num(input.lowSeasonRate),
    lowSeasonDays: num(input.lowSeasonDays),
    midSeasonRate: num(input.midSeasonRate),
    midSeasonDays: num(input.midSeasonDays),
    highSeasonRate: num(input.highSeasonRate),
    highSeasonDays: num(input.highSeasonDays),
    extensionRate: num(input.extensionRate),
    extensionDays: num(input.extensionDays),
    dailyInsurance: num(input.dailyInsurance),
    taxiPickUp: num(input.taxiPickUp),
    taxiDropOff: num(input.taxiDropOff),
    petrol: num(input.petrol),
    extra: num(input.extra),
    discount: num(input.discount),
    commission: num(input.commission),
    lessInsurance: num(input.lessInsurance),
    paid: (input.paid ?? [0, 0, 0, 0]).map(num),
  };

  const totalDays = i.lowSeasonDays + i.midSeasonDays + i.highSeasonDays + i.extensionDays;
  const lowSeasonTotal = i.lowSeasonRate * i.lowSeasonDays;
  const midSeasonTotal = i.midSeasonRate * i.midSeasonDays;
  const highSeasonTotal = i.highSeasonRate * i.highSeasonDays;
  const extensionTotal = i.extensionRate * i.extensionDays;
  const totalInsurance = i.dailyInsurance * totalDays;

  const generalTotal =
    lowSeasonTotal + midSeasonTotal + highSeasonTotal + extensionTotal +
    i.taxiPickUp + i.taxiDropOff + i.petrol + i.extra + totalInsurance;

  const paidTotal = i.paid.reduce((a, b) => a + b, 0);
  const outstandingBalance = generalTotal - i.discount - paidTotal;

  const rentalTotal = lowSeasonTotal + midSeasonTotal + highSeasonTotal + extensionTotal;
  const totalCommission = ((rentalTotal - i.lessInsurance * totalDays) * i.commission) / 100;

  return {
    totalDays,
    lowSeasonTotal: round2(lowSeasonTotal),
    midSeasonTotal: round2(midSeasonTotal),
    highSeasonTotal: round2(highSeasonTotal),
    extensionTotal: round2(extensionTotal),
    totalInsurance: round2(totalInsurance),
    generalTotal: round2(generalTotal),
    totalCommission: round2(totalCommission),
    outstandingBalance: round2(outstandingBalance),
  };
}
