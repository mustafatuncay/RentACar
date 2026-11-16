/**
 * API tests with an in-memory fake of the db module (no MySQL needed).
 * They check routing, validation, permissions and the reservation rules.
 */
import { beforeEach, describe, expect, it, vi } from 'vitest';

type Row = Record<string, any>;
const state = vi.hoisted(() => ({
  users: [] as Row[],
  cars: [] as Row[],
  customers: [] as Row[],
  reservations: [] as Row[],
  executed: [] as { sql: string; params: unknown[] }[],
}));

vi.mock('../db.js', () => {
  const norm = (s: string) => s.replace(/\s+/g, ' ').trim();
  async function q(sql: string, params: unknown[] = []) {
    const s = norm(sql);
    if (s.startsWith('SELECT * FROM users WHERE username')) return state.users.filter((u) => u.username === params[0]);
    if (s.startsWith('SELECT id FROM car WHERE id = ? FOR UPDATE')) return state.cars.filter((c) => c.id === params[0]);
    if (s.startsWith('SELECT id, Model, RegNo, Grup, Type FROM car WHERE id')) return state.cars.filter((c) => c.id === params[0]);
    if (s.startsWith('SELECT BlackList, BlackNote, Name2, Surname2, Email FROM customer')) return state.customers.filter((c) => c.id === params[0]);
    if (s.includes('FROM reservation WHERE Durum <> \'Deleted\' AND Carid = ?')) {
      const exclude = s.includes('AND id <> ?') ? params[1] : null;
      return state.reservations.filter((r) => r.Carid === params[0] && r.id !== exclude && r.Durum !== 'Deleted');
    }
    if (s.startsWith('SELECT id, Durum FROM reservation WHERE id = ?')) return state.reservations.filter((r) => r.id === params[0]);
    return [];
  }
  async function exec(sql: string, params: unknown[] = []) {
    state.executed.push({ sql: norm(sql), params });
    return { insertId: 99, affectedRows: 1 };
  }
  const conn = { query: async () => [[]], beginTransaction: async () => {}, commit: async () => {}, rollback: async () => {}, release: () => {} };
  return {
    pool: { query: async () => [[]], getConnection: async () => conn },
    q,
    one: async (sql: string, params: unknown[] = []) => (await q(sql, params))[0],
    exec,
    tx: async (fn: (c: unknown) => unknown) => fn(conn),
    setClause: (data: Row, allowed: string[]) => {
      const cols = allowed.filter((c) => data[c] !== undefined);
      return { sql: cols.map((c) => `\`${c}\`=?`).join(', '), values: cols.map((c) => data[c]), cols };
    },
    insertClause: (data: Row, allowed: string[]) => {
      const cols = allowed.filter((c) => data[c] !== undefined);
      return { sql: `(${cols.join(',')}) VALUES (${cols.map(() => '?').join(',')})`, values: cols.map((c) => data[c]) };
    },
    tableColumns: async () => new Set(['id', 'username', 'password', 'password_hash']),
  };
});

process.env.LOG_LEVEL = 'silent';
const { buildApp } = await import('../app.js');

const baseReservation = {
  Carid: 1, Customerid: 5, Name: 'John', Surname: 'Smith',
  BirakilacakTarih: '2026-07-01', BirakilacakSaat: '10:00',
  AlinacakTarih: '2026-07-05', AlinacakSaat: '10:00',
  HighSeasonRate: 30, HighSeasonDays: 4, currency: 'STERLIN',
};

async function login(app: Awaited<ReturnType<typeof buildApp>>, username = 'admin', password = 'secret1') {
  const res = await app.inject({ method: 'POST', url: '/api/auth/login', payload: { username, password } });
  const cookie = res.cookies.find((c) => c.name === 'rac_session');
  return { res, cookie: cookie ? `rac_session=${cookie.value}` : '' };
}

beforeEach(() => {
  state.users = [
    { id: 1, username: 'admin', password: 'secret1', password_hash: null, PCarEntry: 1, PTimeTable: 1, PCustomerEntry: 1, PReports: 1, PTransfers: 1, PAdmin: 1, PAgency: 1 },
    { id: 2, username: 'viewer', password: 'secret2', password_hash: null, PCarEntry: 0, PTimeTable: 0, PCustomerEntry: 0, PReports: 0, PTransfers: 0, PAdmin: 0, PAgency: 0 },
  ];
  state.cars = [{ id: 1, Model: 'Fiat Panda', RegNo: 'HZ 123', Grup: 'Group 1', Type: 'Manual' }];
  state.customers = [
    { id: 5, BlackList: 'N', Name2: '', Surname2: '', Email: 'j@example.com' },
    { id: 6, BlackList: 'Y', BlackNote: 'Damaged car', Name2: '', Surname2: '', Email: '' },
  ];
  state.reservations = [
    { id: 10, Carid: 1, Durum: 'Saved', Name: 'Ann', Surname: 'Lee', BirakilacakTarih: '2026-07-10', BirakilacakSaat: '10:00:00', AlinacakTarih: '2026-07-15', AlinacakSaat: '10:00:00' },
  ];
  state.executed = [];
});

