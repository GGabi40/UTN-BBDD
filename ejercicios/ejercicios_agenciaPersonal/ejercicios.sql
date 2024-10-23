use agencia_personal;

CREATE TABLE IF NOT EXISTS empresas (
	cuit VARCHAR(20) NOT NULL PRIMARY KEY,
    razon_social VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(50)
);


INSERT INTO empresas (cuit, razon_social, direccion, telefono, email) VALUES
('30-10504876-5', 'Viejos Amigos', 'Buenos Aires 4444', '4444444', 'rrhh@viejosamigos.com.ar'),
('30-15876543-4', 'Reuniones Improvisadas', 'Oroño 3333', '4576879', NULL),
('30-20987654-4', 'Porciones Reducidas', 'Viedma 1830', '4556677', NULL),
('30-21008765-5', 'Traigame eso', 'Zeballos 7456', '4455667', 'traigameeso@gmail.com'),
('30-21098732-4', 'Informatiks srl', 'Dorrego 2213 4A', '4857339', 'info@informatiks.biz'),
('30-23456328-5', 'Constructora Gaia S.A.', 'Tucuman 649 PA', '4647125', NULL);


CREATE TABLE IF NOT EXISTS personas (
	dni VARCHAR(20) NOT NULL PRIMARY KEY,
    apellido VARCHAR(30) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_registro_agencia DATE NOT NULL,
    direccion VARCHAR(50) DEFAULT NULL,
    telefono VARCHAR(20) DEFAULT NULL
);


INSERT INTO personas (dni, apellido, nombre, fecha_nacimiento, fecha_registro_agencia, direccion, telefono) VALUES
('12345678', 'Garcia', 'Eliseo', '1985-03-10', '2007-06-13', 'Buenos Aires 123', '4444-5678'),
('23456789', 'Lopez', 'Stefania', '1983-07-22', '2005-12-12', 'Córdoba 456', '4555-6789'),
('34567890', 'Wingdam', 'Raul', '1984-09-30', '2007-07-15', 'Rosario 789', '4666-7890'),
('45678901', 'Losteau', 'Pedro', '1986-01-15', '2008-02-26', 'Mendoza 101', '4777-8901'),
('56789012', 'Guftafson', 'Juana', '1985-05-25', '2007-08-12', 'La Plata 112', '4888-9012'),
('67890123', 'Ruiz', 'Aquiles', '1984-11-03', '2007-06-18', 'Santa Fe 221', '4999-0123');


CREATE TABLE IF NOT EXISTS solicitudes (
	id INT PRIMARY KEY AUTO_INCREMENT,
    cod_cargo INT NOT NULL,
	fecha_solicitud DATE NOT NULL,
	anios_experiencia INT DEFAULT NULL,
	edad_minima INT DEFAULT NULL,
	edad_maxima INT DEFAULT NULL,
	sexo ENUM('F', 'M') DEFAULT NULL,
    cuit_empresa VARCHAR(20) NOT NULL,
	FOREIGN KEY(cuit_empresa) REFERENCES empresas(cuit)
);


INSERT INTO solicitudes (cod_cargo, fecha_solicitud, anios_experiencia, edad_minima, edad_maxima, sexo, cuit_empresa) VALUES
	(6, '2014-09-01', NULL, NULL, NULL, NULL, '30-21098732-4'),
	(4, '2014-09-13', NULL, NULL, NULL, NULL, '30-10504876-5'),
	(2, '2014-09-20', NULL, NULL, NULL, 'F', '30-21008765-5'),
	(3, '2014-09-21', NULL, NULL, NULL, NULL, '30-10504876-5'),
	(5, '2014-09-21', 1, 25, 65, NULL, '30-10504876-5'),
	(1, '2014-09-23', NULL, NULL, NULL, NULL, '30-21008765-5'),
	(6, '2014-09-23', NULL, NULL, NULL, NULL, '30-21098732-4');


CREATE TABLE IF NOT EXISTS antecedentes_laborales (
	id INT PRIMARY KEY AUTO_INCREMENT,
    cod_cargo INT NOT NULL,
    fecha_desde DATE NOT NULL,
    fecha_hasta DATE DEFAULT NULL,
    dni_persona VARCHAR(20) NOT NULL,
    persona_contacto VARCHAR(50) DEFAULT NULL,
    cuit_empresa VARCHAR(20) NOT NULL,
    FOREIGN KEY(dni_persona) REFERENCES personas(dni),
	FOREIGN KEY(cuit_empresa) REFERENCES empresas(cuit)
);

