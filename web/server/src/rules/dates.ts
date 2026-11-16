/**
 * Date helpers. All dates travel as strings:
 *   date "YYYY-MM-DD", time "HH:MM" or "HH:MM:SS", datetime "YYYY-MM-DD HH:MM:SS".
 * Calculations use UTC internally so that daylight-saving changes never shift a day.
 */

const DATE_RE = /^(\d{4})-(\d{1,2})-(\d{1,2})/;
const TIME_RE = /(\d{1,2}):(\d{2})(?::(\d{2}))?$/;

/** Extract "YYYY-MM-DD" from a DATE or DATETIME string. */
export function datePart(v: string | null | undefined): string | null {
  if (!v) return null;
  const m = DATE_RE.exec(String(v));
  if (!m) return null;
  const [, y, mo, d] = m;
  if (y === '0000') return null;
  return `${y}-${mo.padStart(2, '0')}-${d.padStart(2, '0')}`;
}

/** Extract "HH:MM" from a TIME or DATETIME string (defaults to 00:00). */
export function timePart(v: string | null | undefined): string {
  if (!v) return '00:00';
  const m = TIME_RE.exec(String(v).trim());
  if (!m) return '00:00';
  return `${m[1].padStart(2, '0')}:${m[2]}`;
}

/** Milliseconds since epoch (UTC) for a date + time. */
export function toMs(date: string, time = '00:00'): number {
  const d = datePart(date);
  if (!d) throw new Error(`Invalid date: ${date}`);
  const [y, mo, da] = d.split('-').map(Number);
  const [h, mi] = timePart(time).split(':').map(Number);
  return Date.UTC(y, mo - 1, da, h, mi);
}

export function addDays(date: string, n: number): string {
  const ms = toMs(date) + n * 86400000;
  return new Date(ms).toISOString().slice(0, 10);
}

export function monthOf(date: string): number {
  return Number(datePart(date)!.slice(5, 7));
}

export function todayLocal(): string {
  const d = new Date();
  const p = (n: number) => String(n).padStart(2, '0');
  return `${d.getFullYear()}-${p(d.getMonth() + 1)}-${p(d.getDate())}`;
}

export function isValidDate(v: unknown): v is string {
  if (typeof v !== 'string' || !/^\d{4}-\d{2}-\d{2}$/.test(v)) return false;
  const [y, m, d] = v.split('-').map(Number);
  const dt = new Date(Date.UTC(y, m - 1, d));
  return dt.getUTCFullYear() === y && dt.getUTCMonth() === m - 1 && dt.getUTCDate() === d;
}

export function isValidTime(v: unknown): v is string {
  return typeof v === 'string' && /^([01]\d|2[0-3]):[0-5]\d(:[0-5]\d)?$/.test(v);
}

/** Inclusive overlap test used by the original program (touching ends count as a clash). */
export function overlaps(aStart: number, aEnd: number, bStart: number, bEnd: number): boolean {
  return aStart <= bEnd && aEnd >= bStart;
}
