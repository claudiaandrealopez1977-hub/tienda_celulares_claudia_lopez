-- Informe: ventas totales por cliente
SELECT * FROM vw_ventas_cliente;

-- Informe: productos más vendidos
SELECT * FROM vw_ventas_producto ORDER BY total_vendido DESC;

-- Informe: estado del stock
SELECT * FROM vw_stock_actual ORDER BY stock_actual ASC;
