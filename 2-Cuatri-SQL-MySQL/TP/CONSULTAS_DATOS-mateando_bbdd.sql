# --- INNER JOIN ---

# 1. CONSULTAS CON INNER JOIN
# Verifica qué clientes obtuvieron descuentos en sus compras
# y qué productos compraron

SELECT clientes.nombre,
clientes.apellido,
porc_descuento as descuento,
productos.nombre AS producto
FROM descuento
INNER JOIN ventas ON descuento.id_venta = ventas.id
INNER JOIN clientes ON clientes.id = ventas.id_cliente
INNER JOIN productos ON productos.id = ventas.id_producto;


# 2. CONSULTAS CON INNER JOIN
# Verifica qué empleado trabaja en cada inventario/deposito 
# y qué rol cumple

SELECT empleados.nombre,
empleados.apellido,
rol.nombre_rol AS rol,
inventario.direccion as inventario
FROM inventario
INNER JOIN empleados ON empleados.id = inventario.id_empleado
INNER JOIN rol ON rol.id = empleados.id_rol;


# --- LEFT/RIGHT JOIN ---

# 1. CONSULTAS CON RIGHT JOIN
# Obtener los productos y observaciones que 
# se vendieron, si no se vendió, aparecerá solamente el 
# nombre del producto

SELECT ventas.observaciones,
ventas.fecha_emision,
ventas.precio_final,
productos.nombre AS producto
FROM ventas
RIGHT JOIN productos ON ventas.id_producto = productos.id;


# 2. CONSULTAS CON LEFT JOIN
# Verifica clientes que realizaron compras, si no realizó una compra
# aparece como "NULL"

SELECT clientes.nombre,
clientes.apellido,
ventas.id_cliente AS realizó_compra
FROM clientes
LEFT JOIN ventas ON ventas.id_cliente = clientes.id;



# --- AGRUPACIÓN y AGREGACIÓN ---

# Obtener el promedio de ventas por cliente
SELECT ROUND(AVG(ventas.precio_final), 2) AS promedio_venta_cliente,
id_cliente AS cliente
FROM ventas
INNER JOIN clientes ON clientes.id = ventas.id_cliente
GROUP BY cliente;


# Verifica la cantidad suficiente de Stock de una categoría en específico
# para su posterior compra

SELECT productos.nombre,
SUM(cant_stock) AS cantidad_stock
FROM productos
WHERE categoria = 'mate'
GROUP BY nombre
HAVING cantidad_stock <= 20;


# --- CONSULTAS CON SUBCONSULTAS ---

# Obtener las ventas de productos específicos
SELECT clientes.nombre, 
clientes.apellido,
clientes.es_usuario,
clientes.mail
FROM clientes
WHERE id IN (
	SELECT id_producto FROM ventas
    WHERE id_producto = 44 OR id_producto = 51
);


# Obtener compra más reciente desde proveedores
SELECT nombre, cuit
FROM proveedores
WHERE id = (
	SELECT id_proveedor
    FROM compras
    ORDER BY fecha_compra DESC
    LIMIT 1
);


# --- STORED PROCEDURES ---

# Inserción de Nuevo Cliente
DELIMITER //
CREATE PROCEDURE insertar_cliente (
IN nuevo_nombre VARCHAR(100),
IN nuevo_apellido VARCHAR(100),
IN nuevo_mail VARCHAR(60),
IN nuevo_telefono VARCHAR(25),
IN nueva_direccion VARCHAR(100),
IN nuevo_es_usuario ENUM('es_usuario', 'no_usuario'),
IN nuevo_dni VARCHAR(10)
)
BEGIN
	INSERT INTO clientes (nombre, apellido, mail, telefono, direccion, es_usuario, dni) VALUES
    (nuevo_nombre, nuevo_apellido, nuevo_mail, nuevo_telefono, nueva_direccion, nuevo_es_usuario, nuevo_dni);
END //
DELIMITER //;

CALL insertar_cliente('Dora', 'Tejedor','luisina51@example.net', '+34 872 274 581', 'Camino de Abril Fuster 365 Burgos, 31991', 'no_usuario', 50040645);


# Modificación de precio de un producto
DELIMITER //
CREATE PROCEDURE modifica_precio (IN id_producto INT, IN nuevo_precio DECIMAL(10,2))
BEGIN
	UPDATE productos
    SET precio = nuevo_precio
    WHERE id = id_producto;
END //
DELIMITER //; */


CALL modifica_precio(41, 10000.00);


# Obtener Productos Por Categoria
DELIMITER //
CREATE PROCEDURE ObtenerProductosPorCategoria (
IN categoria_param ENUM('mate', 'termo', 'bombilla', 'set_matero', 'envio')
)
BEGIN
	SELECT * FROM productos WHERE categoria = categoria_param;
END //
DELIMITER //;


CALL ObtenerProductosPorCategoria('bombilla');
