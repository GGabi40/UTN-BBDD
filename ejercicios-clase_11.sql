use utn_bbdd_testing;

# EJERCICIO 1:
# -- Encuentra todos los alumnos que tienen un número de teléfono. Muestra su
# nombre, apellido y número de teléfono.

SELECT nombre, apellido, telefono FROM alumnos WHERE telefono != 'null';

# EJERCICIO 2:
# -- Muestra los nombres y apellidos de los alumnos que están inscritos en al
# menos un curso. Usa el operador IN para realizar la selección, asumiendo que
# la inscripción está registrada en la tabla de inscripciones.

# nombre y apellido
# condición: inscripcion > 1 curso
SELECT alumnos.nombre AS nombre_alumnos,
alumnos.apellido AS apellido_alumnos
FROM alumnos
INNER JOIN inscripciones ON inscripciones.alumno_id = alumnos.id;

# EJERCICIO 3:
# -- Encuentra todos los cursos que tienen una descripción con una longitud de
# caracteres que se encuentra dentro de un rango específico. Muestra el
# nombre del curso y su descripción.

SELECT cursos.nombre AS nombre_curso,
cursos.descripcion AS descripcion_curso
FROM cursos WHERE LENGTH(cursos.descripcion) BETWEEN 1 AND 255;

# EJERCICIO 4:
# -- Cuenta el número total de cursos que existen en la base de datos.
# Muestra solo el total de cursos.

SELECT COUNT(*) FROM cursos;

# EJERCICIO 5:
# -- Supón que hay una columna precio en una tabla de productos. 
# Calcula la suma de los valores de la columna precio 
# para todos los productos. (Asume que tienes una tabla 
# productos con una columna precio).

SELECT SUM(nota) FROM calificaciones;

# EJERCICIO 6:
# -- Calcula el promedio de la capacidad de todas las aulas.
# Muestra el valor promedio.

SELECT AVG(capacidad) FROM aulas;

# EJERCICIO 7:
# -- Encuentra la mayor y menor capacidad de las aulas registradas. 
# Muestra ambos valores.

SELECT MIN(capacidad), MAX(capacidad) FROM aulas;

# EJERCICIO 8:
# -- Encuentra todos los nombres de profesores que contienen una
# cierta cadena de caracteres en el medio del nombre. 
# Usa el operador LIKE para realizar la selección.

SELECT nombre FROM profesores WHERE nombre LIKE '%a%';

# EJERCICIO 9:
# -- Cuenta cuántos alumnos tienen una fecha de nacimiento 
# posterior a una fecha específica (sin proporcionar una
# fecha concreta). Muestra solo el total.