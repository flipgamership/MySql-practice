CREATE DATABASE IF NOT EXISTS Gestion_Proyectos;
USE Gestion_Proyectos;

-- Tabla de Aliados
CREATE TABLE aliado (
    id_aliado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    apellido VARCHAR(150) NOT NULL
);

CREATE TABLE proyecto (
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proyecto VARCHAR(200) NOT NULL,
    id_aliado INT NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    presupuesto DECIMAL(18,2),
    horas_estimadas INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (id_aliado) REFERENCES aliado(id_aliado) ON DELETE RESTRICT
);

-- Tabla de Fases
CREATE TABLE fase ( 
    id_fase INT AUTO_INCREMENT PRIMARY KEY,
    id_proyecto INT NOT NULL,
    numero_secuencia INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    fecha_comienzo DATE,
    fecha_fin DATE,
    estado VARCHAR(30),
    CONSTRAINT chk_estado CHECK (estado IN ('En curso', 'Finalizada')),
    FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto) ON DELETE CASCADE
);

-- Tabla de Docentes
CREATE TABLE docente (
    id_docente INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(100) UNIQUE NOT NULL,
    documento VARCHAR(100) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    direccion VARCHAR(200),
    titulo VARCHAR(150) NOT NULL,
    experiencia_anios INT
);

-- Tabla de Jefes de Proyecto (Subclase de Docente)
CREATE TABLE jefe_proyecto (
    id_docente INT PRIMARY KEY,
    id_proyecto INT UNIQUE NOT NULL,
    horas_dedicacion INT,
    costo DECIMAL(18,2),
    FOREIGN KEY (id_docente) REFERENCES docente(id_docente) ON DELETE CASCADE,
    FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto) ON DELETE RESTRICT
);

-- Tabla de Informáticos (Superclase)
CREATE TABLE informatico (
    id_informatico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL
);

-- Tabla de Analistas (Subclase de Informático)
CREATE TABLE analista (
    id_informatico INT PRIMARY KEY,
    FOREIGN KEY (id_informatico) REFERENCES informatico(id_informatico) ON DELETE CASCADE
);

-- Tabla de Programadores (Subclase de Informático)
CREATE TABLE programador (
    id_informatico INT PRIMARY KEY,
    FOREIGN KEY (id_informatico) REFERENCES informatico(id_informatico) ON DELETE CASCADE
);

-- Tabla de Lenguajes de Programación para los Programadores
CREATE TABLE programador_lenguaje (
    id_programador INT,
    lenguaje VARCHAR(150),
    PRIMARY KEY (id_programador, lenguaje),
    FOREIGN KEY (id_programador) REFERENCES programador(id_informatico) ON DELETE CASCADE
);

-- Tabla de Participación de Informáticos en los Proyectos
CREATE TABLE participacion_informatico (
    id_informatico INT,
    id_proyecto INT,
    horas_dedicadas INT,
    costo DECIMAL(18,2),
    PRIMARY KEY (id_informatico, id_proyecto),
    FOREIGN KEY (id_informatico) REFERENCES informatico(id_informatico) ON DELETE RESTRICT,
    FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto) ON DELETE CASCADE
);

-- Tabla de Productos
CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_fase INT NOT NULL,
    codigo VARCHAR(100) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    finalizado BOOLEAN,
    id_responsable INT NOT NULL, -- Debe ser un analista
    FOREIGN KEY (id_fase) REFERENCES fase(id_fase) ON DELETE CASCADE,
    FOREIGN KEY (id_responsable) REFERENCES analista(id_informatico) ON DELETE RESTRICT
);

-- Tabla de Relación Producto-Fase
CREATE TABLE producto_fase (
    id_producto INT,
    id_fase INT,
    PRIMARY KEY (id_producto, id_fase),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
    FOREIGN KEY (id_fase) REFERENCES fase(id_fase) ON DELETE RESTRICT
);

-- Tabla de Participación de Informáticos en los Productos
CREATE TABLE participacion_producto (
    id_producto INT,
    id_informatico INT,
    horas_trabajo INT,
    PRIMARY KEY (id_producto, id_informatico),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
    FOREIGN KEY (id_informatico) REFERENCES informatico(id_informatico) ON DELETE RESTRICT
);

-- Subclases de Productos: Software y Prototipo
CREATE TABLE software (
    id_producto INT PRIMARY KEY,
    tipo VARCHAR(150),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);

CREATE TABLE prototipo (
    id_producto INT PRIMARY KEY,
    version VARCHAR(100),
    ubicacion VARCHAR(200),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);

-- Tabla de Recursos
CREATE TABLE recurso (
    id_recurso INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(100) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    tipo VARCHAR(50),
    CONSTRAINT chk_tipo CHECK (tipo IN ('Hardware', 'Software'))
);

-- Tabla de Uso de Recursos en una Fase
CREATE TABLE uso_recurso (
    id_fase INT,
    id_recurso INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    PRIMARY KEY (id_fase, id_recurso),
    FOREIGN KEY (id_fase) REFERENCES fase(id_fase) ON DELETE CASCADE,
    FOREIGN KEY (id_recurso) REFERENCES recurso(id_recurso) ON DELETE RESTRICT
);

-- Tabla de Gastos
CREATE TABLE gasto (
    id_gasto INT AUTO_INCREMENT PRIMARY KEY,
    id_docente INT NOT NULL,
    id_proyecto INT NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    fecha DATE,
    importe DECIMAL(18,2),
    tipo VARCHAR(100),
    CONSTRAINT chk_tipo_gasto CHECK (tipo IN ('Dietas', 'Viajes', 'Alojamiento', 'Otros')),
    FOREIGN KEY (id_docente) REFERENCES docente(id_docente) ON DELETE RESTRICT,
    FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto) ON DELETE CASCADE
);