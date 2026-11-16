import type { FastifyInstance } from 'fastify';
import { z } from 'zod';
import { hasHashColumn, hashPassword, PERMISSIONS, permsFromRow, requireAuth, type Permission } from '../auth.js';
import { config } from '../config.js';
import { exec, one, q } from '../db.js';
import { badRequest, conflict, idParam, notFound, parse, zs } from '../lib/http.js';
import { T } from '../tables.js';

const permKeys = Object.keys(PERMISSIONS) as [Permission, ...Permission[]];
const userSchema = z.object({
  username: z.string().trim().min(1).max(50),
  password: z.string().max(200).optional().default(''),
  duty: zs.text(100),
  description: zs.text(255),
  perms: z.array(z.enum(permKeys)).default([]),
});

/** User administration (UntAdmin). Passwords are never sent back to the browser. */
export async function userRoutes(app: FastifyInstance) {
  const admin = { preHandler: requireAuth('admin') };

  app.get('/api/users', admin, async () => {
    const rows = await q(`SELECT * FROM ${T.users} ORDER BY username`);
    return rows.map((r) => ({
      id: r.id, username: r.username, duty: r.duty ?? '', description: r.description ?? '', perms: permsFromRow(r),
    }));
  });

  async function passwordColumns(password: string) {
    const cols: Record<string, string> = {};
    const hashCol = await hasHashColumn();
    if (hashCol) cols.password_hash = await hashPassword(password);
    // Keep the legacy column while the Delphi program is still used, otherwise blank it.
    cols.password = config.legacyPlaintextPasswords || !hashCol ? password : '';
    return cols;
  }

  function permColumns(perms: Permission[]) {
    return Object.fromEntries(permKeys.map((p) => [PERMISSIONS[p], perms.includes(p) ? 1 : 0]));
  }

  app.post('/api/users', admin, async (req) => {
    const d = parse(userSchema, req.body);
    if (d.password.length < 6) throw badRequest('Password must be at least 6 characters');
    if (await one(`SELECT id FROM ${T.users} WHERE username = ?`, [d.username])) throw conflict('This username already exists');
    const data: Record<string, unknown> = {
      username: d.username, duty: d.duty, description: d.description,
      ...permColumns(d.perms), ...(await passwordColumns(d.password)),
    };
    const cols = Object.keys(data);
    const r = await exec(
      `INSERT INTO ${T.users} (${cols.map((c) => `\`${c}\``).join(',')}) VALUES (${cols.map(() => '?').join(',')})`,
      Object.values(data),
    );
    return { id: r.insertId };
  });

  app.put('/api/users/:id', admin, async (req) => {
    const { id } = parse(idParam, req.params);
    const d = parse(userSchema, req.body);
    if (!(await one(`SELECT id FROM ${T.users} WHERE id = ?`, [id]))) throw notFound();
    if (await one(`SELECT id FROM ${T.users} WHERE id <> ? AND username = ?`, [id, d.username])) throw conflict('This username already exists');
    if (id === req.user.id && !d.perms.includes('admin')) throw badRequest('You can not remove your own admin permission');
    const data: Record<string, unknown> = { username: d.username, duty: d.duty, description: d.description, ...permColumns(d.perms) };
    if (d.password) {
      if (d.password.length < 6) throw badRequest('Password must be at least 6 characters');
      Object.assign(data, await passwordColumns(d.password));
    }
    const cols = Object.keys(data);
    await exec(`UPDATE ${T.users} SET ${cols.map((c) => `\`${c}\`=?`).join(', ')} WHERE id = ?`, [...Object.values(data), id]);
    return { id };
  });

  app.delete('/api/users/:id', admin, async (req) => {
    const { id } = parse(idParam, req.params);
    if (id === req.user.id) throw badRequest('You can not delete yourself');
    await exec(`DELETE FROM ${T.users} WHERE id = ?`, [id]);
    return { ok: true };
  });
}
