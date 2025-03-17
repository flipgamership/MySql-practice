USE Gestion_Proyectos;

-- Insertar (Insert) proyecto
DELIMITER //
CREATE PROCEDURE insert_proyecto(
    IN proyecto_nombre VARCHAR(200),
    IN proyecto_id_aliado INT, 
    IN proyecto_descripcion VARCHAR(300), 
    IN proyecto_presupuesto DECIMAL(18,2), 
    IN proyecto_horas_estimadas INT, 
    IN proyecto_fecha_inicio DATE, 
    IN proyecto_fecha_fin DATE
)
BEGIN
    -- Insertar el proyecto con el id del aliado ya asociado
    INSERT INTO proyecto (nombre_proyecto, id_aliado, descripcion, presupuesto, horas_estimadas, fecha_inicio, fecha_fin)
    VALUES (proyecto_nombre, proyecto_id_aliado, proyecto_descripcion, proyecto_presupuesto, proyecto_horas_estimadas, proyecto_fecha_inicio, proyecto_fecha_fin);
END;
//
DELIMITER ;

-- Leer (SELECT)
DELIMITER //
CREATE PROCEDURE get_proyectos()
BEGIN
    SELECT p.id_proyecto, p.nombre_proyecto, p.descripcion, p.presupuesto, p.fecha_inicio, p.fecha_fin, 
           a.nombre AS aliado_nombre, a.apellido AS aliado_apellido
    FROM proyecto p
    JOIN aliado a ON p.id_aliado = a.id_aliado;
END;
//
DELIMITER ;

-- Actualizar (UPDATE)
DELIMITER //
CREATE PROCEDURE update_proyecto(
    IN proyecto_id INT, 
    IN proyecto_nombre VARCHAR(200), 
    IN proyecto_id_aliado INT, 
    IN proyecto_descripcion VARCHAR(300), 
    IN proyecto_presupuesto DECIMAL(18,2), 
    IN proyecto_horas_estimadas INT, 
    IN proyecto_fecha_inicio DATE, 
    IN proyecto_fecha_fin DATE
)
BEGIN
    UPDATE proyecto 
    SET nombre_proyecto = proyecto_nombre, 
        id_aliado = proyecto_id_aliado, 
        descripcion = proyecto_descripcion, 
        presupuesto = proyecto_presupuesto, 
        horas_estimadas = proyecto_horas_estimadas, 
        fecha_inicio = proyecto_fecha_inicio, 
        fecha_fin = proyecto_fecha_fin
    WHERE id_proyecto = proyecto_id;
END;
//
DELIMITER ;

-- Eliminar (DELETE)
DELIMITER //
CREATE PROCEDURE delete_proyecto(
    IN proyecto_id INT
)
BEGIN
    DELETE FROM proyecto 
    WHERE id_proyecto = proyecto_id;
END;
//
DELIMITER ;