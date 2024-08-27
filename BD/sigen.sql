CREATE DATABASE sigen;

USE sigen;

CREATE TABLE usuarios (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    ci VARCHAR(10) NOT NULL,
    contrasena VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    id_rol INT NOT NULL,
    calle VARCHAR(50) NOT NULL,
    num_puerta INT NOT NULL,
    esquina VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_usuario)
);

CREATE TABLE clientes (
    id_cliente INT NOT NULL,
    alertas INT NOT NULL,
    motivo_inscripcion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_cliente) REFERENCES usuarios(id_usuario)
);

CREATE TABLE pagos (
    id_pago INT NOT NULL AUTO_INCREMENT,
    fecha_pago DATE NOT NULL,
    estado VARCHAR(50) NOT NULL,
    id_cliente INT NOT NULL,
    PRIMARY KEY (id_pago),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE evaluacion  (
    id_evaluacion INT NOT NULL AUTO_INCREMENT,
    fecha_evaluacion DATE NOT NULL,
    item_evaluacion VARCHAR(255) NOT NULL,
    nota_max INT  NOT NULL,
    id_cliente INT NOT NULL,
    PRIMARY KEY (id_evaluacion),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
    );

CREATE TABLE sucursal  (
    id_sucursal INT NOT NULL AUTO_INCREMENT,
    dia DATE  NOT NULL,
    capacidad  INT NOT NULL,
    hora_inicio   TIME NOT NULL,
    hora_fin   TIME NOT NULL,
    PRIMARY KEY (id_sucursal)
    );

CREATE TABLE planes  (
    id_plan INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_plan)
    );

 CREATE TABLE ejercicios  (
    id_ejercicio INT NOT NULL AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_ejercicio)
    );









