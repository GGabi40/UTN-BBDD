CREATE DATABASE IF NOT EXISTS bibliotecaS2;
USE bibliotecaS2;

CREATE TABLE autores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50),
    fecha_nacimiento DATE
);

CREATE TABLE libros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    autor_id INT,
    genero VARCHAR(50),
    anio_publicacion INT,
    disponible BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

CREATE TABLE prestamos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    libro_id INT,
    nombre_usuario VARCHAR(100),
    fecha_prestamo DATE,
    fecha_devolucion_prevista DATE,
    fecha_devolucion_real DATE,
    FOREIGN KEY (libro_id) REFERENCES libros(id)
);

INSERT INTO autores (nombre, nacionalidad, fecha_nacimiento) VALUES
('Gabriel García Márquez', 'Colombiana', '1927-03-06'),
('J.K. Rowling', 'Británica', '1965-07-31'),
('Jorge Luis Borges', 'Argentina', '1899-08-24'),
('Isabel Allende', 'Chilena', '1942-08-02'),
('Haruki Murakami', 'Japonesa', '1949-01-12');

INSERT INTO libros (titulo, autor_id, genero, anio_publicacion, disponible) VALUES
('Cien años de soledad', 1, 'Realismo mágico', 1967, TRUE),
('Harry Potter y la piedra filosofal', 2, 'Fantasía', 1997, TRUE),
('El Aleph', 3, 'Ficción', 1949, TRUE),
('La casa de los espíritus', 4, 'Realismo mágico', 1982, TRUE),
('Tokio blues (Norwegian Wood)', 5, 'Novela', 1987, TRUE),
('Crónica de una muerte anunciada', 1, 'Novela', 1981, TRUE),
('Harry Potter y la cámara secreta', 2, 'Fantasía', 1998, FALSE),
('Ficciones', 3, 'Ficción', 1944, TRUE),
('De amor y de sombra', 4, 'Drama', 1984, TRUE),
('Kafka en la orilla', 5, 'Novela', 2002, TRUE);


-- EJERCICIOS
# 3.Crea un procedimiento llamado sp_insertar_autor que reciba nombre, 
# nacionalidad y fecha de nacimiento de un autor,
# y lo inserte en la tabla correspondiente.

DELIMITER //
CREATE PROCEDURE sp_insertar_autor(
IN nombre VARCHAR(100),
IN nacionalidad VARCHAR(100), 
IN fecha_nacimiento_autor DATE)
BEGIN
	INSERT INTO autores (nombre, nacionalidad, fecha_nacimiento) VALUES (nombre, nacionalidad, fecha_nacimiento);
END //
DELIMITER ;

CALL sp_insertar_autor('George Orwell', 'Indio', '1903-06-25');


-- ----- --

# 4. Crea una función llamada fn_contar_libros_autor que 
# reciba el ID de un autor y devuelva la cantidad de
# libros asociados a él.

DELIMITER //
CREATE FUNCTION fn_contar_libros_autor(p_autor_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE cant_libros INT;
	SELECT count(*) INTO cant_libros FROM libros WHERE p_autor_id = autor_id;
    RETURN cant_libros;
END //
DELIMITER ;

SELECT nombre, fn_contar_libros_autor(id) FROM autores;

INSERT INTO libros(titulo, autor_id, genero, anio_publicacion, disponible) 
VALUES ('Libro', 6, 'Ficción', 1927, TRUE);


-- ----- --

# 5. Crea un procedimiento llamado sp_actualizar_libro que reciba ID 
# y todos los datos de un libro y actualice estos datos si el libro existe.

DELIMITER // 
CREATE PROCEDURE sp_actualizar_libro (
IN id_libro INT,
IN p_titulo VARCHAR(200),
IN p_autor_id INT,
IN p_genero VARCHAR(50),
IN p_anio_publicacion INT,
IN p_disponible BOOLEAN
)
BEGIN
	IF EXISTS (SELECT * FROM libros WHERE id = id_libro) 
		THEN UPDATE libros SET titulo = p_titulo, 
        autor_id = p_autor_id, 
        genero = p_genero,
		anio_publicacion = p_anio_publicacion, 
        disponible = p_disponible
		WHERE id = id_libro;
    END IF;
END //
DELIMITER ;

CALL sp_actualizar_libro(11, '1984', 6, 'Ficción Distopia', '1949', TRUE);
