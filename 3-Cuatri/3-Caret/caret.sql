CREATE DATABASE caret;
use caret;

# Tema: Restricciones CONSTRAIN

CREATE TABLE clientes (
	cliente_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	dni VARCHAR(15) NOT NULL UNIQUE,
	fecha_nacimiento TIMESTAMP NOT NULL,
	email VARCHAR(100),
	telefono VARCHAR(20),
	direccion VARCHAR(150),
	numero_licencia_conducir VARCHAR(150),
	fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	activo TINYINT(1) DEFAULT 1 CHECK (activo IN (0,1))
);

# Ejercicio 1: Intentar romper la integridad de la tabla.
	-- El nunmero de licencia debe estar en INT, no como VARCHAR.
	-- No permitir que otros usuarios se registren con el mismo mail o 
	-- el mismo numero de licencia. Además, la dirección y/o el teléfono deberían 
	-- ser NOT NULL para tener un medio de contacto con el cliente.
	-- fecha_nacimiento podría ser un DATE


# Ejercicio 2: Crear la tabla Vehículos, manteniendo la integridad de los datos con diversas restricciones.
CREATE TABLE IF NOT EXISTS vehiculos (
	vehiculo_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    tipo_vehiculo ENUM('SUV', 'Auto', 'Moto', 'Caminón', 'Camioneta') NOT NULL,
    patente VARCHAR(10) UNIQUE NOT NULL,
    tipo_combustible ENUM('Nafta', 'Diesel', 'Eléctrico', 'Híbrido') NOT NULL,
    kilometraje INT UNSIGNED NOT NULL,
    fecha_revision_tecnica DATE NOT NULL,
    disponible TINYINT(1) DEFAULT 1 CHECK(disponible IN (0,1))
);

# Ejercicio 3: Crear la tabla Reservas, manteniendo la integridad de los datos con diversas restricciones.

CREATE TABLE reservas (
	reserva_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	cliente_id INT UNSIGNED NOT NULL,
	vehiculo_id INT UNSIGNED NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	costo_total DECIMAL(10, 2) NOT NULL CHECK (costo_total >= 0),
	CHECK (fecha_fin > fecha_inicio),
	CHECK (fecha_fin <= DATE_ADD(fecha_inicio, INTERVAL 6 MONTH)),
	CONSTRAINT fk_reserva_cliente FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_reserva_vehiculo FOREIGN KEY (vehiculo_id) REFERENCES vehiculos (vehiculo_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

# ACCIÓN -> Delete / UPDATE
# CASCADE -> NULL / RESTRICT
# -> ON DELETE (acción) CASCADE ON UPDATE (Cascade) CASCADE


# TABLAS PARA PROBAR
INSERT INTO clientes (nombre, apellido, dni, fecha_nacimiento, email, telefono, direccion, numero_licencia_conducir) VALUES
('Juan', 'Pérez', '12345678', '1990-05-15', 'juan.perez@email.com', '1122334455', 'Calle Falsa 123', 'ABC123'),
('María', 'Gómez', '87654321', '1985-09-22', 'maria.gomez@email.com', '2233445566', 'Avenida Siempre Viva 456', 'XYZ789'),
('Carlos', 'López', '11223344', '1992-11-30', 'carlos.lopez@email.com', '3344556677', 'Pasaje Sin Salida 789', 'LMN456');

INSERT INTO vehiculos (marca, modelo, tipo_vehiculo, patente, tipo_combustible, kilometraje, fecha_revision_tecnica) VALUES
('Toyota', 'Corolla', 'Auto', 'AB123CD', 'Nafta', 50000, '2024-02-15'),
('Ford', 'Ranger', 'Camioneta', 'CD456EF', 'Diesel', 75000, '2023-12-10'),
('Honda', 'CB500', 'Moto', 'GH789IJ', 'Nafta', 20000, '2024-01-05');

INSERT INTO reservas (cliente_id, vehiculo_id, fecha_inicio, fecha_fin, costo_total) VALUES
(1, 1, '2025-04-01', '2025-04-10', 1500.00),
(2, 2, '2025-05-05', '2025-05-15', 2500.00),
(3, 3, '2025-06-01', '2025-06-07', 900.00);

-- DATOS INCORRECTOS:
-- Error: `fecha_fin` es menor a `fecha_inicio`
INSERT INTO reservas (cliente_id, vehiculo_id, fecha_inicio, fecha_fin, costo_total) VALUES
(1, 2, '2025-04-10', '2025-04-05', 1800.00);

-- Error: `fecha_fin` es mayor a 6 meses después de `fecha_inicio`
INSERT INTO reservas (cliente_id, vehiculo_id, fecha_inicio, fecha_fin, costo_total) VALUES
(2, 3, '2025-01-01', '2025-08-02', 3000.00);