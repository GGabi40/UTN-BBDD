# EJERCICIO 1
# Creacion de BBDD llamada WeChat;
CREATE DATABASE WeChat;

USE WeChat;

# EJERCICIO 2 
# Creación de tabla de usuarios
# Crea una tabla Usuarios con los siguientes campos: id_usuario (PK, INT,
# AUTO_INCREMENT), nombre (VARCHAR(100)), email (VARCHAR(100), UNIQUE),
# fecha_registro (DATE).

CREATE TABLE IF NOT EXISTS Usuarios (
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    username VARCHAR(100) DEFAULT "juan_perez" NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL, # ejercicio 3
    fecha_registro DATE NOT NULL
);

# EJERCICIO 3
  -- Si olvidaramos de NOT NULL en tabla: Hacerlo manual: 
	-- ALTER TABLE Usuarios MODIFY email VARCHAR(100) UNIQUE NOT NULL
    

# EJERCICIO 4
# Tabla de publicaciones
# Crea una tabla Publicaciones con los siguientes campos: id_publicacion (PK,
# INT, AUTO_INCREMENT), id_usuario (FK, INT), contenido (TEXT),
# fecha_publicacion (DATETIME).

CREATE TABLE IF NOT EXISTS publicaciones (
	id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    contenido TEXT NOT NULL,
    fecha_publicacion DATETIME NOT NULL,
    id_usuario INT NOT NULL
);

ALTER TABLE publicaciones
ADD FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);


# EJERCICIO 5
# Tabla de amigos
# Crea una tabla Amigos para manejar las relaciones de amistad entre usuarios.
# La tabla debe tener dos campos: id_usuario1 e id_usuario2 , ambos FK de la
# tabla Usuarios .

CREATE TABLE IF NOT EXISTS amigos (
	id_usuario1 INT,
    id_usuario2 INT
);

ALTER TABLE amigos
ADD FOREIGN KEY (id_usuario1) REFERENCES usuarios(id_usuario),
ADD FOREIGN KEY (id_usuario2) REFERENCES usuarios(id_usuario);

# EJERCICIO 6
# Inserción de usuarios
# Inserta 3 usuarios en la tabla Usuarios .

INSERT INTO Usuarios (nombre, username, email, fecha_registro) VALUES
	('Gabriela Fernández', 'ggabi40', 'ggabi40@example.com', '2024-01-15'),
	('Juan Pérez', 'juanp', 'juan.p@example.com', '2023-12-01'),
	('María Gómez', 'maria_g', 'maria.gomez@example.com', '2024-02-10'),
	('Carlos López', 'clopez23', 'carlos.lopez@example.com', '2023-11-25'),
	('Ana Martínez', 'ana.m', 'ana.martinez@example.com', '2024-03-05');
    

# EJERCICIO 7
# Inserción de publicaciones
# Inserta dos publicaciones de un mismo usuario.

INSERT INTO publicaciones (contenido, fecha_publicacion, id_usuario) VALUES
	('¡Empezando un nuevo proyecto de programación!', '2024-09-25 10:30:00', 1),
	('Hoy aprendí sobre bases de datos SQL.', '2024-09-24 15:45:00', 2),
	('Preparando una presentación para la universidad.', '2024-09-23 09:20:00', 3),
	('Subí un nuevo video de código en mi canal.', '2024-09-22 18:10:00', 1),
	('Me encanta aprender sobre nuevas tecnologías.', '2024-09-21 12:00:00', 4);


# EJERCICIO 8
# Inserción de amistad
# Inserta una relación de amistad entre dos usuarios.

INSERT INTO amigos (id_usuario1, id_usuario2) VALUES
	(1, 2),
	(1, 3),
	(2, 4),
	(3, 4),
	(1, 4);


# EJERCICIO 9
# Actualización de nombre de usuario
# Actualiza el nombre del usuario con id_usuario = 2 a "Maria Gómez".

UPDATE wechat.usuarios SET nombre = "Maria Gómez"
WHERE id_usuario = 2;
UPDATE wechat.usuarios SET email = "Mariagomez@example.com"
WHERE id_usuario = 2;
UPDATE wechat.usuarios SET username = "mariag"
WHERE id_usuario = 2;

# EJERCICIO 10
# Tabla de comentarios
# Crea una tabla Comentarios para almacenar los comentarios en las
# publicaciones. Debe tener los campos id_comentario (PK, INT, AUTO_INCREMENT),
# id_publicacion (FK, INT), id_usuario (FK, INT), contenido (TEXT),
# fecha_comentario (DATETIME).

CREATE TABLE IF NOT EXISTS comentarios (
    id_comentario INT AUTO_INCREMENT PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_comentario DATETIME
);

# EJERCICIO 11
# Inserción de comentarios
# Inserta dos comentarios de distintos usuarios en una publicación.

INSERT INTO comentarios (id_publicacion, id_usuario, contenido, fecha_comentario) VALUES 
	(1, 2, '¡Qué buen proyecto, mucha suerte!', '2024-09-25 11:00:00'),
	(2, 3, 'Bases de datos son súper interesantes, ¿qué aprendiste?', '2024-09-24 16:00:00'),
	(3, 4, '¡Éxitos con la presentación!', '2024-09-23 10:15:00'),
	(4, 1, 'Gracias por compartir el video, ¡está genial!', '2024-09-22 19:00:00'),
	(5, 2, 'Totalmente de acuerdo, aprender es lo mejor.', '2024-09-21 12:30:00');

# EJERCICIO 12
# Actualización de contenido de publicación
# Actualiza el contenido de una publicación, cambiando el texto a "Hoy es un día
# increíble".

UPDATE wechat.comentarios 
SET contenido = "Hoy es un día increíble" 
WHERE id_comentario = 4;

# EJERCICIO 13
# Tabla de likes
# Crea una tabla Likes para registrar los "me gusta" en las publicaciones. Los
# campos serán: id_like (PK, INT, AUTO_INCREMENT), id_publicacion (FK, INT),
# id_usuario (FK, INT), fecha_like (DATETIME).

CREATE TABLE IF NOT EXISTS likes (
    id_like INT AUTO_INCREMENT PRIMARY KEY,
    id_publicacion INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_like DATETIME
);

ALTER TABLE likes
ADD FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion),
ADD FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);


# EJERCICIO 14
# Inserción de likes
# Inserta un "me gusta" de dos usuarios diferentes en una publicación.

INSERT INTO likes (id_publicacion, id_usuario, fecha_like) VALUES 
	(1, 2, '2024-09-25 11:05:00'),
	(1, 3, '2024-09-25 11:10:00'),
	(2, 1, '2024-09-24 16:05:00'),
	(3, 4, '2024-09-23 10:20:00'),
	(4, 1, '2024-09-22 19:05:00'),
	(5, 2, '2024-09-21 12:35:00');

# contar likes:
SELECT COUNT(*) FROM likes as cant_likes
WHERE id_publicacion = 4;
# no hacer com SUM() ya que suma las tuplas.

# EJERCICIO 15
# Eliminación de un usuario
# Elimina el usuario con id_usuario = 3 y asegúrate de que todas sus
# publicaciones, comentarios y likes también se eliminen.
    
DELETE FROM wechat.usuarios WHERE id_usuario = 6;
