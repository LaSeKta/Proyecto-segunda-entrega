CREATE DATABASE sigen;

USE sigen;

CREATE TABLE usuarios (
    CI VARCHAR(10) NOT NULL,
    contrasena VARCHAR(20) NOT NULL,
    id_rol INT NOT NULL,
    PRIMARY KEY (CI)
);

CREATE TABLE personas (
    id_persona VARCHAR(10) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_persona) REFERENCES usuarios (CI)
);

CREATE TABLE clientes (
    id_cliente VARCHAR(10) NOT NULL,
    -- Cambiado de INT a VARCHAR(10) para coincidir con CI
    alertas INT NOT NULL,
    motivo_inscripcion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_cliente) REFERENCES usuarios (CI)
);

CREATE TABLE pagos (
    id_pago INT NOT NULL AUTO_INCREMENT,
    
    id_cliente VARCHAR(10) NOT NULL,
    -- Ajustado a VARCHAR(10)
    PRIMARY KEY (id_pago),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE evaluaciones (
    id_evaluacion INT NOT NULL AUTO_INCREMENT,
    item_evaluacion VARCHAR(255) NOT NULL,
    nota_max INT NOT NULL,
    id_cliente VARCHAR(10) NOT NULL,
    -- Ajustado a VARCHAR(10)
    PRIMARY KEY (id_evaluacion),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE sucursales (
    id_sucursal INT NOT NULL AUTO_INCREMENT,
    dia DATE NOT NULL,
    capacidad INT NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    PRIMARY KEY (id_sucursal)
);

CREATE TABLE planes (
    id_plan INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_plan)
);

CREATE TABLE ejercicios (
    id_ejercicio INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_ejercicio)
);

CREATE TABLE sesiones (
    id_sesion INT NOT NULL AUTO_INCREMENT,
    fecha DATE NOT NULL,
    asistencia BOOLEAN NOT NULL,
    notas VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_sesion)
);

CREATE TABLE horarios (
    id_horario INT NOT NULL AUTO_INCREMENT,
    dia VARCHAR(10) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    PRIMARY KEY (id_horario)
);

-- Relaciones
CREATE TABLE cliente_estado (
    id_cliente VARCHAR(10) NOT NULL,
    -- Ajustado a VARCHAR(10)
    id_estado INT NOT NULL,
    PRIMARY KEY (id_cliente, id_estado),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE cliente_evaluaciones (
    id_evaluacion INT NOT NULL,
    id_cliente VARCHAR(10) NOT NULL,
    fecha_evaluacion DATE NOT NULL,
    PRIMARY KEY (id_evaluacion, id_cliente),
    FOREIGN KEY (id_evaluacion) REFERENCES evaluaciones (id_evaluacion),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE cliente_deporte (
    id_deporte INT NOT NULL,
    id_cliente VARCHAR(10) NOT NULL,
    -- Ajustado a VARCHAR(10)
    PRIMARY KEY (id_deporte, id_cliente),
    FOREIGN KEY (id_deporte) REFERENCES planes (id_plan),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE cliente_sesion (
    id_sesion INT NOT NULL,
    id_cliente VARCHAR(10) NOT NULL,
    -- Ajustado a VARCHAR(10)
    PRIMARY KEY (id_sesion, id_cliente),
    FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE entrenador_sesion (
    id_entrenador VARCHAR(10) NOT NULL,
    -- Ajustado a VARCHAR(10) para coincidir con CI de usuarios
    id_sesion INT NOT NULL,
    PRIMARY KEY (id_entrenador, id_sesion),
    FOREIGN KEY (id_entrenador) REFERENCES usuarios (CI),
    FOREIGN KEY (id_sesion) REFERENCES sesiones (id_sesion)
);

CREATE TABLE entrenador_horario (
    id_entrenador VARCHAR(10) NOT NULL,
    -- Ajustado a VARCHAR(10) para coincidir con CI de usuarios
    id_horario INT NOT NULL,
    PRIMARY KEY (id_entrenador, id_horario),
    FOREIGN KEY (id_entrenador) REFERENCES usuarios (CI),
    FOREIGN KEY (id_horario) REFERENCES horarios (id_horario)
);

CREATE TABLE sucursal_horario (
    id_sucursal INT NOT NULL,
    id_horario INT NOT NULL,
    PRIMARY KEY (id_sucursal, id_horario),
    FOREIGN KEY (id_sucursal) REFERENCES sucursales (id_sucursal),
    FOREIGN KEY (id_horario) REFERENCES horarios (id_horario)
);

CREATE TABLE planes_ejercicios (
    id_plan INT NOT NULL,
    id_ejercicio INT NOT NULL,
    PRIMARY KEY (id_plan, id_ejercicio),
    FOREIGN KEY (id_plan) REFERENCES planes (id_plan),
    FOREIGN KEY (id_ejercicio) REFERENCES ejercicios (id_ejercicio)
);

CREATE TABLE cliente_pago (
    id_pago INT NOT NULL,
    id_cliente VARCHAR(10) NOT NULL,
    fecha_pago DATE NOT NULL,
    PRIMARY KEY (id_pago, id_cliente),
    FOREIGN KEY (id_pago) REFERENCES pagos (id_pago),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);