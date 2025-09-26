USE tienda_celulares;

-- Vista: Stock actual por producto
CREATE OR REPLACE VIEW vw_stock_actual AS
SELECT p.id_producto, p.nombre, s.cantidad AS stock_actual
FROM producto p
JOIN stock s ON p.id_producto = s.id_producto;

-- Vista: Ventas por cliente
CREATE OR REPLACE VIEW vw_ventas_cliente AS
SELECT c.nombre AS cliente, SUM(v.total_linea) AS total_gastado
FROM venta v
JOIN cliente c ON v.id_cliente = c.id_cliente
GROUP BY c.nombre;

-- Vista: Ventas por producto
CREATE OR REPLACE VIEW vw_ventas_producto AS
SELECT p.nombre AS producto, SUM(v.cantidad) AS total_vendido, SUM(v.total_linea) AS ingresos
FROM venta v
JOIN producto p ON v.id_producto = p.id_producto
GROUP BY p.nombre;
