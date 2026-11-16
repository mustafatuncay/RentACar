import { assertConfig, config } from './config.js';
import { buildApp } from './app.js';
import { pool } from './db.js';

assertConfig();
const app = await buildApp();

try {
  await pool.query('SELECT 1');
} catch (e) {
  app.log.error(`Can not connect to MySQL: ${(e as Error).message}`);
  process.exit(1);
}

await app.listen({ port: config.port, host: config.host });

for (const sig of ['SIGINT', 'SIGTERM'] as const) {
  process.on(sig, async () => {
    await app.close();
    await pool.end();
    process.exit(0);
  });
}
