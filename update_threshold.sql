-- Run in pgAdmin (heatwave database > Query Tool). Then restart: npm start
-- Sets the alert level to 9% and rebuilds alert_logs the same way the trigger does.
BEGIN;
UPDATE settings SET threshold = 0.09 WHERE id = 1;
UPDATE model_params SET params = params || '{"th": 0.09, "precision": 0.13667117726657646, "recall": 0.6474358974358975, "f1": 0.22569832402234638}'::jsonb WHERE name = 'M';
DELETE FROM alert_logs;
INSERT INTO alert_logs (station_id, issue_date, probability, level)
SELECT f.station_id, f.issue_date, f.probability,
       CASE WHEN f.probability >= s.threshold*2 THEN 'RED' WHEN f.probability >= s.threshold*1.4 THEN 'ORANGE' ELSE 'YELLOW' END
FROM forecasts f, settings s WHERE s.id = 1 AND f.probability >= s.threshold;
COMMIT;
SELECT level, count(*) FROM alert_logs GROUP BY level ORDER BY level;
