 CREATE TABLE core.h_fahrzeug
  (
     h_fahrzeug_key CHAR(32) NOT NULL PRIMARY KEY,
     fin            CHAR(17) NOT NULL UNIQUE,
     loaddate       TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
     recordsource   VARCHAR(10) NOT NULL
  );

CREATE TABLE core.h_kunde
  (
     h_kunde_key   CHAR(32) NOT NULL PRIMARY KEY,
     kunde_account VARCHAR(50) NOT NULL UNIQUE,
     loaddate      TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
     recordsource  VARCHAR(10) NOT NULL
  );

CREATE TABLE core.l_fahrzeugkauf
  (
     l_fahrzeug_kauf_key CHAR(32) NOT NULL PRIMARY KEY,
     h_fahrzeug_key      CHAR(32) NOT NULL,
     h_kunde_key         CHAR(32) NOT NULL,
     CONSTRAINT fk_fahrzeug FOREIGN KEY(h_fahrzeug_key) REFERENCES core.h_fahrzeug(h_fahrzeug_key),
     CONSTRAINT fk_kunde FOREIGN KEY(h_kunde_key) REFERENCES core.h_kunde(h_kunde_key)
  );

CREATE TABLE core.s_kunde
  (
     h_kunde_key  CHAR(32) NOT NULL PRIMARY KEY,
     vorname      VARCHAR(200) NOT NULL,
     nachname     VARCHAR(200) NOT NULL,
     geschlecht   VARCHAR(20) NOT NULL,
     geburtsdatum DATE,
     ort_id       INTEGER NOT NULL,
     loaddate     TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
     recordsource VARCHAR(10) NOT NULL,
     CONSTRAINT fk_kunde FOREIGN KEY(h_kunde_key) REFERENCES core.h_kunde(h_kunde_key)
  );

CREATE TABLE core.s_fahrzeugkauf
  (
     l_fahrzeug_kauf_key CHAR(32) NOT NULL PRIMARY KEY,
     kfz_kennzeichen     VARCHAR(20) NOT NULL,
     kaufdatum           DATE,
     lieferdatum         DATE,
     kaufpreis           INTEGER,
     rabatt_pct          INTEGER,
     loaddate            TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
     recordsource        VARCHAR(10) NOT NULL,
     CONSTRAINT fk_fahrzeug_kauf FOREIGN KEY(l_fahrzeug_kauf_key) REFERENCES core.l_fahrzeugkauf(l_fahrzeug_kauf_key)
  );

CREATE TABLE core.s_fahrzeug
  (
     h_fahrzeug_key   CHAR(32) NOT NULL PRIMARY KEY,
     modell           VARCHAR(200) NOT NULL,
     produktionsdatum DATE,
     loaddate         TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
     recordsource     VARCHAR(10) NOT NULL,
     CONSTRAINT fk_fahrzeug FOREIGN KEY(h_fahrzeug_key) REFERENCES core.h_fahrzeug(h_fahrzeug_key)
  );

CREATE TABLE core.s_hersteller
  (
     h_fahrzeug_key  CHAR(32) NOT NULL PRIMARY KEY,
     hersteller_code CHAR(3) NOT NULL,
     hersteller_name VARCHAR(200) NOT NULL,
     loaddate        TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
     recordsource    VARCHAR(10) NOT NULL,
     CONSTRAINT fk_fahrzeug FOREIGN KEY(h_fahrzeug_key) REFERENCES core.h_fahrzeug(h_fahrzeug_key)
  );

CREATE TABLE core.s_messung
  (
     h_fahrzeug_key  CHAR(32) NOT NULL PRIMARY KEY,
     geschwindigkeit INTEGER NOT NULL,
     loaddate        TIMESTAMP WITH time zone DEFAULT CURRENT_TIMESTAMP,
     recordsource    VARCHAR(10) NOT NULL,
     CONSTRAINT fk_fahrzeug FOREIGN KEY(h_fahrzeug_key) REFERENCES core.h_fahrzeug(h_fahrzeug_key)
  );  