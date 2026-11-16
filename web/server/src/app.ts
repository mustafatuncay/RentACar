import Fastify from 'fastify';
import cookie from '@fastify/cookie';
import jwt from '@fastify/jwt';
import fastifyStatic from '@fastify/static';
import { existsSync } from 'node:fs';
import { join } from 'node:path';
import { authRoutes, COOKIE } from './auth.js';
import { config } from './config.js';
import { sendError } from './lib/http.js';
import { carRoutes } from './routes/cars.js';
import { customerRoutes } from './routes/customers.js';
import { kurRoutes } from './routes/kur.js';
import { lookupRoutes } from './routes/lookups.js';
import { reportRoutes } from './routes/reports.js';
import { reservationRoutes } from './routes/reservations.js';
import { timetableRoutes } from './routes/timetable.js';
import { transferRoutes } from './routes/transfers.js';
import { userRoutes } from './routes/users.js';

export async function buildApp() {
  const app = Fastify({
    logger: { level: process.env.LOG_LEVEL ?? (config.isProd ? 'info' : 'debug') },
    trustProxy: true, // behind nginx
    bodyLimit: 1024 * 1024,
  });

  await app.register(cookie);
  await app.register(jwt, { secret: config.jwtSecret || 'dev-only-secret-change-me-dev-only-secret', cookie: { cookieName: COOKIE, signed: false } });

  app.setErrorHandler((err, req, reply) => sendError(err, req, reply));

  // Basic security headers (nginx can add more).
  app.addHook('onSend', async (_req, reply) => {
    reply.header('X-Content-Type-Options', 'nosniff');
    reply.header('Referrer-Policy', 'same-origin');
    reply.header('X-Frame-Options', 'DENY');
  });

  app.get('/api/health', async () => ({ ok: true }));
  await app.register(authRoutes);
  await app.register(carRoutes);
  await app.register(customerRoutes);
  await app.register(reservationRoutes);
  await app.register(timetableRoutes);
  await app.register(transferRoutes);
  await app.register(lookupRoutes);
  await app.register(kurRoutes);
  await app.register(userRoutes);
  await app.register(reportRoutes);

  // Serve the built PWA (client/dist) and fall back to index.html for client-side routes.
  if (existsSync(join(config.clientDist, 'index.html'))) {
    await app.register(fastifyStatic, { root: config.clientDist, wildcard: false, index: ['index.html'] });
    app.setNotFoundHandler((req, reply) => {
      if (req.url.startsWith('/api/')) return reply.status(404).send({ error: 'Not found' });
      return reply.type('text/html').sendFile('index.html');
    });
  }
  return app;
}
