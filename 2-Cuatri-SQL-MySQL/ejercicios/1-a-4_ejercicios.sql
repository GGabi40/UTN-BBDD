use utn_bbdd_testing;

# Ejercicio 1:
# obtén una lista de todos los profesores que pertenecel al departamento de 'Science'
# Muestra nombre, apellido, nombre del dpto.

SELECT nombre, apellido, departamento FROM profesores WHERE departamento_id = 1;

# Ejercicio 2:
# Calcula el número total de inscripciones en cada curso.
# Muestra el nombre del curso y la cantidad de alumnos inscriptos.

# -- "AS" es como ponerlo dentro de una variable

SELECT cursos.nombre AS nombre_curso, COUNT(inscripciones.id) AS total_inscripciones 
FROM cursos
LEFT JOIN inscripciones ON cursos.id = inscripciones.id
GROUP BY cursos.id, cursos.nombre;

# Ejercicio 3:
# Encuentra todos los alumnos que nacieron entre el 1 de enero de 1995 y el 31 de diciembre de 2000.
# muestra su nombre, apellido y fecha de nacimiento.

SELECT nombre, apellido, fecha_nacimiento FROM alumnos 
WHERE fecha_nacimiento BETWEEN '1995-01-01' AND '2000-12-31';

# Ejercicio 4:
# Obtén una lista de los cursos y los nombres de los profesores que los imparten,
# pero solo para aquellos cursos que se dicten en aulas con una capacidad mayor a 30 personas.

SELECT cursos.nombre AS nombre_curso, 
profesores.nombre AS nombre_profesores 
FROM cursos
INNER JOIN profesores ON cursos.profesor_id = profesores.id
INNER JOIN horarios ON cursos.id = horarios.curso_id
INNER JOIN aulas ON horarios.aula_id = aulas.id
WHERE aulas.capacidad > 30;