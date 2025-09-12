-- =========================================================
-- Tienda de Celulares - OBJETOS (Entrega 2, modelo simple 4 tablas)
-- Vistas, Funciones, Stored Procedures y Triggers
-- MySQL 8+
-- =========================================================
USE tienda_celulares;

DROP VIEW IF EXISTS vw_stock_actual;
DROP VIEW IF EXISTS vw_ventas_clientes;
DROP VIEW IF EXISTS vw_ventas_por_dia;

DROP FUNCTION IF EXISTS fn_total_linea;
DROP FUNCTION IF EXISTS fn_faltante_stock;

DROP PROCEDURE IF EXISTS sp_registrar_venta;

DROP TRIGGER IF EXISTS trg_validar_stock_before_insert;
DROP TRIGGER IF EXISTS trg_descuenta_stock_after_insert;

DELIMITER $$
CREATE FUNCTION fn_total_linea(p_cantidad INT, p_precio DECIMAL(10,2))
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
  RETURN p_cantidad * p_precio;
END$$

CREATE FUNCTION fn_faltante_stock(p_actual INT, p_minimo INT)
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE v_falta INT;
  SET v_falta = p_minimo - p_actual;
  IF v_falta < 0 THEN SET v_falta = 0; END IF;
  RETURN v_falta;
END$$
DELIMITER ;

CREATE OR REPLACE VIEW vw_stock_actual AS
SELECT p.id_producto, p.nombre, s.cantidad AS stock_actual, p.stock_minimo,
       fn_faltante_stock(s.cantidad, p.stock_minimo) AS faltante_minimo
FROM producto p JOIN stock s ON s.id_producto = p.id_producto;

CREATE OR REPLACE VIEW vw_ventas_clientes AS
SELECT v.id_venta, v.fecha, COALESCE(c.nombre,'Consumidor Final') AS cliente,
       p.nombre AS producto, v.cantidad, v.precio_unitario,
       fn_total_linea(v.cantidad, v.precio_unitario) AS total_linea
FROM venta v
LEFT JOIN cliente c ON c.id_cliente=v.id_cliente
JOIN producto p ON p.id_producto=v.id_producto;

CREATE OR REPLACE VIEW vw_ventas_por_dia AS
SELECT v.fecha, SUM(fn_total_linea(v.cantidad, v.precio_unitario)) AS total_dia
FROM venta v GROUP BY v.fecha ORDER BY v.fecha DESC;

DELIMITER $$
CREATE PROCEDURE sp_registrar_venta(
  IN p_fecha DATE, IN p_id_cliente INT, IN p_id_producto INT,
  IN p_cantidad INT, IN p_precio DECIMAL(10,2)
)
BEGIN
  INSERT INTO venta (fecha,id_cliente,id_producto,cantidad,precio_unitario)
  VALUES (p_fecha,p_id_cliente,p_id_producto,p_cantidad,p_precio);
  SELECT LAST_INSERT_ID() AS id_venta_creada;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trg_validar_stock_before_insert
BEFORE INSERT ON venta
FOR EACH ROW
BEGIN
  DECLARE v_stock INT;
  SELECT cantidad INTO v_stock FROM stock WHERE id_producto=NEW.id_producto FOR UPDATE;
  IF v_stock IS NULL THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No existe registro de stock para el producto.'; END IF;
  IF NEW.cantidad > v_stock THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Stock insuficiente para la venta.'; END IF;
END$$

CREATE TRIGGER trg_descuenta_stock_after_insert
AFTER INSERT ON venta
FOR EACH ROW
BEGIN
  UPDATE stock SET cantidad = cantidad - NEW.cantidad WHERE id_producto = NEW.id_producto;
END$$
DELIMITER ;
