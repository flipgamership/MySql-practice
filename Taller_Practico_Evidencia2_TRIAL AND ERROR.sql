USE Gestion_Proyectos;

-- Test Procedimientos Almacenados CRUD
SHOW PROCEDURE STATUS WHERE Db = 'Gestion_Proyectos';

-- Obtener todos los aliados
CALL get_aliados();

-- Test Función AVG
SELECT promedio_presupuesto();

-- Ingresar (Insert) nuevos aliados con IDs diferentes
INSERT INTO aliado (id_aliado, nombre, apellido)
VALUES (101, 'Carlos', 'Lopez'),
       (102, 'Ana', 'Garcia'),
       (103, 'Pedro', 'Hernandez'),
       (104, 'Lucia', 'Martinez'),
       (105, 'Javier', 'Torres');

-- Ingresar (Insert) nuevos proyectos con IDs de aliados actualizados
INSERT INTO proyecto (nombre_proyecto, id_aliado, descripcion, presupuesto, horas_estimadas, fecha_inicio, fecha_fin)
VALUES 
('Sistema de Gestión Financiera', 101, 'Desarrollo de un sistema para la gestión de finanzas', 40000.00, 300, '2025-01-01', '2025-12-31'),
('Aplicación de Reservas', 102, 'Creación de una app para reservas de eventos', 25000.00, 200, '2025-02-15', '2025-08-15'),
('Plataforma de Aprendizaje', 103, 'Implementación de una plataforma de e-learning', 60000.00, 450, '2025-03-01', '2025-11-30'),
('Sistema de Logística', 104, 'Sistema para optimización de rutas de transporte', 35000.00, 280, '2025-04-01', '2025-10-01'),
('Aplicación de Gestión Médica', 105, 'Desarrollo de una app para gestión de citas médicas', 50000.00, 320, '2025-05-01', '2025-12-01');

SHOW TABLE STATUS LIKE 'proyecto';

-- Obtener todos los proyectos
CALL get_proyectos();

-- Actualizar un proyecto
CALL update_proyecto(103, 'Plataforma de Aprendizaje - Actualizada', 103, 'Actualización de funcionalidades de la plataforma de e-learning', 65000.00, 470, '2025-03-01', '2025-12-15');

-- Trigger before Insert
INSERT INTO proyecto (nombre_proyecto, id_aliado, descripcion, presupuesto, horas_estimadas, fecha_inicio, fecha_fin)
VALUES ('Nuevo Proyecto de Innovación', 102, 'Proyecto enfocado en innovación tecnológica', 30000.00, 250, '2025-06-01', '2025-12-31');

-- Trigger before Update
UPDATE proyecto SET nombre_proyecto = 'Sistema de Logística - Optimizado', presupuesto = 40000 WHERE id_proyecto = 104;

-- Trigger before Delete
DELETE FROM proyecto WHERE id_proyecto = 102;

-- Registros copiados de actualización
SELECT * FROM copia_actualizados_proyecto;

-- Registros copiados de eliminación
SELECT * FROM copia_eliminados_proyecto;

-- Triggers Activos
SHOW TRIGGERS FROM Gestion_Proyectos;