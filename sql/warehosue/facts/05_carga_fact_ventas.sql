-- carga de datos a la tabla de fact_ventas
INSERT INTO facts.fact_ventas (
    fecha_key,
    vehiculo_key,
    ubicacion_key,
    vendedor_key,
    mmr,
    selling_price,
    odometer,
    condition
)

SELECT

    dt.fecha_key,
    dv.vehiculo_key,
    du.ubicacion_key,
    dven.vendedor_key,

    stg.mmr,
    stg.selling_price,
    stg.odometer,
    stg.condition

FROM staging.car_sales_raw stg

JOIN dimensions.dim_tiempo dt
    ON stg.sale_date::DATE = dt.fecha

JOIN dimensions.dim_vehiculo dv
    ON stg.vin = dv.vin

JOIN dimensions.dim_ubicacion du
    ON stg.state = du.state

JOIN dimensions.dim_vendedor dven
    ON stg.seller = dven.seller;