USE nba;

/* Obtener el número de equipos de cada división */
SELECT COUNT(*), Division FROM equipos GROUP BY Division;

/* Cuanta media de puntos por partido lleva cada equipo historicamente */
SELECT equipo_local, AVG(puntos_local+puntos_visitante) as MediaPuntos FROM partidos GROUP BY equipo_local;

/* Muestra el codigo, el nombre y los puntos por partido de todos los jugadores(hayan jugado o no) la temporada 06/07 */
SELECT jugadores.codigo, jugadores.Nombre, estadisticas.Puntos_por_partido FROM jugadores LEFT JOIN estadisticas ON jugadores.codigo=estadisticas.jugador AND estadisticas.temporada = "06/07";

/*TEORIA*/
/* Explica qué cláusulas hay que usar con una consulta cuando se compara */
/* A) Una columna con una constante u otra columna. */
/* WHERE: clausula de mysql que se utiliza para comparar, especifica criterios que tienen que cumplir los valores para que se incluyan en la consulta. */
/* B) Una función de agregación con una constante */
/* HAVING: "Where despues de GROUP BY", especifica que registros agrupados se muestran. */
/* C) Una función de agregación con otra columna */
/* SUBCONSULTA: Anteriormente utilizabamos el WHERE para seleccionar los datos que deseábamos, comparando un valor de una columna con una constante.
                Si los valores de dichas consultas son desconocidos, tendremos que utilizar una subconsulta.
