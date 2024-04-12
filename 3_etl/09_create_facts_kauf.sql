SELECT fzg.dim_fahrzeug_id, kunde.dim_kunde_id, kfz.dim_kfz_id, k.kaufdatum, k.lieferdatum, k.kaufpreis, k.rabatt_pct
FROM staging.fzg_kauf AS k
JOIN mart.dim_fahrzeug AS fzg ON k.fin = fzg.fin
JOIN mart.dim_kunde AS kunde ON k.kunde_account = kunde.kunde_account
JOIN mart.dim_kfz AS kfz ON k.kfz_kennzeichen = kfz.kfz_kennzeichen;