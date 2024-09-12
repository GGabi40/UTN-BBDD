use biblioteca;

# Ejercicio 1
# Obtené una lista con todos los libros y los nombres de los autores.

SELECT libros.titulo AS titulo_libro,
autores.nombre AS nombre_autor,
autores.apellido AS nombre_apellido
FROM libros
JOIN autores
ON libros.autor_id = autores.id_autor; # combinar las filas donde el valor en la columna autor_id 
# de libros coincide con el valor en la columna id de autores


# Ejercicio 2
# Encontrar los libros publicados después del 2000.

SELECT titulo, fecha_publicacion FROM libros
WHERE fecha_publicacion > '2000-01-01';

# /\ OTRA ALTERNATIVA \/
SELECT titulo, fecha_publicacion FROM libros
WHERE YEAR(fecha_publicacion) > 2000; # año mayor a 2000

# - para mes:
SELECT titulo, fecha_publicacion FROM libros
WHERE MONTH(fecha_publicacion) = 3; # mes igual a mayo

# - para día:
SELECT titulo, fecha_publicacion FROM libros
WHERE DAY(fecha_publicacion) > 15; # día mayor a 15

# Ejercicio 3
# Mostrar los nombres de los usuarios activos, ordenar por apellido
# de forma descendente.
SELECT nombre, apellido
FROM usuario
WHERE estado_cliente = 'ACTIVO'
ORDER BY apellido ASC;

# Ejercicio 4
# Contá cuantos préstamos se realizó por usuario.

SELECT usuario.nombre, usuario.apellido, usuario_id, COUNT(*) AS cantidad_prestamos
FROM prestamos
JOIN usuario ON usuario.id_usuario = prestamos.usuario_id
GROUP BY usuario_id;

# Ejercicio 5
# Mostrar los titulos de los préstamos de los titulos de los
# usuarios suspendidos.

SELECT usuario.nombre, usuario.apellido, libros.titulo
FROM prestamos
JOIN usuario ON usuario.id_usuario = prestamos.usuario_id
JOIN libros ON libros.id = prestamos.libro_id
WHERE estado_cliente = 'SUSPENDIDO';

# Ejercicio 6
# Calcular el numero total de libros que hay en la bbdd
# y la cantidad de autores distintos.


# Ejercicio 7
# Actualizar el estado de los usuarios a SUSPENDIDO en el
# caso de que tengan más de 5 prestamos.

