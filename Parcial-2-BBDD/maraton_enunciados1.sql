USE maraton;

# Consulta básica de selección
# Muestra la lista de todos los participantes con su nombre, 
# apellido y número de documento.

SELECT nombre, apellido, nro_doc_pas FROM participantes;


# Operador lógico - Filtros por edad y género
# Encuentra los participantes de género femenino 
# cuya edad sea entre 18 y 30 años.

SELECT nombre, apellido, genero, edad
FROM participantes
WHERE genero = 'F' AND edad BETWEEN 18 AND 30
order by edad ASC;


# Consulta de agrupación - Categorías por recorrido
# Obtén el número de categorías disponibles para cada recorrido.

SELECT COUNT(categorias.descripcion) AS numero_de_categorias,
recorridos.distancia AS distancia_reco
FROM categorias
JOIN recorridos ON recorridos.id = categorias.recorrido_id
GROUP BY categorias.recorrido_id;



# Uso de JOIN para relacionar tablas
# Realiza una consulta para mostrar el 
# nombre, apellido, y nacionalidad de cada participante, 
# utilizando las tablas participantes y paises.

SELECT nombre, apellido, paises.pais
FROM participantes
JOIN paises ON paises.id = participantes.nacionalidad_id;

-- cuenta cuántos son de qué país
SELECT COUNT(nacionalidad_id) as otras_nac, 
paises.pais
FROM participantes
JOIN paises ON paises.id = participantes.nacionalidad_id
GROUP BY pais;


# Consulta con función de agregación - Tiempo promedio
# Calcula el tiempo promedio registrado para cada 
# inscripción de la tabla tiempos.

SELECT inscripcion_id as ID_participantes,
AVG(tiempo) as promedio_tiempo
FROM tiempos
JOIN inscripciones ON inscripciones.id = tiempos.inscripcion_id
GROUP BY inscripcion_id;

-- 3 mejores tiempos:
SELECT nombre, apellido
FROM participantes
WHERE id IN (
	SELECT inscripcion_id
    FROM tiempos
    WHERE tiempo < (SELECT AVG(tiempo) FROM tiempos)
)
LIMIT 3;


-- Alteracion de tablas:
ALTER TABLE tiempos
DROP PRIMARY KEY;

ALTER TABLE tiempos
ADD COLUMN tiempos_id INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE tiempos
MODIFY COLUMN inscripcion_id BIGINT;

ALTER TABLE tiempos
ADD CONSTRAINT
FOREIGN KEY (inscripcion_id) REFERENCES inscripciones(id);
-- -- -- -- -- -- -- -- -- -- -- -- -- -- 


# Consulta con JOIN y filtros - Participantes por ciudad
# Encuentra los nombres y apellidos de los 
# participantes que residen en la ciudad de "Buenos Aires".

SELECT nombre, apellido
FROM participantes p
JOIN ciudades ON p.id = ciudades.id
WHERE ciudad = 'Buenos Aires';


# Consulta de eliminación - Participantes sin inscripción
# Mostrar tabla de participantes en el cual los registros 
# que no tengan una inscripción asociada en la tabla inscripciones.

SELECT p.nombre, p.apellido, p.id
FROM inscripciones
RIGHT JOIN participantes p ON inscripciones.participante_id = p.id
WHERE inscripciones.id IS NULL;

-- contar:
SELECT COUNT(p.id) AS cant_No_Inscripto
FROM inscripciones i
RIGHT JOIN participantes p ON i.participante_id = p.id
WHERE i.id IS NULL;


-- Store Procedures

# Crea un procedimiento llamado registrar_participante que reciba 
# como parámetro el nombre y apellido de un participante y registre los 
# datos en la tabla participantes. Si el participante ya existe (por su nombre y apellido), 
# no debe insertarse un nuevo registro, y debe devolver un mensaje indicando que el 
# participante ya está registrado.

