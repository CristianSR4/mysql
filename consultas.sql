/************************************************************************************************
 *  Autor: Cristian Lérida Sánchez									*
 *  Fecha: 20/03/2018										*
 *												*
 *			TITULO: Consultas							*
 *												*
 ************************************************************************************************/

/* FUNCIONES DE AGREGACIÓN */
/* GROUP BY [DESC || ASC]*/

/*Columnas de agregación*/
/*SUM(), MAX(), MIN(), AVG(), COUNT()*/


USE jardineria;

/*Palabras que empiezan por OR*/
SELECT Codigoproducto FROM Productos WHERE Codigoproducto LIKE "OR%";														
																						
/*ERROR*/ 																					
SELECT Estado, CodigoPedido FROM Pedidos GROUP BY Estado;							

/*Devuelve las repeticiones de una palabra*/ 																
SELECT Estado, COUNT(*) FROM Pedidos GROUP BY Estado;

/*Muestra el valor más alto*/
SELECT MAX(PrecioVenta) FROM Productos;

/*Muestra numero de oficinas por pais*/
SELECT Pais, COUNT(*) FROM Oficinas GROUP BY Pais;

/*Media de cada gama de productos*/
SELECT Gama, AVG(PrecioVenta) FROM Productos GROUP BY Gama;

