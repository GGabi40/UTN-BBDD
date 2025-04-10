# Subconsultas
SELECT nombre, apellido, salario,
	(SELECT AVG(salario) FROM empleados) as promedio
FROM empleados;

-- fila con varias colummnas:
SELECT * FROM empleados
WHERE (departamento_id, salario) = (
	SELECT departamento_id, MAX(salario)
    FROM empleados
    GROUP BY departamento_id
    HAVING departamento_id = 3
);

-- columna con multiples filas
-- multiples filas y multiples columnas
-- correlacionadas: ref a columnas de la columna externa.

-- ALL -> Si todos los valores cumplen el where
-- ANY -> Si algunos cumplen