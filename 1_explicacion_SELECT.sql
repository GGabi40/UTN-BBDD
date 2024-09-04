use utn_bbdd_testing;

# SELECT
SELECT id, nombre, apellido FROM alumnos;
SELECT id, nombre, apellido FROM profesores;
SELECT * FROM cursos;

# SELECT .... WHERE
SELECT * FROM alumnos WHERE nombre = 'Lisa';
# --- Sirve para consultar posteriormente las notas de Lisa ---
SELECT id FROM alumnos WHERE nombre = 'Lisa' AND apellido = 'Sanchez';

# SELECT ... WHERE ... BETWEEN
# -- Me trae todos los aulas con capacidad entre 20 y 50
SELECT nombre, capacidad FROM aulas WHERE capacidad BETWEEN 20 AND 50;

# -- Me trae todos los alumnos desaprobados
SELECT alumno_id FROM calificaciones WHERE nota BETWEEN 0 AND 5.9;
# -- Me trae todos los alumnos aprobados
SELECT alumno_id FROM calificaciones WHERE nota BETWEEN 6 AND 10;

# SELECT ... WHERE ... IN
SELECT id, nombre, apellido FROM alumnos WHERE nombre IN ('Derek',  'Lucia', 'Joe');

# SELECT ... WHERE ... LIKE
# -- Trae todos los que tengan el mail example.com
# -- % -> Trae cualquier cosa que venga (si está antes arranca antes)
SELECT id, nombre, apellido FROM profesores WHERE email LIKE '%example.com';
SELECT id, nombre, apellido, email FROM profesores WHERE email LIKE '%14%';
SELECT id, nombre, apellido FROM profesores WHERE nombre LIKE 'k%';