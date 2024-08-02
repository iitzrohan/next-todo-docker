# dev.Dockerfile
FROM node:20-alpine

RUN apk add --no-cache libc6-compat git

# Setup pnpm environment
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
RUN corepack prepare pnpm@latest --activate

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile --prefer-frozen-lockfile

COPY . .

ENV NODE_ENV development
ENV NEXT_TELEMETRY_DISABLED 1

CMD ["pnpm", "dev"]

EXPOSE 3000
