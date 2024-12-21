-- Parcial SQL Bases de Datos I
-- Fecha: 07/11/2024

-- Realiza la ejercitación solicitada dentro de este script para luego subirlo a la tarea
-- 2do Parcial II SQL https://frro.cvg.utn.edu.ar/mod/assign/view.php?id=71777

-- Base de datos MARATÓN: https://frro.cvg.utn.edu.ar/pluginfile.php/258594/mod_resource/content/1/maraton.sql
USE maraton;

# 1  (1 punto)
-- Seleccionar los participantes que cumplan con las siguientes condiciones:
-- sexo masculino
-- que hayan cumplido 70 años o más
-- cuyo nombre comience con Ricardo y apellido contenga la letra a
-- ordenados por fecha de nacimiento en forma ascendente
-- | Nro de documento | Nombre y apellido | Fec. Nacimiento | Edad|
-- | xxxxxxxx         | xxxx xxxxxx       | dd/mm/yyyy      | xx  |

SELECT 
    nro_doc_pas AS nro_Documento,
    CONCAT(nombre, ' ', apellido) AS nombre_Apellido,
    fec_nac AS fecha_Nacimiento,
    edad
FROM
    participantes
WHERE
    genero = 'M' AND edad >= 70 AND nombre LIKE 'Ricardo%' AND apellido LIKE '%a%'
ORDER BY fec_nac ASC;



# 2 (1 punto)
-- Relaciona la tabla hija tiempos con inscripciones creando una foreign key, verifica el dominio del atributo 
-- inscripcion_id y cambialo de ser necesario.

ALTER TABLE tiempos
DROP PRIMARY KEY;

ALTER TABLE tiempos
ADD COLUMN tiempos_id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE tiempos
MODIFY COLUMN inscripcion_id BIGINT;

ALTER TABLE tiempos
ADD CONSTRAINT
FOREIGN KEY (inscripcion_id) REFERENCES inscripciones(id);


# 3 (2 punto)
-- crear la tabla localidades con los campos:
-- id INT AUTOINCREMENT
-- localidad VARCHAR(100) NOT NULL
-- provincia VARCHAR(100) NOT NULL
-- insertar las localidades de Rosario, Villa Gobernador Gálvez y Funes de la provincia de Santa Fe
-- modificar la tabla participantes creando un campo id_localidad y armar la foreign key a la tabla localidades
-- actualizar la tabla para que todos los participantes pertenezcan a la localidad de Rosario 
-- (no hardcodear el id para Rosario, usar subconsulta o variables)

CREATE TABLE IF NOT EXISTS localidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    localidad VARCHAR(100) NOT NULL,
    provincia VARCHAR(100) NOT NULL
);

INSERT INTO localidades (localidad, provincia) VALUES 
('Rosario', 'Santa Fe'),
('Villa Gobernador Gálvez', 'Santa Fe'),
('Funes', 'Santa Fe');


ALTER TABLE participantes
ADD COLUMN id_localidad INT;

ALTER TABLE participantes
ADD CONSTRAINT
FOREIGN KEY (id_localidad) REFERENCES localidades(id);


#INSERT INTO participantes (id_localidad) 
# --------


SELECT ciudad_id, id_localidad FROM participantes;
SELECT * FROM ciudades; # rosario id = 270


# 4 (3 puntos)
-- Mostrar nombre y apellido, tiempo de los participantes
-- en el caso de que no haya tiempo mostrar la leyenda "sin registro"
-- ordenados por tiempo en forma ascendente.
-- |nombre y apellido     |tiempo  |
-- |xxxxxxxxx xxxxxxx     |hh:mm:ss|

SELECT CONCAT(nombre, ' ', apellido) AS nombre_Apellido,
tiempos.tiempo AS tiempo
FROM tiempos
JOIN inscripciones ON inscripciones.id = tiempos.inscripcion_id
JOIN participantes ON participantes.id = inscripciones.participante_id
WHERE tiempo IN (
    IF tiempo IS NULL THEN
		SELECT "Sin registro"
	ELSE
		SELECT tiempo FROM tiempos
	END IF
)
GROUP BY tiempo ASC;


# 5 (3 puntos)
-- Edad promedio (redondeada a 2 decimales) de los participantes y cantidad de 
# inscriptos por categoría para las categorías
-- General Masculino y General Femenino para el recorrido con distancia de 42 kms.
-- |categoría           | edad promedio | cant. Inscriptos |
-- |General M			| xx.xx años    | xxx			   |
-- |General F			| xx.xx años    | xxx              |

SELECT 
    categorias.descripcion,
    AVG(participantes.edad) AS edad_Promedio,
    COUNT(participantes.id) AS cant_Inscriptos
FROM
inscripciones
JOIN insccats ON inscripcion.id = inscripciones.id
JOIN categorias ON categorias.id = insscats.id
JOIN participantes ON inscripciones.id = participantes.id;


