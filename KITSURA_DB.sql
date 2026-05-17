CREATE DATABASE IF NOT EXISTS KITSURA_DB;
USE KITSURA_DB;

-- TABLA ROL
CREATE TABLE Rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    -- SE DEJARA COMO ENUM O SE CAMBIARA POR LO DE LA NORMALIZACION? 
    nombre ENUM('administrador', 'usuario', 'invitado') NOT NULL
);

-- TABLA USUARIO
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT,
    nombre_usuario VARCHAR(255),
    correo VARCHAR(255),
    contrasena VARCHAR(255),
    imagen_perfil VARCHAR(255),
    modo_oscuro BOOLEAN,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo TINYINT(1),
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

-- TABLA SESION
CREATE TABLE Sesion (
    id_sesion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    token VARCHAR(255),
    fecha_inicio TIMESTAMP,
    fecha_expiracion TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- TABLA MINIJUEGO
CREATE TABLE Minijuego (
    id_minijuego INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion TEXT,
    activo TINYINT(1)
);

-- TABLA CONFIGURACION JUEGO
CREATE TABLE Configuracion_juego (
    id_configuracion INT AUTO_INCREMENT PRIMARY KEY,
    id_minijuego INT,
    tiempo_limite INT,
    vidas_iniciales INT,
    ranking_activo BOOLEAN,
    FOREIGN KEY (id_minijuego) REFERENCES Minijuego(id_minijuego)
);

-- TABLA PREGUNTA
CREATE TABLE Pregunta (
    id_pregunta INT AUTO_INCREMENT PRIMARY KEY,
    id_minijuego INT,
    pregunta TEXT,
    respuesta_correcta VARCHAR(255),
    activo TINYINT(1),
    FOREIGN KEY (id_minijuego) REFERENCES Minijuego(id_minijuego)
);

-- TABLA PISTA
CREATE TABLE Pista (
    id_pista INT AUTO_INCREMENT PRIMARY KEY,
    id_pregunta INT,
    tipo ENUM('audio', 'texto', 'imagen', 'revelacion_letras'),
    contenido TEXT,
    activo TINYINT(1),
    FOREIGN KEY (id_pregunta) REFERENCES Pregunta(id_pregunta)
);

-- TABLA PARTIDA
CREATE TABLE Partida (
    id_partida INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_minijuego INT,
    puntuacion INT,
    vidas_restantes INT,
    tiempo_jugado INT,
    fecha_partida TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_minijuego) REFERENCES Minijuego(id_minijuego)
);

-- TABLA ESTADISTICA MINIJUEGO
CREATE TABLE Estadistica_minijuego (
    id_estadistica INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_minijuego INT,
    mejor_puntuacion INT,
    puntuacion_total INT,
    partidas_jugadas INT,
    tiempo_total INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_minijuego) REFERENCES Minijuego(id_minijuego)
);