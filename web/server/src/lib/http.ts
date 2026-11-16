import type { FastifyReply, FastifyRequest } from 'fastify';
import { z, ZodError, type ZodTypeAny } from 'zod';

export class HttpError extends Error {
  constructor(public status: number, message: string, public details?: unknown) {
    super(message);
  }
}

export const badRequest = (m: string, d?: unknown) => new HttpError(400, m, d);
export const notFound = (m = 'Record not found') => new HttpError(404, m);
export const conflict = (m: string, d?: unknown) => new HttpError(409, m, d);

export function parse<S extends ZodTypeAny>(schema: S, data: unknown): z.infer<S> {
  try {
    return schema.parse(data);
  } catch (e) {
    if (e instanceof ZodError) {
      throw badRequest(
        e.issues.map((i) => `${i.path.join('.') || 'value'}: ${i.message}`).join('; '),
        e.issues,
      );
    }
    throw e;
  }
}

export const idParam = z.object({ id: z.coerce.number().int().positive() });

/** Common field helpers that accept what HTML forms send (empty strings, numeric strings). */
export const zs = {
  text: (max = 255) => z.string().trim().max(max).optional().default(''),
  money: () => z.coerce.number().finite().optional().default(0),
  int: () => z.coerce.number().int().optional().default(0),
  yn: () => z.enum(['Y', 'N']).optional().default('N'),
  date: () => z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'expected YYYY-MM-DD'),
  optDate: () =>
    z.union([z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'expected YYYY-MM-DD'), z.literal(''), z.null()])
      .optional()
      .transform((v) => (v ? v : null)),
  time: () => z.string().regex(/^([01]\d|2[0-3]):[0-5]\d(:[0-5]\d)?$/, 'expected HH:MM').transform((v) => (v.length === 5 ? `${v}:00` : v)),
};

export function sendError(err: unknown, req: FastifyRequest, reply: FastifyReply) {
  if (err instanceof HttpError) {
    return reply.status(err.status).send({ error: err.message, details: err.details });
  }
  const e = err as { statusCode?: number; message?: string; code?: string };
  if (e.statusCode && e.statusCode < 500) {
    return reply.status(e.statusCode).send({ error: e.message });
  }
  req.log.error(err);
  return reply.status(500).send({ error: 'Unexpected server error' });
}