#DELIMITER //
#CREATE PROCEDURE registrar_participante(
#IN doc VARCHAR(15), 
#IN nuevo_genero ENUM('F', 'M'),
#IN nuevo_nombre VARCHAR(100), 
#IN nuevo_apellido VARCHAR(100),
#IN nueva_fecha_nac DATE,
#IN nueva_edad INT,
#IN nueva_institucion VARCHAR(255),
#IN nuevo_cto_em VARCHAR(255),
#IN nuevo_cel_cto_em VARCHAR(20),
#IN nueva_cobertura VARCHAR(255),
#IN nueva_direccion VARCHAR(100),
#IN nueva_ciudad_id BIGINT,
#IN nueva_nac_id BIGINT,
#IN nuevo_celular VARCHAR(20))
#BEGIN
	
#    IF EXISTS (SELECT 1 FROM participantes WHERE nombre = nuevo_nombre AND apellido = nuevo_apellido) THEN
#		SELECT 'Ya está registrado.';
#	ELSE    
#		INSERT INTO participantes (nro_doc_pas, genero, nombre, apellido, fec_nac, edad, institucion,
#		nom_cto_emerg, cel_cto_emerg, cobertura_medica, ciudad_id, nacionalidad_id, celular)
#		VALUES (doc, nuevo_genero, nuevo_nombre, nuevo_apellido,
#		nueva_fecha_nac, nueva_edad, nueva_institucion, nuevo_cto_em, nuevo_cel_cto_em, nueva_cobertura,
#		nueva_direccion, nueva_ciudad_id, nueva_nac_id, nuevo_celular);
#	END IF;
#END //


# Kits asignados en Maratones
# Para cada participante, muestra el nombre de la maratón, 
# el tipo de kit asignado y el número total de participantes que
# han recibido ese kit.

SELECT nombre, 
apellido,
kits.talle,
maratones.descripcion
FROM inscripciones
JOIN participantes p ON p.id = inscripciones.participante_id
JOIN recorridos ON recorridos.id = inscripciones.recorrido_id
JOIN kits ON kits.id = inscripciones.talle_kit_id
JOIN maratones ON maratones.id = recorridos.maraton_id;

-- contar
SELECT kits.talle,
COUNT(kits.id) AS cant_talle
FROM inscripciones
JOIN recorridos ON recorridos.id = inscripciones.recorrido_id
JOIN kits ON kits.id = inscripciones.talle_kit_id
JOIN maratones ON maratones.id = kits.maraton_id
GROUP BY kits.talle;


# Consulta de Participantes en Maratones por Distancia
# Muestra los nombres de los participantes, la maratón en la que 
# están inscritos, y la distancia del recorrido. Solo incluye a los 
# participantes inscritos en recorridos de más de 10 km.

SELECT p.nombre,
p.apellido,
r.distancia
FROM inscripciones
JOIN recorridos r ON r.id = inscripciones.recorrido_id
JOIN participantes p ON p.id = inscripciones.participante_id
WHERE distancia >= 42;



# Participantes con Mejor Tiempo
# Encuentra los nombres y apellidos de los participantes que 
# hayan registrado un tiempo menor al promedio en la tabla de tiempos. 
# Solo deben aparecer los participantes que tienen tiempos registrados 
# por debajo de este promedio general.

SELECT p.nombre, p.apellido
FROM participantes p
WHERE id IN (
	SELECT inscripcion_id
    FROM tiempos
    WHERE tiempo < (SELECT AVG(tiempo) FROM tiempos)
);


# Consulta de Inscripciones sin Kit Asignado
# Muestra el nombre, apellido y la maratón en la que están 
# inscritos los participantes que aún no tienen un kit asignado. 
# Asegúrate de que solo aparezcan los registros en los que el kit está vacío o nulo.

SELECT nombre, apellido
FROM participantes
WHERE id IN (
	SELECT participante_id FROM inscripciones
    WHERE talle_kit_id IS NULL
);

SELECT nombre, apellido
FROM participantes
WHERE id IN (
	SELECT participante_id FROM inscripciones
    WHERE recorrido_id IS NULL
);


