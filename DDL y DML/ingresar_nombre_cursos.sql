USE utn_bbdd_modificar;

# -- Agrego nombres de cursos
INSERT INTO cursos_tabla_GABIBC (nombre)
VALUES
	('Inglés'),
    ('Programación I'),
    ('Programación II'),
    ('Programación III'),
    ('Base de Datos I'),
    ('Base de Datos II');

# -- Datos de tabla estudiantes
INSERT INTO estudiantes_tabla_GABIBC (nombre, mail, curso_id_tabla)
VALUES
	('Gabriela Baptista', 'gabi@example.com', 2),
    ('Fab Barreto', 'fabBarreto@example.com', 3),
    ('Ela Pedroso', 'elaPedroso@example.com', 4),
    ('Papa frita', 'papaFrita@example.com', 3),
    ('Cheddar', 'cheddar@example.com', 2),
    ('Gabriel Carvalho', 'gabi@example.com', 2);

# -- ACTUALIZAR DATOS
#UPDATE estudiantes_tabla_GABIBC (nombre, mail, curso_id)
#SET mail = 'gabi@example.com';