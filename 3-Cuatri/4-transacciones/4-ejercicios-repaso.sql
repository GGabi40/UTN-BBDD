# Repaso Procedimientos Almacenados, Funciones y
# Transacciones

-- 1. Crear tabla de usuarios y posts. Relacionarlas entre ellas con una clave
-- foránea en la tabla que corresponda.
-- Las dos tablas deben tener como mínimo las siguientes columnas: ID, Fecha de creación,
-- Fecha de modificación, Activo (boolean).
-- Para los siguientes ejercicios, registrar en la tabla de auditoría la acción correspondiente.
-- Considerar usar transacciones donde sea necesario

use bibliotecas2;

CREATE TABLE IF NOT EXISTS usuarios (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);


CREATE TABLE IF NOT EXISTS post (
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Además de esto, se requiere crear una tabla llamada trail_auditoria que tenga los siguientes
-- campos: ID, ID de la entidad modificada, Tipo de entidad (usuario | post), Tipo de
-- modificación (creado | modificado | borrado), Comentario. Esta tabla no debe contener la
-- columna Activo.

CREATE TABLE IF NOT EXISTS trail_auditoria
(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_modificado INT NOT NULL,
    tipo_entidad ENUM('usuario', 'post') NOT NULL,
    tipo_modificacion ENUM('creado', 'modificado', 'borrado') NOT NULL,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    comentario VARCHAR(255)
);

# 2. Crear una función que compruebe si un usuario está activo.
# Crear una función que reciba como parámetro el id de un usuario y compruebe si está activo
# o no

DELIMITER // 
CREATE FUNCTION fn_esta_activo (id_usuario INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	DECLARE usuario_activo BOOLEAN;
	SELECT activo INTO usuario_activo FROM usuarios WHERE id = id_usuario;
    
    IF usuario_activo THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END //
DELIMITER ;

SELECT fn_esta_activo(4) AS esta_activo;


# 3. Crear un procedimiento almacenado para insertar publicaciones.
# Desarrollar un procedimiento almacenado que permita crear nuevas publicaciones
# asociadas a un usuario específico, implementando validaciones y manejo de errores.
# Sugerencia: Utilizar la función creada en el ejercicio anterior

SET AUTOCOMMIT = 0;

DELIMITER //
CREATE PROCEDURE sp_crear_post (
IN p_descripcion VARCHAR(255),
IN p_id_usuario INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SELECT "ERROR" AS msj;
		RESIGNAL;
    END;
    
	IF fn_esta_activo(p_id_usuario) THEN
		-- activo
        INSERT INTO post (descripcion, id_usuario) VALUES (p_descripcion, p_id_usuario);
        COMMIT;
    ELSE 
		-- inactivo
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR: El usuario está inactivo.'; # error por ingreso del usuario
		ROLLBACK;
    END IF;
    
END //
DELIMITER ;

CALL sp_crear_post('Que belleza', 1);
CALL sp_crear_post('Que lindo', 4); # salta error - usuario inactivo
SELECT * FROM post;


# 4. Crear un procedimiento almacenado para eliminar publicaciones.
# Desarrollar un procedimiento almacenado que permita eliminar publicaciones de forma
# segura. Implementar un borrado lógico.

DELIMITER //
CREATE PROCEDURE sp_eliminar_post (IN p_id_post INT)
BEGIN
	DECLARE esta_activo BOOLEAN;
    
    SELECT activo INTO esta_activo FROM post WHERE id = p_id_post;
    
    IF esta_activo THEN
		UPDATE post SET activo = 0 WHERE id = p_id_post;
        COMMIT;
    ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR: La publicación está inactiva.'; # error por ingreso del usuario
		ROLLBACK;
    END IF;
END //
DELIMITER ;

SELECT * FROM post;
CALL sp_eliminar_post(2);


# 5. Crear un procedimiento almacenado para actualizar publicaciones.
# Desarrollar un procedimiento almacenado que permita actualizar el contenido de una
# publicación existente.

DELIMITER //
CREATE PROCEDURE sp_actualizar_post (IN p_id_post INT, IN p_descripcion VARCHAR(255))
BEGIN
	DECLARE esta_activo BOOLEAN;
    
    SELECT activo INTO esta_activo FROM post WHERE id = p_id_post;
    
    IF esta_activo THEN
		UPDATE post SET descripcion = p_descripcion, fecha_modificacion = now() WHERE id = p_id_post;
        COMMIT;
    ELSE
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERROR: La publicación está inactiva.'; # error por ingreso del usuario
		ROLLBACK;
    END IF;
END //
DELIMITER ;

SELECT * FROM post;
CALL sp_actualizar_post(1, 'Que divino');

# 6. Crear una función para contar la cantidad de posts activos por usuario.
# Crear una función que reciba un ID de usuario y devuelva la cantidad de posts que el usuario
# tenga activos.

DELIMITER //
CREATE FUNCTION fn_cant_post (p_id_usuario INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE contador INT;
    
    SELECT COUNT(*) INTO contador 
    FROM post 
    WHERE id_usuario = p_id_usuario AND activo = 1;
    
    RETURN contador;
END //
DELIMITER ;

SELECT fn_cant_post(2) AS cant_post_activo;

