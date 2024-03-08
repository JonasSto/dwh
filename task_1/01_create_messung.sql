drop schema if exists staging cascade;

create schema staging;


create table staging.messung (
     messung_id serial
   , payload JSON not null
   , empfangen TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP 
   , CONSTRAINT pk_messung PRIMARY KEY(messung_id)
);