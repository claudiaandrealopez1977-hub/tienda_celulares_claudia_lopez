USE tienda_celulares;

-- Productos
INSERT INTO producto (nombre, precio_lista, stock_minimo) VALUES
 ('Samsung Galaxy S23', 450000, 5),
 ('iPhone 14 128GB',   650000, 4),
 ('Xiaomi Redmi Note 12', 250000, 6),
 ('Cargador USB-C 25W', 12000, 8),
 ('Funda Silicona S23', 6000, 10);

-- Clientes
INSERT INTO cliente (nombre, telefono, email) VALUES
 ('Juan Pérez','3704-111111','juanp@gmail.com'),
 ('María López','3704-222222','mlopez@yahoo.com');

-- Stock base (una fila por producto)
INSERT INTO stock (id_producto, cantidad) VALUES
 (1,0),(2,0),(3,0),(4,0),(5,0)
ON DUPLICATE KEY UPDATE cantidad = VALUES(cantidad);

-- Ajuste simple para permitir ventas
UPDATE stock SET cantidad = 5  WHERE id_producto = 1; -- S23
UPDATE stock SET cantidad = 3  WHERE id_producto = 2; -- iPhone
UPDATE stock SET cantidad = 20 WHERE id_producto = 3; -- Redmi
UPDATE stock SET cantidad = 15 WHERE id_producto = 4; -- Cargador
UPDATE stock SET cantidad = 30 WHERE id_producto = 5; -- Funda

-- Ventas de prueba (disparan triggers)
INSERT INTO venta (fecha, id_cliente, id_producto, cantidad, precio_unitario, total_linea)
VALUES
 (CURRENT_DATE, 1, 1, 1, 450000, 0),  -- 1 Galaxy S23
 (CURRENT_DATE, 2, 5, 3,   6000,  0); -- 3 Fundas

-- Verificaciones rápidas (dejá descomentado si querés ver en el momento)
-- SELECT * FROM vw_stock_actual;
-- SELECT * FROM vw_ventas_por_dia;
-- SELECT * FROM vw_top_productos;
SELECT * FROM vw_stock_actual;
SELECT * FROM vw_ventas_por_dia;
SELECT * FROM vw_top_productos;
