#!/usr/bin/env bash
# RentACar PWA: derleme betiği. Depo kök klasöründen değil, web/ klasöründen çalıştırın:
#   cd web && bash deploy/install.sh
# Gereken: Node.js 20 veya 22 LTS.
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== Arayüz (PWA) derleniyor"
(cd client && npm ci && npm run build)

echo "== Sunucu derleniyor"
(cd server && npm ci && npm test && npm run build && npm prune --omit=dev)

if [ ! -f server/.env ]; then
  cp server/.env.example server/.env
  echo "!! server/.env oluşturuldu. DB_PASSWORD ve JWT_SECRET değerlerini doldurun."
fi
echo "Tamam. Servisi başlatmak için: sudo systemctl restart rentacar"
