use S1;

CREATE TABLE IF NOT EXISTS productos (
	producto_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_producto VARCHAR(255) NOT NULL,
    codigo_barra BIGINT UNIQUE NOT NULL,
    precio DECIMAL(3,2) NOT NULL CHECK (precio >= 0),
    cantidad_stock INT DEFAULT 0,
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);
