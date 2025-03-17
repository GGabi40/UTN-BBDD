use utn_bbdd_testing;

# COUNT()
SELECT COUNT(*) FROM inscripciones;
# -- me trae todas las inscripciones que hubo en el curso de id 2
SELECT COUNT(*) FROM inscripciones WHERE curso_id = 2;
# -- me trae todos los mails de alumnos que terminen en example.com
SELECT COUNT(*) FROM alumnos WHERE email LIKE '%example.com';
# adentro de COUNT se pueden poner columnas
SELECT COUNT(id) FROM alumnos WHERE email LIKE '%example.com';

SELECT COUNT(*) FROM calificaciones WHERE nota BETWEEN 6 AND 10;

# SUM()
# -- suma columnas de una tabla
SELECT SUM(capacidad) FROM aulas;
SELECT SUM(presente) FROM asistencias WHERE curso_id = 7;

# -- verifico cuantas ausencias hubo
SELECT COUNT(*) FROM asistencias WHERE curso_id = 10 AND presente = 0;

# AVG()
# -- promedio de columna
SELECT AVG(nota) FROM calificaciones WHERE nota BETWEEN 6 AND 10;

# MAX()
# -- valor máximo de una columna
select max(nota) from calificaciones WHERE nota;

# MIN()
# -- valor mínimo de una columna
select min(nota) from calificaciones WHERE nota;