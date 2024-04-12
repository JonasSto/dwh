INSERT INTO mart.dim_kunde (kunde_account, vorname, nachname, geschlecht, geburtsdatum, wohnort, land)
SELECT kunde_account, vorname, nachname, geschlecht, geburtsdatum, ort AS wohnort, land
FROM staging.Kunde
JOIN staging.ort ON (staging.Kunde.wohnort_id = staging.ort.ort_id)
JOIN staging.land ON (staging.ort.land_id = staging.land.land_id);