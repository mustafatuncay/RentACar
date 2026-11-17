#!/usr/bin/env bash
# Runs every time the Codespace starts: waits for MySQL, then starts the app in the background.
set -uo pipefail
cd "$(dirname "$0")/../web/server"
LOG=/tmp/rentacar.log

echo "== Waiting for MySQL"
for i in $(seq 1 60); do
  if node -e "
    const m = require('mysql2/promise');
    m.createConnection({ host: '127.0.0.1', user: 'rentacar_app', password: 'codespace-app', database: 'RentACar' })
      .then(c => c.query('SELECT COUNT(*) FROM users').then(() => c.end()))
      .then(() => process.exit(0), () => process.exit(1));
  " 2>/dev/null; then
    echo "MySQL is ready"; break
  fi
  sleep 2
done

pkill -f "tsx.*src/index.ts" 2>/dev/null || true
echo "== Starting RentACar on port 3000 (log: $LOG)"
setsid nohup npx tsx src/index.ts > "$LOG" 2>&1 < /dev/null &
sleep 3
tail -n 5 "$LOG" || true
echo "Open the PORTS tab and click the address next to port 3000. Login: admin / admin123"
