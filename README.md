# Heatwave Watch India + PostgreSQL
1. Open `db.js` and put your Postgres password in.
2. pgAdmin: open the `heatwave` database > Query Tool > paste `schema.sql` > run (F5).
3. Terminal in this folder: `npm install`, then `npm run seed`, then `npm start`.
4. Open http://localhost:3000

## Alert level (threshold)
The default alert level is 9% (`model.M.th` in `data.json`, copied into `settings.threshold` by `npm run seed`).
To change it without re-seeding, edit and run `update_threshold.sql` in pgAdmin, then restart `npm start`.
