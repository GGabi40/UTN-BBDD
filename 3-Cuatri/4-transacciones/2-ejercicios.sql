use bibliotecas2;

-- Ejecicios Transacciones:
# Crea una transacción que cambie el estado de disponibilidad de un libro a FALSE
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