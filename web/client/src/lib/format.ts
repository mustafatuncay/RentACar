export const CURRENCIES = ['TL', 'EURO', 'STERLIN', 'DOLLAR'] as const;
export const CURRENCY_SYMBOL: Record<string, string> = { TL: 'TL', EURO: '€', STERLIN: '£', DOLLAR: '$' };
export const CAR_GROUPS = ['Group 1', 'Group 2', 'Group 3', 'Group 4', 'Group 5', 'Group 6', 'Group 7'];
export const WEEKDAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
export const MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

/** "2026-05-03" or "2026-05-03 00:00:00" -> "03/05/2026" */
export function fmtDate(v?: string | null) {
  const m = /^(\d{4})-(\d{2})-(\d{2})/.exec(v ?? '');
  if (!m || m[1] === '0000') return '';
  return `${m[3]}/${m[2]}/${m[1]}`;
}

/** "14:05:00" or "1899-12-30 14:05:00" -> "14:05" */
export function fmtTime(v?: string | null) {
  const m = /(\d{1,2}):(\d{2})(?::\d{2})?$/.exec((v ?? '').trim());
  return m ? `${m[1].padStart(2, '0')}:${m[2]}` : '';
}

export function toDateInput(v?: string | null) {
  const m = /^(\d{4})-(\d{2})-(\d{2})/.exec(v ?? '');
  return m && m[1] !== '0000' ? `${m[1]}-${m[2]}-${m[3]}` : '';
}

export function fmtMoney(v: unknown, currency?: string) {
  const n = Number(v ?? 0);
  const s = n.toLocaleString('en-GB', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  return currency ? `${s} ${CURRENCY_SYMBOL[currency] ?? currency}` : s;
}

export function today() {
  const d = new Date();
  return isoDate(d);
}

export function isoDate(d: Date) {
  const p = (n: number) => String(n).padStart(2, '0');
  return `${d.getFullYear()}-${p(d.getMonth() + 1)}-${p(d.getDate())}`;
}

export function addDays(iso: string, n: number) {
  const [y, m, d] = iso.split('-').map(Number);
  return isoDate(new Date(y, m - 1, d + n));
}

export function daysBetween(a: string, b: string) {
  const [y1, m1, d1] = a.split('-').map(Number);
  const [y2, m2, d2] = b.split('-').map(Number);
  return Math.round((Date.UTC(y2, m2 - 1, d2) - Date.UTC(y1, m1 - 1, d1)) / 86400000);
}

/** Totals per currency, e.g. for report footers. */
export function sumByCurrency(rows: any[], field: string, currencyField = 'currency') {
  const out: Record<string, number> = {};
  for (const r of rows) {
    const c = r[currencyField] || '-';
    out[c] = (out[c] ?? 0) + Number(r[field] ?? 0);
  }
  return out;
}

/** Download rows as a CSV file that opens correctly in Excel. */
export function downloadCsv(filename: string, rows: any[], columns?: { field: string; header: string }[]) {
  if (!rows.length) return;
  const cols = columns ?? Object.keys(rows[0]).map((k) => ({ field: k, header: k }));
  const esc = (v: unknown) => {
    const s = v === null || v === undefined ? '' : String(v);
    return /[",;\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s;
  };
  const lines = [cols.map((c) => esc(c.header)).join(';'), ...rows.map((r) => cols.map((c) => esc(r[c.field])).join(';'))];
  const blob = new Blob(['﻿' + lines.join('\r\n')], { type: 'text/csv;charset=utf-8' });
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = filename;
  a.click();
  URL.revokeObjectURL(a.href);
}
