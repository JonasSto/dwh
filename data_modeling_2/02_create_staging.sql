--drop schema if exists staging cascade;

--create schema staging;

create table staging.hersteller (
     hersteller_code char(3) not null
   , hersteller_name varchar(200) not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(20) not null
   , CONSTRAINT pk_hersteller PRIMARY KEY(hersteller_code)
);

create table staging.land (
     land_id integer not null
   , land varchar(200) not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(20) not null
   , CONSTRAINT pk_land PRIMARY KEY(land_id)
);

create table staging.ort (
     ort_id integer not null
   , ort varchar(200) not null
   , land_id integer not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(20) not null
   , CONSTRAINT pk_ort PRIMARY KEY(ort_id)
   , CONSTRAINT fk_o_land FOREIGN KEY(land_id) REFERENCES staging.land(land_id)
);

create table staging.kunde (
     kunde_account varchar(50) not null
   , vorname varchar(200) not null
   , nachname varchar(200) not null
   , geschlecht varchar(20) not null 
   , geburtsdatum date
   , wohnort_id integer not null
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(50) not null
   , CONSTRAINT pk_kunde PRIMARY KEY(kunde_account)
   , CONSTRAINT fk_k_ort FOREIGN KEY(wohnort_id) REFERENCES staging.ort(ort_id)
);

create table staging.fahrzeug (
     fin char(17) not null
   , hersteller_code char(3) not null
   , modell varchar(200) not null
   , produktionsdatum date
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(50) not null
   , CONSTRAINT pk_fahrzeug PRIMARY KEY(fin)
   , CONSTRAINT fk_f_hersteller FOREIGN KEY(hersteller_code) REFERENCES staging.hersteller(hersteller_code)
);

create table staging.fzg_kauf (
     fin char(17) not null
   , kunde_account varchar(50)
   , kfz_kennzeichen varchar(20) not null
   , kaufdatum date
   , lieferdatum date
   , kaufpreis integer
   , rabatt_pct integer
   , erstellt_am TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , quelle varchar(50) not null
   , CONSTRAINT pk_kfzzuordnung PRIMARY KEY(fin, kunde_account, kaufdatum)
   , CONSTRAINT fk_k_fahrzeug FOREIGN KEY(fin) REFERENCES staging.fahrzeug(fin)
   , CONSTRAINT fk_f_kunde FOREIGN KEY(kunde_account) REFERENCES staging.kunde(kunde_account)
);