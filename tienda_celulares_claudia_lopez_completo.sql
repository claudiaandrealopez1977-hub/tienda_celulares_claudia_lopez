
-- =========================================================
-- TIENDA DE CELULARES - ESQUEMA COMPLETO (versión simple: 4 tablas)
-- Crea la base de datos, tablas, claves foráneas, índices e inserta datos mínimos
-- MySQL 8+
-- =========================================================

-- 1) Recrear base de datos
DROP DATABASE IF EXISTS tienda_celulares;
CREATE DATABASE tienda_celulares
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE tienda_celulares;

-- 2) Tablas
-- 2.1 producto
CREATE TABLE producto (
  id_producto   INT AUTO_INCREMENT PRIMARY KEY,
  nombre        VARCHAR(150) NOT NULL,
  precio        DECIMAL(10,2) NOT NULL,
  stock_minimo  INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

-- 2.2 cliente
CREATE TABLE cliente (
  id_cliente  INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(150) NOT NULL,
  telefono    VARCHAR(30),
  email       VARCHAR(150)
) ENGINE=InnoDB;

-- 2.3 stock (1 a 1 con producto)
CREATE TABLE stock (
  id_producto INT PRIMARY KEY,
  cantidad    INT NOT NULL DEFAULT 0,
  CONSTRAINT fk_stock_producto
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 2.4 venta (cada fila = un producto vendido)
CREATE TABLE venta (
  id_venta         INT AUTO_INCREMENT PRIMARY KEY,
  fecha            DATE NOT NULL,
  id_cliente       INT NULL,
  id_producto      INT NOT NULL,
  cantidad         INT NOT NULL,
  precio_unitario  DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_venta_cliente  FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_venta_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 3) �?ndices
CREATE INDEX ix_producto_nombre ON producto (nombre);
CREATE INDEX ix_venta_fecha     ON venta (fecha);
CREATE INDEX ix_venta_cliente   ON venta (id_cliente);

-- 4) Datos mínimos de prueba
INSERT INTO producto (nombre, precio, stock_minimo) VALUES
('Samsung Galaxy S21 FE', 250000, 5),
('Funda Silicona S21',    5000,   10),
('Cargador USB-C 25W',    12000,  8);

INSERT INTO cliente (nombre, telefono, email) VALUES
('Juan Pérez',  '3704-111111', 'juanp@gmail.com'),
('María López', '3704-222222', 'mlopez@yahoo.com');

INSERT INTO stock (id_producto, cantidad) VALUES
(1, 5), (2, 20), (3, 10);

INSERT INTO venta (fecha, id_cliente, id_producto, cantidad, precio_unitario) VALUES
(CURRENT_DATE(), 1, 1, 1, 250000),
(CURRENT_DATE(), 2, 2, 3,  5000);

-- 5) Verificaciones rápidas (opcionales)
-- SELECT * FROM producto;
-- SELECT * FROM cliente;
-- SELECT p.nombre, s.cantidad FROM producto p JOIN stock s ON s.id_producto = p.id_producto;
-- SELECT v.id_venta, v.fecha, c.nombre AS cliente, p.nombre AS producto, v.cantidad, v.precio_unitario
-- FROM venta v LEFT JOIN cliente c ON c.id_cliente = v.id_cliente JOIN producto p ON p.id_producto = v.id_producto;
