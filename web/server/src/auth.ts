import type { FastifyInstance, FastifyReply, FastifyRequest } from 'fastify';
import bcrypt from 'bcryptjs';
import { z } from 'zod';
import { config } from './config.js';
import { exec, one, tableColumns } from './db.js';
import { HttpError, parse } from './lib/http.js';
import { T } from './tables.js';

/** Permission flags of the original users table (UntAdmin / UntLogin). */
export const PERMISSIONS = {
  cars: 'PCarEntry',
  timetable: 'PTimeTable',
  customers: 'PCustomerEntry',
  reports: 'PReports',
  transfers: 'PTransfers',
  admin: 'PAdmin',
  agency: 'PAgency',
} as const;
export type Permission = keyof typeof PERMISSIONS;

export interface SessionUser {
  id: number;
  username: string;
  perms: Permission[];
}

declare module '@fastify/jwt' {
  interface FastifyJWT {
    payload: SessionUser;
    user: SessionUser;
  }
}

export const COOKIE = 'rac_session';

export function permsFromRow(row: Record<string, unknown>): Permission[] {
  const lower = Object.fromEntries(Object.entries(row).map(([k, v]) => [k.toLowerCase(), v]));
  return (Object.keys(PERMISSIONS) as Permission[]).filter((p) => Number(lower[PERMISSIONS[p].toLowerCase()]) === 1);
}

export async function hasHashColumn() {
  return (await tableColumns(T.users)).has('password_hash');
}

export async function hashPassword(plain: string) {
  return bcrypt.hash(plain, 12);
}

// Very small brute-force protection: 5 failed logins per IP+user in 10 minutes.
const failures = new Map<string, { n: number; until: number }>();
function tooMany(key: string) {
  const f = failures.get(key);
  return !!f && f.n >= 5 && f.until > Date.now();
}
function fail(key: string) {
  const f = failures.get(key);
  const now = Date.now();
  if (!f || f.until < now) failures.set(key, { n: 1, until: now + 10 * 60_000 });
  else f.n++;
}

export function requireAuth(perm?: Permission) {
  return async (req: FastifyRequest, _reply: FastifyReply) => {
    try {
      await req.jwtVerify();
    } catch {
      throw new HttpError(401, 'Please log in');
    }
    if (perm && !req.user.perms.includes(perm)) {
      throw new HttpError(403, 'You do not have permission for this screen');
    }
  };
}

export async function authRoutes(app: FastifyInstance) {
  app.post('/api/auth/login', async (req, reply) => {
    const body = parse(
      z.object({ username: z.string().trim().min(1).max(100), password: z.string().min(1).max(200) }),
      req.body,
    );
    const key = `${req.ip}|${body.username.toLowerCase()}`;
    if (tooMany(key)) throw new HttpError(429, 'Too many attempts, please wait a few minutes');

    const row = await one(`SELECT * FROM ${T.users} WHERE username = ? LIMIT 1`, [body.username]);
    let ok = false;
    if (row) {
      const hash = row.password_hash as string | null | undefined;
      if (hash) {
        ok = await bcrypt.compare(body.password, hash);
      } else if (typeof row.password === 'string' && row.password.length > 0) {
        // Legacy plain-text password from the Delphi program.
        ok = row.password === body.password;
        if (ok && (await hasHashColumn())) {
          // Upgrade silently: store a hash next to it (the Delphi column stays untouched).
          await exec(`UPDATE ${T.users} SET password_hash = ? WHERE id = ?`, [await hashPassword(body.password), row.id]);
        }
      }
    }
    if (!row || !ok) {
      fail(key);
      throw new HttpError(401, 'Wrong username or password');
    }
    failures.delete(key);

    const user: SessionUser = { id: Number(row.id), username: String(row.username), perms: permsFromRow(row) };
    const token = await reply.jwtSign(user, { expiresIn: `${config.sessionHours}h` });
    reply.setCookie(COOKIE, token, {
      httpOnly: true,
      sameSite: 'strict',
      secure: config.isProd,
      path: '/',
      maxAge: config.sessionHours * 3600,
    });
    return { user };
  });

  app.post('/api/auth/logout', async (_req, reply) => {
    reply.clearCookie(COOKIE, { path: '/' });
    return { ok: true };
  });

  app.get('/api/auth/me', { preHandler: requireAuth() }, async (req) => ({ user: req.user }));
}
