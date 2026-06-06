------------------------------------------
-- 1. CREACIÓN DE LA BASE DE DATOS
-- ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS gestion_veterinaria
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE gestion_veterinaria;


-- ------------------------------------------------------------
-- 2. TABLA: dueno
--    Almacena la información de los dueños de mascotas (clientes).
-- ------------------------------------------------------------
CREATE TABLE dueno (
    id_dueno            INT             NOT NULL AUTO_INCREMENT,
    nombre_completo     VARCHAR(100)    NOT NULL,
    correo_electronico  VARCHAR(100)    NOT NULL,
    telefono_contacto   VARCHAR(20)     NOT NULL,

    CONSTRAINT pk_dueno
        PRIMARY KEY (id_dueno),

    CONSTRAINT uq_dueno_correo
        UNIQUE (correo_electronico)
);


-- ------------------------------------------------------------
-- 3. TABLA: veterinario
--    Almacena la información de los profesionales de la salud.
--    La tarjeta_profesional es el identificador único del veterinario.
-- ------------------------------------------------------------
CREATE TABLE veterinario (
    tarjeta_profesional VARCHAR(20)     NOT NULL,
    nombre_completo     VARCHAR(100)    NOT NULL,
    especialidad        VARCHAR(100)    NOT NULL,

    CONSTRAINT pk_veterinario
        PRIMARY KEY (tarjeta_profesional)
);


-- ------------------------------------------------------------
-- 4. TABLA: mascota
--    Almacena la información de cada mascota y su dueño.
--    Relación: Muchas mascotas → Un dueño.
-- ------------------------------------------------------------
CREATE TABLE mascota (
    id_mascota          INT             NOT NULL AUTO_INCREMENT,
    id_dueno            INT             NOT NULL,
    nombre              VARCHAR(100)    NOT NULL,
    especie             VARCHAR(50)     NOT NULL,
    fecha_nacimiento    DATE            NOT NULL,

    CONSTRAINT pk_mascota
        PRIMARY KEY (id_mascota),

    CONSTRAINT fk_mascota_dueno
        FOREIGN KEY (id_dueno)
        REFERENCES dueno (id_dueno)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- ------------------------------------------------------------
-- 5. TABLA: cita
--    Representa la programación de una consulta médica.
--    Relaciona una mascota con un veterinario.
-- ------------------------------------------------------------
CREATE TABLE cita (
    id_cita             INT             NOT NULL AUTO_INCREMENT,
    id_mascota          INT             NOT NULL,
    tarjeta_profesional VARCHAR(20)     NOT NULL,
    fecha_hora          DATETIME        NOT NULL,
    costo_total         DECIMAL(10,2)   NOT NULL,
    estado              ENUM(
                            'Programada',
                            'Completada',
                            'Cancelada'
                        )               NOT NULL DEFAULT 'Programada',
    diagnostico         TEXT            NULL,

    CONSTRAINT pk_cita
        PRIMARY KEY (id_cita),

    CONSTRAINT fk_cita_mascota
        FOREIGN KEY (id_mascota)
        REFERENCES mascota (id_mascota)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_cita_veterinario
        FOREIGN KEY (tarjeta_profesional)
        REFERENCES veterinario (tarjeta_profesional)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_cita_costo_positivo
        CHECK (costo_total >= 0)
);


-- ============================================================
-- FIN DEL SCRIPT DDL
-- ============================================================
