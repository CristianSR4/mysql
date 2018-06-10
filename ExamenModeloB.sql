USE nba;

/* Muestra que temporadas han sido jugado los partidos */
SELECT DISTINCT temporada FROM partidos;

/* Muestra cuantos partidos ha ganado cada equipo en "local" y que empiecen por "M" */
SELECT equipos.Nombre, COUNT(*) AS Victorias FROM partidos JOIN equipos ON partidos.equipo_local = equipos.Nombre WHERE puntos_local > puntos_visitante AND equipos.Nombre LIKE "M%" GROUP BY equipo_local;

/* Muestra el codigo, el nombre y el numero de temporadas que ha jugado solo aquellos que hayan estado mas de 15 temporadas */
SELECT jugadores.codigo, jugadores.Nombre, COUNT(*) FROM jugadores LEFT JOIN estadisticas ON jugadores.codigo=estadisticas.jugador GROUP BY jugadores.codigo HAVING COUNT(*)>15;

/*TEORIA*/
/* 1. Explica los tipos de join */
/* El join se utiliza para conectar dos tablas de la misma base de datos. Tenemos diferentes tipos:
   -Inner: Entregara el resultado de las coincidencias de las tablas A y B. Viene predeterminado al poner join.
   -Outer: Entregara el resultado  de la unión de A y B sin coincidencias. Dos tipos:
           -LEFT: Devuelve todos los campos de la tabla de la izquierda y los que coinciden de la derecha.
           -RIGHT: Devuelve todos los campos de la tabla de la derecha y los que coinciden de la izquierda.
   -Natural: Tipo de inner join que solo se puede utilizar cuando se conecta una foreing key o tienen el mismo nombre, no hace falta condición.

Todos la condición con un ON despues del ultimo join. */
/* 2. ¿Qué es una vista? ¿Como se accede? Pon una sentencia de vista */
/* Son un mecanismo que permite generar un resultado a partir de una consulta almacenada y ejecutar nuevas consultas sobre el resultado como si fuese una tabla mas.
   Para acceder: SELECT * FROM nombrevista;
   Para crear: CREATE VIEW nombrevista AS query;
   Consulta: SELECT * FROM nombrevista WHERE codigo>100; */
