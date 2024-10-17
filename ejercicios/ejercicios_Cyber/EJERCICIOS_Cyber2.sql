use cyber;


# -- EJERCICIO 1
# Obtener las reservas con el nombre 
# del cliente y la PC utilizada.

SELECT fecha_reserva, computadoras.nombre as nombre_PC,
clientes.nombre as nombre_Cliente
FROM reservas
JOIN clientes ON clientes.id_cliente = reservas.id_cliente
JOIN computadoras ON computadoras.id_computadora = reservas.id_computadora;


# -- EJERCICIO 2
# Obtener el cliente que hizo la reserva más reciente.

SELECT nombre as nombre_cliente,
reservas.fecha_reserva
FROM clientes
JOIN reservas ON reservas.id_cliente = clientes.id_cliente
ORDER BY reservas.fecha_reserva DESC
LIMIT 1;


# -- EJERCICIO 3
# Obtener el total de ingresos por servicio brindado.

SELECT servicios.nombre,
SUM(total) AS total_servicio
FROM facturas
JOIN servicios ON servicios.id_servicio = facturas.id_servicio
GROUP BY servicios.nombre
ORDER BY total_servicio;


# -- EJERCICIO 4
# Obtener el ingreso generado por PC para clientes 
# que reservaron más de 60 min.

SELECT computadoras.nombre,
clientes.nombre,
reservas.duracion_minutos
FROM computadoras
JOIN clientes ON clientes.id_cliente = computadoras.id_computadora
JOIN reservas ON reservas.id_computadora = computadoras.id_computadora
WHERE reservas.duracion_minutos > 60
ORDER BY reservas.duracion_minutos DESC;


# -- EJERCICIO 5
# Obtener los clientes que no han realizado 
# reservas.ALTER

SELECT clientes.nombre
FROM clientes
LEFT JOIN reservas ON clientes.id_cliente = reservas.id_cliente
WHERE reservas.id_reserva IS NULL;


# -- EJERCICIO 6
# Obtener una lista de computadoras y el numero de 
# reservas realizadas por cada una.

SELECT computadoras.nombre, 
COUNT(reservas.id_computadora) AS cant_reservas
FROM computadoras
LEFT JOIN reservas ON reservas.id_computadora = computadoras.id_computadora
GROUP BY computadoras.nombre;


# -- EJERCICIO 7
# Obtener los servicios que no han sido utilizados en facturas.

SELECT servicios.nombre
FROM servicios
LEFT JOIN facturas ON facturas.id_servicio = servicios.id_servicio
WHERE facturas.id_servicio IS NULL;


# -- EJERCICIO 8
# Obtener los clientes y sus facturas incluyendo 
# los que no tienen facturas.

SELECT clientes.nombre, facturas.total
FROM clientes
LEFT JOIN facturas ON facturas.id_cliente = clientes.id_cliente;


# -- EJERCICIO 9
# Obtener el total de ingresos por clientes.

SELECT clientes.nombre,
SUM(facturas.total) as total_ingreso
FROM clientes
LEFT JOIN facturas on facturas.id_cliente = clientes.id_cliente
GROUP BY clientes.nombre;


# -- EJERCICIO 10
# Obtener todas las reservas y la información de los servicios utilizados, 
# incluyendo los que no tienen servicios asociados.

SELECT reservas.fecha_reserva,
servicios.nombre
FROM reservas
LEFT JOIN facturas ON reservas.id_cliente = facturas.id_cliente
LEFT JOIN servicios ON facturas.id_servicio = servicios.id_servicio;

-- otra alternativa:
SELECT computadoras.nombre as PC,
COUNT(reservas.id_reserva) AS cant_reservas
FROM reservas
INNER JOIN computadoras ON computadoras.id_computadora = reservas.id_computadora
GROUP BY computadoras.nombre
ORDER BY cant_reservas DESC
LIMIT 1;


# -- EJERCICIO 11
# Obtener los servicios que tienen un ingreso total superior a un cierto monto (elegir).

SELECT SUM(total) as monto_total,
servicios.nombre as nombre_servicio
FROM facturas
JOIN servicios ON servicios.id_servicio = facturas.id_servicio
GROUP BY servicios.nombre
HAVING monto_total > 60; # having se usa después de group by


# -- EJERCICIO 12
# Obtener las reservas de un cliente específico (tratar de crear una store procedure).

#DELIMITER //
#CREATE PROCEDURE obtenerReservas(IN nombre_cliente VARCHAR(100))
#BEGIN
	SELECT clientes.nombre as nombre_cliente,
	computadoras.nombre as nombre_computadora,
    reservas.fecha_reserva
	FROM reservas
	JOIN computadoras ON reservas.id_computadora = computadoras.id_computadora
	JOIN clientes ON clientes.id_cliente = reservas.id_cliente
	WHERE clientes.nombre = nombre_cliente;
#END
#//
    
# CALL obtenerReservas('Juan Pérez');


#  -- EJERCICIO 13
# Obtener todos los clientes y la duración total de sus revervas.

SELECT SUM(duracion_minutos) as duracion_total,
clientes.nombre as nombre_cliente
FROM clientes
LEFT JOIN reservas ON clientes.id_cliente = reservas.id_cliente
GROUP BY nombre_cliente;


# -- EJERCICIO 14
# Obtener las computadoras y el tiempo total de reservas.

SELECT computadoras.nombre AS nombre_computadora,
SUM(duracion_minutos) AS duracion_total
FROM reservas
JOIN computadoras ON computadoras.id_computadora = reservas.id_computadora
GROUP by nombre_computadora
ORDER BY duracion_total DESC;

