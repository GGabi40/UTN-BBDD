# EJERCICIO 1 - crear base de datos bilbioteca
CREATE DATABASE biblioteca;

# EJERCICIO 2
# Crear una tabla llamada libros en la base de datos bibliotecas,
# con los siguientes campos:
# id (entero, clave única autoincremental)
# titulo (cadena de hasta 100 chars)
# autor (cadena de hasta 100 chars)
#fecha_publicacion (date)

use biblioteca;

CREATE TABLE IF NOT EXISTS libros (
	id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL UNIQUE,
    autor VARCHAR(100) NOT NULL UNIQUE,
    fecha_publicacion DATE NOT NULL
);

# EJERCICIO 3
# Crear tabla con claves foráneas
# Crear tabla llamada préstamos con los campos:
# 	prestamo_id (entero, clave primaria, autoinc)
#	libro_id (entero, clave foránea q referencia tabla libros)
# 	usuario_id (entero, clave foránea q representa usuario del prestamo)
#	fecha_prestamo (fecha)
#	fecha_devolucion (fecha)

CREATE TABLE IF NOT EXISTS prestamos(
	prestamo_id INT AUTO_INCREMENT PRIMARY KEY,
    libro_id INT NOT NULL,
    usuario_id INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NOT NULL
);

# EJERCICIO 4
# Crear tabla llamada usuario con los campos:
# 	usuario_id (entero, clave primaria, autoinc)
#	nombre (VARCHAR de 50 chars)
# 	apellido (VARCHAR de 50 chars)
#	fecha_nacimiento (fecha)
#	email (texto)
#	teléfono (texto)
#	fecha_alta (fecha)
#	estado (texto (ACTIVO | SUSPENDIDO | VETADO))

CREATE TABLE IF NOT EXISTS usuario(
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR(100),
    fecha_alta DATE NOT NULL,
    telefono VARCHAR(20),
    estado_cliente VARCHAR(20)
);

# EJERCICIO 5
# Crear tabla llamada autores con los campos:
# 	usuario_id (entero, clave primaria, autoinc)
#	nombre (VARCHAR de 50 chars)
# 	apellido (VARCHAR de 50 chars)
#	email (texto)

CREATE TABLE IF NOT EXISTS autores(
	id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100)
);

# EJERCICIO 6
# Crear tabla llamada editorial con los campos:
# 	editorial_id (entero, clave primaria, autoinc)
#	nombre (VARCHAR de 50 chars)
# 	cuit (VARCHAR de 50 chars)
#	email (texto)
#	direccion (texto)

CREATE TABLE IF NOT EXISTS editorial(
	editorial_id INT AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(100) NOT NULL,
    direccion VARCHAR(100),
    cuit INT NOT NULL
);

# EJERCICIO 7
# a) borrar att erróneo autor
# b) crear att autor_id
# c) establecer como FK

# a)
ALTER TABLE libros
DROP COLUMN autor;

# b)
ALTER TABLE libros
ADD COLUMN autor_id INT;

# c)
ALTER TABLE libros
ADD FOREIGN KEY (autor_id) REFERENCES autores(id_autor);

# EJERCICIO 8
# añadir editorales a libros
ALTER TABLE libros
ADD COLUMN editorial_id INT;

ALTER TABLE libros
ADD FOREIGN KEY (editorial_id) REFERENCES editorial(editorial_id);

#  ***** LAS RELACIONES  *****
#
#             |---> autores
#             | 
#   libros ---|
#   		  |
#             |---> editoriales
#
#
#    préstamos ---> usuarios
#
#  ****************************


# EJERCICIO 9
# Crear relaciones entre libros <- préstamos -> usuario

ALTER TABLE prestamos
ADD FOREIGN KEY (libro_id) REFERENCES libros(id);

ALTER TABLE prestamos
ADD FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario);

# *** PARTE 2 | Insertar datos ***


#	 -- Insertamos datos en tabla autores

INSERT INTO autores (nombre, apellido, email) VALUES
	('Laura', 'Pérez', 'laura.perez@example.com'),
	('Carlos', 'Gómez', 'carlos.gomez@example.com'),
	('María', 'López', 'maria.lopez@example.com'),
	('Juan', 'Martínez', 'juan.martinez@example.com'),
	('Ana', 'Fernández', 'ana.fernandez@example.com'),
	('Pedro', 'Rodríguez', 'pedro.rodriguez@example.com'),
	('Sofía', 'Sánchez', 'sofia.sanchez@example.com'),
	('Luis', 'Torres', 'luis.torres@example.com'),
	('Elena', 'García', 'elena.garcia@example.com'),
	('Miguel', 'Hernández', 'miguel.hernandez@example.com');

SELECT * FROM biblioteca.autores;


#	 -- Insertamos datos en tabla editorial

ALTER TABLE editorial
MODIFY cuit VARCHAR(13);

