create table house_location as
select id,longitude,latitude
from house;

create table house_add as
select id,address,city,zip,location,state
from house;

create table house_type as
select id,beds,baths
from house;

create table house_detail as
select id,type,lot,year,dayson
from house;

create table house_price as
select sf,pricesf,price
from house;