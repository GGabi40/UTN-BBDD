# Creación de una BBDD para un Cyber

CREATE DATABASE Cyber;
Use Cyber;

# Creacion de tabla computadoras:
CREATE TABLE IF NOT EXISTS computadoras(
	id_computadora INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    estado ENUM('Disponible', 'Ocupada', 'Fuera de Servicio') NOT NULL
);

# Creacion de tabla clientes:
CREATE TABLE IF NOT EXISTS clientes(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    mail VARCHAR(100) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP # Por defecto: el día y hora actual
);

# Creacion de tabla servicios:
CREATE TABLE IF NOT EXISTS servicios(
	id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL NOT NULL
);

ALTER TABLE servicios
MODIFY precio DECIMAL(10, 3);

# Creacion de tabla reservas:
CREATE TABLE IF NOT EXISTS reservas(
	id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_computadora INT,
	fecha_reserva DATETIME NOT NULL,
    duracion_minutos INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_computadora) REFERENCES computadoras(id_computadora)
);

# Creacion de tabla reservas:
CREATE TABLE IF NOT EXISTS facturas(
	id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_servicio INT,
    id_cliente INT,
	fecha_factura DATE NOT NULL,
    total DECIMAL NOT NULL,
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

# ---------------------------- #

# Agregando datos a las tablas:

INSERT INTO computadoras (nombre, ubicacion, estado) VALUES
('PC-01', 'Sala Principal', 'Disponible'),
('PC-02', 'Sala Principal', 'Ocupada'),
('PC-03', 'Sala de Juegos', 'Disponible'),
('PC-04', 'Sala de Estudio', 'Fuera de Servicio'),
('PC-05', 'Sala Principal', 'Ocupada'),
('PC-06', 'Sala de Juegos', 'Disponible');

INSERT INTO clientes (nombre, mail) VALUES
('Juan Pérez', 'juan.perez@example.com'),
('María Gómez', 'maria.gomez@example.com'),
('Carlos López', 'carlos.lopez@example.com'),
('Ana Martínez', 'ana.martinez@example.com'),
('Luis Fernández', 'luis.fernandez@example.com');

INSERT INTO servicios (nombre, precio) VALUES
('Navegación por Internet', 50.00),
('Juegos en Línea', 100.00),
('Impresión de Documentos', 20.00),
('Asistencia Técnica', 150.00);

INSERT INTO reservas (id_cliente, id_computadora, fecha_reserva, duracion_minutos) VALUES
(1, 1, '2024-10-01 10:00:00', 60),
(2, 2, '2024-10-01 11:00:00', 120),
(3, 3, '2024-10-01 12:30:00', 90),
(4, 1, '2024-10-01 14:00:00', 30),
(5, 4, '2024-10-01 15:00:00', 45);

INSERT INTO facturas (id_servicio, id_cliente, fecha_factura, total) VALUES
(1, 1, '2024-10-01', 50.00),
(2, 2, '2024-10-01', 100.00),
(3, 3, '2024-10-01', 20.00),
(4, 4, '2024-10-01', 150.00),
(1, 5, '2024-10-01', 50.00);


# ---------- #

# EJERCICIOS
# 1. Obtener las reservas con el nombre del cliente y la PC utilizada.

SELECT fecha_reserva, computadoras.nombre, clientes.nombre
FROM reservas
JOIN clientes ON clientes.id_cliente = reservas.id_cliente
JOIN computadoras ON computadoras.id_computadora = reservas.id_computadora;


# 2. Obtener el cliente que hizo la reserva más reciente.

SELECT fecha_reserva, clientes.nombre
FROM reservas
JOIN clientes ON clientes.id_cliente = reservas.id_cliente
ORDER BY reservas.fecha_reserva DESC
LIMIT 1;

-- Otra alternativa:
SELECT nombre
FROM clientes
WHERE id_cliente = (SELECT id_cliente FROM reservas ORDER BY fecha_reserva DESC LIMIT 1);


# 3. Obtener el total de ingresos por servicio brindado.

SELECT s.nombre, SUM(f.total) AS total_ingreso
FROM facturas f
JOIN servicios s ON f.id_servicio = s.id_servicio
GROUP BY s.nombre
ORDER BY total_ingreso DESC;


# 4. Obtener el ingreso generado por PC para clientes que reservaron más de 60 minutos

SELECT computadoras.nombre, SUM(facturas.total) AS ingreso_total
FROM reservas
JOIN computadoras ON computadoras.id_computadora = reservas.id_computadora
JOIN facturas ON reservas.id_cliente = facturas.id_cliente
WHERE reservas.duracion_minutos > 60
GROUP BY computadoras.nombre
ORDER BY ingreso_total;


# 5. Obtener el número del cliente y nombre con la mayor cantidad de minutos reservados.

SELECT duracion_minutos, clientes.id_cliente AS numero_cliente, clientes.nombre
FROM reservas
JOIN clientes ON clientes.id_cliente = reservas.id_cliente
ORDER BY duracion_minutos DESC
LIMIT 1;