/*De cada producto cuantos pedidos tiene*/
SELECT CodigoPedido, SUM(Cantidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*De cada pedido cuanto cuesta en total*/
SELECT CodigoPedido, SUM(Cantidad * PrecioUnidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*De cada pedido cuanto cuesta en total mayores de 1500*/
/*comparar función de agregación*/
SELECT CodigoPedido, SUM(Cantidad * PrecioUnidad) AS total FROM DetallePedidos GROUP BY CodigoPedido HAVING total>1500;
SELECT CodigoPedido, SUM(Cantidad * PrecioUnidad) AS 'total' FROM DetallePedidos GROUP BY CodigoPedido HAVING total>1500;

/*Mostra los productos mayores que le media*/
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta>(SELECT AVG(PrecioVenta) FROM Productos);

/*Mostrar producto más caro*/
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta>(SELECT MAX(PrecioVenta) FROM Productos);

/*Mostrar productos entre 200 y 400*/
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta>=200 AND PrecioVenta<=400;
SELECT CodigoProducto, PrecioVenta FROM Productos WHERE PrecioVenta BETWEEN 200 AND 400;

/*Mostrar el codigo de oficina de España y EEUU*/
SELECT CodigoOficina, Pais FROM Oficinas WHERE Pais IN ('España', 'EEUU');

/*Mostrar empleados que no tengan jefe*/
SELECT CodigoEmpleado, CodigoJefe FROM Empleados WHERE CodigoJefe IS NULL;

/*Mostrar empleados que tienen jefe*/
SELECT CodigoEmpleado, CodigoJefe FROM Empleados WHERE CodigoJefe IS NOT NULL;

/*Sacar el Codigo de oficina y la ciudad donde hay oficina */
SELECT CodigoOficina, Ciudad FROM Oficinas WHERE Ciudad IS NOT NULL;

/*Sacar cuantos empleados hay en la compañia*/
SELECT COUNT(CodigoEmpleado) FROM Empleados;

/*Sacar cuantos clientes tiene cada pais*/
SELECT Pais, COUNT(CodigoCliente) FROM Clientes GROUP BY Pais;

/*Sacar cual fue el pago medio en 2009*/
SELECT AVG(Cantidad) FROM Pagos WHERE YEAR(FechaPago)=2009;

/*Sacar cuantos pedidos estan en cada estado ordenado descendentemente por el numero de pedidos*/
SELECT Estado, COUNT(CodigoPedido) AS Pedido FROM Pedidos GROUP BY Estado ORDER BY Pedido DESC;

/*Sacar el precio del producto mas caro y mas barato*/
SELECT (SELECT MIN(PrecioVenta) FROM Productos) AS Minimo, (SELECT MAX(PrecioVenta) FROM Productos) AS Maximo FROM Productos LIMIT 1;

/*Sacar el producto mas caro de cada gama*/
SELECT Gama,MAX(PrecioVenta) FROM Productos GROUP BY Gama;

/*Sacar en la misma consulta el empleado y el jefe que tiene cada empleado*/
SELECT Curritos.CodigoEmpleado, Curritos.Nombre, Curritos.Apellido1, Jefes.Nombre, Jefes.Apellido1 FROM Empleados AS Curritos, Empleados AS Jefes WHERE Curritos.CodigoJefe=Jefes.CodigoEmpleado;

/*Sacar en la misma consulta el empleado juntando en misma columna Nombre y Apellido, y lo mismo con el jefe*/
SELECT Curritos.CodigoEmpleado, CONCAT(Curritos.Nombre,' ', Curritos.Apellido1) AS NombreEmpleado, CONCAT(Jefes.Nombre,' ', Jefes.Apellido1) AS NombreJefe FROM Empleados AS Curritos, Empleados AS Jefes WHERE Curritos.CodigoJefe=Jefes.CodigoEmpleado;

/*Sacar cuantos pedidos hay por pais*/
SELECT Pedidos.CodigoPedido, Pedidos.CodigoCliente, Clientes.Pais FROM Pedidos, Clientes WHERE Clientes.CodigoCliente=Pedidos.CodigoCliente;

/*Sacar cuantos pedidos hay de cada pais*/
SELECT Clientes.Pais, COUNT(*) FROM Pedidos, Clientes WHERE Clientes.CodigoCliente=Pedidos.CodigoCliente GROUP BY Clientes.Pais;

/*Sacar cuantos pedidos ha hecho cada cliente*/
SELECT Pedidos.CodigoCliente, COUNT(*) FROM Pedidos GROUP BY Pedidos.CodigoCliente;

/*Sacar cuanto dinero cuesta cada pedido*/
SELECT CodigoPedido, SUM(PrecioUnidad*Cantidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*Sacar cuanto dinero se ha gastado cada cliente*/
SELECT Pedidos.CodigoCliente, SUM(PrecioUnidad*Cantidad) FROM DetallePedidos, Pedidos WHERE Pedidos.CodigoPedido=DetallePedidos.CodigoPedido GROUP BY Pedidos.CodigoCliente;

/*Sacar el responsable de venta de cada cliente*/
SELECT Clientes.CodigoCliente, Clientes.NombreCliente, Empleados.CodigoEmpleado, Empleados.Nombre FROM Clientes JOIN Empleados ON Empleados.CodigoEmpleado=Clientes.CodigoEmpleadoRepVentas;

/*Sacar el nombre de los empleados que llevan ventas */
SELECT DISTINCT Clientes.CodigoEmpleadoRepVentas, Empleados.Nombre FROM Clientes JOIN Empleados ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado;

/*Sacar todos los empleados y decir a que cliente lleva*/
SELECT Empleados.CodigoEmpleado, Empleados.Nombre, Clientes.CodigoCliente, Clientes.NombreCliente FROM Empleados LEFT JOIN Clientes ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado;

/*Obtener nombre del cliente con mayor limite de credito*/
SELECT NombreCliente FROM Clientes WHERE LimiteCredito = (SELECT MAX(LimiteCredito) FROM Clientes);

/*Obtener Nombre, Apellido1 y cargo de los empleados que no representen a ningun cliente*/
SELECT Empleados.Nombre, Empleados.Apellido1, Empleados.Puesto, Clientes.CodigoCliente, Clientes.NombreCliente FROM Empleados LEFT JOIN Clientes ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado WHERE Clientes.CodigoEmpleadoRepVentas IS NULL;
SELECT CONCAT(Empleados.Nombre, ' ', Empleados.Apellido1) AS Empleado, Empleados.Puesto AS Puesto FROM Empleados LEFT JOIN Clientes ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado WHERE Clientes.CodigoEmpleadoRepVentas IS NULL;

/*Saca un listado con el nombre de cada cliente y nombre y apellido de su representante de venta*/
SELECT Clientes.NombreCliente, CONCAT(Empleados.Nombre, ' ', Empleados.Apellido1) AS Representante FROM Clientes JOIN Empleados ON Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado;

/*Muestra el nombre de los clientes que no hayan realizado el pago con su representante de ventas*/
SELECT Clientes.NombreCliente, Empleados.Nombre, Pagos.FechaPago FROM Empleados LEFT JOIN Clientes ON Clientes.CodigoEmpleadoRepVentas = Empleados.CodigoEmpleado LEFT JOIN Pagos ON Clientes.CodigoCliente = Pagos.CodigoCliente WHERE FechaPago IS NULL AND NombreCliente IS NOT NULL;

/*Listar las ventas totales de los productos que hayan faturado más de 3.000 €, se mostrara el nombre del producto, unidades vendidas, total facturado y total facturado con el 21% de IVA*/
SELECT Productos.Nombre, SUM(Cantidad) AS Unidades, SUM(Cantidad * PrecioUnidad) AS Total, SUM(Cantidad * PrecioUnidad)*21/100+SUM(Cantidad * PrecioUnidad) AS IVA FROM DetallePedidos NATURAL JOIN Productos GROUP BY Productos.Nombre HAVING Total > 3000;

/*Listar la dirección de las oficinas que tengan clientes en Fuenlabrada*/
SELECT CONCAT(Oficinas.LineaDireccion1, ' ', Oficinas.LineaDireccion2) AS 'Dirección' FROM Clientes JOIN Empleados NATURAL JOIN Oficinas ON(Clientes.CodigoEmpleadoRepVentas=Empleados.CodigoEmpleado) WHERE Clientes.Ciudad='Fuenlabrada' ORDER BY Clientes.CodigoCliente;

/*Sacar cliente que hizo el pedido de mayor cuantia*/
SELECT Clientes.NombreCliente, Pedidos.CodigoPedido, SUM(Detalle.PrecioUnidad*Detalle.Cantidad) as Precio FROM DetallePedidos as Detalle JOIN Pedidos as Pedidos JOIN Clientes as Clientes ON Detalle.CodigoPedido = Pedidos.CodigoPedido AND Pedidos.CodigoCliente = Clientes.CodigoCliente GROUP BY Detalle.CodigoPedido HAVING Precio = (SELECT SUM(PrecioUnidad*Cantidad) as Precio FROM DetallePedidos GROUP BY CodigoPedido ORDER BY Precio DESC LIMIT 1);

/*Sacar cuantos clientes tienen las ciudades que empiezan por M*/
 SELECT COUNT(Clientes.NombreCliente) AS NumeroClientes, Clientes.Ciudad FROM Clientes GROUP BY Ciudad HAVING Ciudad REGEXP "^M";
 SELECT COUNT(Clientes.NombreCliente) AS NumeroClientes, Clientes.Ciudad FROM Clientes GROUP BY Ciudad HAVING Ciudad LIKE "M%";

/*Sacar CodEmpleado, numero clientes al que atiende cada representante de ventas*/
 SELECT Clientes.CodigoEmpleadoRepVentas, COUNT(Clientes.NombreCliente) as NumeroClientes FROM Clientes as Clientes GROUP BY CodigoEmpleadoRepVentas;

/*Sacar numero de clientes que no tienen asignado RepVentas*/
 SELECT COUNT(Clientes.NombreCliente) as NumeroClientes FROM Clientes WHERE CodigoEmpleadoRepVentas IS NULL;

/*Sacar el primer pago y el ultimo de algún cliente*/
 SELECT MAX(FechaPago), MIN(FechaPago), CodigoCliente FROM Pagos GROUP BY CodigoCliente LIMIT 1;
 SELECT * FROM Pagos WHERE FechaPago = (SELECT MAX(FechaPago) FROM Pagos WHERE CodigoCliente = 1) OR (SELECT MIN(FechaPago) FROM Pagos WHERE CodigoCliente = 1) AND CodigoCliente = 1;

/*Sacar el codigo cliente de aquellos clientes que hicieron pago en 2008*/
 SELECT CodigoCliente FROM Pagos WHERE YEAR(FechaPago) = "2008";

/*Sacar numero pedido, codigo cliente, fecha requerida y fecha entrega de los pedidos que no han sido entegrados a tiempo*/
 SELECT CodigoPedido, CodigoCliente, FechaEsperada, FechaEntrega FROM Pedidos WHERE FechaEsperada>FechaEntrega;

/*Sacar cuantos productos existen en cada linea de pedido*/
 SELECT CodigoPedido, COUNT(Cantidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*Sacar listado de los 20 codigos de producto mas pedidos ordenados por cantidad pedida*/
 SELECT CodigoProducto, Cantidad FROM DetallePedidos ORDER BY Cantidad DESC LIMIT 20;

/*Sacar numero pedido, codigo clientes, fecha entrega, fecha requerida de los pedidos cuya fecha entrega ha sido al menos 2 dias antes de la fecha requerida*/
 SELECT CodigoPedido, CodigoCliente, FechaEsperada, FechaEntrega FROM Pedidos WHERE DATE(FechaEsperada)-2 >= DATE(FechaEntrega);

/*Sacar la facturacion que ha tenido la empresa en toda la historia indicando la mas imposible suma(costeproducto*numero udsvendidas), el IVA y el total facturado(suma dos campos anteriores)*/
 SELECT SUM(PrecioUnidad*Cantidad) AS Cantidad, (SUM(PrecioUnidad*Cantidad)*21)/100 AS IVA, (SUM(PrecioUnidad*Cantidad)+(SUM(PrecioUnidad*Cantidad)*21)/100) AS Total FROM DetallePedidos;

/*Sacar la misma que la anterior agrupando por codigoProducto filtrada por los codigos que empiecen por fr*/
 SELECT SUM(PrecioUnidad*Cantidad) AS Cantidad, (SUM(PrecioUnidad*Cantidad)*21)/100 AS IVA, (SUM(PrecioUnidad*Cantidad)+(SUM(PrecioUnidad*Cantidad)*21)/100) AS Total FROM DetallePedidos WHERE CodigoProducto LIKE "FR%";

/*Obtener listado del nombre de empleados con el nombre de sus jefes*/
SELECT Trabajadores.CodigoEmpleado, CONCAT(Trabajadores.Nombre,' ',Trabajadores.Apellido1) AS NombreEmpleado, CONCAT(Jefes.Nombre,' ',Jefes.Apellido1) AS NombreJefe FROM Empleados AS Trabajadores, Empleados AS Jefes WHERE Trabajadores.CodigoJefe=Jefes.CodigoEmpleado;

/*Sacar listado de jefes y sacar empleados a su cargo ordenado por numero empleados subordinados*/
SELECT Trabajadores.CodigoEmpleado, CONCAT(Trabajadores.Nombre,' ',Trabajadores.Apellido1) AS NombreEmpleado, CONCAT(Jefes.Nombre,' ',Jefes.Apellido1) AS NombreJefe FROM Empleados AS Trabajadores, Empleados AS Jefes WHERE Trabajadores.CodigoJefe=Jefes.CodigoEmpleado ORDER BY Trabajadores.CodigoEmpleado;

/*Obtener nombre de clientes a los que no se les ha entregado a tiempo un pedido*/
SELECT DISTINCT Clientes.NombreCliente FROM Clientes JOIN Pedidos ON Pedidos.CodigoCliente = Clientes.CodigoCliente WHERE FechaEsperada>FechaEntrega;

/*Sacar em importe medio de los pedidos*/
SELECT CodigoPedido, AVG(PrecioUnidad*Cantidad) FROM DetallePedidos GROUP BY CodigoPedido;

/*Cual es el pedido mas caro del empleado que mas clientes tiene*/


/*Trigger Syntax(MIRAR)
