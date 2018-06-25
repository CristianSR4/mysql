Use fabrica;

/* Obtener el número de equipos de cada división */
SELECT COUNT(*), Division FROM equipos GROUP BY Division;

/* Cuanta media de puntos por partido lleva cada equipo historicamente */
SELECT equipo_local, AVG(puntos_local+puntos_visitante) as MediaPuntos FROM partidos GROUP BY equipo_local;

/* Muestra el codigo, el nombre y los puntos por partido de todos los jugadores(hayan jugado o no) la temporada 06/07 */
SELECT jugadores.codigo, jugadores.Nombre, estadisticas.Puntos_por_partido FROM jugadores LEFT JOIN estadisticas ON jugadores.codigo=estadisticas.jugador AND estadisticas.temporada = "06/07";
