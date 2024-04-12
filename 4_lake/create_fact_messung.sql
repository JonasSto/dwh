DROP VIEW IF EXISTS mart.agg_sampling_1min;

DROP TABLE IF EXISTS mart.fact_messung;
CREATE TABLE mart.fact_messung (
    dim_fahrzeug_id INT,
    gesendet TIMESTAMP,
    empfangen TIMESTAMP,
    geschwindigkeit INT
) PARTITION BY RANGE (EXTRACT(YEAR FROM gesendet));

CREATE TABLE mart.fact_messung_2023 PARTITION OF mart.fact_messung FOR VALUES FROM (2023) TO (2024); 
CREATE TABLE mart.fact_messung_2024 PARTITION OF mart.fact_messung FOR VALUES FROM (2024) TO (2025);
-- SELECT payload->>'fin' AS fin, payload->>'zeit' AS zeit, payload->>'geschwindigkeit' AS geschwindigkeit, payload->>'ort' AS ort
-- FROM staging.messung;

INSERT INTO mart.fact_messung (dim_fahrzeug_id, gesendet, empfangen, geschwindigkeit)
SELECT f.dim_fahrzeug_id, TO_TIMESTAMP((m.payload->>'zeit')::INT) AS gesendet, m.empfangen AS empfangen, (m.payload->>'geschwindigkeit')::INT AS geschwindigkeit
FROM mart.dim_fahrzeug AS f
JOIN staging.messung AS m ON f.fin = (m.payload->>'fin');

CREATE VIEW mart.agg_sampling_1min AS
SELECT
  dim_fahrzeug_id,
  DATE_TRUNC('minute', gesendet) AS minute_interval,
  ROUND(AVG(geschwindigkeit), 2) AS durch_geschw,
  COUNT(*) AS anzahl
FROM
  mart.fact_messung
GROUP BY
  dim_fahrzeug_id,
  minute_interval;

SELECT * FROM mart.agg_sampling_1min;