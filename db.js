require('dotenv').config();
const { Pool } = require('pg');
// Online (Render + Neon): set DATABASE_URL. Locally: leave it out and the PG* values are used.
const url = process.env.DATABASE_URL;
const pool = new Pool(url ? { connectionString: url, ssl: { rejectUnauthorized: false } } : {
  host: process.env.PGHOST || 'localhost',
  port: parseInt(process.env.PGPORT) || 5432,
  user: process.env.PGUSER || 'postgres',
  password: process.env.PGPASSWORD,
  database: process.env.PGDATABASE || 'heatwave'
});
pool.on('error', e => console.error('Idle DB client error:', e.message));
module.exports = pool;
