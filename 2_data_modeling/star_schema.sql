DROP SCHEMA IF EXISTS mart CASCADE;
CREATE SCHEMA mart;

CREATE TABLE mart.d_kunde 
(
    kunde_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    kundenaccount VARCHAR(50) NOT NULL UNIQUE,
    vorname VARCHAR(200) NOT NULL,
    nachname VARCHAR(200) NOT NULL,
    geschlecht VARCHAR(20) NOT NULL,
    geburtsdatum DATE,
    ort VARCHAR(200),
    land VARCHAR(200)
);

CREATE TABLE mart.d_fahrzeug 
(
    fahrzeug_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fin CHAR(17) NOT NULL UNIQUE,
    hersteller_code CHAR(3) NOT NULL,
    hersteller_name VARCHAR(200) NOT NULL,
    modell VARCHAR(200) NOT NULL,
    produktionsdatum DATE
)

CREATE TABLE mart.d_kennzeichen 
(
    kennzeichen_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    kfz VARCHAR(20) NOT NULL 
)

CREATE TABLE mart.f_sales
(
    kunde INTEGER NOT NULL,
    fahrzeug INTEGER NOT NULL,
    kennzeichen INTEGER NOT NULL,
    kaufdatum DATE,
    lieferdatum DATE,
    kaufpreis INTEGER,
    rabatt_pct INTEGER,
    CONSTRAINT fk_kunde FOREIGN KEY(kunde) REFERENCES mart.d_kunde(kunde_id),
    CONSTRAINT fk_fahrzeug FOREIGN KEY(fahrzeug) REFERENCES mart.d_fahrzeug(fahrzeug_id),
    CONSTRAINT fk_kennzeichen FOREIGN KEY(kennzeichen) REFERENCES mart.d_kennzeichen(kennzeichen_id)
)