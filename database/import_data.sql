create table house (
	id int, 
    type varchar(50), 
	address varchar(100), 
	city varchar(20), 
	state varchar(20), 
	zip int, 
	price int, 
	beds float, 
	baths float, 
	location varchar(50), 
	sf float NULL, 
	lot float, 
	year int, 
	dayson int, 
	pricesf float, 
	latitude double, 
	longitude double,
    primary key (id)
);

 create table crime(
	 id int, 
	 date varchar(20), 
	 PDC int, 
	 PDD varchar(50), 
	 KYC int, 
	 KYD varchar(40), 
	 type varchar(1), 
	 age varchar(10), 
	 sex varchar(1), 
	 race varchar(40), 
	 latitude double, 
	 longitude double,
     primary key (id)
 );