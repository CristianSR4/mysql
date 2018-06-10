DROP DATABASE IF EXISTS examenjunio2015;
CREATE DATABASE examenjunio2015;
USE examenjunio2015;

CREATE TABLE clientes (
	cid INT,
	nombre VARCHAR(20),
	telefono INT
);

CREATE TABLE empresa (
	eid INT,
	nombre VARCHAR(20),
	precio DECIMAL(10,2)
);

CREATE TABLE acciones (
	aid INT,
	cid INT,
	eid INT,
	CANTIDAD INT
);

INSERT INTO clientes VALUES
	(1, 'jose', 111),
	(2, 'maria', 222),
	(3, 'manuel', 333),
	(4, 'jesus', 4444);

INSERT INTO empresa VALUES
	(1, 'REDHAT', 1.19),
	(2, 'NOVELL', 2.02),
	(3, 'SUN', 1.33),
	(4, 'FORD', 0.49);

INSERT INTO acciones VALUES
	(1, 2, 1, 10),
	(2, 4, 2, 20),
	(3, 4, 3, 30),
	(4, 5, 4, 100);


/* EJERCICIOS */

/* a) Mostrar toda la información de los clientes de aquellos que tienen acciones(es decir, aparecen en la tabla acciones). */
SELECT * FROM clientes NATURAL JOIN acciones;
/* b) Mostrar el nombre del cliente que menos cantidad de acciones tenga en una compañía y su cantidad. */
SELECT clientes.nombre, acciones.cantidad FROM clientes NATURAL JOIN acciones WHERE cantidad = (SELECT MIN(cantidad) FROM acciones);
/* c) Mostrar el nombre del cliente y el precio total de las acciones que posee cada uno. */
SELECT clientes.nombre, empresa.precio*acciones.cantidad as Total FROM clientes JOIN acciones JOIN empresa ON clientes.cid = acciones.cid AND empresa.eid = acciones.eid;
/* d) Mostrar todos los campos de clientes y acciones de todas las 'aid'. */
SELECT * FROM clientes RIGHT JOIN acciones ON clientes.cid = acciones.cid;

/*TEORIA*/
/* Explica qué es el producto cartesiano y como se produce en mysql */
/* Es un tipo de composición de tablas que obtiene una tabla resultante con los campos de la tabla1 unidos a los de la tabla2,
   y las filas son todas las combinaciones posibles entre la primera y la segunda tabla.
   Se produce: SELECT * FROM Tabla1,Tabla2; */
