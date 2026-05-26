-- creacion de la base de datos del car sales dw
DROP DATABASE IF EXISTS car_sales_dw;
CREATE DATABASE 
-- creacion de squemas
create schema staging;
-- los esquemas dimensions y facts se crean para organizar las tablas de dimensiones y hechos respectivamente
create schema dimensions; 
create schema facts ;

--creacion de tabla staging
create table staging.car_sales_raw (
 year int,
 make varchar(50),
 model varchar(50),
 trim varchar(50),
 body varchar(30),
 transmission varchar(20),
 vin varchar(20),
 state varchar(5),
 condition varchar(4),
 odometer int,
 color varchar(20),
 interior varchar(20),
 seller varchar(100),
 mmr decimal (10,2),
 selling_price decimal(10,2),
 sale_date date
 );