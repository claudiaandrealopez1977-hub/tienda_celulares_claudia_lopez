-- Trigger: Evitar venta si no hay stock suficiente
DELIMITER $$
CREATE TRIGGER trg_validar_stock
BEFORE INSERT ON venta
FOR EACH ROW
BEGIN
  DECLARE stock_actual INT;
  SELECT cantidad INTO stock_actual FROM stock WHERE id_producto = NEW.id_producto;

  IF stock_actual < NEW.cantidad THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: Stock insuficiente para realizar la venta';
  END IF;
END$$
DELIMITER ;

-- Trigger: Descontar stock automáticamente al registrar venta
DELIMITER $$
CREATE TRIGGER trg_descontar_stock
AFTER INSERT ON venta
FOR EACH ROW
BEGIN
  UPDATE stock
  SET cantidad = cantidad - NEW.cantidad
  WHERE id_producto = NEW.id_producto;
END$$
DELIMITER ;
