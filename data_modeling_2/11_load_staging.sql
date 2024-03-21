INSERT INTO staging.hersteller (hersteller_code, hersteller_name, quelle)
  values 
      ('WDD', 'Mercedes-Benz', 'Fahrzeug DB')
	, ('WVW', 'Volkswagen', 'Fahrzeug DB')
	, ('WBA', 'BMW', 'Fahrzeug DB')
	, ('WB1', 'BMW Motorrad', 'Fahrzeug DB')
	, ('1FM', 'Ford', 'Fahrzeug DB')
	, ('ZFF', 'Ferrari', 'Fahrzeug DB')
	, ('WMA', 'MAN', 'Fahrzeug DB')
	, ('WAU', 'Audi', 'Fahrzeug DB')
	, ('WPO', 'Porsche', 'Fahrzeug DB')
	, ('SCC', 'Lotus', 'Fahrzeug DB')
	, ('WOL', 'Opel', 'Fahrzeug DB')
	, ('VF1', 'Renault', 'Fahrzeug DB')
	, ('SNT', 'Sachsenring Automobilwerke Zwickau GmbH', 'Fahrzeug DB')
;


INSERT INTO staging.land (land_id, land, quelle) values 
      (101, 'Deutschland', 'Geo System')
	, (102, 'Österreich', 'Geo System')
	, (103, 'Mittelerde', 'Geo System')
	, (104, 'Schweiz', 'Geo System')
	, (105, 'China', 'Geo System')
;

INSERT INTO staging.ort (ort_id, ort, land_id, quelle) values 
      (1, 'Stuttgart', 101, 'Geo System')
	, (2, 'Valmar', 103, 'Geo System')
	, (3, 'Wien', 102, 'Geo System')
;
	
INSERT INTO staging.kunde (kunde_account, vorname, nachname, geschlecht, geburtsdatum, wohnort_id, quelle)
VALUES
     ('K001', 'John', 'Doe',         'm', to_date('15.05.1985', 'DD.MM.YYYY'), 1, 'OLTP: CRM')
   , ('K002', 'Jane', 'Smith',       'w', to_date('20.08.1990', 'DD.MM.YYYY'), 1, 'OLTP: CRM')
   , ('K003', 'Bob', 'Johnson',      'm', to_date('10.03.1980', 'DD.MM.YYYY'), 2, 'OLTP: CRM')
   , ('K004', 'Alice', 'Brown',      'w', to_date('05.12.1995', 'DD.MM.YYYY'), 2, 'OLTP: CRM')
   , ('K005', 'Charlie', 'Williams', 'm', to_date('25.06.1988', 'DD.MM.YYYY'), 3, 'OLTP: CRM')
   ;

INSERT INTO staging.fahrzeug (fin, hersteller_code, modell, produktionsdatum, quelle)
VALUES
   ('F1000001', 'SNT', 'Trabant 601 de luxe',   to_date('2019-05-20', 'YYYY-MM-DD'), 'OLTP: Produktionssystem')
 , ('F1000002', 'SNT', 'Trabant 601 de luxe',   to_date('2018-06-10', 'YYYY-MM-DD'), 'OLTP: Produktionssystem')
 , ('F1000003', 'SNT', 'Trabant SUV',           to_date('2018-10-10', 'YYYY-MM-DD'), 'OLTP: Produktionssystem')
 , ('F1000004', 'WPO', '911 Turbo',             to_date('2019-01-30', 'YYYY-MM-DD'), 'OLTP: Produktionssystem')
 , ('F1000005', 'WPO', 'Macan',                 to_date('2017-12-01', 'YYYY-MM-DD'), 'OLTP: Produktionssystem')
 , ('F1000006', 'WB1', 'R 18 Classic',          to_date('2019-11-05', 'YYYY-MM-DD'), 'OLTP: Produktionssystem')
 , ('F1000007', 'WVW', 'Passat',                to_date('2019-01-12', 'YYYY-MM-DD'), 'OLTP: Produktionssystem')
 , ('F1000008', 'WBA', 'BMW 3 Series',          to_date('2018-04-25', 'YYYY-MM-DD'), 'OLTP: Produktionssystem')
 , ('F1000009', 'WDD', 'C-Class',               to_date('2020-01-08', 'YYYY-MM-DD'), 'OLTP: Produktionssystem')
 , ('F1000010', 'WAU', 'A4',                    to_date('2017-09-14', 'YYYY-MM-DD'), 'OLTP: Produktionssystem')
