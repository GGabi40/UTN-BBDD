use bibliotecas2;

-- Ejecicios Transacciones:
# 1. Crea una transacción que cambie el estado de disponibilidad de un libro a FALSE
# (prestado), pero sólo si el libro está actualmente disponible. Utiliza ROLLBACK si el
# libro no está disponible.

SET AUTOCOMMIT = 0;

DELIMITER // 
CREATE PROCEDURE sp_libro_disponible(IN libro INT)
BEGIN
	DECLARE esta_disponible BOOLEAN;
    
    START TRANSACTION;
	SELECT disponible INTO esta_disponible FROM libros WHERE id = libro;
    
    IF esta_disponible THEN
		UPDATE libros 
        SET disponible = FALSE
        WHERE id = libro;
        
        SELECT 'Estado de disponibilidad cambiado a prestado' AS Mensaje;
		COMMIT; # todo salió bien, actualizá
    ELSE
        SELECT 'Libro indisponible.' AS Mensaje;
        ROLLBACK; # algo salió mal, volvemos al estado anterior
    END IF;
END //
DELIMITER ;

CALL sp_libro_disponible(6);

SELECT * FROM libros;

-- ----- --

# 2. Crea un procedimiento almacenado llamado prestar_libro que registre un préstamo
# y actualice la disponibilidad del libro, todo dentro de una transacción.

DELIMITER //
CREATE PROCEDURE sp_prestar_libro 
(
IN p_libro_id INT,
IN p_nombre_usuario VARCHAR(100),
IN p_fecha_prestamo DATE,
IN p_fecha_devolucion_prev DATE,
IN p_fecha_devolucion DATE
)
BEGIN
	DECLARE esta_disponible BOOLEAN;
    
    START TRANSACTION;
	SELECT disponible INTO esta_disponible FROM libros WHERE id = p_libro_id;
    
    IF esta_disponible THEN
        INSERT INTO prestamos 
        (libro_id, nombre_usuario, fecha_prestamo, fecha_devolucion_prevista, fecha_devolucion_real) 
        VALUES (p_libro_id, p_nombre_usuario, p_fecha_prestamo, p_fecha_devolucion_prev, p_fecha_devolucion);
        
        UPDATE libros 
        SET disponible = FALSE
        WHERE id = p_libro_id;
        
        SELECT 'Estado de disponibilidad cambiado a prestado' AS Mensaje;
		COMMIT; # todo salió bien, actualizá
    ELSE
        SELECT 'Libro indisponible.' AS Mensaje;
        ROLLBACK; # algo salió mal, volvemos al estado anterior
    END IF;
END //;
DELIMITER ;

SELECT * FROM prestamos;
SELECT * FROM libros;

CALL sp_prestar_libro(5, 'GGabi40', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 2 MONTH), DATE_ADD(CURDATE(), INTERVAL 1 MONTH));


-- ----- --

# 3. Crea una transacción simple que añada un nuevo libro. Si el autor no existe (por
# ejemplo, el autor_id = 10), la transacción debe cancelarse.

DELIMITER //
CREATE PROCEDURE sp_add_book
(
IN p_titulo VARCHAR(200), 
IN p_author_id INT, 
IN p_genero VARCHAR(50), 
IN p_anio_publicacion INT,
IN p_disponible TINYINT(1)
)
BEGIN
	DECLARE id_author INT;
    SELECT id INTO id_author FROM autores WHERE id = p_author_id;
    
    START TRANSACTION;
    IF (id_author) IS NOT NULL THEN
		SELECT 'Agregando libro...' as msj;
        
        INSERT INTO libros (titulo, autor_id, genero, anio_publicacion, disponible) VALUES
        (p_titulo, p_author_id, p_genero, p_anio_publicacion, p_disponible);
	ELSE
		SELECT 'Este autor no existe.' as msj;
        ROLLBACK;
    END IF;
END //;
DELIMITER ;

DROP PROCEDURE sp_add_book;

CALL sp_add_book('Homenaje a Cataluña', 6, 'Biografía', 1938, 1);

SELECT titulo FROM libros
JOIN autores ON autores.id = libros.autor_id
WHERE autores.id = 6;

-- ----- --

# 4. Crea un procedimiento almacenado que preste un libro específico a un usuario,
# utilizando una transacción. 
-- > Similar al 2

-- ----- --

# 5. Crea un procedimiento almacenado llamado devolver_libro que registre la
# devolución de un libro y actualice su disponibilidad. Debe incluir manejo de errores
# para garantizar que la transacción se complete correctamente

DELIMITER //
CREATE PROCEDURE sp_devolver_libro
(
IN p_id_libro INT
)
BEGIN
	DECLARE libro_disponible BOOLEAN;
    
	SELECT 
		disponible
	INTO
		libro_disponible
    FROM
		libros
	WHERE
		id = p_id_libro;
    
    IF (libro_disponible) THEN
		SELECT 'Este libro no fue reservado.'
        ROLLBACK;
	ELSE
		SELECT 'Devolviendo libro...' as MSJ;
        
        UPDATE libros
        SET disponible = 1
        WHERE id = p_id_libro;
        
        COMMIT;
	END IF;
END //;
DELIMITER ;

SELECT * FROM libros;
SELECT * FROM prestamos;

CALL sp_devolver_libro(1);

-- ----- --

# 6. Crea un procedimiento para registrar la devolución de múltiples libros en una sola
# transacción, utilizando savepoints para poder hacer rollback parcial si alguna
# devolución falla.


