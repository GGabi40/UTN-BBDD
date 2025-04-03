# TRIGGERS
-- Es un disparador, es un objeto de la bbdd que está asociado con una tabla.
-- Se activa cuando se produce un evento particular en ella.
-- Es una acción en cadena que empieza cuando un evento específico
-- ocurre sobre una tabla específica.

-- Eventos: INSERT / DELETE / UPDATE
-- Momentos de activación: BEFORE / AFTER
-- Tipos de Triggers: ROW TRIGGERS (de fila) / STATEMENT TRIGGERS (en setencia)
-- Sintaxis:
#CREATE TRIGGER nombre_trigger
#[AFTER|BEFORE] [INSERT|UPDATE|DELETE] ON nombre_tabla FOR EACH ROW
#BEGIN
	-- codigo
#END

-- ejemplo:
CREATE TRIGGER nombre_trigger
BEFORE UPDATE ON nombre_tabla FOR EACH ROW
BEGIN
	-- Codigo para antes de actualizar
END;


-- Se utiliaz para mantener la integridad de la bbdd, como por ejemplo:
-- validar información, calcular att derivador, seguimientos de movimientos
-- en la bbdd.

## Limitaciones de triggers:
-- No se puede referir a tablas directamente por su nombre.
-- No se puede invocar procedimiento almacenados utilizando la sentencia CALL.
-- No puede utilizar sentencias que inicien o finalicen una transacción, tal como
	-- START TRANSACTION, COMMIT, o ROLLBACK.
-- Triggers consumen muchos recursos.
