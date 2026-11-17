#!/usr/bin/env bash
# Runs once when the Codespace is created: installs packages, writes .env, builds the PWA.
set -euo pipefail
cd "$(dirname "$0")/../web"

echo "== Installing server packages"
(cd server && npm ci)
echo "== Installing client packages"
(cd client && npm ci)

if [ ! -f server/.env ]; then
  SECRET=$(node -e "console.log(require('crypto').randomBytes(48).toString('hex'))")
  cat > server/.env <<ENV
PORT=3000
HOST=0.0.0.0
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=rentacar_app
DB_PASSWORD=codespace-app
DB_NAME=RentACar
JWT_SECRET=$SECRET
SESSION_HOURS=10
LEGACY_PLAINTEXT_PASSWORDS=true
CLIENT_DIST=../client/dist
ENV
  echo "== server/.env written (test values)"
fi

echo "== Building the PWA"
(cd client && npm run build)
echo "== Setup finished"
