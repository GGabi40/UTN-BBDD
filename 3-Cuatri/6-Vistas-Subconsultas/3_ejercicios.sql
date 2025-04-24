-- Practica Semana 5

# 1. Crear una vista que combine información relevante para el personal
# administrativo, ocultando domicilios. Mostrará nombre y documento del
# estudiante, la materia, horario, nombre del profesor y estado de la
# inscripción. Solo incluir estudiantes que estén cursando alguna materia.

use universidad;

CREATE VIEW infoRelevante
AS
SELECT estudiantes.nombre AS nombre_estudiante, 
estudiantes.documento AS documento_estudiante, 
inscripciones.cod_materia AS codigo_materia,
nombre_materia, 
horario,
profesores.nombre AS nombre_profesor
FROM materias
JOIN inscripciones ON inscripciones.cod_materia = materias.codigo_materia
JOIN estudiantes ON inscripciones.doc_estudiante = estudiantes.documento
JOIN profesores ON profesores.documento = materias.doc_profesor
WHERE inscripciones.estado = 'cursando';

-- mostrar vista
SELECT * FROM infoRelevante;


# 2. Realizar una consulta a la vista para mostrar cuántos estudiantes hay
# inscriptos por materia y horario, ordenados por cantidad.

SELECT nombre_materia, horario,
COUNT(*) AS cantidad_estudiantes
FROM infoRelevante 
GROUP BY codigo_materia
ORDER BY cantidad_estudiantes DESC;


# 3. Consultar la vista para obtener la lista de profesores y los horarios en
# que dictan clases, sin repeticiones.

SELECT DISTINCT nombre_profesor, horario FROM infoRelevante;


# 4. Mostrar, utilizando la vista, a todos los estudiantes que son
# compañeros en Programación I los Martes 14-17.

SELECT nombre_estudiante FROM infoRelevante
WHERE nombre_materia = 'Programación I' AND horario = 'Martes 14-17';


# 5. Crear una nueva vista que muestre la cantidad total de inscriptos para
# cada materia (independientemente del estado: Cursando, Aprobada,
# Libre, etc.), incluyendo el nombre de la materia y el horario. Eliminarla
# previamente si existe.

DROP VIEW IF EXISTS totalPorMateria;

CREATE VIEW totalPorMateria AS 
SELECT COUNT(doc_estudiante),
materias.nombre_materia AS nombre_materia,
materias.horario AS horario
FROM inscripciones
JOIN materias ON materias.codigo_materia = inscripciones.cod_materia
GROUP BY nombre_materia, horario;

SELECT * FROM totalPorMateria;


# 6. Crear una vista que muestre información del estudiante junto con su
# edad calculada, sin exponer la fecha de nacimiento directamente en
# esta vista específica.

CREATE VIEW edadEstudiante AS
SELECT *, 
TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad_estudiante 
FROM estudiantes;

SELECT * FROM edadEstudiante;


# 7. Crear una vista simple, que muestre estudiantes nacidos después del 1
# de enero del 2000. Usando esta vista, insertar 3 nuevos estudiantes.

DROP VIEW IF EXISTS estudiantesJovenes;

CREATE VIEW estudiantesJovenes AS
SELECT * FROM estudiantes WHERE fecha_nacimiento > '2000-01-01';

SELECT * FROM estudiantesJovenes;

INSERT INTO estudiantesJovenes VALUES
('34555666', 'Lucia Torres', 'Mitre 1245', '2001-03-20'),
('35666777', 'Ezequiel Gómez', 'San Juan 998', '2002-12-05'),
('36777888', 'Paula Medina', 'Belgrano 401', '2003-07-30');
