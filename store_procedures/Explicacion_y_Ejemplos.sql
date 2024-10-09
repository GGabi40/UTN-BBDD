# Store Procedures

# Son conjuntos de instrucciones q se almacenan en el server de la BBDD
# se ejecutan cuando son invocados.ALTER
# Aceptan parámetros, ejecutan operaciones y devulven resultados.

# Ejemplo: Cyber

use cyber;

DELIMITER //
CREATE PROCEDURE Obtener_reservas_con_clientes()
BEGIN
	SELECT reservas.fecha_reserva, computadoras.nombre as computadora,
    clientes.nombre AS cliente
    FROM reservas
    JOIN computadoras ON computadoras.id_computadora = reservas.id_computadora
    JOIN clientes ON clientes.id_cliente = reservas.id_cliente;
END //

CALL Obtener_reservas_con_clientes();

# Ejemplo 2:
# Crear un procedimiento que devuelva el nombre del cliente
# que realizó la reserva más reciente.

DELIMITER //
CREATE PROCEDURE ClienteConReservaMasReciente()
BEGIN
	SELECT nombre FROM Clientes
    WHERE id_cliente =  ( SELECT id_cliente FROM Reservas
		ORDER BY fecha_reserva DESC
        LIMIT 1);
END //

CALL ClienteConReservaMasReciente();

# Ejemplo 3:
# Crear un procedimiento almacenado que permita 
# cambiar el estado de una computadora

DELIMITER //
CREATE PROCEDURE cambiaEstado(IN id_comp INT, IN nuevo_estado ENUM('Disponible', 'Ocupada', 'Fuera de Servicio'))
BEGIN
	UPDATE computadoras
    SET estado = nuevo_estado
    WHERE id_computadora = id_comp;
END //

CALL cambiaEstado(1, 'Ocupada');

# Ejemplo 4
# Crea un procedimiento que inserte una nueva reserva en a tabla Reservas

DELIMITER //
CREATE PROCEDURE insertaReserva( 
IN id_clien INT,
IN id_comp INT,
IN fecha_res DATETIME,
IN minutos INT)
BEGIN
	INSERT INTO Reservas(id_cliente, id_computadora, fecha_reserva, duracion_minutos) VALUES (id_clien, id_comp, fecha_res, minutos);
END //

CALL insertaReserva(2, 3, '2024-10-03 11:50:00', 70);

# Simular pasar valores por defecto:
DELIMITER //
CREATE PROCEDURE Leone_Valentin_NuevaReserva_con_valor(IN id_cli INT,
 IN id_comp INT,
 IN duracion INT,
 fecha DATETIME)
BEGIN
	SET fecha = IFNULL(fecha, CURRENT_DATE());

	INSERT INTO Reservas (id_cliente,id_computadora,fecha_reserva,duracion_minutos)
    VALUES (id_cli, id_comp, fecha, duracion);
END  //

CALL Leone_Valentin_NuevaReserva_con_valor(1, 1, 119, NULL)


# Ejemplo 5
# Crea un procedimiento que permita cambiar la 
# ubicación de una computadora

DELIMITER //
CREATE PROCEDURE cambiaUbicacion( 
IN id_comp INT,
IN nuevaUbic VARCHAR(100))
BEGIN
	UPDATE computadoras
    SET ubicacion = nuevaUbic
    WHERE id_computadora = id_comp;
END //

CALL cambiaUbicacion(1, 'Sala de Juegos');


# Ejemplo 6
# Crea un procedimiento que inserte una nueva factura:
DELIMITER //
CREATE PROCEDURE nuevaFactura(
IN id_serv INT, 
IN id_clien INT, 
IN fecha DATE, 
IN total DECIMAL(10, 3))
BEGIN
	SET fecha = IFNULL (fecha, CURRENT_DATE());
    
	INSERT INTO facturas (id_servicio, id_cliente, fecha_factura, total) VALUES (id_serv, id_clien, fecha, total);
END // 

CALL nuevafactura(2, 1, NULL, 100);


# Ejemplo 7
# Crea un procedimiento que devuelva los 
# clientes que han realizado más de una reserva

DELIMITER //
CREATE PROCEDURE masDeUnaReserva()
BEGIN
	SELECT clientes.nombre
    FROM clientes
    JOIN reservas ON clientes.id_cliente = reservas.id_cliente
    GROUP BY clientes.nombre
    HAVING COUNT(reservas.id_reserva) > 1;
END //

CALL masDeUnaReserva();