## Store Procedure (20/03/2025) -> S2

# Procedimiento Almacenado -> Sentencias de SQL que se guarda en BBDD. Se puede llamar 
# cuando sea necesario.
	# Ventajas -> Consultas se compilan dentro del motor de bbdd (más eficiencia),
	# 			Permite controlar tablas y permisos, reutilización de código,
    #			Reduce el tráfico de red, facilita mantenimiento, simplifica transacciones.

# Sintaxis:
DELIMITER //
CREATE PROCEDURE nombre_procedimiento()
BEGIN
	-- consultas SQL
END //
DELIMITER ;

-- Tipos de Parámetros (exclusivo store procedure)
# IN: entrada
# OUT: salida
# INOUT

DELIMITER //
CREATE PROCEDURE generar_reporte(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
	DECLARE total INT;
    SELECT SUM(can_ventas) INTO total FROM ventas;
END //
DELIMITER ;

# Para llamarlo:
CALL nombre_procedimiento();
# @ -> variables de sesión.

-- VARIABLES
# de sesión -> No tienen un tipo, duran mientras se mantenga la sesión. Se declaran:
SET @total = 10;

# regulares -> Tienen un tipo. Tienen validez en el scope de la función (siempre dentro de una función).
-- DECLARE papas VARCHAR(20);

-- EJERCICIO -> S2


-- --------------------- --

## FUNCIONES ALMACENADAS -> Similar, pero está diseñada para calcular 
# 						y devolver un único valor.
# Solo se pueden utilizar en SELECT, o INSERT...
# Los parámetros siempre serán de entrada.

-- Sintaxis:
DELIMITER //
CREATE FUNCTION nombre_funcion(valor1 INT, valor2 VARCHAR(20))
RETURNS VARCHAR(20)
BEGIN
	-- funcion
    RETURN algo;
END //
DELIMITER ;

-- Ejemplo:
DELIMITER //
CREATE FUNCTION multiply(valor1 INT, valor2 INT))
RETURNS INT
BEGIN
    RETURN valor1 * valor2;
END //
DELIMITER ;


# DROP PROCEDURE IF EXISTS nombre_procedimiento;
# DROP FUNCTION IF EXISTS nombre_function;


## Buenas Practicas
-- sp_nombre_storeProcedure -> "sp_"
-- fn_nombre_funcion -> "fn_"
-- dejar comentarios sobre qué hace la funcion o procedimiento.
