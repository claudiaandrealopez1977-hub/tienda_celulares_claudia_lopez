
-- =========================================================
-- Tienda de Celulares - Carga mínima de datos
-- Solo INSERTs (para volver a poblar sin recrear tablas)
-- =========================================================

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
