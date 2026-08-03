FROM node:20-alpine AS base

RUN apk add --no-cache curl libc6-compat
WORKDIR /src

ARG VERSION=50bdaaea0c02744720ed374d88584fd01494eeb7
ARG SOURCE=https://github.com/mem0ai/mem0
RUN curl -fsSL "${SOURCE}/archive/${VERSION}.tar.gz" | tar xz --strip-components=1

FROM base AS deps
WORKDIR /src/server/dashboard
RUN corepack enable && pnpm install --frozen-lockfile

FROM base AS builder
WORKDIR /src/server/dashboard
COPY --from=deps /src/server/dashboard/node_modules ./node_modules
ENV NEXT_TELEMETRY_DISABLED=1
ENV NEXT_PUBLIC_API_URL=NEXT_PUBLIC_API_URL
ENV NEXT_PUBLIC_INSTANCE_NAME=NEXT_PUBLIC_INSTANCE_NAME
RUN corepack enable && pnpm build

FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
RUN addgroup --system --gid 1001 nodejs \
    && adduser --system --uid 1001 nextjs
COPY --from=builder /src/server/dashboard/public ./public
COPY --from=builder --chown=nextjs:nodejs /src/server/dashboard/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /src/server/dashboard/.next/static ./.next/static
COPY --from=builder --chown=nextjs:nodejs /src/server/dashboard/entrypoint.sh /home/nextjs/entrypoint.sh
RUN chmod +x /home/nextjs/entrypoint.sh
USER nextjs
EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME=0.0.0.0
ENTRYPOINT ["/home/nextjs/entrypoint.sh"]
CMD ["node", "server.js"]
