import mysql from 'mysql2/promise';
import type { Pool, PoolConnection, ResultSetHeader, RowDataPacket } from 'mysql2/promise';
import { config } from './config.js';

/**
 * Connection pool to the existing RentACar MySQL database.
 * dateStrings: DATE/DATETIME/TIME come back as plain strings, so no timezone shifts
 * happen between the database, the server and the browser.
 */
export const pool: Pool = mysql.createPool({
  ...config.db,
  waitForConnections: true,
  connectionLimit: 10,
  dateStrings: true,
  decimalNumbers: true,
  charset: 'utf8mb4',
});

export type Row = Record<string, any>;
type Executor = Pick<Pool, 'query'> | PoolConnection;

/** Parameterised SELECT. Never build SQL from user input; pass values in `params`. */
export async function q<T = Row>(sql: string, params: unknown[] = [], ex: Executor = pool): Promise<T[]> {
  const [rows] = await ex.query<RowDataPacket[]>(sql, params);
  return rows as unknown as T[];
}

export async function one<T = Row>(sql: string, params: unknown[] = [], ex: Executor = pool): Promise<T | undefined> {
  const rows = await q<T>(sql, params, ex);
  return rows[0];
}

export async function exec(sql: string, params: unknown[] = [], ex: Executor = pool): Promise<ResultSetHeader> {
  const [res] = await ex.query<ResultSetHeader>(sql, params);
  return res;
}

export async function tx<T>(fn: (c: PoolConnection) => Promise<T>): Promise<T> {
  const c = await pool.getConnection();
  try {
    await c.beginTransaction();
    const r = await fn(c);
    await c.commit();
    return r;
  } catch (e) {
    await c.rollback();
    throw e;
  } finally {
    c.release();
  }
}

/** Build "a=?, b=?" + values for UPDATE, using only whitelisted columns present in data. */
export function setClause(data: Row, allowed: readonly string[]) {
  const cols = allowed.filter((c) => data[c] !== undefined);
  return { sql: cols.map((c) => `\`${c}\`=?`).join(', '), values: cols.map((c) => data[c]), cols };
}

/** Build "(a,b) VALUES (?,?)" for INSERT from whitelisted columns present in data. */
export function insertClause(data: Row, allowed: readonly string[]) {
  const cols = allowed.filter((c) => data[c] !== undefined);
  return {
    sql: `(${cols.map((c) => `\`${c}\``).join(',')}) VALUES (${cols.map(() => '?').join(',')})`,
    values: cols.map((c) => data[c]),
  };
}

const columnCache = new Map<string, Set<string>>();
/** Lower-cased column names of a table (used to tolerate optional columns such as users.password_hash). */
export async function tableColumns(table: string): Promise<Set<string>> {
  const key = table.toLowerCase();
  const cached = columnCache.get(key);
  if (cached) return cached;
  const rows = await q<{ c: string }>(
    'SELECT COLUMN_NAME AS c FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND LOWER(TABLE_NAME) = ?',
    [key],
  );
  const set = new Set(rows.map((r) => r.c.toLowerCase()));
  columnCache.set(key, set);
  return set;
}
