create table crime_location as
select id,latitude,longitude
from crime;

create table crime_level as
select id,KYC,PDC
from crime;

create table PDC_description as
select distinct PDC,PDD
from crime;

create table KYC_description as
select distinct KYC,KYD
from crime;

create table crime_type as
select type,min(KYC) as lower_bound,max(KYC) as upper_bound
from crime
group by type;

create table criminal_detail as
select id,age,sex,race
from crime;

create table crime_date as
select id,cridate
from crime;