describe('auth', () => {
  it('rejects wrong password and accepts the legacy plain-text one (upgrading to a hash)', async () => {
    const app = await buildApp();
    expect((await login(app, 'admin', 'nope')).res.statusCode).toBe(401);
    const ok = await login(app);
    expect(ok.res.statusCode).toBe(200);
    expect(ok.res.json().user.perms).toContain('admin');
    expect(state.executed.some((e) => e.sql.startsWith('UPDATE users SET password_hash'))).toBe(true);
  });

  it('requires a session for API calls', async () => {
    const app = await buildApp();
    expect((await app.inject({ method: 'GET', url: '/api/cars' })).statusCode).toBe(401);
  });

  it('enforces permissions', async () => {
    const app = await buildApp();
    const { cookie } = await login(app, 'viewer', 'secret2');
    const res = await app.inject({ method: 'POST', url: '/api/reservations', payload: baseReservation, headers: { cookie } });
    expect(res.statusCode).toBe(403);
  });
});

describe('reservations', () => {
  it('saves a valid reservation with server-side totals', async () => {
    const app = await buildApp();
    const { cookie } = await login(app);
    const res = await app.inject({ method: 'POST', url: '/api/reservations', payload: baseReservation, headers: { cookie } });
    expect(res.statusCode).toBe(200);
    const ins = state.executed.find((e) => e.sql.startsWith('INSERT INTO reservation'))!;
    const cols = ins.sql.slice(ins.sql.indexOf('(') + 1, ins.sql.indexOf(')')).split(',');
    const val = (c: string) => ins.params[cols.indexOf(c)];
    expect(val('GeneralTotal')).toBe(120);
    expect(val('OutstandingBalance')).toBe(120);
    expect(val('CarRegNo')).toBe('HZ 123');
    expect(val('Durum')).toBe('Saved');
    expect(val('email')).toBe('j@example.com');
  });

  it('refuses a double booking', async () => {
    const app = await buildApp();
    const { cookie } = await login(app);
    const res = await app.inject({
      method: 'POST', url: '/api/reservations', headers: { cookie },
      payload: { ...baseReservation, BirakilacakTarih: '2026-07-14', AlinacakTarih: '2026-07-20' },
    });
    expect(res.statusCode).toBe(409);
    expect(res.json().details.code).toBe('DOUBLE_BOOKING');
    expect(res.json().details.clash.id).toBe(10);
  });

  it('allows editing a reservation over its own dates', async () => {
    const app = await buildApp();
    const { cookie } = await login(app);
    const res = await app.inject({
      method: 'PUT', url: '/api/reservations/10', headers: { cookie },
      payload: { ...baseReservation, BirakilacakTarih: '2026-07-11', AlinacakTarih: '2026-07-16' },
    });
    expect(res.statusCode).toBe(200);
  });

  it('asks for confirmation for black-listed customers', async () => {
    const app = await buildApp();
    const { cookie } = await login(app);
    const first = await app.inject({ method: 'POST', url: '/api/reservations', headers: { cookie }, payload: { ...baseReservation, Customerid: 6 } });
    expect(first.statusCode).toBe(409);
    expect(first.json().details).toEqual({ code: 'BLACKLIST', note: 'Damaged car' });
    const second = await app.inject({ method: 'POST', url: '/api/reservations', headers: { cookie }, payload: { ...baseReservation, Customerid: 6, confirmBlacklist: true } });
    expect(second.statusCode).toBe(200);
  });

  it('rejects collection before delivery and invalid input', async () => {
    const app = await buildApp();
    const { cookie } = await login(app);
    const bad = await app.inject({ method: 'POST', url: '/api/reservations', headers: { cookie }, payload: { ...baseReservation, AlinacakTarih: '2026-06-01' } });
    expect(bad.statusCode).toBe(400);
    const invalid = await app.inject({ method: 'POST', url: '/api/reservations', headers: { cookie }, payload: { ...baseReservation, BirakilacakTarih: "2026-07-01' OR 1=1 --" } });
    expect(invalid.statusCode).toBe(400);
  });

  it('calculates days and totals for the form', async () => {
    const app = await buildApp();
    const { cookie } = await login(app);
    const res = await app.inject({
      method: 'POST', url: '/api/reservations/calc', headers: { cookie },
      payload: { BirakilacakTarih: '2026-06-30', BirakilacakSaat: '10:00', AlinacakTarih: '2026-07-05', AlinacakSaat: '15:00', MidSeasonRate: 20, HighSeasonRate: 30, autoDays: true },
    });
    expect(res.statusCode).toBe(200);
    expect(res.json()).toMatchObject({ MidSeasonDays: 1, HighSeasonDays: 5, TotalDays: 6, GeneralTotal: 170 });
  });
});
