use caret2;

#1. CONTRAINT:
#El negocio quiere empezar a registrar la información de las multas que poseen cada vehículo.
#De cada multa se desea registrar:
#● id_multa (código identificador autoincremental)
#● id_vehiculo (código del vehiculo al cual se dirije la multa)
#● fecha_multa
#● descripcion_infraccion
#● monto
#● pagada (registra si la multa fue pagada o no)
#● fecha_pago
#● observaciones (campo texto)
#Se solicita escribir el CREATE TABLE de esta nueva tabla, teniendo en cuenta de:

#a) escribir todas las reglas de integridad (dominio, identidad, referencial).
#b) crear al menos 2 restricciones personalizadas con la sentencia CHECK.
#c) crear un índice sobre la columna fecha_multa

CREATE TABLE IF NOT EXISTS multas (
	id_multa INT AUTO_INCREMENT PRIMARY KEY,
    id_vehiculo INT NOT NULL,
    fecha_multa DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion_infraccion VARCHAR(255) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    pagada BOOLEAN DEFAULT FALSE,
    fecha_pago DATETIME,
    observaciones TEXT,
    CONSTRAINT fk_id_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT check_fecha_pago CHECK (
		pagada = TRUE AND fecha_pago IS NOT NULL 
        OR
        pagada = FALSE AND fecha_pago IS NULL
    ),
    CONSTRAINT check_fecha_multa CHECK (fecha_multa < fecha_pago)
);

CREATE INDEX idx_fecha_multa ON multas (fecha_multa);

-- dropea la constraint
ALTER TABLE multas
DROP CONSTRAINT check_fecha_multa;

-- altera la constraint
ALTER TABLE multas
ADD CONSTRAINT check_fecha_multa CHECK (fecha_multa <= fecha_pago);

# 2) TRIGGER
# Se solicita crear un trigger que cambie el estado del vehículo de “En mantenimiento” a
# “disponible” cuando se registra la revisión técnica del vehículo que aprueba el uso del
# vehículo.

SELECT * FROM revisiones_tecnicas; # posee columna aprobada
SELECT * FROM estados;
# estado 1 = disponible; 2 = en mantenimiento

DROP TRIGGER IF EXISTS tg_actualiza_estado;

DELIMITER //
CREATE TRIGGER tg_actualiza_estado
AFTER INSERT ON revisiones_tecnicas
FOR EACH ROW
BEGIN
	IF NEW.aprobada = 1 
    THEN
		UPDATE vehiculos
        SET id_estado = 1
        WHERE vehiculos.id_vehiculos = NEW.id_vehiculo;
	END IF;
END //
DELIMITER ;

INSERT INTO revisiones_tecnicas(id_vehiculo, fecha_revision, aprobada, observaciones) VALUES 
	(18,CURRENT_DATE,1,'OK');
    
SELECT * FROM vehiculos;


# 3. STORE PROCEDURE
# Crear un procedimiento que genere los pagos de la reserva. Este procedimiento tendrá como
# parámetros de entrada:
# ● id_reserva: código que hace referencia a la reserva.
# ● cant_cuotas: indica la cantidad de instancias de la clase “Pagos” que se crearan sobre
# la reserva. El monto de cada una es la división entre la tarifa de la reserva y la
# cantidad de cuotas.
# ● método_pago: indica el método de pago elegido por el cliente.

DROP PROCEDURE IF EXISTS sp_genera_pago;

DELIMITER //
CREATE PROCEDURE sp_genera_pago(
IN id_reserva_p INT, 
IN cant_cuotas_p INT,
IN metodo_pago_p VARCHAR(50))
BEGIN
	DECLARE monto_total DECIMAL(10,2);
    DECLARE monto_parcial DECIMAL(10,2);
    DECLARE i INT DEFAULT 1;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SELECT 'Error detectado' AS mensaje;
	END;
    
    IF cant_cuotas_p = 0 OR cant_cuotas_p IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad de cuotas no puede ser 0 o nula';
    END IF;
    
    START TRANSACTION;
    
    SELECT monto INTO monto_total
    FROM reservas
    WHERE id_reserva = id_reserva_p;
    
    SET monto_parcial = monto_total / cant_cuotas_p;
    
    WHILE i <= cant_cuotas_p DO
        INSERT INTO pagos(id_reserva, fecha_pago, monto, metodo_pago)
        VALUES (id_reserva_p, CURRENT_DATE, monto_parcial, metodo_pago);
        SET i = i + 1;
    END WHILE;
    
    COMMIT;
    
    SELECT 'Pagos generados exitosamente' AS mensaje;
END //
DELIMITER ;

SELECT * FROM reservas;
SELECT * FROM pagos WHERE id_reserva = 14;
CALL sp_genera_pago(14, 2, 'Tarjeta de Crédito');


# 4. FUNCTION
# A partir del código de una multa, desarrollar una función que retorne el código del cliente
# responsable. Para lograr esto, se debe analizar la fecha de la multa y localizar la reserva
# efectuada en esa fecha para el vehículo asociado a la multa

DROP FUNCTION IF EXISTS fn_cliente_multado;

DELIMITER //
CREATE FUNCTION fn_cliente_multado (id_multa INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE id_cliente_reserva INT DEFAULT NULL;
    
	-- 1. manejo de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		RETURN -1;
	END;
    
	-- 2. si esta todo bien, analizar fecha de multa
    -- 3. localizar reserva efectuada en la fecha
    IF id_multa <= 0 OR id_multa IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El código de la multa no puede ser 0 o nulo';
	ELSE
		SELECT reservas.id_cliente
        INTO id_cliente_reserva
        FROM multas
        LEFT JOIN reservas 
            ON reservas.fecha_inicio = multas.fecha_multa
        WHERE multas.id_multa = id_multa;
    END IF;
    
    -- devolver id_cliente
    RETURN id_cliente_reserva;
END //
DELIMITER ;


SELECT fn_cliente_multado(5);


# 5. VISTA
# Crear una vista que obtenga todos los vehículos que no están alquilados y estén disponibles.
CREATE VIEW vehiculos_disponibles AS
SELECT patente, marca, modelo FROM vehiculos WHERE id_estado = 1;

SELECT * FROM vehiculos_disponibles;


# 6. SEGURIDAD
# La empresa contrató un nuevo empleado que será encargado de realizar diversos informes,
# por lo que deberá tener acceso para poder recuperar datos de todas las tablas. Además,
# tendrá la responsabilidad de realizar cambios en las reservas registradas por diversos motivos
# como campos mal ingresados o cambios de reservas por parte del cliente. Por esto se
# solicita:
# 	● Crear un usuario para que el nuevo empleado pueda acceder a la base de datos.
#	● Habilitarle el permiso necesario para que pueda recuperar datos de la base de datos y
# actualizar la tabla registros.


-- creando un rol:
CREATE ROLE new_employee;

GRANT SELECT ON caret2.* TO new_employee;
GRANT UPDATE ON caret2.reservas TO new_employee;

CREATE USER 'new_user'@'localhost'
IDENTIFIED BY 'contra123';

GRANT new_employee TO 'new_user'@'localhost';


-- como dice la consigna:

CREATE USER 'new_new_user'@'localhost'
IDENTIFIED BY 'contra1234';

GRANT SELECT ON caret2.* TO 'new_new_user'@'localhost';
GRANT UPDATE ON caret2.reservas TO 'new_new_user'@'localhost';

-- verificacion:
SHOW GRANTS FOR 'new_new_user'@'localhost';
SHOW GRANTS FOR new_employee;
