use airbnb_hotel_system;

-- EJERCICIO 1 --> Mostrar el nombre de las propiedades 
# junto con el nombre de sus anfitriones
SELECT propiedades.nombre AS nombre_propiedad,
usuarios.nombre as nombre_usuario
FROM propiedades
JOIN usuarios ON propiedades.anfitrion_id = usuarios.usuario_id
WHERE usuarios.tipo = 'anfitrion';


-- EJERCICIO 2 --> Mostrar el nombre de cada huésped junto con 
# los nombres de las propiedades que ha reservado.
SELECT usuarios.nombre AS nombre_usuario,
propiedades.nombre AS nombre_propiedad
FROM reservas
JOIN usuarios ON usuarios.usuario_id = reservas.huesped_id
JOIN propiedades ON propiedades.propiedad_id = reservas.propiedad_id
WHERE usuarios.tipo = 'huesped'
ORDER BY nombre_usuario;


-- EJERCICIO 3 --> Listar todas las propiedades que no 
# han sido reservadas nunca.
SELECT * FROM propiedades
LEFT JOIN reservas ON propiedades.propiedad_id = reservas.propiedad_id
WHERE reservas.reserva_id IS NULL;


-- EJERCICIO 4 -->  Obtener las propiedades que tienen una calificación 
# promedio menor a 3.
SELECT AVG(reseñas.calificacion) AS promedio_calificacion, 
propiedades.nombre AS nombre_propiedad
FROM reseñas
JOIN propiedades ON propiedades.propiedad_id = reseñas.propiedad_id
WHERE reseñas.calificacion < 3
GROUP BY propiedades.nombre;


-- EJERCICIO 5 --> Mostrar todas las propiedades y sus reservas, 
# incluyendo las propiedades sin reservas.
SELECT propiedades.nombre as nombre_propiedad,
reservas.reserva_id as nro_reserva
FROM reservas # Izquierda: reservas
RIGHT JOIN propiedades ON propiedades.propiedad_id = reservas.propiedad_id;
# Derecha: propiedades


-- EJERCICIO 6 -->  Listar las propiedades que han
# sido reservadas al menos 5 veces con estado 'confirmada'.
SELECT propiedades.nombre AS nombre_propiedad,
COUNT(reservas.reserva_id) AS cant_reservas
FROM reservas
JOIN propiedades ON reservas.propiedad_id = propiedades.propiedad_id
WHERE reservas.estado = 'confirmada'
GROUP BY nombre_propiedad
HAVING cant_reservas >= 2;


-- EJERCICIO 7 --> Mostrar los huéspedes que han reservado 
# en más de una propiedad diferente.
SELECT usuarios.nombre AS nombre_usuario,
COUNT(reservas.reserva_id) AS cant_reservas
FROM reservas
JOIN usuarios ON usuarios.usuario_id = reservas.huesped_id
WHERE usuarios.tipo = 'huésped'
GROUP BY usuarios.nombre
HAVING COUNT(DISTINCT reservas.propiedad_id) > 1;


-- EJERCICIO 8 --> Mostrar las fechas disponibles para la 
# propiedad 'Casa de Playa'
SELECT d.fecha_disponible
FROM disponibilidad d
JOIN propiedades ON d.propiedad_id = propiedades.propiedad_id
WHERE propiedades.nombre = 'Casa de Playa' AND d.disponible = TRUE;


-- EJERCICIO 9 --> Mostrar todas las propiedades que tienen 
# el servicio 'Wi-Fi'
SELECT propiedades.nombre AS propiedad,
servicios.nombre AS nombre_servicio
FROM propiedades
JOIN propiedades_servicios ps ON propiedades.propiedad_id = ps.propiedad_id
JOIN servicios ON servicios.servicio_id = ps.servicio_id
WHERE servicios.nombre LIKE 'Es%';


-- EJERCICIO 10 --