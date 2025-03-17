USE Gestion_Proyectos;

-- Crear la tabla copia_eliminados_proyecto
CREATE TABLE copia_eliminados_proyecto (
    id_proyecto INT,
    nombre_proyecto VARCHAR(200),
    id_aliado INT,
    descripcion VARCHAR(300),
    presupuesto DECIMAL(18,2),
    horas_estimadas INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

-- Crear el trigger before_delete_proyecto
CREATE TRIGGER before_delete_proyecto
BEFORE DELETE ON proyecto
FOR EACH ROW
BEGIN
    -- Insertar los datos antiguos antes de la eliminación
    INSERT INTO copia_eliminados_proyecto (id_proyecto, nombre_proyecto, id_aliado, descripcion, presupuesto, horas_estimadas, fecha_inicio, fecha_fin)
    VALUES (OLD.id_proyecto, OLD.nombre_proyecto, OLD.id_aliado, OLD.descripcion, OLD.presupuesto, OLD.horas_estimadas, OLD.fecha_inicio, OLD.fecha_fin);
END;
//

DELIMITER ;