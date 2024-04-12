INSERT INTO
  mart.Dim_fahrzeug (
    fin,
    Produktionsdatum,
    modell,
    hersteller_code,
    hersteller_name
  )
SELECT
  fahrzeug.fin,
  fahrzeug.Produktionsdatum,
  fahrzeug.modell,
  fahrzeug.hersteller_code,
  hersteller.hersteller_name
FROM
  staging.fahrzeug
  JOIN staging.hersteller ON fahrzeug.hersteller_code = hersteller.hersteller_code;