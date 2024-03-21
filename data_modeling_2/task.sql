CREATE TABLE staging.h_fahrzeug (
   h_fahrzeug_key CHAR(32) NOT NULL PRIMARY KEY,
   fin CHAR(17) NOT NULL UNIQUE,
   loaddate TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
   recordsource VARCHAR(10) NOT NULL
);

CREATE TABLE staging.h_kunde (
   h_kunde_key CHAR(32) NOT NULL PRIMARY KEY,
   kunde_account VARCHAR(50) NOT NULL UNIQUE,
   loaddate TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
   recordsource VARCHAR(10) NOT NULL
);

CREATE TABLE staging.l_fahrzeugkauf (
   l_fahrzeug_kauf_key CHAR(32) NOT NULL PRIMARY KEY,
   h_fahrzeug_key CHAR(32) NOT NULL,
   h_kunde_key CHAR(32) NOT NULL,
   CONSTRAINT fk_fahrzeug FOREIGN KEY(h_fahrzeug_key) REFERENCES staging.h_fahrzeug(h_fahrzeug_key),
   CONSTRAINT fk_kunde FOREIGN KEY(h_kunde_key) REFERENCES staging.h_kunde(h_kunde_key)
);

CREATE TABLE staging.s_kunde (
   h_kunde_key CHAR(32) NOT NULL,
   vorname VARCHAR(200) NOT NULL,
   nachname VARCHAR(200) NOT NULL,
   geschlecht VARCHAR(20) NOT NULL,
   geburtsdatum DATE,
   ort_id INTEGER NOT NULL,
   loaddate TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
   recordsource VARCHAR(10) NOT NULL,
   PRIMARY KEY(h_kunde_key, loaddate),
   CONSTRAINT fk_kunde FOREIGN KEY(h_kunde_key) REFERENCES staging.h_kunde(h_kunde_key)
);

CREATE TABLE staging.s_fahrzeugkauf (
   l_fahrzeug_kauf_key CHAR(32) NOT NULL,
   kfz_kennzeichen VARCHAR(20) NOT NULL,
   kaufdatum DATE,
   lieferdatum DATE,
   kaufpreis INTEGER,
   rabatt_pct INTEGER,
   loaddate TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
   recordsource VARCHAR(10) NOT NULL,
   PRIMARY KEY(l_fahrzeug_kauf_key, loaddate),
   CONSTRAINT fk_fahrzeug_kauf FOREIGN KEY(l_fahrzeug_kauf_key) REFERENCES staging.l_fahrzeugkauf(l_fahrzeug_kauf_key)
);

CREATE TABLE staging.s_fahrzeug (
   h_fahrzeug_key CHAR(32) NOT NULL,
   modell VARCHAR(200) NOT NULL,
   produktionsdatum DATE,
   loaddate TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
   recordsource VARCHAR(10) NOT NULL,
   PRIMARY KEY(h_fahrzeug_key, loaddate),
   CONSTRAINT fk_fahrzeug FOREIGN KEY(h_fahrzeug_key) REFERENCES staging.h_fahrzeug(h_fahrzeug_key)
);

CREATE TABLE staging.s_hersteller (
   h_fahrzeug_key CHAR(32) NOT NULL,
   hersteller_code CHAR(3) NOT NULL,
   hersteller_name VARCHAR(200) NOT NULL,
   loaddate TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
   recordsource VARCHAR(10) NOT NULL,
   PRIMARY KEY(h_fahrzeug_key, loaddate),
   CONSTRAINT fk_fahrzeug FOREIGN KEY(h_fahrzeug_key) REFERENCES staging.h_fahrzeug(h_fahrzeug_key)
);

CREATE TABLE staging.s_messung (
   h_fahrzeug_key CHAR(32) NOT NULL,
   geschwindigkeit INTEGER NOT NULL,
   zeit INTEGER NOT NULL,
   loaddate TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
   recordsource VARCHAR(10) NOT NULL,
   PRIMARY KEY(h_fahrzeug_key, loaddate),
   CONSTRAINT fk_fahrzeug FOREIGN KEY(h_fahrzeug_key) REFERENCES staging.h_fahrzeug(h_fahrzeug_key)
);