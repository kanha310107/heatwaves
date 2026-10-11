-- Demo queries for your viva
-- 1. Top 10 riskiest station-days
SELECT s.name, f.issue_date, round(f.probability::numeric,3) AS prob FROM forecasts f JOIN stations s ON s.id=f.station_id ORDER BY f.probability DESC LIMIT 10;
-- 2. Alerts written by the trigger, per state and level
SELECT s.state, a.level, count(*) FROM alert_logs a JOIN stations s ON s.id=a.station_id GROUP BY s.state, a.level ORDER BY s.state, a.level;
-- 3. Forecast vs observed heatwave: how many alerts were real? (precision)
SELECT count(*) FILTER (WHERE o.target_heatwave) AS true_alerts, count(*) AS all_alerts,
       round(100.0*count(*) FILTER (WHERE o.target_heatwave)/count(*),1) AS precision_pct
FROM alert_logs a JOIN weather_observations o USING (station_id, issue_date);

-- 4. Trigger demo (safe: undone at the end). Run the block from BEGIN to the SELECT, show the result, then run ROLLBACK on its own.
-- First confirm the row exists (must return 1 row):
--   SELECT 1 FROM weather_observations WHERE station_id=1 AND issue_date='2024-01-01';
BEGIN;
DELETE FROM forecasts WHERE station_id=1 AND issue_date='2024-01-01';
INSERT INTO forecasts (station_id, issue_date, probability, predicted_max_temp) VALUES (1,'2024-01-01',0.40,44.0);
SELECT * FROM alert_logs WHERE station_id=1 AND issue_date='2024-01-01';
-- then run this separately:
-- ROLLBACK;

-- 5. Heatwave episodes for station index 0 as of a date (uses heatwave_history)
-- SELECT * FROM heatwave_history(0, '2024-06-01');
