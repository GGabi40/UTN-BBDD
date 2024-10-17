CREATE SCHEMA hospital;
use hospital;

# EJERCICIO 1
# CREACIÓN DE TABLA y RELACIONES

CREATE TABLE IF NOT EXISTS pacientes (
	id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(9) NOT NULL,
    edad INT NOT NULL,
    sexo ENUM('F', 'M') NOT NULL,
    mail VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS doctores (
	id_doctor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    matricula VARCHAR(50) NOT NULL,
    especialidad VARCHAR(80) NOT NULL,
    mail VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS diagnosticos (
	id_diagnostico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_cita INT NOT NULL
);

ALTER TABLE diagnosticos
ADD FOREIGN KEY (id_cita) REFERENCES citas(id_cita);


CREATE TABLE IF NOT EXISTS citas (
	id_cita INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    horario TIME NOT NULL,
    consultorio VARCHAR(10) NOT NULL,
    id_paciente INT NOT NULL,
    id_doctor INT NOT NULL
);

ALTER TABLE citas
ADD FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente);
ALTER TABLE citas
ADD FOREIGN KEY (id_doctor) REFERENCES doctores(id_doctor);


CREATE TABLE IF NOT EXISTS tratamientos (
	id_tratamientos INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_diagnostico INT NOT NULL
);

ALTER TABLE tratamientos
ADD FOREIGN KEY (id_diagnostico) REFERENCES diagnosticos(id_diagnostico);


-- Insertar Datos:

INSERT INTO pacientes (nombre, apellido, dni, edad, sexo, mail)
VALUES
('Juan', 'Pérez', '12345678', 34, 'M', 'juan.perez@mail.com'),
('Ana', 'González', '87654321', 28, 'F', 'ana.gonzalez@mail.com'),
('Lucía', 'Martínez', '11223344', 42, 'F', 'lucia.martinez@mail.com'),
('Carlos', 'López', '44332211', 55, 'M', 'carlos.lopez@mail.com'),
('Marta', 'Fernández', '66778899', 36, 'F', 'marta.fernandez@mail.com');


INSERT INTO doctores (nombre, apellido, matricula, especialidad, mail)
VALUES
('Roberto', 'Sosa', 'MAT12345', 'Cardiología', 'roberto.sosa@hospital.com'),
('Patricia', 'Ramírez', 'MAT54321', 'Dermatología', 'patricia.ramirez@hospital.com'),
('Alberto', 'Méndez', 'MAT67890', 'Neurología', 'alberto.mendez@hospital.com'),
('Laura', 'García', 'MAT98765', 'Pediatría', 'laura.garcia@hospital.com'),
('Santiago', 'Domínguez', 'MAT11223', 'Gastroenterología', 'santiago.dominguez@hospital.com');


INSERT INTO citas (fecha, horario, consultorio, id_paciente, id_doctor)
VALUES
('2024-10-01', '10:00:00', 'C101', 1, 1),
('2024-10-02', '12:00:00', 'C102', 2, 2),
('2024-10-03', '09:00:00', 'C103', 3, 3),
('2024-10-04', '11:00:00', 'C104', 4, 4),
('2024-10-05', '13:00:00', 'C105', 5, 5);


INSERT INTO diagnosticos (nombre, id_cita)
VALUES
('Hipertensión', 1),
('Dermatitis', 2),
('Migraña', 3),
('Bronquitis', 4),
('Úlcera gástrica', 5);


INSERT INTO tratamientos (nombre, id_diagnostico)
VALUES
('Medicamento antihipertensivo', 1),
('Crema tópica', 2),
('Analgésico', 3),
('Inhaladores', 4),
('Antiácidos', 5);


# ------------ #
-- CONSULTAS:


# 3 - Consultas Avanzadas
# 3.1 

SELECT 
    pacientes.nombre,
    pacientes.apellido,
    doctores.especialidad,
    doctores.nombre AS nombre_doctor,
    doctores.apellido AS apellido_doctor
FROM
    citas
JOIN
    pacientes ON pacientes.id_paciente = citas.id_paciente
JOIN
    doctores ON doctores.id_doctor = citas.id_doctor;


# 3.2

SELECT 
    tratamientos.nombre AS tratamiento,
    diagnosticos.nombre AS diagnostico,
    pacientes.nombre AS nombre_paciente,
    pacientes.apellido AS apellido_paciente,
    citas.fecha AS fecha_cita,
    citas.horario AS horario_cita
FROM
    tratamientos
JOIN
    diagnosticos ON diagnosticos.id_diagnostico = tratamientos.id_diagnostico
JOIN
    citas ON citas.id_cita = diagnosticos.id_cita
JOIN
    pacientes ON pacientes.id_paciente = citas.id_paciente
WHERE
    fecha = '2024-10-02';


# 4 - Store Procedure
# 4.1

DELIMITER //
CREATE PROCEDURE Insertar_Cita(
IN nueva_fecha DATE,
IN nuevo_horario TIME,
IN nuevo_consultorio VARCHAR(10),
IN id_pac INT,
IN id_doc INT)
BEGIN
	INSERT INTO citas (fecha, horario, consultorio, id_paciente, id_doctor) VALUES (nueva_fecha, nuevo_horario, nuevo_consultorio, id_pac, id_doc);
END //

CALL Insertar_Cita('2024-10-10', '11:50:00', 'C105', 1, 2);


# 4.2

DELIMITER //
CREATE PROCEDURE Actualiza_Pac(IN id_pac INT,
IN nuevo_nombre VARCHAR(100),
IN nuevo_apellido VARCHAR(100),
IN nuevo_dni VARCHAR(9),
IN nueva_edad INT,
IN nuevo_sexo ENUM('F', 'M'),
IN nuevo_mail VARCHAR(100))
BEGIN
	UPDATE pacientes
    SET nombre = nuevo_nombre,
    apellido = nuevo_apellido,
    dni = nuevo_dni,
    edad = nueva_edad,
    sexo = nuevo_sexo,
    mail = nuevo_mail
    WHERE id_paciente = id_pac;
END //

CALL Actualiza_Pac(1, 'Juana', 'Pérez', '12345678', 32, 'F', 'juana.perez@mail.com');


# 5 - Consultas Desafiantes
# 5.1

