FROM node:20-bookworm-slim

WORKDIR /app

# Enable pnpm via Corepack and install dependencies first for better layer cache.
RUN corepack enable

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY plugins/vscode/package.json ./plugins/vscode/package.json

RUN pnpm install --frozen-lockfile

COPY . .

RUN pnpm run build

ENTRYPOINT ["node", "dist/cli.js"]
