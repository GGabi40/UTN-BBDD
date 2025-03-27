# Transacciones Y Control de Concurrencia

# Transacciones en BBDD: 
-- Es un conjunto de operaciones que se ejecutan simultáneamente 
-- o no se ejecuta ninguna.
-- Asegura la consistencia y la integridad de los datos.
-- Ejemplo: Transferencia Bancaria
-- 			Verifica que la cuenta tenga fondos suficientes > Restar monto de la cuenta >
-- 		Sumar monto a la cuenta destino > registro en el historial > Si hay alguna falla: la 
-- 		transferencia se cancela > se mantiene la consistencia del sistema.

-- -> SET AUTOCOMMIT = 0; -> Que no se committee automaticamente los cambios.

-- SINTAXIS:

START transaction;
	-- consulta
COMMIT; # uno u otro
ROLLBACK;

-- ejempo:
use bibliotecas2;
START transaction;
	SELECT * FROM libros;
	DELETE FROM libros;
-- ROLLBACK; # vuelve para atrás lo que se hizo dentro de la transacción.
COMMIT; # ejecuta el cambio.

-- se debe utilizar un rollaback o un commit


## ACID
# Atomicidad, Consistencia, Aislamiento, Durabilidad.
--  > Atomicity, Consistency, Isolation, Durability.
-- A: todas las operaciones de una transacción se ejecutarán juntas o no se ejecutarán.
-- C: asegura que todos los datos estén en un estado valido.
-- I: capacidad de ejecutar muchas transacciones al mismo momento sin que se "choquen".
-- D: garantiza que los datos permanezcan segurso incluso ante fallos del sistema.
-- 		Lo logra mediante el registro anticipado (write-ahead logging).

# Isolation: tiene 4 niveles.
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; # nivel por defecto. Permite leer 
# datos no confirmados por otras transacciones.

SET TRANSACTION ISOLATION LEVEL READ COMMITTED; # Puede leer solo los datos confirmados.
# Tambien los puede modificar.

-- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; # Lee un dato confirmado pero no lo puede cambiar.

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; # Es el más estricto. Ejecuta las 
# transacciones secuencialmente. Cuando termine la 1a, arranca la 2a, ...
# Recude significativamente el rendimiento.


--  -------  --
# Control de Concurrencia

## Control de Concurrencia y Bloqueos
-- Es el mecanismo que permite que múltiples usuarios 
-- accedan y modifiquen los datos simultáneamente sin crear inconistenncias.

### Tipos de Bloqueos:
-- Bloqueo compartido (Shared Locks) -> varios tipos de bloqueos para controlar 
	-- el acceso concurrent a los datos.
-- Bloqueos exclusivos (Exclusive locks) -> Previene que distintas transacciones ni lean 
	-- ni escriban datos.
-- Bloqueos de intención (Intent locks) -> Indica una transacción planea adquirir 
	-- un bloqueo más específico sobre ciertos datos.
-- Bloqueo a nivel de fila (Row-level locks) -> Bloquea filas individuales en 
	-- lugar de tablas completas.

-- Ejemplo:
SELECT * FROM table_name WHERE id = 10 LOCK IN SHARE MODE; # boqueo para lectura (compartido)
SELECT * FROM table_name WHERE id = 10  FOR UPDATE; # bloqueo para escritura (exclusivo)

## MySQL -> Control de Concurrencia Multiversión (MVCC)
-- Permite a múltiples transacciones trabajar con los mismos 
-- datos sin interferirse entre sí.

-- Manejo de excepciones: (Debe estar dentro de un STORE PROCEDURE)
#START TRANSACTION;
#DECLARE EXIT HANDLER FOR SQLEXCEPTION
#BEGIN
#	ROLLBACK;
#    SELECT 'Error detectdo' AS mensaje;
#END;
-- codigo de la transacción
#COMMIT;


# Puntos de guardados (Savepoints): 
-- Permiten definir marcadores dentro de una transacción 
-- para poder realizar rollbacks.
-- Definir un punto de guardado:
SAVEPOINT transferencia_iniciada;


# Problemas de Concurrencia:
-- Dirty reads: lee datos modificados por otra transacción que aún no ha sido confirmada.
-- Non-repeatable reads: Lee el mismo registro 2 veces y obtiene valores diferentes porque
	-- otra transacción ha modificado los datos.
-- Phantom reads: Ejecuta la misma consulta 2 veces, la segunda vez aparecen filas
	-- adicionales que cumplen los criterios de busqueda.
-- Lost updates: Dos transacciones leen el mismo registro, lo modifican y lo escriben,
	-- causando que la última actualización sobrescriba la primera.
-- Deadlock: Dos transacciones se bloquean mutuamente porque c/u espera recursos que la 
	-- otra tiene bloquedos.
    