INSERT INTO contratos (dni_persona, salario, cuit_empresa) VALUES
('45678901', 2063.000, '30-10504876-5'),
('67890123', 5870.000, '30-21098732-4'),
('12345678', 5870.000, '30-10504876-5');

INSERT INTO contratos (dni_persona, salario, cuit_empresa) VALUES ('34567890', 1400.000, '30-21008765-5');

INSERT INTO antecedentes_laborales (cod_cargo, fecha_desde, fecha_hasta, dni_persona, persona_contacto, cuit_empresa) VALUES
(2, '2005-03-01', NULL, '12345678', 'Belen Arisa', '30-20987654-4'),
(4, '2006-01-01', NULL, '23456789', 'Armando Esteban Quito', '30-15876543-4'),
(6, '2007-04-15', NULL, '34567890', NULL, '30-10504876-5'),
(7, '2007-06-01', NULL, '45678901', 'Alicia Ramos', '30-23456328-5'),
(3, '2010-02-15', '2015-05-01', '12345678', 'Carlos Mendez', '30-21008765-5'),
(1, '2011-06-30', '2016-07-15', '23456789', 'Laura Perez', '30-20987654-4'),
(5, '2008-09-01', '2014-12-30', '45678901', 'Rodrigo Suarez', '30-15876543-4');


CREATE TABLE IF NOT EXISTS contratos (
	nro_Contrato INT AUTO_INCREMENT PRIMARY KEY,
    dni_persona VARCHAR(20) NOT NULL,
    salario DECIMAL(10, 3) NOT NULL,
    cuit_empresa VARCHAR(20) NOT NULL,
    FOREIGN KEY(dni_persona) REFERENCES personas(dni),
	FOREIGN KEY(cuit_empresa) REFERENCES empresas(cuit)
);


CREATE TABLE IF NOT EXISTS titulos (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(30) NOT NULL,
    tipo VARCHAR(30) NOT NULL
);

INSERT INTO titulos (descripcion, tipo) VALUES
('Técnico Electrónico', 'Secundario'),
('Diseñador de Interiores', 'Terciario'),
('Técnico Mecánico', 'Secundario'),
('Payaso de Circo', 'Educación no formal'),
('Arquitecto', 'Universitario'),
('Entrenador de Lemures', 'Educación no formal'),
('Ing en Sist de Inf', 'Universitario'),
('Bachiller', 'Secundario');

# Ordenar por descripcion
SELECT * FROM titulos ORDER BY descripcion;


# Buscar Nro dni 12345678
SELECT CONCAT(apellido, " " ,nombre) as Apellido_Nombre,
fecha_nacimiento as Fecha_Nac,
telefono as Teléfono,
direccion as Dirección
FROM personas
WHERE dni = "12345678";


# Buscar Dnis 34567890 45678901 56789012
SELECT CONCAT(apellido, " " ,nombre) as Apellido_Nombre,
fecha_nacimiento as Fecha_Nac,
telefono as Teléfono,
direccion as Dirección
FROM personas
WHERE dni = "34567890" OR dni = "45678901" OR dni = "56789012"
ORDER BY fecha_nacimiento;


# Apellido empiece con la letra ‘G’
SELECT * FROM personas
WHERE apellido LIKE 'G%';


# Personas nacidas entre 1980 y 2000
SELECT nombre, apellido, fecha_nacimiento
FROM personas
WHERE YEAR(fecha_nacimiento)
BETWEEN 1980 AND 2000
ORDER BY fecha_nacimiento;


# 8. Solicitudes que hayan sido hechas alguna 
# vez ordenados en forma ascendente
# por fecha de solicitud

SELECT * FROM solicitudes
ORDER BY fecha_solicitud ASC;


# 9. Que aún no hayan terminado su relación laboral
# ordenados por fecha desde.

SELECT * FROM antecedentes_laborales
WHERE fecha_hasta IS NULL
ORDER BY fecha_desde;


# 10. Mostrar aquellos antecedentes laborales que finalizaron 
# y cuya fecha hasta no esté entre
# junio del 2013 a diciembre de 2013, 
# ordenados por número de DNI del empleado.

SELECT dni_persona, cod_cargo, fecha_desde, fecha_hasta
FROM antecedentes_laborales
WHERE fecha_hasta NOT BETWEEN (2013-06-01) AND (2013-12-31)
ORDER BY dni_persona;


# 11. Salario sea mayor que 2000 y trabajen en las empresas 
# 30-10504876-5 o 30-21098732-4.

SELECT *
FROM contratos
WHERE salario > 2000.000 AND (cuit_empresa = '30-10504876-5' OR '30-21098732-4');