;

INSERT INTO staging.fzg_kauf (fin, kunde_account, kfz_kennzeichen, kaufdatum, lieferdatum, kaufpreis, rabatt_pct, quelle)
VALUES
     ('F1000001', 'K001', 'ABC123', to_date('2020-01-10', 'YYYY-MM-DD'), to_date('2020-01-15', 'YYYY-MM-DD'), 25000, 5, 'OLTP: Buchungssystem')
   , ('F1000002', 'K002', 'XYZ789', to_date('2019-11-25', 'YYYY-MM-DD'), to_date('2019-12-01', 'YYYY-MM-DD'), 22000, 3, 'OLTP: Buchungssystem')
   , ('F1000003', 'K003', 'DEF456', to_date('2020-05-03', 'YYYY-MM-DD'), to_date('2020-05-08', 'YYYY-MM-DD'), 28000, 7, 'OLTP: Buchungssystem')
   , ('F1000004', 'K004', 'GHI789', to_date('2019-09-18', 'YYYY-MM-DD'), to_date('2019-09-25', 'YYYY-MM-DD'), 26000, 4, 'OLTP: Buchungssystem')
   , ('F1000005', 'K005', 'JKL012', to_date('2020-08-12', 'YYYY-MM-DD'), to_date('2020-08-20', 'YYYY-MM-DD'), 23000, 6, 'OLTP: Buchungssystem')
   , ('F1000006', 'K001', 'MNO456', to_date('2020-03-05', 'YYYY-MM-DD'), to_date('2020-03-10', 'YYYY-MM-DD'), 30000, 8, 'OLTP: Buchungssystem')
   , ('F1000007', 'K002', 'PQR789', to_date('2021-02-15', 'YYYY-MM-DD'), to_date('2021-02-20', 'YYYY-MM-DD'), 27000, 5, 'OLTP: Buchungssystem')
   , ('F1000008', 'K003', 'STU012', to_date('2019-07-01', 'YYYY-MM-DD'), to_date('2019-07-10', 'YYYY-MM-DD'), 32000, 9, 'OLTP: Buchungssystem')
   , ('F1000009', 'K004', 'VWX345', to_date('2020-11-08', 'YYYY-MM-DD'), to_date('2020-11-15', 'YYYY-MM-DD'), 29000, 6, 'OLTP: Buchungssystem')
   , ('F1000010', 'K005', 'YZA678', to_date('2021-09-22', 'YYYY-MM-DD'), to_date('2021-09-28', 'YYYY-MM-DD'), 26000, 3, 'OLTP: Buchungssystem')
   , ('F1000002', 'K001', 'BCD901', to_date('2018-06-12', 'YYYY-MM-DD'), to_date('2018-06-18', 'YYYY-MM-DD'), 33000, 7, 'OLTP: Buchungssystem')
   , ('F1000001', 'K002', 'EFG234', to_date('2020-04-30', 'YYYY-MM-DD'), to_date('2020-05-05', 'YYYY-MM-DD'), 28000, 4, 'OLTP: Buchungssystem')
   , ('F1000001', 'K003', 'HIJ567', to_date('2019-12-10', 'YYYY-MM-DD'), to_date('2019-12-15', 'YYYY-MM-DD'), 31000, 9, 'OLTP: Buchungssystem')
   , ('F1000006', 'K004', 'KLM890', to_date('2021-08-05', 'YYYY-MM-DD'), to_date('2021-08-10', 'YYYY-MM-DD'), 27000, 5, 'OLTP: Buchungssystem')
   , ('F1000007', 'K004', 'NOP123', to_date('2019-03-18', 'YYYY-MM-DD'), to_date('2019-03-25', 'YYYY-MM-DD'), 30000, 8, 'OLTP: Buchungssystem')
;
  