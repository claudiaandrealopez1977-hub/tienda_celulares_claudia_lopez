-- CREA/SELECCIONA LA BASE
CREATE DATABASE IF NOT EXISTS tienda_celulares CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tienda_celulares;

-- LIMPIEZA (por si había restos)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS venta;
DROP TABLE IF EXISTS stock;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS producto;
SET FOREIGN_KEY_CHECKS = 1;

-- ===== TABLAS =====

-- Productos
CREATE TABLE producto (
  id_producto   INT AUTO_INCREMENT PRIMARY KEY,
  nombre        VARCHAR(150) NOT NULL,
  precio_lista  DECIMAL(10,2) NOT NULL,
  stock_minimo  INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

-- Clientes
CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre     VARCHAR(150) NOT NULL,
  telefono   VARCHAR(30),
  email      VARCHAR(150)
) ENGINE=InnoDB;

-- Stock (1 fila por producto)
CREATE TABLE stock (
  id_producto INT PRIMARY KEY,
  cantidad    INT NOT NULL DEFAULT 0,
  CONSTRAINT fk_stock_prod FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
) ENGINE=InnoDB;

-- Ventas (1 fila = un producto vendido)
CREATE TABLE venta (
  id_venta        INT AUTO_INCREMENT PRIMARY KEY,
  fecha           DATE NOT NULL,
  id_cliente      INT NULL,
  id_producto     INT NOT NULL,
  cantidad        INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  total_linea     DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_vta_cli  FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente)  ON DELETE SET NULL,
  CONSTRAINT fk_vta_prod FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
) ENGINE=InnoDB;

-- Índices útiles
CREATE INDEX ix_prod_nombre ON producto(nombre);
CREATE INDEX ix_vta_fecha   ON venta(fecha);
SHOW TABLES;