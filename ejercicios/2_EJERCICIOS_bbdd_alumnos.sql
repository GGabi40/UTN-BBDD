# Ejercicio 8:
# Obtener la cantidad de alumnos por curso
# Usar un JOIN entre Inscripciones y Cursos 
# para contar cuántos alumnos hay en cada curso.

SELECT cursos.nombre, COUNT(*) AS total_alumnos
FROM inscripciones
INNER JOIN cursos ON cursos.id = inscripciones.curso_id
GROUP BY cursos.nombre;

# Ejercicio 9:
# Listar cursos que se dictan en aulas con capacidad mayor a 30 alumnos
# y que hayan empezado después de 2023
# Usar un JOIN entre Cursos, Horarios y Aulas y agregar una
# cláusula WHERE para la capacidad y la fecha.

SELECT cursos.nombre AS nombre_Curso,
aulas.nombre AS nombre_Aula,
aulas.capacidad
FROM horarios
INNER JOIN cursos ON cursos.id = horarios.curso_id
INNER JOIN aulas ON aulas.id = horarios.aula_id
WHERE aulas.capacidad > 30 AND horarios.hora_inicio > '2023-01-01';

# Ejercicio 10:
# Obtener el promedio de calificaciones por curso
# Usar funciones de agregación para calcular el promedio
# de calificaciones de cada curso.

SELECT AVG(calificaciones.nota) AS promedio,
cursos.nombre AS nombre_curso
FROM calificaciones
JOIN evaluaciones ON evaluaciones.id = calificaciones.evaluacion_id
JOIN cursos ON cursos.id = evaluaciones.curso_id
GROUP BY cursos.id;

# Ejercicio 11:
# Listar los alumnos con calificaciones por encima del promedio en su curso
# Usar una subconsulta para calcular el promedio de calificaciones 
# en cada curso y luego filtrar a los estudiantes con calificaciones mayores a ese promedio.



# Ejercicio 12:
# Obtener el número de alumnos inscritos por departamento de profesor
# Usar JOINs entre Cursos, Inscripciones, y Profesores 
# para obtener la cantidad de alumnos por departamento del profesor.

# Ejercicio 13:
# Listar los cursos que se dictan en un día específico y un rango de horas
# Usar un JOIN entre Cursos y Horarios, y filtrar por día de la semana y hora.

# Ejercicio 14:
# Listar alumnos que no se han inscrito en ningún curso
# Usar una subconsulta con NOT IN para listar los alumnos
# que no tienen registros en la tabla Inscripciones.
# Ejercicio 15:
# Obtener el curso más largo en duración (fecha_fin - fecha_inicio)
# Usar una función para calcular la duración del curso y 
# ordenar para obtener el de mayor duración.

# Ejercicio 16:
# Obtener la lista de profesores que no tienen cursos asignados
# Usar un LEFT JOIN para encontrar los profesores que no están relacionados con ningún curso

# Ejercicio 17:
# Listar los cursos con el mayor número de inscripciones y
# la calificación promedio más alta
# Combinar funciones de agregación (COUNT y AVG)
# y agrupar para obtener cursos ordenados por cantidad de inscripciones
# y calificación promedio.