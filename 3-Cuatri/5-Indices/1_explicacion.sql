# Índices
## Optimización de consultas

-- Estructura de datos que permite encontrar eficientemente aquellas tuplas
-- (registros) q tienen un valor fijo para el att.

# ejemplo de busqueda sin índice:
SELECT * FROM friends WHERE nombre = 'Zack';

## Estructuras de Índices
-- Árboles de Búsqueda: tipo especial de árbol que sirve para guiar
-- la búsqueda de un registro, dado el valor de uno de sus campos.

-- Árboles B: similar al anterior, pero el árbol siempre estará equilibrado.


## Formas de Aplicar Índices
-- Índices Simple: una única columna con valores duplicados o nulos.
CREATE INDEX idx_actor_last_name ON actor (last_name);

-- Índice Único (Unique Index): se define una columna con restricción UNIQUE, lo que garantiza
-- que los valores sean únicos. Pero admite valores nulos.
CREATE UNIQUE INDEX idx_unique_manager ON store (manager_staff_id);

-- Primary Index: se genera automaticamente al definir la clave primaria de una tabla.
-- Su caract principal es que los valores de los campos nidexados son únicos y no nulos.

-- Índice Compuesto: se crea a partir de 2 o + columnas de una tabla, permitiendo búsquedas
-- basadas en la combinación de estas. El orden en que se definen las columnas son imp!
CREATE INDEX idx_store_id_film__id ON inventory (story_id, film_id);

-- Índice de Texto Completo (Full-Text Index): para optimizar búsquedas en columnas de texto 
-- extenso. Permite realizar consultas en lenguaje natural e incluye caract avanzadas.
CREATE FULLTEXT INDEX idx_title_description ON film_text (title, descriptionFilm);

-- Índice Espacial (Spatial Index): se utiliza para indexar objetos geométricos, como puntos,
-- líneas y polígonos, con el objetivo de optimizar consultas espaciales.
CREATE SPATIAL INDEX idx_location ON address (location);

