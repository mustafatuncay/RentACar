import { readFileSync, existsSync } from 'node:fs';
import { resolve } from 'node:path';

/** Minimal .env loader (no extra dependency). Existing env vars win. */
function loadDotEnv(file: string) {
  if (!existsSync(file)) return;
  for (const raw of readFileSync(file, 'utf8').split(/\r?\n/)) {
    const line = raw.trim();
    if (!line || line.startsWith('#')) continue;
    const eq = line.indexOf('=');
    if (eq < 0) continue;
    const key = line.slice(0, eq).trim();
    let val = line.slice(eq + 1).trim();
    if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) val = val.slice(1, -1);
    if (process.env[key] === undefined) process.env[key] = val;
  }
}

loadDotEnv(resolve(process.cwd(), '.env'));

const env = (k: string, d?: string) => {
  const v = process.env[k] ?? d;
  if (v === undefined) throw new Error(`Missing environment variable ${k}`);
  return v;
};

export const config = {
  port: Number(env('PORT', '3000')),
  host: env('HOST', '127.0.0.1'),
  db: {
    host: env('DB_HOST', '127.0.0.1'),
    port: Number(env('DB_PORT', '3306')),
    user: env('DB_USER', 'rentacar_app'),
    password: env('DB_PASSWORD', ''),
    database: env('DB_NAME', 'RentACar'),
  },
  jwtSecret: env('JWT_SECRET', ''),
  sessionHours: Number(env('SESSION_HOURS', '10')),
  legacyPlaintextPasswords: env('LEGACY_PLAINTEXT_PASSWORDS', 'true') === 'true',
  kurXmlUrl: env('KUR_XML_URL', 'https://www.mb.gov.ct.tr/kur/gunluk.xml'),
  clientDist: resolve(process.cwd(), env('CLIENT_DIST', '../client/dist')),
  isProd: process.env.NODE_ENV === 'production',
};

export function assertConfig() {
  if (config.jwtSecret.length < 32) {
    throw new Error('JWT_SECRET must be set to at least 32 random characters (see .env.example).');
  }
}
