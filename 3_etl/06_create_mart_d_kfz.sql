INSERT INTO
  mart.Dim_kfz (kfz_kennzeichen)
SELECT
  kfz_kennzeichen
FROM
  staging.fzg_kauf;