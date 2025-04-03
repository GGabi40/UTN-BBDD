use caret;

# Tema: TRIGGERS

CREATE TABLE log_clientes (
  log_id INT NOT NULL AUTO_INCREMENT,
  cliente_id INT UNSIGNED NOT NULL,
  accion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
  nombre_anterior VARCHAR(50) DEFAULT NULL,
  apellido_anterior VARCHAR(50) DEFAULT NULL,
  dni_anterior VARCHAR(15) DEFAULT NULL,
  email_anterior VARCHAR(100) DEFAULT NULL,
  telefono_anterior VARCHAR(15) DEFAULT NULL,
  direccion_anterior VARCHAR(150) DEFAULT NULL,
  nombre_siguiente VARCHAR(50) DEFAULT NULL,
  apellido_siguiente VARCHAR(50) DEFAULT NULL,
  dni_siguiente VARCHAR(15) DEFAULT NULL,
  email_siguiente VARCHAR(100) DEFAULT NULL,
  telefono_siguiente VARCHAR(15) DEFAULT NULL,
  direccion_siguiente VARCHAR(150) DEFAULT NULL,
  fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (log_id)
);

-- 1. Crear un log de clientes. Al momento de 
-- modificar los datos de un cliente, registrar 
-- los datos del cliente anteriores y posteriores 
-- a la modificación

DELIMITER //
CREATE TRIGGER log_reserva
AFTER UPDATE ON clientes 
FOR EACH ROW
BEGIN
    INSERT INTO log_clientes (
        cliente_id, 
        accion,
        nombre_anterior, apellido_anterior, dni_anterior, 
        email_anterior, telefono_anterior, direccion_anterior,
        nombre_siguiente, apellido_siguiente, dni_siguiente, 
        email_siguiente, telefono_siguiente, direccion_siguiente, 
        fecha_cambio
    ) 
    VALUES (
        OLD.cliente_id, 
        'UPDATE',
        OLD.nombre, OLD.apellido, OLD.dni,
        OLD.email, OLD.telefono, OLD.direccion,
        NEW.nombre, NEW.apellido, NEW.dni,
        NEW.email, NEW.telefono, NEW.direccion,
        NOW()
    );
END //
DELIMITER ;

# DROP TRIGGER log_reserva;

UPDATE clientes 
SET nombre = 'Pablo', email = 'carlos@email.com'
WHERE cliente_id = 1;

SELECT * FROM clientes;
SELECT * FROM log_clientes;


-- 2. Al momento de crear una reserva, modificar 
-- el estado del vehículo reservado para que deje 
-- de estar disponible para otra reserva.

DELIMITER //
CREATE TRIGGER cambio_vehiculo
AFTER INSERT ON reservas
FOR EACH ROW
BEGIN
	UPDATE vehiculos
    SET disponible = 0
    WHERE vehiculo_id = NEW.vehiculo_id;
END //
DELIMITER ;

INSERT INTO reservas (cliente_id, vehiculo_id, fecha_inicio, fecha_fin, costo_total)
VALUES (1, 1, '2025-04-02', '2025-04-05', 10000);

SELECT * FROM vehiculos;
SELECT * FROM reservas;


-- 3. Agregar una columna "fecha_devolución" a la tabla
--  reserva. Cuando se devuelve el vehículo, se debe registrar
--  esta fecha en la tabla reserva y, a su vez, se debe modificar
--  el estado del vehículo para que pase a estar disponible.

ALTER TABLE reservas
ADD COLUMN fecha_devolucion DATETIME;



-- 4. Si un vehículo retorna de una reserva con el kilometraje
-- excediendo los 10.000 km desde el registro de kilometraje de su 
-- última revisión técnica, dicho vehículo será catalogado como
-- "En Mantenimiento" y no estará disponible hasta que se realice la revisión pertinente

