## EJERCICIOS TABLAS TEMPORALES
# (Utilizando Cyber)

use cyber;


## EJERCICIO 1

CREATE TEMPORARY TABLE total_facturacion_cliente AS 
	SELECT id_cliente, SUM(facturas.total) AS total_factura
    FROM facturas
    GROUP BY id_cliente;


SELECT * FROM total_facturacion_cliente
WHERE total_factura > 100;


## EJERCICIO 2
CREATE TEMPORARY TABLE tiempo_uso_cliente AS
	SELECT id_cliente, SUM(reservas.duracion_minutos) AS total_duracion
    FROM reservas
    GROUP BY id_cliente;
    
    
SELECT * FROM tiempo_uso_cliente
WHERE total_duracion > 100;


## EJERCICIO 3
CREATE TEMPORARY TABLE cantidades_computadoras_ocupadas AS 
	SELECT ubicacion, COUNT(estado) as cant_ocupada
    FROM computadoras
    WHERE estado = 'Ocupada'
    GROUP BY ubicacion;

SELECT * FROM cantidades_computadoras_ocupadas;


## EJERCICIO 4
CREATE TEMPORARY TABLE reservas_compus_disponibles AS
	SELECT reservas.id_computadora, nombre, fecha_reserva 
    FROM reservas
    JOIN computadoras ON computadoras.id_computadora = reservas.id_computadora
    WHERE computadoras.estado = 'Disponible' AND fecha_reserva > '2024-10-01';

SELECT * FROM reservas_compus_disponibles;


## EJERCICIO 5
CREATE TEMPORARY TABLE servicios_cliente AS
	SELECT id_cliente, servicios.nombre, SUM(total)
    FROM facturas
    JOIN servicios ON servicios.id_servicio = facturas.id_servicio
    GROUP BY servicios.nombre, id_cliente;

SELECT * FROM servicios_cliente;


## EJERCICIO 6
CREATE TEMPORARY TABLE clientes_multip_reservas AS
	SELECT 
    id_cliente,
    fecha_reserva,
    COUNT(*) AS total_reservas
	FROM reservas
	WHERE date(fecha_reserva) LIKE '2024-10-01'
	GROUP BY id_cliente;

SELECT * FROM clientes_multip_reservas;


    
SELECT * FROM facturas;