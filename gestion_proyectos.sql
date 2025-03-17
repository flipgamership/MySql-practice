-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-03-2025 a las 04:27:11
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_proyectos`
--
CREATE DATABASE IF NOT EXISTS `gestion_proyectos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gestion_proyectos`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `delete_aliado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_aliado` (IN `aliado_id` INT)   BEGIN
    DELETE FROM aliado 
    WHERE id_aliado = aliado_id;
END$$

DROP PROCEDURE IF EXISTS `delete_proyecto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_proyecto` (IN `proyecto_id` INT)   BEGIN
    DELETE FROM proyecto 
    WHERE id_proyecto = proyecto_id;
END$$

DROP PROCEDURE IF EXISTS `get_aliados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_aliados` ()   BEGIN
    SELECT * FROM aliado;
END$$

DROP PROCEDURE IF EXISTS `get_proyectos`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_proyectos` ()   BEGIN
    SELECT p.id_proyecto, p.nombre_proyecto, p.descripcion, p.presupuesto, p.fecha_inicio, p.fecha_fin, 
           a.nombre AS aliado_nombre, a.apellido AS aliado_apellido
    FROM proyecto p
    JOIN aliado a ON p.id_aliado = a.id_aliado;
END$$

DROP PROCEDURE IF EXISTS `insert_aliado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_aliado` (IN `aliado_nombre` VARCHAR(150), IN `aliado_apellido` VARCHAR(150))   BEGIN
    INSERT INTO aliado (nombre, apellido) 
    VALUES (aliado_nombre, aliado_apellido);
END$$

DROP PROCEDURE IF EXISTS `insert_proyecto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_proyecto` (IN `proyecto_nombre` VARCHAR(200), IN `proyecto_id_aliado` INT, IN `proyecto_descripcion` VARCHAR(300), IN `proyecto_presupuesto` DECIMAL(18,2), IN `proyecto_horas_estimadas` INT, IN `proyecto_fecha_inicio` DATE, IN `proyecto_fecha_fin` DATE)   BEGIN
    -- Insertar el proyecto con el id del aliado ya asociado
    INSERT INTO proyecto (nombre_proyecto, id_aliado, descripcion, presupuesto, horas_estimadas, fecha_inicio, fecha_fin)
    VALUES (proyecto_nombre, proyecto_id_aliado, proyecto_descripcion, proyecto_presupuesto, proyecto_horas_estimadas, proyecto_fecha_inicio, proyecto_fecha_fin);
END$$

DROP PROCEDURE IF EXISTS `update_aliado`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_aliado` (IN `aliado_id` INT, IN `aliado_nombre` VARCHAR(150), IN `aliado_apellido` VARCHAR(150))   BEGIN
    UPDATE aliado 
    SET nombre = aliado_nombre, apellido = aliado_apellido 
    WHERE id_aliado = aliado_id;
END$$

DROP PROCEDURE IF EXISTS `update_proyecto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_proyecto` (IN `proyecto_id` INT, IN `proyecto_nombre` VARCHAR(200), IN `proyecto_id_aliado` INT, IN `proyecto_descripcion` VARCHAR(300), IN `proyecto_presupuesto` DECIMAL(18,2), IN `proyecto_horas_estimadas` INT, IN `proyecto_fecha_inicio` DATE, IN `proyecto_fecha_fin` DATE)   BEGIN
    UPDATE proyecto 
    SET nombre_proyecto = proyecto_nombre, 
        id_aliado = proyecto_id_aliado, 
        descripcion = proyecto_descripcion, 
        presupuesto = proyecto_presupuesto, 
        horas_estimadas = proyecto_horas_estimadas, 
        fecha_inicio = proyecto_fecha_inicio, 
        fecha_fin = proyecto_fecha_fin
    WHERE id_proyecto = proyecto_id;
END$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `promedio_presupuesto`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `promedio_presupuesto` () RETURNS DECIMAL(18,2) DETERMINISTIC BEGIN
    DECLARE promedio DECIMAL(18,2);
    -- Calcular el promedio de los presupuestos
    SELECT AVG(presupuesto) INTO promedio FROM proyecto;
    -- Retornar el resultado
    RETURN promedio;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aliado`
--

