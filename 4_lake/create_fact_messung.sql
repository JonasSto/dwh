DROP TABLE IF EXISTS mart.fact_messung;
CREATE TABLE mart.fact_messung (
    dim_fahrzeug_id INT,
    gesendet TIMESTAMP,
    empfangen TIMESTAMP,
    geschwindigkeit INT
);

-- SELECT payload->>'fin' AS fin, payload->>'zeit' AS zeit, payload->>'geschwindigkeit' AS geschwindigkeit, payload->>'ort' AS ort
-- FROM staging.messung;

INSERT INTO mart.fact_messung (dim_fahrzeug_id, gesendet, empfangen, geschwindigkeit)
SELECT f.dim_fahrzeug_id, TO_TIMESTAMP((m.payload->>'zeit')::INT) AS gesendet, m.empfangen AS empfangen, (m.payload->>'geschwindigkeit')::INT AS geschwindigkeit
FROM mart.dim_fahrzeug AS f
JOIN staging.messung AS m ON f.fin = (m.payload->>'fin');
SELECT *
FROM mart.fact_messung;