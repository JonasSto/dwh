drop schema if exists mart cascade;

create schema mart;

-- Create dimension tables with named primary keys
CREATE TABLE mart.dim_fahrzeug (
  dim_fahrzeug_id SERIAL,
  fin CHAR(17) UNIQUE NOT NULL,
  hersteller_code char(3) not null,
  hersteller_name VARCHAR(200) NOT NULL,
  modell VARCHAR(200) NOT NULL,
  produktionsdatum DATE,
  CONSTRAINT pk_dim_fahrzeug PRIMARY KEY (dim_fahrzeug_id)
);

CREATE TABLE mart.dim_kunde (
  dim_kunde_id SERIAL,
  kunde_account VARCHAR(50) UNIQUE NOT NULL,
  vorname VARCHAR(200) NOT NULL,
  nachname VARCHAR(200) NOT NULL,
  geschlecht VARCHAR(20) NOT NULL,
  geburtsdatum DATE,
  wohnort varchar(200),
  land varchar(200),
  CONSTRAINT pk_dim_kunde PRIMARY KEY (dim_kunde_id)
);

CREATE TABLE mart.dim_kfz (
  dim_kfz_id SERIAL,
  kfz_kennzeichen VARCHAR(20) UNIQUE NOT NULL,
  CONSTRAINT pk_dim_kfz PRIMARY KEY (dim_kfz_id)
);

/*
 CREATE TABLE mart.dim_datum (
 dim_datum_id SERIAL
 , kalender_datum DATE UNIQUE NOT NULL
 , tag INTEGER NOT NULL
 , monat INTEGER NOT NULL
 , jahr INTEGER NOT NULL
 , CONSTRAINT pk_dim_datum PRIMARY KEY (dim_datum_id)
 );
 */
CREATE TABLE mart.fact_kauf (
  dim_fahrzeug_id INT,
  dim_kunde_id INT,
  dim_kfz_id INT,
  kauf_kalender_datum DATE,
  liefer_kalender_datum DATE,
  kaufpreis INTEGER,
  rabatt_pct INTEGER,
  CONSTRAINT fk_fact_kauf_fahrzeug FOREIGN KEY (dim_fahrzeug_id) REFERENCES mart.dim_fahrzeug(dim_fahrzeug_id),
  CONSTRAINT fk_fact_kauf_kunde FOREIGN KEY (dim_kunde_id) REFERENCES mart.dim_kunde(dim_kunde_id),
  CONSTRAINT fk_fact_kauf_kfz FOREIGN KEY (dim_kfz_id) REFERENCES mart.dim_kfz(dim_kfz_id) --  , CONSTRAINT fk_fact_kauf_date_kauf FOREIGN KEY (kauf_kalender_datum) REFERENCES mart.dim_datum(kalender_datum)
  --  , CONSTRAINT fk_fact_kauf_date_liefer FOREIGN KEY (liefer_kalender_datum) REFERENCES mart.dim_datum(kalender_datum)
);