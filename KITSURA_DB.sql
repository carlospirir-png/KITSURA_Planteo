CREATE DATABASE IF NOT EXISTS KITSURA_DB;
USE KITSURA_DB;


-- TABLA ROL
CREATE TABLE Rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    -- NO SE SI SE CAMBIARA A ENUM
    nombre VARCHAR(50) NOT NULL UNIQUE
);


-- TABLA USUARIO
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT NOT NULL,
    nombre_usuario VARCHAR(255) NOT NULL UNIQUE,
    correo VARCHAR(255) UNIQUE,
    contrasena VARCHAR(255),
    imagen_perfil VARCHAR(255),
    modo_oscuro BOOLEAN DEFAULT FALSE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);


-- TABLA SESION
CREATE TABLE Sesion (
    id_sesion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- TABLA MINIJUEGO
CREATE TABLE Minijuego (
    id_minijuego INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT,
    activo TINYINT(1) DEFAULT 1
);


-- TABLA CONFIGURACION JUEGO
CREATE TABLE Configuracion_juego (
    id_configuracion INT AUTO_INCREMENT PRIMARY KEY,
    id_minijuego INT NOT NULL UNIQUE,
    tiempo_limite INT DEFAULT 60,
    vidas_iniciales INT DEFAULT 3,
    ranking_activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_minijuego) REFERENCES Minijuego(id_minijuego)
);


-- TABLA PREGUNTA
CREATE TABLE Pregunta (
    id_pregunta INT AUTO_INCREMENT PRIMARY KEY,
    id_minijuego INT NOT NULL,
    pregunta TEXT NOT NULL,
    respuesta_correcta VARCHAR(255) NOT NULL,
    activo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_minijuego) REFERENCES Minijuego(id_minijuego)
);

-- TABLA PISTA

CREATE TABLE Pista (
    id_pista INT AUTO_INCREMENT PRIMARY KEY,
    id_pregunta INT NOT NULL,
    tipo ENUM('audio', 'texto', 'imagen', 'revelacion_letras') NOT NULL,
    contenido TEXT,
    activo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_pregunta) REFERENCES Pregunta(id_pregunta)
);

-- TABLA PARTIDA
CREATE TABLE Partida (
    id_partida INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_minijuego INT NOT NULL,
    puntuacion INT DEFAULT 0,
    vidas_restantes INT DEFAULT 3,
    tiempo_jugado INT DEFAULT 0,
    fecha_partida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_minijuego) REFERENCES Minijuego(id_minijuego)
);


-- TABLA ESTADISTICA MINIJUEGO
CREATE TABLE Estadistica_minijuego (
    id_estadistica INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_minijuego INT NOT NULL,
    mejor_puntuacion INT DEFAULT 0,
    puntuacion_total INT DEFAULT 0,
    partidas_jugadas INT DEFAULT 0,
    tiempo_total INT DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_minijuego) REFERENCES Minijuego(id_minijuego),
    UNIQUE (id_usuario, id_minijuego)
);