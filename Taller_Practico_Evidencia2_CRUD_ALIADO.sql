USE Gestion_Proyectos;

-- Ingresar (Insert) aliado
DELIMITER //
CREATE PROCEDURE insert_aliado(
    IN aliado_nombre VARCHAR(150), 
    IN aliado_apellido VARCHAR(150)
)
BEGIN
    INSERT INTO aliado (nombre, apellido) 
    VALUES (aliado_nombre, aliado_apellido);
END;
//
DELIMITER ;

-- Leer (SELECT)
DELIMITER //
CREATE PROCEDURE get_aliados()
BEGIN
    SELECT * FROM aliado;
END;
//
DELIMITER ;

-- Actualizar (UPDATE)
DELIMITER //
CREATE PROCEDURE update_aliado(
    IN aliado_id INT, 
    IN aliado_nombre VARCHAR(150), 
    IN aliado_apellido VARCHAR(150)
)
BEGIN
    UPDATE aliado 
    SET nombre = aliado_nombre, apellido = aliado_apellido 
    WHERE id_aliado = aliado_id;
END;
//
DELIMITER ;

-- Eliminar (DELETE)
DELIMITER //
CREATE PROCEDURE delete_aliado(
    IN aliado_id INT
)
BEGIN
    DELETE FROM aliado 
    WHERE id_aliado = aliado_id;
END;
//
DELIMITER ;