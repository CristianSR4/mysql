USE nba;

/* Muestra que temporadas han sido jugado los partidos */
SELECT DISTINCT temporada FROM partidos;

/* Muestra cuantos partidos ha ganado cada equipo en "local" y que empiecen por "M" */
SELECT equipos.Nombre, COUNT(*) AS Victorias FROM partidos JOIN equipos ON partidos.equipo_local = equipos.Nombre WHERE puntos_local > puntos_visitante AND equipos.Nombre LIKE "M%" GROUP BY equipo_local;

/* Muestra el codigo, el nombre y el numero de temporadas que ha jugado solo aquellos que hayan estado mas de 15 temporadas */
SELECT jugadores.codigo, jugadores.Nombre, COUNT(*) FROM jugadores LEFT JOIN estadisticas ON jugadores.codigo=estadisticas.jugador GROUP BY jugadores.codigo HAVING COUNT(*)>15;

