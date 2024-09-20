use sala_cine;

# EJERCICIO 2
CREATE TABLE IF NOT EXISTS Genero (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Pelicula (
	id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL UNIQUE,
    duracion INT NOT NULL,
    anioEstreno DATE NOT NULL
);

ALTER TABLE pelicula
ADD COLUMN id_genero INT;

ALTER TABLE pelicula
ADD FOREIGN KEY (id_genero) REFERENCES genero(id);

# EJERCICIO 3
CREATE TABLE IF NOT EXISTS usuario (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    mail VARCHAR(50) NOT NULL UNIQUE,
    contrasenia VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS rol (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

ALTER TABLE usuario
ADD COLUMN id_rol INT;

ALTER TABLE usuario
ADD FOREIGN KEY (id_rol) REFERENCES rol(id);

# EJERCICIO 4

CREATE TABLE IF NOT EXISTS sala (
	id INT AUTO_INCREMENT PRIMARY KEY,
    numero_sala INT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS asiento (
	id INT AUTO_INCREMENT PRIMARY KEY,
    numero_asiento INT NOT NULL
);

ALTER TABLE asiento
ADD COLUMN id_sala INT;

ALTER TABLE asiento
ADD FOREIGN KEY (id_sala) REFERENCES sala(id);

# EJERCICIO 5

CREATE TABLE IF NOT EXISTS funcion (
	id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora DATETIME NOT NULL,
    id_sala INT NOT NULL,
    id_pelicula INT NOT NULL
);

ALTER TABLE funcion
ADD FOREIGN KEY (id_sala) REFERENCES sala(id);

ALTER TABLE funcion
ADD FOREIGN KEY (id_pelicula) REFERENCES pelicula(id);

CREATE TABLE IF NOT EXISTS reserva (
	id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_reserva DATE NOT NULL,
    id_usuario INT NOT NULL,
    id_asiento INT NOT NULL,
    id_funcion INT NOT NULL
);

ALTER TABLE reserva
ADD FOREIGN KEY (id_usuario) REFERENCES usuario(id),
ADD FOREIGN KEY (id_asiento) REFERENCES asiento(id),
ADD FOREIGN KEY (id_funcion) REFERENCES funcion(id);

# EJERCICIO 6

INSERT INTO genero (nombre) VALUES
    ('Acción'),
    ('Comedia'),
    ('Drama'),
    ('Terror'),
    ('Ciencia Ficción'),
    ('Animación'),
    ('Romance'),
    ('Documental');
    
INSERT INTO rol (nombre) VALUES
    ('Administrador'),
    ('Cliente'),
    ('Gerente');
    
INSERT INTO sala (numero_sala) VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10),
    (11),
    (12),
    (13),
    (14),
    (15),
    (16),
    (17),
    (18),
    (19),
    (20);

INSERT INTO pelicula (titulo, duracion, anioEstreno, id_genero) VALUES
    ('Inception', 148, '2010-07-16', 5),    -- Ciencia Ficción
    ('The Matrix', 136, '1999-03-31', 5),   -- Ciencia Ficción
    ('Interstellar', 169, '2014-11-07', 5), -- Ciencia Ficción
    ('The Godfather', 175, '1972-03-24', 3),-- Drama
    ('Pulp Fiction', 154, '1994-10-14', 3), -- Drama
    ('The Dark Knight', 152, '2008-07-18', 1), -- Acción
    ('Forrest Gump', 142, '1994-07-06', 3), -- Drama
    ('Gladiator', 155, '2000-05-05', 1),    -- Acción
    ('Titanic', 195, '1997-12-19', 7),      -- Romance
    ('Avatar', 162, '2009-12-18', 5);       -- Ciencia Ficción

DELETE FROM pelicula; # Borrar datos ingresados anteriormente

    
INSERT INTO funcion (fecha, hora, id_sala, id_pelicula) VALUES
    ('2024-09-20', '2024-09-20 14:00:00', 1, 41), -- Inception en Sala 1
    ('2024-09-20', '2024-09-20 16:30:00', 2, 42), -- The Matrix en Sala 2
    ('2024-09-21', '2024-09-21 18:00:00', 3, 43), -- Interstellar en Sala 3
    ('2024-09-21', '2024-09-21 20:30:00', 4, 44), -- The Godfather en Sala 4
    ('2024-09-22', '2024-09-22 15:00:00', 5, 45), -- Pulp Fiction en Sala 5
    ('2024-09-22', '2024-09-22 17:30:00', 6, 46), -- The Dark Knight en Sala 6
    ('2024-09-23', '2024-09-23 19:00:00', 7, 47), -- Forrest Gump en Sala 7
    ('2024-09-23', '2024-09-23 21:30:00', 8, 48), -- Gladiator en Sala 8
    ('2024-09-24', '2024-09-24 16:00:00', 9, 49), -- Titanic en Sala 9
    ('2024-09-24', '2024-09-24 18:30:00', 10, 50); -- Avatar en Sala 10


# EJERCICIO 7

SELECT titulo FROM pelicula
WHERE id_genero = 3;

# EJERCICIO 8

SELECT fecha AS fecha_Funcion, 
hora AS hora_Funcion, 
pelicula.titulo AS titulo_Pelicula, 
sala.numero_sala AS numero_Sala
FROM funcion
INNER JOIN pelicula ON pelicula.id = funcion.id_pelicula
INNER JOIN sala ON sala.id = funcion.id_sala;

# EJERCICIO 9

INSERT INTO usuario (nombre, mail, contrasenia, id_rol) VALUES
    ('Juan Pérez', 'juan.perez@example.com', 'password123', 1), -- Administrador
    ('Ana Gómez', 'ana.gomez@example.com', 'securepass', 2), -- Cliente
    ('Luis Martínez', 'luis.martinez@example.com', 'mysecret', 2), -- Cliente
    ('Laura Fernández', 'laura.fernandez@example.com', 'laura2024', 2), -- Cliente
    ('Carlos López', 'carlos.lopez@example.com', 'clientpass', 2), -- Cliente
    ('Marta Rodríguez', 'marta.rodriguez@example.com', 'manager2024', 3), -- Gerente
    ('Papa Frita', 'papa.frita@example.com', 'ass', 2); -- Cliente

-- Insertar asientos numerados del 1 al 20 para cada sala desde id_sala 1 hasta id_sala 20
INSERT INTO asiento (numero_asiento, id_sala) VALUES
    (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1), (13, 1), (14, 1), (15, 1), (16, 1), (17, 1), (18, 1), (19, 1), (20, 1),
    (1, 2), (2, 2), (3, 2), (4, 2), (5, 2), (6, 2), (7, 2), (8, 2), (9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 2), (15, 2), (16, 2), (17, 2), (18, 2), (19, 2), (20, 2),
    (1, 3), (2, 3), (3, 3), (4, 3), (5, 3), (6, 3), (7, 3), (8, 3), (9, 3), (10, 3), (11, 3), (12, 3), (13, 3), (14, 3), (15, 3), (16, 3), (17, 3), (18, 3), (19, 3), (20, 3),
    (1, 4), (2, 4), (3, 4), (4, 4), (5, 4), (6, 4), (7, 4), (8, 4), (9, 4), (10, 4), (11, 4), (12, 4), (13, 4), (14, 4), (15, 4), (16, 4), (17, 4), (18, 4), (19, 4), (20, 4),
    (1, 5), (2, 5), (3, 5), (4, 5), (5, 5), (6, 5), (7, 5), (8, 5), (9, 5), (10, 5), (11, 5), (12, 5), (13, 5), (14, 5), (15, 5), (16, 5), (17, 5), (18, 5), (19, 5), (20, 5),
    (1, 6), (2, 6), (3, 6), (4, 6), (5, 6), (6, 6), (7, 6), (8, 6), (9, 6), (10, 6), (11, 6), (12, 6), (13, 6), (14, 6), (15, 6), (16, 6), (17, 6), (18, 6), (19, 6), (20, 6),
    (1, 7), (2, 7), (3, 7), (4, 7), (5, 7), (6, 7), (7, 7), (8, 7), (9, 7), (10, 7), (11, 7), (12, 7), (13, 7), (14, 7), (15, 7), (16, 7), (17, 7), (18, 7), (19, 7), (20, 7),
    (1, 8), (2, 8), (3, 8), (4, 8), (5, 8), (6, 8), (7, 8), (8, 8), (9, 8), (10, 8), (11, 8), (12, 8), (13, 8), (14, 8), (15, 8), (16, 8), (17, 8), (18, 8), (19, 8), (20, 8),
    (1, 9), (2, 9), (3, 9), (4, 9), (5, 9), (6, 9), (7, 9), (8, 9), (9, 9), (10, 9), (11, 9), (12, 9), (13, 9), (14, 9), (15, 9), (16, 9), (17, 9), (18, 9), (19, 9), (20, 9),
    (1, 10), (2, 10), (3, 10), (4, 10), (5, 10), (6, 10), (7, 10), (8, 10), (9, 10), (10, 10), (11, 10), (12, 10), (13, 10), (14, 10), (15, 10), (16, 10), (17, 10), (18, 10), (19, 10), (20, 10),
    (1, 11), (2, 11), (3, 11), (4, 11), (5, 11), (6, 11), (7, 11), (8, 11), (9, 11), (10, 11), (11, 11), (12, 11), (13, 11), (14, 11), (15, 11), (16, 11), (17, 11), (18, 11), (19, 11), (20, 11),
    (1, 12), (2, 12), (3, 12), (4, 12), (5, 12), (6, 12), (7, 12), (8, 12), (9, 12), (10, 12), (11, 12), (12, 12), (13, 12), (14, 12), (15, 12), (16, 12), (17, 12), (18, 12), (19, 12), (20, 12),
    (1, 13), (2, 13), (3, 13), (4, 13), (5, 13), (6, 13), (7, 13), (8, 13), (9, 13), (10, 13), (11, 13), (12, 13), (13, 13), (14, 13), (15, 13), (16, 13), (17, 13), (18, 13), (19, 13), (20, 13),
    (1, 14), (2, 14), (3, 14), (4, 14), (5, 14), (6, 14), (7, 14), (8, 14), (9, 14), (10, 14), (11, 14), (12, 14), (13, 14), (14, 14), (15, 14), (16, 14), (17, 14), (18, 14), (19, 14), (20, 14),
    (1, 15), (2, 15), (3, 15), (4, 15), (5, 15), (6, 15), (7, 15), (8, 15), (9, 15), (10, 15), (11, 15), (12, 15), (13, 15), (14, 15), (15, 15), (16, 15), (17, 15), (18, 15), (19, 15), (20, 15),
    (1, 16), (2, 16), (3, 16), (4, 16), (5, 16), (6, 16), (7, 16), (8, 16), (9, 16), (10, 16), (11, 16), (12, 16), (13, 16), (14, 16), (15, 16), (16, 16), (17, 16), (18, 16), (19, 16), (20, 16),
    (1, 17), (2, 17), (3, 17), (4, 17), (5, 17), (6, 17), (7, 17), (8, 17), (9, 17), (10, 17), (11, 17), (12, 17), (13, 17), (14, 17), (15, 17), (16, 17), (17, 17), (18, 17), (19, 17), (20, 17),
    (1, 18), (2, 18), (3, 18), (4, 18), (5, 18), (6, 18), (7, 18), (8, 18), (9, 18), (10, 18), (11, 18), (12, 18), (13, 18), (14, 18), (15, 18), (16, 18), (17, 18), (18, 18), (19, 18), (20, 18),
    (1, 19), (2, 19), (3, 19), (4, 19), (5, 19), (6, 19), (7, 19), (8, 19), (9, 19), (10, 19), (11, 19), (12, 19), (13, 19), (14, 19), (15, 19), (16, 19), (17, 19), (18, 19), (19, 19), (20, 19),
    (1, 20), (2, 20), (3, 20), (4, 20), (5, 20), (6, 20), (7, 20), (8, 20), (9, 20), (10, 20), (11, 20), (12, 20), (13, 20), (14, 20), (15, 20), (16, 20), (17, 20), (18, 20), (19, 20), (20, 20);

INSERT INTO reserva (fecha_reserva, id_usuario, id_asiento, id_funcion) VALUES
    ('2024-09-19', 9, 1, 31), -- Reserva de Ana Gómez en el asiento 1 para la función 1
    ('2024-09-19', 10, 2, 32), -- Reserva de Luis Martínez en el asiento 2 para la función 2
    ('2024-09-20', 11, 3, 33), -- Reserva de Laura Fernández en el asiento 3 para la función 3
    ('2024-09-20', 12, 4, 34), -- Reserva de Carlos López en el asiento 4 para la función 4
    ('2024-09-21', 14, 5, 35); -- Reserva de Papa Frita en el asiento 5 para la función 5


# EJERCICIO 10

SELECT fecha_reserva,
usuario.nombre AS nombre_usuario,
pelicula.titulo AS titulo_pelicula,
funcion.hora AS hora_funcion,
asiento.numero_asiento AS numero_asiento
FROM reserva
INNER JOIN usuario ON usuario.id = reserva.id_usuario
INNER JOIN asiento ON asiento.id = reserva.id_asiento
INNER JOIN funcion ON funcion.id = reserva.id_funcion
INNER JOIN pelicula ON pelicula.id = funcion.id_pelicula
WHERE usuario.id = 14;