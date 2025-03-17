-- Ejemplo 1 - ORDER BY

use biblioteca;

SELECT titulo, fecha_publicacion 
FROM libros 
ORDER BY titulo ASC;

-- Ejemplo 2 - GROUP BY

SELECT usuario_id, COUNT(*) AS total_prestamos
FROM prestamos
GROUP BY usuario_id;


-- Ejemplo 3 - HAVING

SELECT autor_id, nombre, apellido, COUNT(*) AS total_libros
FROM libros
JOIN autores ON autores.id_autor = libros.autor_id
WHERE libros.fecha_publicacion > '2000-01-01'
GROUP BY autor_id
HAVING COUNT(*) > 0;


-- Ejemplo 4 - SUBCONSULTAS

SELECT titulo
FROM libros
WHERE id IN (
	SELECT libro_id
    FROM prestamos
    GROUP BY libro_id
    HAVING COUNT(*) > 1
);


SELECT nombre, apellido
FROM usuario
WHERE id_usuario IN (
	SELECT usuario_id
    FROM prestamos
    JOIN libros ON libros.id = prestamos.libro_id
    WHERE autor_id = (
		SELECT id_autor
        FROM autores
        WHERE nombre = 'Laura' AND apellido = 'Pérez'
    )
);
# Trae nombre, apellido de usuarios de préstamos que pidieron prestamos libros de Laura

-- Ejemplo 5 - INDEXACIÓN

CREATE INDEX idx_usuario_id ON prestamos(usuario_id);
