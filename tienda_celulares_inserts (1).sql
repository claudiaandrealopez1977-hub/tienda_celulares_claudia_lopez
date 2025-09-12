-- =========================================================
-- Tienda de Celulares - INSERTS (Entrega 2, modelo simple 4 tablas)
-- =========================================================
USE tienda_celulares;

INSERT INTO producto (nombre, precio, stock_minimo) VALUES
('Samsung Galaxy S23', 450000, 5),
('iPhone 14 128GB',   650000, 4),
('Xiaomi Redmi Note 12', 250000, 6),
('Cargador USB-C 25W', 12000, 8),
('Funda Silicona S23', 6000, 10);

INSERT INTO cliente (nombre, telefono, email) VALUES
('Juan Pérez',  '3704-111111', 'juanp@gmail.com'),
('María López', '3704-222222', 'mlopez@yahoo.com');

INSERT INTO stock (id_producto, cantidad) VALUES
(1,5), (2,3), (3,10), (4,25), (5,30);

CALL sp_registrar_venta(CURRENT_DATE(), 1, 1, 1, 450000);
-- CALL sp_registrar_venta(CURRENT_DATE(), 2, 2, 999, 650000); -- debería fallar por trigger
CALL sp_registrar_venta(CURRENT_DATE(), 1, 5, 3, 6000);

-- SELECT * FROM vw_stock_actual;
-- SELECT * FROM vw_ventas_clientes;
-- SELECT * FROM vw_ventas_por_dia;
