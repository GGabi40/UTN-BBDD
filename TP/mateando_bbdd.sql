CREATE DATABASE mateando_bbdd;
USE mateando_bbdd;

CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    mail VARCHAR(60) UNIQUE NOT NULL,
    telefono VARCHAR(25) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    es_usuario ENUM('es_usuario', 'no_usuario') NOT NULL,
    dni VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cuit VARCHAR(11) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS rol (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol ENUM('repositor', 'vendedor', 'gerente') NOT NULL
);

CREATE TABLE IF NOT EXISTS empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    mail VARCHAR(60) UNIQUE NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    dni VARCHAR(10) NOT NULL,
    id_rol INT NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES rol(id)
);


CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    detalle TEXT,
    categoria ENUM('mate', 'termo', 'bombilla', 'set_matero', 'envio') NOT NULL,
    cant_stock INT,
    precio DECIMAL(10 , 2) NOT NULL
);


CREATE TABLE IF NOT EXISTS compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cant_producto INT NOT NULL,
    fecha_compra DATE,
    id_producto INT NOT NULL,
    id_proveedor INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id)
);


CREATE TABLE IF NOT EXISTS ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    observaciones TEXT,
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_factura ENUM('A', 'B', 'C') NOT NULL,
    nro_factura INT NOT NULL,
    precio_final DECIMAL(10, 2) NOT NULL,
    metodo_pago ENUM('efectivo', 'tarjeta_credito', 'tarjeta_debito', 'transferencia', 'QR') NOT NULL,
    cant_productos INT NOT NULL,
    id_producto INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos (id),
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes (id)
);

CREATE TABLE IF NOT EXISTS inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    capacidad_total INT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    id_producto INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    id_empleado INT NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id)
);


CREATE TABLE IF NOT EXISTS descuento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    porc_descuento DECIMAL(5, 2),
    id_venta INT NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas (id)
);



--  INSERTAR DATOS --> Otro archivo
