import { describe, expect, it } from 'vitest';
import { calculatePrice, countDays } from './pricing.js';
import { datePart, overlaps, timePart, toMs } from './dates.js';

describe('countDays', () => {
  it('counts whole 24h periods', () => {
    expect(countDays('2026-05-01', '10:00', '2026-05-04', '10:00').totalDays).toBe(3);
  });
  it('adds a day when collected after 12:59', () => {
    expect(countDays('2026-05-01', '10:00', '2026-05-04', '13:00').totalDays).toBe(4);
    expect(countDays('2026-05-01', '10:00', '2026-05-04', '12:30').totalDays).toBe(3);
  });
  it('splits seasons starting from the first rental day (fixed off-by-one)', () => {
    // 30 June (mid) .. 5 July: days are 30.06, 1.07, 2.07, 3.07, 4.07
    const r = countDays('2026-06-30', '10:00', '2026-07-05', '10:00');
    expect(r.totalDays).toBe(5);
    expect(r.midSeasonDays).toBe(1);
    expect(r.highSeasonDays).toBe(4);
  });
  it('handles year change in low season', () => {
    const r = countDays('2026-12-30', '09:00', '2027-01-02', '09:00');
    expect(r).toEqual({ totalDays: 3, lowSeasonDays: 3, midSeasonDays: 0, highSeasonDays: 0 });
  });
  it('compares full date and time (no midnight=24 hack)', () => {
    expect(() => countDays('2026-05-02', '00:00', '2026-05-01', '23:00')).toThrow();
    expect(countDays('2026-05-01', '23:00', '2026-05-02', '00:00').totalDays).toBe(0);
  });
});

describe('calculatePrice', () => {
  it('matches the original formulas', () => {
    const r = calculatePrice({
      lowSeasonRate: 20, lowSeasonDays: 2,
      midSeasonRate: 30, midSeasonDays: 1,
      highSeasonRate: 40, highSeasonDays: 1,
      extensionRate: 25, extensionDays: 1,
      dailyInsurance: 5,
      taxiPickUp: 15, taxiDropOff: 15, petrol: 10, extra: 3,
      discount: 8, commission: 10, lessInsurance: 2,
      paid: [50, 20, 0, 0],
    });
    expect(r.totalDays).toBe(5);
    expect(r.generalTotal).toBe(40 + 30 + 40 + 25 + 15 + 15 + 10 + 3 + 25);
    expect(r.outstandingBalance).toBe(203 - 8 - 70);
    expect(r.totalCommission).toBe(((135 - 10) * 10) / 100);
  });
  it('treats missing values as zero', () => {
    expect(calculatePrice({}).generalTotal).toBe(0);
  });
});

describe('dates', () => {
  it('parses DATE, DATETIME and TIME strings', () => {
    expect(datePart('2026-5-3')).toBe('2026-05-03');
    expect(datePart('2026-05-03 00:00:00')).toBe('2026-05-03');
    expect(datePart('0000-00-00')).toBeNull();
    expect(timePart('1899-12-30 14:05:00')).toBe('14:05');
    expect(timePart('9:30:00')).toBe('09:30');
  });
  it('overlap is inclusive like the original', () => {
    const a = toMs('2026-05-01', '10:00');
    const b = toMs('2026-05-05', '10:00');
    expect(overlaps(a, b, b, toMs('2026-05-07', '10:00'))).toBe(true);
    expect(overlaps(a, b, toMs('2026-05-05', '10:01'), toMs('2026-05-07', '10:00'))).toBe(false);
  });
});
