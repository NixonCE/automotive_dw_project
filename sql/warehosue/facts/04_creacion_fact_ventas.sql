--creacion de de la tabla de fact_venta en la dimension fact
create table facts.fact_ventas(
	venta_key serial primary key,
	--foreing key de las dimensiones
	fecha_key int references dimensions.dim_tiempo(fecha_key),
	vehiculo_key int references dimensions.dim_vehiculo(vehiculo_key),
	ubicacion_key int references dimensions.dim_ubicacion(ubicacion_key),
	vendedor_key int references dimensions.dim_vendedor(vendedor_key),
	mmr numeric(10,2),
	selling_price numeric(10,2),
	odometer int,
	condition varchar(20)
);