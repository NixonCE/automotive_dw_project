-- Carga de datos a dimension de tiempo
insert into dimensions.dim_tiempo(
	fecha,anio,mes,nombre_mes,trimestre,dia,dia_semana
)
select distinct 
	sale_date::DATE,
	extract(year from sale_date),
	extract(month from sale_date),
	TO_CHAR(sale_date,'Month'),
	extract(quarter from sale_date),
	extract(day from sale_date),
	TO_CHAR(sale_date, 'Day')
from staging.car_sales_raw;
--carga de datos a la dimension ubicacion

insert into dimensions.dim_ubicacion(
	state,region
)
select distinct
	state,
	CASE 
        -- West
        WHEN state IN ('ca','or','wa','nv','az','hi','ut','co','nm') THEN 'West'
        -- South
        WHEN state IN ('tx','fl','ga','nc','sc','tn','va','la','ms','al','md') THEN 'South'
        -- Northeast
        WHEN state IN ('ny','nj','ma','pa','ct') THEN 'Northeast'
        -- Midwest
        WHEN state IN ('il','in','mi','mn','mo','oh','wi','ne') THEN 'Midwest'
        -- Canada
        WHEN state IN ('on','qc','ns','ab') THEN 'Canada'
        -- Otros
        WHEN state IN ('ok') THEN 'South'
        WHEN state IN ('pr') THEN 'Caribbean'
        ELSE 'Other'
    END
from staging.car_sales_raw;
-- carga de datos de la dimension de vendedor
insert into dimensions.dim_vendedor(
	seller,
	tipo_vendedor
)
select distinct
	seller,
	CASE
    WHEN seller ILIKE '%bank%' THEN 'financial'
    WHEN seller ILIKE '%leasing%' THEN 'financial'
    WHEN seller ILIKE '%motors%' THEN 'dealer'
    ELSE 'unknown'
END
from staging.car_sales_raw;
-- agregacion de tabla odometer porque puede ser necesaria
alter table dimensions.dim_vehiculo
add column odometer int;
--carga de datos de la dimension vehiculo
insert into dimensions.dim_vehiculo(
	vin,
	year,
	make,
	model,
	trim,
	body,
	transmission,
	color,
	interior,
	condition,
	odometer
)
select distinct on (vin)
 	 vin,
	 year,
	 make,
	 model,
	 trim,
	 body,
	 transmission,
	 color,
	 interior,
	 condition,
	 odometer
from staging.car_sales_raw
order by vin;