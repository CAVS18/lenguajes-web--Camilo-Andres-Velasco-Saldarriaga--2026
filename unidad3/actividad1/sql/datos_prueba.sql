
USE gestion_veterinaria;


-- ------------------------------------------------------------
-- 1. INSERCIÓN: dueno (3 registros)
-- ------------------------------------------------------------
INSERT INTO dueno (nombre_completo, correo_electronico, telefono_contacto) VALUES
    ('Carlos Andrés Mejía Ríos',    'carlos.mejia@gmail.com',    '3001234567'),
    ('Laura Patricia Gómez Vargas', 'laura.gomez@hotmail.com',   '3112345678'),
    ('Jorge Iván Salazar Patiño',   'jorge.salazar@outlook.com', '3204567890');


-- ------------------------------------------------------------
-- 2. INSERCIÓN: veterinario (2 registros)
-- ------------------------------------------------------------
INSERT INTO veterinario (tarjeta_profesional, nombre_completo, especialidad) VALUES
    ('VET-COL-00123', 'Dra. Mariana Ospina Cardona', 'Medicina General y Cirugía'),
    ('VET-COL-00456', 'Dr. Felipe Restrepo Aguirre', 'Dermatología y Nutrición');


-- ------------------------------------------------------------
-- 3. INSERCIÓN: mascota (3 registros)
--    id_dueno 1 → Carlos (tiene 2 mascotas)
--    id_dueno 2 → Laura  (tiene 1 mascota)
--    id_dueno 3 → Jorge  (tiene 0 mascotas — válido para probar integridad)
-- ------------------------------------------------------------
INSERT INTO mascota (id_dueno, nombre, especie, fecha_nacimiento) VALUES
    (1, 'Max',     'Perro', '2020-03-15'),
    (1, 'Luna',    'Gato',  '2021-07-22'),
    (2, 'Picolín', 'Ave',   '2022-11-05');


-- ------------------------------------------------------------
-- 4. INSERCIÓN: cita (3 registros)
--    Cita 1 → Max     con Dra. Ospina  | Completada
--    Cita 2 → Luna    con Dr. Restrepo | Programada
--    Cita 3 → Picolín con Dra. Ospina  | Cancelada
-- ------------------------------------------------------------
INSERT INTO cita (id_mascota, tarjeta_profesional, fecha_hora, costo_total, estado, diagnostico) VALUES
    (
        1,
        'VET-COL-00123',
        '2025-06-01 09:00:00',
        85000.00,
        'Completada',
        'Paciente presenta otitis externa leve en oído derecho. Se prescribe limpieza diaria con solución ótica y antibiótico tópico por 7 días. Control en 2 semanas.'
    ),
    (
        2,
        'VET-COL-00456',
        '2025-06-10 14:30:00',
        60000.00,
        'Programada',
        NULL
    ),
    (
        3,
        'VET-COL-00123',
        '2025-05-28 11:00:00',
        45000.00,
        'Cancelada',
        NULL
    );


-- ============================================================
-- CONSULTAS DE VERIFICACIÓN
-- ============================================================

-- Verificar dueños
SELECT * FROM dueno;

-- Verificar veterinarios
SELECT * FROM veterinario;

-- Verificar mascotas con nombre de dueño
SELECT
    m.id_mascota,
    m.nombre          AS mascota,
    m.especie,
    m.fecha_nacimiento,
    d.nombre_completo AS dueno
FROM mascota m
INNER JOIN dueno d ON m.id_dueno = d.id_dueno
ORDER BY m.id_mascota;

-- Verificar citas con mascota y veterinario
SELECT
    c.id_cita,
    m.nombre          AS mascota,
    v.nombre_completo AS veterinario,
    c.fecha_hora,
    c.costo_total,
    c.estado,
    c.diagnostico
FROM cita c
INNER JOIN mascota    m ON c.id_mascota          = m.id_mascota
INNER JOIN veterinario v ON c.tarjeta_profesional = v.tarjeta_profesional
ORDER BY c.fecha_hora;

-- ============================================================
-- FIN DEL SCRIPT DML
-- ============================================================
