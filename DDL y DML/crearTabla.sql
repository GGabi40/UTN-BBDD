use utn_bbdd_modificar;

# -- Crear tabla

CREATE TABLE cursos_tabla_GABIBC (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE estudiantes_tabla_GABIBC (
	id INT AUTO_INCREMENT PRIMARY KEY, # su id
    nombre VARCHAR(50) NOT NULL, # nombre de hasta 50 caracteres que no puede ser nulo
    fecha_nacimiento DATE,
    curso_id_tabla INT,
    FOREIGN KEY (curso_id_tabla) REFERENCES cursos_tabla_GABIBC(id)
);

# -- alterar tabla, agregar tabla mail
ALTER TABLE estudiantes_tabla_GABIBC ADD mail VARCHAR(100);

# -- alterar tabla, eliminar tabla fecha nacimiento
ALTER TABLE estudiantes_tabla_GABIBC DROP COLUMN fecha_nacimiento;