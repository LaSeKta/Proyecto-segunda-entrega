CREATE DATABASE sigen;

USE sigen;

-- Tabla Usuario
CREATE TABLE usuarios (
    nro_documento VARCHAR(10) NOT NULL,
    password VARCHAR(20) NOT NULL,
    id_rol INT NOT NULL,
    PRIMARY KEY (nro_documento)
);

-- Tabla Persona
CREATE TABLE personas (
    id_persona VARCHAR(10) NOT NULL,
    nombre_completo VARCHAR(40) NOT NULL, -- Asumiendo que nombre completo es un solo campo
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_persona) REFERENCES usuarios (nro_documento)
);

-- Tabla Cliente
CREATE TABLE clientes (
    id_cliente VARCHAR(10) NOT NULL,
    cantidad_alertas INT NOT NULL,
    motivo_inscripcion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_cliente) REFERENCES personas (id_persona)
);

-- Tabla Estado
CREATE TABLE estados (
    id_estado INT NOT NULL AUTO_INCREMENT,
    estado VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_estado)
);

-- Relación Cliente-Estado
CREATE TABLE cliente_estado (
    id_cliente VARCHAR(10) NOT NULL,
    id_estado INT NOT NULL,
    PRIMARY KEY (id_cliente, id_estado),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_estado) REFERENCES estados (id_estado)
);

-- Tabla Pago
CREATE TABLE pagos (
    id_pago INT NOT NULL AUTO_INCREMENT,
    fecha_pago DATE NOT NULL,
    tipo_pago VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_pago)
);

-- Relación Cliente-Pago
CREATE TABLE cliente_pago (
    id_pago INT NOT NULL,
    id_cliente VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_pago, id_cliente),
    FOREIGN KEY (id_pago) REFERENCES pagos (id_pago),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- Tabla Evaluaciones
CREATE TABLE evaluaciones (
    id_evaluacion INT NOT NULL AUTO_INCREMENT,
    fecha_evaluacion DATE NOT NULL,
    item VARCHAR(255) NOT NULL,
    nota_max INT NOT NULL,
    PRIMARY KEY (id_evaluacion)
);

-- Relación Cliente-Evaluaciones
CREATE TABLE cliente_evaluaciones (
    id_evaluacion INT NOT NULL,
    id_cliente VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_evaluacion, id_cliente),
    FOREIGN KEY (id_evaluacion) REFERENCES evaluaciones (id_evaluacion),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- Tabla Sesiones
CREATE TABLE sesiones (
    id_sesion INT NOT NULL AUTO_INCREMENT,
    fecha DATE NOT NULL,
    asistencia BOOLEAN NOT NULL,
    notas VARCHAR(255),
    PRIMARY KEY (id_sesion)
);

-- Relación Cliente-Sesión
CREATE TABLE cliente_sesion (
    id_sesion INT NOT NULL,
    id_cliente VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_sesion, id_cliente),
    FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- Tabla Entrenador
CREATE TABLE entrenadores (
    id_entrenador VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_entrenador),
    FOREIGN KEY (id_entrenador) REFERENCES personas (id_persona)
);

-- Relación Entrenador-Sesión
CREATE TABLE entrenador_sesion (
    id_entrenador VARCHAR(10) NOT NULL,
    id_sesion INT NOT NULL,
    PRIMARY KEY (id_entrenador, id_sesion),
    FOREIGN KEY (id_entrenador) REFERENCES entrenadores (id_entrenador),
    FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion)
);

-- Tabla Horarios
CREATE TABLE horarios (
    id_horario INT NOT NULL AUTO_INCREMENT,
    dia VARCHAR(10) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    PRIMARY KEY (id_horario)
);

-- Relación Entrenador-Horario
CREATE TABLE entrenador_horario (
    id_entrenador VARCHAR(10) NOT NULL,
    id_horario INT NOT NULL,
    PRIMARY KEY (id_entrenador, id_horario),
    FOREIGN KEY (id_entrenador) REFERENCES entrenadores (id_entrenador),
    FOREIGN KEY (id_horario) REFERENCES horarios (id_horario)
);

-- Tabla Sucursales
CREATE TABLE sucursales (
    id_sucursal INT NOT NULL AUTO_INCREMENT,
    capacidad INT NOT NULL,
    PRIMARY KEY (id_sucursal)
);

-- Relación Sucursal-Horario
CREATE TABLE sucursal_horario (
    id_sucursal INT NOT NULL,
    id_horario INT NOT NULL,
    PRIMARY KEY (id_sucursal, id_horario),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales (id_sucursal),
    FOREIGN KEY (id_horario) REFERENCES horarios (id_horario)
);

-- Tabla Planes
CREATE TABLE planes (
    id_plan INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_plan)
);

-- Tabla Ejercicios
CREATE TABLE ejercicios (
    id_ejercicio INT NOT NULL AUTO_INCREMENT,
    tipo_actividad VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_ejercicio)
);

-- Relación Plan-Ejercicio
CREATE TABLE planes_ejercicios (
    id_plan INT NOT NULL,
    id_ejercicio INT NOT NULL,
    PRIMARY KEY (id_plan, id_ejercicio),
    FOREIGN KEY (id_plan) REFERENCES planes (id_plan),
    FOREIGN KEY (id_ejercicio) REFERENCES ejercicios (id_ejercicio)
);
