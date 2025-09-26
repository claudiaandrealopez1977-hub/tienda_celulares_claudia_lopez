-- SP: Registrar una venta
DELIMITER $$
CREATE PROCEDURE sp_registrar_venta(
  IN p_id_cliente INT,
  IN p_id_producto INT,
  IN p_cantidad INT
)
BEGIN
  DECLARE v_precio DECIMAL(12,2);
  DECLARE v_total DECIMAL(12,2);

  -- Obtener precio del producto
  SELECT precio INTO v_precio FROM producto WHERE id_producto = p_id_producto;

  -- Calcular total
  SET v_total = fn_total_linea(p_cantidad, v_precio);

  -- Insertar venta
  INSERT INTO venta (fecha, id_cliente, id_producto, cantidad, precio_unitario, total_linea)
  VALUES (CURDATE(), p_id_cliente, p_id_producto, p_cantidad, v_precio, v_total);

  -- Descontar stock
  UPDATE stock SET cantidad = cantidad - p_cantidad WHERE id_producto = p_id_producto;
END$$
DELIMITER ;

-- SP: Listar ventas de un cliente
DELIMITER $$
CREATE PROCEDURE sp_listar_ventas_cliente(IN p_id_cliente INT)
BEGIN
  SELECT v.id_venta, v.fecha, p.nombre AS producto, v.cantidad, v.total_linea
  FROM venta v
  JOIN producto p ON v.id_producto = p.id_producto
  WHERE v.id_cliente = p_id_cliente;
END$$
DELIMITER ;
