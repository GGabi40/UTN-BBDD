### TABLAS TEMPORALES ###

-- Es una tabla especial que se crea y almacena únicamente en la sesión 
-- de la BBDD en la q fue creada.

-- Ideales para procesar grandes volumenes de datos en consultas complejas,
-- optimizando el rendimiento sin impactar permanentemente en la BBDD.


# Tipos de tablas temporales:
-- Temporary Table: Solo existen dentro de las sesiones en la q se crearon.
	-- Son exclusivas de la sesión.

-- Derived Table: Subconsultas, por ejemplo.

CREATE TEMPORARY TABLE temp_table_name (
	prod_id INT,
    nombre_prod VARCHAR(100),
    precio DECIMAL(10,2)
);

	-- se pueden realizar las mismas consultas.

# Dropearla:
DROP TEMPORARY TABLE IF EXISTS temp_table_name; 
	-- No es muy común ya que se eliminan automáticamente.