DROP TABLE IF EXISTS `aliado`;
CREATE TABLE `aliado` (
  `id_aliado` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `apellido` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aliado`
--

INSERT INTO `aliado` (`id_aliado`, `nombre`, `apellido`) VALUES
(101, 'Carlos', 'Lopez'),
(102, 'Ana', 'Garcia'),
(103, 'Pedro', 'Hernandez'),
(104, 'Lucia', 'Martinez'),
(105, 'Javier', 'Torres');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `analista`
--

DROP TABLE IF EXISTS `analista`;
CREATE TABLE `analista` (
  `id_informatico` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `copia_actualizados_proyecto`
--

DROP TABLE IF EXISTS `copia_actualizados_proyecto`;
CREATE TABLE `copia_actualizados_proyecto` (
  `id_proyecto` int(11) DEFAULT NULL,
  `nombre_proyecto` varchar(200) DEFAULT NULL,
  `id_aliado` int(11) DEFAULT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `presupuesto` decimal(18,2) DEFAULT NULL,
  `horas_estimadas` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `copia_eliminados_proyecto`
--

DROP TABLE IF EXISTS `copia_eliminados_proyecto`;
CREATE TABLE `copia_eliminados_proyecto` (
  `id_proyecto` int(11) DEFAULT NULL,
  `nombre_proyecto` varchar(200) DEFAULT NULL,
  `id_aliado` int(11) DEFAULT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `presupuesto` decimal(18,2) DEFAULT NULL,
  `horas_estimadas` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente`
--

DROP TABLE IF EXISTS `docente`;
CREATE TABLE `docente` (
  `id_docente` int(11) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `documento` varchar(100) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `titulo` varchar(150) NOT NULL,
  `experiencia_anios` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fase`
--

DROP TABLE IF EXISTS `fase`;
CREATE TABLE `fase` (
  `id_fase` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `numero_secuencia` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `fecha_comienzo` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto`
--

DROP TABLE IF EXISTS `gasto`;
CREATE TABLE `gasto` (
  `id_gasto` int(11) NOT NULL,
  `id_docente` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `fecha` date DEFAULT NULL,
  `importe` decimal(18,2) DEFAULT NULL,
  `tipo` varchar(100) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informatico`
--

DROP TABLE IF EXISTS `informatico`;
CREATE TABLE `informatico` (
  `id_informatico` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jefe_proyecto`
--

DROP TABLE IF EXISTS `jefe_proyecto`;
CREATE TABLE `jefe_proyecto` (
  `id_docente` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `horas_dedicacion` int(11) DEFAULT NULL,
  `costo` decimal(18,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `participacion_informatico`
--

DROP TABLE IF EXISTS `participacion_informatico`;
CREATE TABLE `participacion_informatico` (
  `id_informatico` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `horas_dedicadas` int(11) DEFAULT NULL,
  `costo` decimal(18,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `participacion_producto`
--

DROP TABLE IF EXISTS `participacion_producto`;
CREATE TABLE `participacion_producto` (
  `id_producto` int(11) NOT NULL,
  `id_informatico` int(11) NOT NULL,
  `horas_trabajo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `id_fase` int(11) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `finalizado` tinyint(1) DEFAULT NULL,
  `id_responsable` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_fase`
--

DROP TABLE IF EXISTS `producto_fase`;
CREATE TABLE `producto_fase` (
  `id_producto` int(11) NOT NULL,
  `id_fase` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programador`
--

DROP TABLE IF EXISTS `programador`;
CREATE TABLE `programador` (
  `id_informatico` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programador_lenguaje`
--

DROP TABLE IF EXISTS `programador_lenguaje`;
CREATE TABLE `programador_lenguaje` (
  `id_programador` int(11) NOT NULL,
  `lenguaje` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prototipo`
--

DROP TABLE IF EXISTS `prototipo`;
CREATE TABLE `prototipo` (
  `id_producto` int(11) NOT NULL,
  `version` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyecto`
--

DROP TABLE IF EXISTS `proyecto`;
CREATE TABLE `proyecto` (
  `id_proyecto` int(11) NOT NULL,
  `nombre_proyecto` varchar(200) NOT NULL,
  `id_aliado` int(11) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `presupuesto` decimal(18,2) DEFAULT NULL,
  `horas_estimadas` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proyecto`
--

INSERT INTO `proyecto` (`id_proyecto`, `nombre_proyecto`, `id_aliado`, `descripcion`, `presupuesto`, `horas_estimadas`, `fecha_inicio`, `fecha_fin`) VALUES
(1, 'Sistema de Gestión Financiera', 101, 'Desarrollo de un sistema para la gestión de finanzas', 40000.00, 300, '2025-01-01', '2025-12-31'),
(2, 'Aplicación de Reservas', 102, 'Creación de una app para reservas de eventos', 25000.00, 200, '2025-02-15', '2025-08-15'),
(3, 'Plataforma de Aprendizaje', 103, 'Implementación de una plataforma de e-learning', 60000.00, 450, '2025-03-01', '2025-11-30'),
(4, 'Sistema de Logística', 104, 'Sistema para optimización de rutas de transporte', 35000.00, 280, '2025-04-01', '2025-10-01'),
(5, 'Aplicación de Gestión Médica', 105, 'Desarrollo de una app para gestión de citas médicas', 50000.00, 320, '2025-05-01', '2025-12-01'),
(6, 'Nuevo Proyecto de Innovación', 102, 'Proyecto enfocado en innovación tecnológica', 30000.00, 250, '2025-06-01', '2025-12-31');

--
-- Disparadores `proyecto`
--
DROP TRIGGER IF EXISTS `before_delete_proyecto`;
DELIMITER $$
CREATE TRIGGER `before_delete_proyecto` BEFORE DELETE ON `proyecto` FOR EACH ROW BEGIN
    -- Insertar los datos antiguos antes de la eliminación
    INSERT INTO copia_eliminados_proyecto (id_proyecto, nombre_proyecto, id_aliado, descripcion, presupuesto, horas_estimadas, fecha_inicio, fecha_fin)
    VALUES (OLD.id_proyecto, OLD.nombre_proyecto, OLD.id_aliado, OLD.descripcion, OLD.presupuesto, OLD.horas_estimadas, OLD.fecha_inicio, OLD.fecha_fin);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `before_update_proyecto`;
DELIMITER $$
CREATE TRIGGER `before_update_proyecto` BEFORE UPDATE ON `proyecto` FOR EACH ROW BEGIN
    -- Insertar los datos antiguos antes de la actualización
    INSERT INTO copia_actualizados_proyecto 
    (id_proyecto, nombre_proyecto, id_aliado, descripcion, presupuesto, horas_estimadas, fecha_inicio, fecha_fin)
    VALUES 
    (OLD.id_proyecto, OLD.nombre_proyecto, OLD.id_aliado, OLD.descripcion, OLD.presupuesto, OLD.horas_estimadas, OLD.fecha_inicio, OLD.fecha_fin);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recurso`
--

DROP TABLE IF EXISTS `recurso`;
CREATE TABLE `recurso` (
  `id_recurso` int(11) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `software`
--

DROP TABLE IF EXISTS `software`;
CREATE TABLE `software` (
  `id_producto` int(11) NOT NULL,
  `tipo` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `uso_recurso`
--

DROP TABLE IF EXISTS `uso_recurso`;
CREATE TABLE `uso_recurso` (
  `id_fase` int(11) NOT NULL,
  `id_recurso` int(11) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aliado`
--
ALTER TABLE `aliado`
  ADD PRIMARY KEY (`id_aliado`);

--
-- Indices de la tabla `analista`
--
ALTER TABLE `analista`
  ADD PRIMARY KEY (`id_informatico`);

--
-- Indices de la tabla `docente`
--
ALTER TABLE `docente`
  ADD PRIMARY KEY (`id_docente`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD UNIQUE KEY `documento` (`documento`);

--
-- Indices de la tabla `fase`
--
ALTER TABLE `fase`
  ADD PRIMARY KEY (`id_fase`),
  ADD KEY `id_proyecto` (`id_proyecto`);

--
-- Indices de la tabla `gasto`
--
ALTER TABLE `gasto`
  ADD PRIMARY KEY (`id_gasto`),
  ADD KEY `id_docente` (`id_docente`),
  ADD KEY `id_proyecto` (`id_proyecto`);

--
-- Indices de la tabla `informatico`
--
ALTER TABLE `informatico`
  ADD PRIMARY KEY (`id_informatico`);

--
-- Indices de la tabla `jefe_proyecto`
--
ALTER TABLE `jefe_proyecto`
  ADD PRIMARY KEY (`id_docente`),
  ADD UNIQUE KEY `id_proyecto` (`id_proyecto`);

--
-- Indices de la tabla `participacion_informatico`
--
ALTER TABLE `participacion_informatico`
  ADD PRIMARY KEY (`id_informatico`,`id_proyecto`),
  ADD KEY `id_proyecto` (`id_proyecto`);

--
-- Indices de la tabla `participacion_producto`
--
ALTER TABLE `participacion_producto`
  ADD PRIMARY KEY (`id_producto`,`id_informatico`),
  ADD KEY `id_informatico` (`id_informatico`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `id_fase` (`id_fase`),
  ADD KEY `id_responsable` (`id_responsable`);

--
-- Indices de la tabla `producto_fase`
--
ALTER TABLE `producto_fase`
  ADD PRIMARY KEY (`id_producto`,`id_fase`),
  ADD KEY `id_fase` (`id_fase`);

--
-- Indices de la tabla `programador`
--
ALTER TABLE `programador`
  ADD PRIMARY KEY (`id_informatico`);

--
-- Indices de la tabla `programador_lenguaje`
--
ALTER TABLE `programador_lenguaje`
  ADD PRIMARY KEY (`id_programador`,`lenguaje`);

--
-- Indices de la tabla `prototipo`
--
ALTER TABLE `prototipo`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `proyecto`
--
ALTER TABLE `proyecto`
  ADD PRIMARY KEY (`id_proyecto`),
  ADD KEY `id_aliado` (`id_aliado`);

--
-- Indices de la tabla `recurso`
--
ALTER TABLE `recurso`
  ADD PRIMARY KEY (`id_recurso`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Indices de la tabla `software`
--
ALTER TABLE `software`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `uso_recurso`
--
ALTER TABLE `uso_recurso`
  ADD PRIMARY KEY (`id_fase`,`id_recurso`),
  ADD KEY `id_recurso` (`id_recurso`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aliado`
--
ALTER TABLE `aliado`
  MODIFY `id_aliado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT de la tabla `docente`
--
ALTER TABLE `docente`
  MODIFY `id_docente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fase`
--
ALTER TABLE `fase`
  MODIFY `id_fase` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `gasto`
--
ALTER TABLE `gasto`
  MODIFY `id_gasto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `informatico`
--
ALTER TABLE `informatico`
  MODIFY `id_informatico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proyecto`
--
ALTER TABLE `proyecto`
  MODIFY `id_proyecto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `recurso`
--
ALTER TABLE `recurso`
  MODIFY `id_recurso` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `analista`
--
ALTER TABLE `analista`
  ADD CONSTRAINT `analista_ibfk_1` FOREIGN KEY (`id_informatico`) REFERENCES `informatico` (`id_informatico`) ON DELETE CASCADE;

--
-- Filtros para la tabla `fase`
--
ALTER TABLE `fase`
  ADD CONSTRAINT `fase_ibfk_1` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `gasto`
--
ALTER TABLE `gasto`
  ADD CONSTRAINT `gasto_ibfk_1` FOREIGN KEY (`id_docente`) REFERENCES `docente` (`id_docente`),
  ADD CONSTRAINT `gasto_ibfk_2` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `jefe_proyecto`
--
ALTER TABLE `jefe_proyecto`
  ADD CONSTRAINT `jefe_proyecto_ibfk_1` FOREIGN KEY (`id_docente`) REFERENCES `docente` (`id_docente`) ON DELETE CASCADE,
  ADD CONSTRAINT `jefe_proyecto_ibfk_2` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`);

--
-- Filtros para la tabla `participacion_informatico`
--
ALTER TABLE `participacion_informatico`
  ADD CONSTRAINT `participacion_informatico_ibfk_1` FOREIGN KEY (`id_informatico`) REFERENCES `informatico` (`id_informatico`),
  ADD CONSTRAINT `participacion_informatico_ibfk_2` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `participacion_producto`
--
ALTER TABLE `participacion_producto`
  ADD CONSTRAINT `participacion_producto_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE,
  ADD CONSTRAINT `participacion_producto_ibfk_2` FOREIGN KEY (`id_informatico`) REFERENCES `informatico` (`id_informatico`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_fase`) REFERENCES `fase` (`id_fase`) ON DELETE CASCADE,
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`id_responsable`) REFERENCES `analista` (`id_informatico`);

--
-- Filtros para la tabla `producto_fase`
--
ALTER TABLE `producto_fase`
  ADD CONSTRAINT `producto_fase_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE,
  ADD CONSTRAINT `producto_fase_ibfk_2` FOREIGN KEY (`id_fase`) REFERENCES `fase` (`id_fase`);

--
-- Filtros para la tabla `programador`
--
ALTER TABLE `programador`
  ADD CONSTRAINT `programador_ibfk_1` FOREIGN KEY (`id_informatico`) REFERENCES `informatico` (`id_informatico`) ON DELETE CASCADE;

--
-- Filtros para la tabla `programador_lenguaje`
--
ALTER TABLE `programador_lenguaje`
  ADD CONSTRAINT `programador_lenguaje_ibfk_1` FOREIGN KEY (`id_programador`) REFERENCES `programador` (`id_informatico`) ON DELETE CASCADE;

--
-- Filtros para la tabla `prototipo`
--
ALTER TABLE `prototipo`
  ADD CONSTRAINT `prototipo_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `proyecto`
--
ALTER TABLE `proyecto`
  ADD CONSTRAINT `proyecto_ibfk_1` FOREIGN KEY (`id_aliado`) REFERENCES `aliado` (`id_aliado`);

--
-- Filtros para la tabla `software`
--
ALTER TABLE `software`
  ADD CONSTRAINT `software_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `uso_recurso`
--
ALTER TABLE `uso_recurso`
  ADD CONSTRAINT `uso_recurso_ibfk_1` FOREIGN KEY (`id_fase`) REFERENCES `fase` (`id_fase`) ON DELETE CASCADE,
  ADD CONSTRAINT `uso_recurso_ibfk_2` FOREIGN KEY (`id_recurso`) REFERENCES `recurso` (`id_recurso`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
