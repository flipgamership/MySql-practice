USE Gestion_Proyectos;

DELIMITER //
CREATE FUNCTION promedio_presupuesto()
RETURNS DECIMAL(18,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(18,2);
    -- Calcular el promedio de los presupuestos
    SELECT AVG(presupuesto) INTO promedio FROM proyecto;
    -- Retornar el resultado
    RETURN promedio;
END;
//
DELIMITER ;

SELECT promedio_presupuesto();