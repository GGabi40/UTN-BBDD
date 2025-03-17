# EJERCICIO 1
# Ordenar Libros
# Crea una consulta que muestre todos los libros de la tabla libros , ordenados
# alfabéticamente por el título.

use biblioteca;

SELECT * 
FROM libros
ORDER BY titulo ASC;


# EJERCICIO 2
# Libros Más Recientes
# Escribe una consulta que obtenga todos los libros publicados después del año 2015,
# ordenados por la fecha de publicación en orden descendente.

SELECT fecha_publicacion, titulo 
FROM libros
WHERE fecha_publicacion > '2015-01-01'
ORDER BY fecha_publicacion ASC;


# EJERCICIO 3
# Contar Libros por Autor
# Realiza una consulta que cuente cuántos libros hay por cada autor en la tabla
# libros . Muestra el autor_id y el total de libros.

SELECT autor_id, COUNT(*) AS total_libros
FROM libros
JOIN autores ON autores.id_autor = libros.autor_id
GROUP BY autor_id;


# EJERCICIO 4
# Promedio de Libros Prestados
# Escribe una consulta que calcule el promedio de libros prestados por cada usuario en
# la tabla prestamos . Asegúrate de agrupar los resultados por usuario_id .

SELECT usuario_id, AVG(numero_prestamos) AS promedio_libros
FROM (
	SELECT usuario_id, COUNT(*) AS numero_prestamos
    FROM prestamos
    GROUP BY usuario_id
) AS subconsulta
GROUP BY usuario_id;


# EJERCICIO 5
# Autores con Más de 3 Libros
# Crea una consulta que muestre los autor_id de los autores que tienen más de 3 libros
# en la biblioteca. Usa la cláusula HAVING para filtrar los resultados.

SELECT autor_id, nombre, apellido
FROM libros
JOIN autores ON libros.autor_id = autores.id_autor
GROUP BY autor_id
HAVING COUNT(*) >= 1;


# EJERCICIO 6
# Libros Prestados Frecuentemente
# Escribe una consulta que muestre los títulos de los libros que han sido prestados más
# de 5 veces. Utiliza funciones de grupo y la cláusula HAVING .

SELECT libro_id, COUNT(*) AS cant_prestamos, titulo
FROM prestamos
JOIN libros ON prestamos.libro_id = libros.id
GROUP BY libros.id
HAVING cant_prestamos > 1;


# EJERCICIO 7
# Usuarios que Han Prestado Libros
# Crea una consulta que devuelva los nombres y apellidos de los usuarios que han tomado
# prestados libros de un autor específico, por ejemplo, "Gabriel García Márquez".

SELECT usuario.nombre, usuario.apellido
FROM usuario
JOIN prestamos ON prestamos.usuario_id = usuario.id_usuario
JOIN libros ON libros.id = prestamos.libro_id
JOIN autores ON autores.id_autor = libros.autor_id
WHERE autores.nombre = 'Laura';


# EJERCICIO 8
# Libros con Préstamos Recientes
# Realiza una consulta que obtenga los títulos de los libros que han sido prestados en
# los últimos 30 días, junto con la fecha del préstamo.

SELECT l.titulo, p.fecha_prestamo
FROM libros l
JOIN prestamos p ON l.id = p.libro_id
WHERE
p.fecha_prestamo >= CURRENT_DATE() - INTERVAL 30 DAY;


# EJERCICIO 9
# Libros con el Mayor Préstamo
# Escribe una consulta que muestre el título del libro con el mayor número de préstamos.
# Utiliza una subconsulta para lograrlo.

SELECT titulo, fecha_publicacion
FROM libros
WHERE libros.id = (
	SELECT prestamos.libro_id
	FROM prestamos
	GROUP BY prestamos.libro_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
);


# EJERCICIO 10
# Préstamos Agrupados por Mes
# Crea una consulta que cuente el número total de préstamos realizados cada mes y
# muestre el resultado junto con el mes y el año. Utiliza funciones de grupo y GROUP
# BY .

SELECT DATE_FORMAT(fecha_prestamo, "%Y-%m") AS mes_anio, 
COUNT(*) AS total_prestamos
FROM prestamos
GROUP BY mes_anio
ORDER BY mes_anio;