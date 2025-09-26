-- Función: calcular margen (precio - costo hipotético)
DELIMITER $$
CREATE FUNCTION fn_margen_unitario(precio DECIMAL(12,2), costo DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
  RETURN precio - costo;
END$$
DELIMITER ;

-- Función: calcular total línea (cantidad * precio)
DELIMITER $$
CREATE FUNCTION fn_total_linea(cantidad INT, precio DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
  RETURN cantidad * precio;
END$$
DELIMITER ;
