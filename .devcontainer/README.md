# RentACar PWA – Codespaces test environment

This Codespace runs the new PWA (`web/`) with a **test** MySQL database that has sample data.
Nothing here touches your real database.

## Open the app
1. Wait until the setup in the terminal finishes (first time: a few minutes).
2. Open the **PORTS** tab and click the address next to port **3000** (or the globe icon).
3. Log in with **admin / admin123** (all permissions) or **staff / staff123** (limited).

The app is private to you by default. To show it to someone else, right-click port 3000 →
*Port Visibility* → *Public* (anyone with the link can then open it, so switch it back afterwards).

## Useful commands (in the terminal)
```bash
bash .devcontainer/start.sh            # restart the app
tail -f /tmp/rentacar.log               # app log
cd web/server && npm test               # run the tests
cd web/client && npm run dev            # live-reload UI on port 5173 (while the app runs on 3000)
```

## Reset the test database
Delete the Codespace and create a new one, or in the terminal:
```bash
cd web/server && node -e "require('mysql2/promise').createConnection({host:'127.0.0.1',user:'root',password:'codespace-root',multipleStatements:true}).then(async c=>{await c.query('DROP DATABASE RentACar; CREATE DATABASE RentACar; GRANT ALL ON RentACar.* TO \'rentacar_app\'@\'%\';');await c.changeUser({database:'RentACar'});const fs=require('fs');await c.query(fs.readFileSync('sql/dev_schema_inferred.sql','utf8'));await c.query(fs.readFileSync('sql/dev_seed.sql','utf8'));await c.end();console.log('reset done')})"
```

## Notes
- The schema is **inferred from the Delphi code**, not taken from the real database. If something
  fails on the real database, the column types may differ.
- Codespaces stop when idle and the free plan has limited hours per month. For daily use install the app
  on your own Linux server (see `web/README.md`).