INSERT INTO editorial (direccion, razon_social, cuit) VALUES
	('Calle Falsa 123, Buenos Aires', 'Editorial Alfa', '30-12345678-9'),
	('Av. Siempre Viva 742, Córdoba', 'Libros Beta', '30-87654321-0'),
	('Pje. Sol 456, Mendoza', 'Ediciones Gamma', '30-23456789-1'),
	('Av. Libertador 321, Rosario', 'Editorial Delta', '30-98765432-1'),
	('Calle Luna 789, Tucumán', 'Letras Omega', '30-34567890-2'),
	('Av. Estrella 234, La Plata', 'Editorial Épsilon', '30-76543210-4'),
	('Calle Nube 567, Mar del Plata', 'Imprenta Sigma', '30-45678901-3'),
	('Av. Roca 876, Salta', 'Editorial Kappa', '30-65432109-6'),
	('Calle Viento 345, Neuquén', 'Librería Zeta', '30-56789012-7'),
	('Av. Mar 654, Bariloche', 'Libros Pi', '30-54321098-5');


#	 -- Insertamos datos en tabla libros

INSERT INTO libros (titulo, fecha_publicacion, autor_id) VALUES
	('El misterio del bosque', '2021-05-12', 1),
	('Aventuras en el espacio', '2019-09-23', 2),
	('La sombra del viento', '2020-11-05', 3),
	('El camino del héroe', '2018-03-15', 4),
	('Historias del futuro', '2022-07-07', 5),
	('El último reino', '2017-01-20', 6),
	('El despertar de la magia', '2021-12-01', 7),
	('Crónicas de un viajero', '2020-08-19', 8),
	('El secreto del alquimista', '2019-04-30', 9),
	('La batalla de los dioses', '2022-10-14', 10);


#	 -- Insertamos datos en tabla usuario

INSERT INTO usuario (nombre, apellido, fecha_nacimiento, email, fecha_alta, telefono, estado_cliente) VALUES
	('Lucía', 'González', '1990-03-25', 'lucia.gonzalez@example.com', '2023-01-15', '3412345678', 'ACTIVO'),
	('Martín', 'Pérez', '1985-07-14', 'martin.perez@example.com', '2022-05-23', '3419876543', 'SUSPENDIDO'),
	('Clara', 'López', '1992-10-11', 'clara.lopez@example.com', '2023-03-09', '3414567890', 'ACTIVO'),
	('Pedro', 'Rodríguez', '1980-12-22', 'pedro.rodriguez@example.com', '2021-11-01', '3411234567', 'VETADO'),
	('Ana', 'Martínez', '1995-08-30', 'ana.martinez@example.com', '2020-06-12', '3418765432', 'ACTIVO'),
	('Diego', 'Fernández', '1988-02-15', 'diego.fernandez@example.com', '2022-12-05', '3412345678', 'SUSPENDIDO'),
	('María', 'Sánchez', '1993-09-09', 'maria.sanchez@example.com', '2021-04-19', '3419876543', 'VETADO'),
	('Javier', 'Torres', '1979-06-07', 'javier.torres@example.com', '2019-10-20', '3414567890', 'ACTIVO'),
	('Sofía', 'Ramírez', '1991-01-18', 'sofia.ramirez@example.com', '2020-08-30', '3411234567', 'ACTIVO'),
	('Carlos', 'Gómez', '1983-04-02', 'carlos.gomez@example.com', '2023-07-07', '3418765432', 'SUSPENDIDO');


#	 -- Insertamos datos en tabla préstamos

INSERT INTO prestamos (libro_id, usuario_id, fecha_prestamo, fecha_devolucion) VALUES
	(1, 3, '2023-09-01', '2023-09-15'),
	(2, 5, '2023-08-25', '2023-09-08'),
	(3, 7, '2023-09-10', '2023-09-24'),
	(4, 1, '2023-08-30', '2023-09-13'),
	(5, 2, '2023-07-20', '2023-08-03'),
	(6, 6, '2023-09-12', '2023-09-26'),
	(7, 4, '2023-08-05', '2023-08-19'),
	(8, 8, '2023-09-03', '2023-09-17'),
	(9, 9, '2023-07-15', '2023-07-29'),
	(10, 10, '2023-06-01', '2023-06-15');
    
# para agregar más préstamos:
INSERT INTO prestamos (libro_id, usuario_id, fecha_prestamo, fecha_devolucion) VALUES
	(3, 2, '2023-09-20', '2023-10-04'),
	(1, 4, '2023-09-18', '2023-10-02'),
	(5, 6, '2023-09-15', '2023-09-29'),
	(7, 8, '2023-09-12', '2023-09-26');

SELECT * FROM prestamos;

# *********************************************
## HACER EJERCICIOS PROPUESTOS

# Ejercicio 1 :
# Obtené una lista con todos los libros y los nombres de los autores.

# Ejercicio 2: 
# Encontrar los libros publicados después del 2000.

# Ejercicio 3: 
# Mostrar los nombres de los usuarios activos, ordenar por apellido
# de forma descendente.

# Ejercicio 4:
# Contá cuanto cuantos prestamos se realizó por usuario.

# Ejercicio 5:
# Mostrar los titulos de los prestamos de usuarios SUSPENDIDOS.

# Ejercicio 6:
# Calcular el numero total de libros  que hay en la BBDD y la cantidad de autores distintos.

# Ejercicio 7:
# Actualizar el estado de los usuarios a SUSPENDIDO en el caso de de que tengan mas de 5 prestamos.