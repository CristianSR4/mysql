Use fabrica;

/* 1. Obtener todos los datos de la Memoria RAM y meroias USB  */
SELECT * FROM Articulos WHERE Nombre= "Memoria RAM" OR Nombre= "Memoria USB" ;

/* 2. Mostrar los fabricantes(clave y nombre) que no tienen articulos asociados */
SELECT Fabricantes.Clave_Fabricante, Fabricantes.Nombre FROM Fabricantes LEFT JOIN Articulos ON Fabricantes.Clave_Fabricante = Articulos.Clave_Fabricante WHERE Clave_Articulo IS NULL; ;

/* 3. Obtener la clave del articulo, nombre del articulo y nombre del fabricante de todos los productos en venta */
SELECT Articulos.Clave_Articulo, Articulos.Nombre, Fabricantes.Nombre FROM Articulos, Fabricantes WHERE Articulos.Clave_Fabricante = Fabricantes.Clave_Fabricante;

/* 4. Obtener el nombre y precio del articulo mas caro  */
SELECT Nombre, Precio FROM Articulos WHERE Precio = (SELECT MAX(Precio) FROM Articulos);

/* 4. Obtener el numero de articulos y la media de precio que vende cada fabricante  */
SELECT COUNT(*), AVG(Articulos.Precio), Fabricantes.Nombre FROM Articulos RIGTH JOIN Fabricantes ON Fabricantes.Clave_Fabricante = Articulos.Clave_Fabricante GROUP BY Fabricantes.Clave_Fabricante;

/*5. Mostar los fabricantes que tengan colaboradores idicando cuantos tienen.*/
SELECT Fabricantes.Nombre, COUNT(*) FROM Fabricantes AS Fabricantes JOIN Fabricantes AS Colaboradores ON Fabricantes.Clave_Fabricante = Colaboradores.Clave_Fabricante_Colaborador GROUP BY Colaboradores.Clave_Fabricantes_Colaborador;
