#ejercicios de parcial 2 - bases de datos 1!
#Responder las siguientes consultas utilizando la base Northwind
USE `northwind`;
SET lc_time_names = `es_AR`;

#1) Seleccionar las órdenes (OrderID, CustomerID, EmployeeID, OrderDate), realizadas por el empleado
#con código 3, de cualquier año, pero sólo de los de los primeros cinco meses (enero – mayo)
/*
SELECT
	`OrderID`,
    `CustomerID`,
	`EmployeeID`,
    `OrderDate`
FROM
	`orders`
WHERE
	`EmployeeID` = 3
    AND (MONTH(`OrderDate`) BETWEEN 1 AND 5)
ORDER BY 
	`OrderDate` ASC;*/

#2) Listar los diferentes (sin repetidos) países que se encuentran en la tabla de clientes, ordenados
#alfabéticamente.

/*
SELECT DISTINCT
	`Country`
FROM
	`customers`
WHERE
	`Country` IS NOT NULL
ORDER BY
	`Country` ASC;*/

#3) Armar un listado que incluya el nombre, apellido, puesto y apellido de su jefe (el listado debe incluir
#a todos los empleados). # EmployeeID -> ReportsTo

/*
SELECT
    `E`.`lastName` AS `apellido`,
	`E`.`firstName` AS `nombre`,
    `E`.`Title` AS `puesto`,
	IFNULL(`J`.`lastName`,'no tiene') AS `apellido_jefe`
FROM 
	`employees` AS `E`
LEFT JOIN 
	`employees` AS `J`
	ON `J`.`EmployeeID` = `E`.`ReportsTo`;*/
## ojo con el orden en el ON... de esta manera estamos juntando la tabla E con la J. si la ID de la tabla J es igual al del jefe de la tabla E.


#4) Calcular el total solicitado (en cantidades, y en importe total) en 1997, agrupado por categoría de
#producto (mostrar el nombre de la categoría).
#Calcular el importe total multiplicando Cantidad
#(Quantity) por el precio unitario (UnitPrice)
/*
SELECT `CategoryName`,
		SUM(`Quantity`) AS `CANTIDAD`,
        FORMAT(SUM(`Quantity` * `order details`.`UnitPrice`),2) AS `TOTAL`
FROM `categories`
INNER JOIN `products`
	ON `categories`.`CategoryID` = `products`.`CategoryID`
INNER JOIN `order details`
	ON `order details`.`ProductID` = `products`.`ProductID`
INNER JOIN `orders`
	ON `orders`.`OrderID` = `order details`.`OrderID`
WHERE YEAR(`orders`.`OrderDate`) = 1997
GROUP BY `CategoryName`*/

#5) Seleccionar todos los clientes que no cuenten con FAX, del país “UK”
/*
SELECT 
	`CustomerID`,
    `CompanyName`,
    `ContactName`,
    `ContactTitle`,
    `Address`,
    `City`,
    `Region`,
    `PostalCode`,
    `Country`,
	`Phone`,
    `Fax`
FROM
	`customers`
WHERE 
	`Fax` IS NULL
    AND `Country` = 'UK';
*/

#6) Seleccionar los 3 productos con menor precio, de las categorías 3, 5 y 8
## 3 productos por categoria??? -> no pide empates
/*
(SELECT *
FROM `products`
WHERE `CategoryID` = 3 
ORDER BY `UnitPrice` ASC
LIMIT 3)
UNION
(SELECT *
FROM `products`
WHERE `CategoryID` = 5
ORDER BY `UnitPrice` ASC
LIMIT 3)
UNION
(SELECT *
FROM `products`
WHERE `CategoryID` = 8
ORDER BY `UnitPrice` ASC
LIMIT 3)
*/

#7)  Obtener todos los productos, cuyo nombre termine con la letra I (letra i laƟna) y tengan un precio
#unitario comprendido entre 20 y 50

/*
SELECT
	`ProductID`,
    `ProductName`
FROM 
	`products`
WHERE
	`ProductName` LIKE '%i'
    AND `UnitPrice` BETWEEN 20 AND 50;
*/


############################################

# SEGUN MODELO DE PARCIAL 2 - BBDD

#1)
#Seleccionar las órdenes realizadas por los empleados con código entre el 4 y 7, que tengan como 
#destino ciudades (ShipCity) que comienzan con las letras "O" o "L", y que hayan sido gestionadas el 
#día 15 de abril (no importa el año). 

SELECT
	`OrderID`,
    `CustomerID`,
    `EmployeeID`,
    `OrderDate`,
    `RequiredDate`,
    `ShippedDate`,
    `ShipVia`,
    `Freight`,
    `ShipName`,
    `ShipCity`,
    `ShipRegion`,
    `ShipPostalCode`,
    `ShipCountry`
FROM `orders`
WHERE
	`EmployeeID` BETWEEN 4 AND 7
	AND (
		`ShipCity` LIKE 'O%'
        OR `ShipCity` LIKE 'L%')
	AND (
		MONTH(`ShippedDate`) = 4 
        AND DAY(`ShippedDate`) = 15);

#2) 
#Listar los diferentes (sin repetidos) países que se encuentran en la tabla de clientes, ordenados 
#alfabéticamente.

SELECT DISTINCT
	`Country`
FROM 
	`customers`
ORDER BY
	`Country` ASC;


#3)
#Armar un listado que incluya el nombre, apellido, puesto y apellido de su jefe (el listado debe incluir 
#a todos los empleados). 

SELECT 
	`E`.`FirstName`,
    `E`.`LastName`,
    `E`.`Title`,
    IFNULL(`J`.`LastName`,'No tiene') AS `JEFE`
FROM 
	`employees` AS `E`
LEFT JOIN 
	`employees` AS `J`
	ON `J`.`EmployeeID` = `E`.`ReportsTo`;

## resultados esperados:
/*
FirstName LastName Title 					Jefe 
---------- -------------------- ----------------------
Nancy 	Davolio 	Sales Representative 	Fuller 
Andrew 	Fuller 		Vice President, Sales 	No tiene 
Janet 	Leverling 	Sales Representative 	Fuller 
Margaret Peacock 	Sales Representative 	Fuller 
Steven	 Buchanan 	Sales Manager 			Fuller */

#4)
#Obtener el nombre del cliente, nombre del empleado y el nombre de los productos que están en la 
#orden 10250.

SELECT
	`customers`.`ContactName`,
    `employees`.`FirstName` AS `employeeName`,
    `products`.`ProductName`
FROM
	`orders`
INNER JOIN
	`customers`
	ON `customers`.`CustomerID` = `orders`.`CustomerID`
INNER JOIN
	`employees`
	ON `employees`.`EmployeeID` = `orders`.`EmployeeID`
INNER JOIN
	`order details` AS `OD`
	ON `OD`.`OrderID` = `orders`.`OrderID`
INNER JOIN
	`products`
	ON `products`.`ProductID` = `OD`.`ProductID`
WHERE
	`orders`.`OrderID` = 10250;

/*
CompanyName 		Empleado 						ProductName 
---------------------------------------- ------------------------------- --------------
Hanari Carnes 		Margaret Peacock 				Jack's New England Clam Chowder 
Hanari Carnes 		Margaret Peacock 				Manjimup Dried Apples 
Hanari Carnes 		Margaret Peacock 				ouisiana Fiery Hot Pepper Sauce */


#5)
#Seleccionar todos los clientes que cuenten con FAX, del país “Argentina”

SELECT
	`CustomerID`,
	`CompanyName`,
    `ContactName`,
    `ContactTitle`,
    `Address`,
    `City`,
    `Region`,
    `PostalCode`,
    `Country`,
    `Phone`,
    `Fax`
FROM 
	`customers`
WHERE 
	(`Fax` IS NOT NULL)
	AND (`Country` = 'Argentina');


#6) 
#Seleccionar los 3 productos con menor precio, de las categorías 3, 5 y 8 

	(SELECT
		`ProductID`,
		`ProductName`
	FROM
		`products`
	WHERE 
		`CategoryID` = 3
	ORDER BY 
		`UnitPrice` ASC
	LIMIT 3)
UNION
	(SELECT 
		`ProductID`,
		`ProductName`
	FROM 
		`products`
	WHERE
		`CategoryID` = 3
	ORDER BY 
		`UnitPrice` ASC
	LIMIT 5)
UNION
	(SELECT 
		`ProductID`,
		`ProductName`
	FROM 
		`products`
	WHERE
		`CategoryID` = 3
	ORDER BY
		`UnitPrice` ASC
	LIMIT 8);

#7)
#Obtener todos los productos, cuyo nombre termine con la letra I (letra i latina) y tengan un precio 
#unitario comprendido entre 20 y 50

SELECT 
	`ProductID`,
	`ProductName`,
    `SupplierID`,
    `CategoryID`,
    `QuantityPerUnit`,
    `UnitPrice`,
    `UnitsInStock`,
    `UnitsOnOrder`,
    `ReorderLevel`,
    `Discontinued` 
FROM `products`
WHERE
	`UnitPrice` BETWEEN 20 AND 50;

####################################################
# ejercicios practica segundo parcial

#Armar un reporte que incluya a los países y la cantidad de pedidos que se solicitaron despachar a cada país. Hay que considerar que en el listado 
#se deben mostrar todos los países que se encuentran en la base de datos, 
#y aquellos países a los que no solicitaron despachar pedidos deben figurar mostrando como cantidad cero (0).

#-> tener en cuenta, suppliers,employees,customers... ya que en la union de las columnas Country, tendriamos todos los paises de la base de datos. (no pense esto en el parcial :sob: )

SELECT
	`CA`.`Country`,
    IFNULL(`CC`.`cantidad`,0) AS `cantidad`
FROM ( /*selecciono todos los paises de la base de datos*/
	(SELECT `Country` FROM `suppliers`)
	UNION
	(SELECT `Country` FROM `employees`)
	UNION
	(SELECT `Country` FROM `customers`)
    ) AS `CA`
LEFT JOIN (
	SELECT
		`Country`,
		COUNT(*) AS `cantidad`
	FROM
		`customers`
	GROUP BY
		`Country`) AS `CC`
	ON `CA`.`Country` = `CC`.`Country`
WHERE
	`CA`.`Country` IS NOT NULL;

# ¿Qué clientes compraron productos que son suministrados por proveedores que residen en la misma región que ellos? 
#Mostrar ID, Nombre de la empresa, nombre del contacto y región.
#Incluir en el resultado aquellos cuya región es NULL si la región del proveedor también es NULL. Ordenar por región. 

# order details -> orders -> customers -> products -> suppliers

SELECT DISTINCT #Mostrar ID, Nombre de la empresa, nombre del contacto y región.
    `customers`.`CustomerID`,
    `customers`.`CompanyName`,
    `customers`.`ContactName`,
    `customers`.`Country`
FROM
	`order details`
INNER JOIN
	`orders`
	ON `orders`.`OrderID` = `order details`.`OrderID`
INNER JOIN 
	`customers`
	ON `customers`.`CustomerID` = `orders`.`CustomerID`
INNER JOIN
	`products`
    ON `products`.`ProductID` = `order details`.`ProductID`
INNER JOIN
	`suppliers`
    ON `products`.`SupplierID` = `suppliers`.`SupplierID`
WHERE
	`suppliers`.`Country` = `customers`.`Country` # -> clientes y proveedores del mismo pais
    OR `customers`.`Country` IS NULL AND `suppliers`.`Country` IS NULL; # cliente con region null y su proveedor tambien... pero no hay ninguno en la base de datos.

#Realizar un reporte de las ventas realizadas por los representantes de ventas
#(title: Sales Representative) durante el último año en que se registraron ventas en la base.
#Los totales de ventas deberán estar agrupadas y mostradas por mes, en orden cronológico. Los empleados se deberán mostrar ordenados por apellido y luego por nombre.
#Las columnas a mostrar son: Nombre, Apellido, Mes, VentasTotales.

## respuesta!
SELECT #Las columnas a mostrar son: Nombre, Apellido, Mes, VentasTotales.
	`S`.`FirstName` AS `Nombre`,
	`S`.`LastName` AS `Apellido`,
    MONTHNAME(`O`.`OrderDate`) AS `Mes`,
	COUNT(`S`.`EmployeeID`) AS `VentasTotales`
FROM (
	SELECT
		`EmployeeID`,
		`FirstName`,
		`LastName`
	FROM
		`employees`
	WHERE
		`Title` = 'Sales Representative') AS `S` ##empleados "Sales Representative"
INNER JOIN
	`orders` AS `O`
    ON `O`.`EmployeeID` = `S`.`EmployeeID`
WHERE ## ultimo año que se registraron ventas.
	YEAR(`OrderDate`) = (
		SELECT
			YEAR(MAX(`OrderDate`))
		FROM
			`orders`)
GROUP BY
	`S`.`FirstName`,
    `S`.`LastName`,
    MONTHNAME(`O`.`OrderDate`)
ORDER BY  #Los empleados se deberán mostrar ordenados por apellido y luego por nombre
	`S`.`LastName`,
    `S`.`FirstName`;




#¿Qué empleados no tienen como jefe al empleado cuyo apellido es Buchanan? Mostrar ID, y saludo, nombre y apellido concatenados.

SELECT
	`E`.`EmployeeID` AS `ID`,
    CONCAT(`E`.`FirstName`,' ',`E`.`LastName`) AS `NOMBRE`,
    `E`.`TitleOfCourtesy` AS `SALUDO`
FROM
	`employees` AS `E`
LEFT JOIN
	`employees` AS `J`
    ON `E`.`ReportsTo` = `J`.`EmployeeID`
WHERE
	`J`.`LastName` <> 'Buchanan' #no tienen como jefe al empleado cuyo apellido es Buchanan
    OR `E`.`ReportsTo` IS NULL /*podria pasar que no tenga jefe, por eso tenemos que evaluarlo de esta manera. ya que sino no aparecen los nulls*/;


#Listar los productos (ID, Nombre, precio unitario, y nombre de su categoría).
#Mostrar solamente aquellos productos cuyo precio unitario esté por encima del precio promedio de su categoría.
#Ordenar por nombre de categoría y nombre de producto.

SELECT /*ID, Nombre, precio unitario, y nombre de su categoría*/
	`products`.`ProductID`,
    `products`.`ProductName`,
    `products`.`UnitPrice`,
    `PROMEDIOS`.`CategoryName`
FROM
	`products`
INNER JOIN ( /*promedio de las categorias*/
	SELECT
		`categories`.`CategoryID`,
		`categories`.`CategoryName`,
		FORMAT(AVG(`products`.`UnitPrice`),2) AS `PROMEDIO`
	FROM
		`categories`
	INNER JOIN
		`products`
		ON `categories`.`CategoryID` = `products`.`CategoryID`
	GROUP BY
		`categories`.`CategoryID`,
		`categories`.`CategoryName`) AS `PROMEDIOS`
	ON `products`.`CategoryID` = `PROMEDIOS`.`CategoryID`
WHERE /*mostrar solamente aquellos productos cuyo precio unitario esté por encima del precio promedio de su categoría*/
	`products`.`UnitPrice` > `PROMEDIOS`.`PROMEDIO`
ORDER BY /*Ordenar por nombre de categoría y nombre de producto*/
	`PROMEDIOS`.`CategoryName` ASC, `products`.`ProductName` ASC;


#Listar los proveedores junto con el producto más caro que suministran.
#Mostrar ID del proveedor, nombre de la empresa, ID del producto, nombre del producto. Ordenar por nombre de categoría y nombre de producto

SELECT /*Mostrar ID del proveedor, nombre de la empresa, ID del producto, nombre del producto*/
	`suppliers`.`SupplierID`,
    `suppliers`.`CompanyName`,
    `products`.`ProductID`,
    `products`.`ProductName`
FROM
	`suppliers`
INNER JOIN /*proveedores con sus productos*/
	`products`
    ON `suppliers`.`SupplierID` = `products`.`SupplierID`
INNER JOIN
	`categories`
    ON `products`.`CategoryID` = `categories`.`CategoryID`
WHERE /*proveedores junto con el producto más caro que suministran*/
	`products`.`UnitPrice` = (
		SELECT
			MAX(`UnitPrice`)
		FROM
			`products`
		WHERE
			`products`.`SupplierID` = `suppliers`.`SupplierID`
    )
ORDER BY /*Ordenar por nombre de categoría y nombre de producto*/
	`categories`.`CategoryName` ASC, `products`.`ProductName`;

#Armar un reporte de los pedidos despachados, agrupados por día de la semana en que fueron despachados (lunes, martes, etc.).c

SELECT
	DAYNAME(`OrderDate`) AS `DIA`, /*agrupados por día de la semana en que fueron despachados (lunes, martes, etc.)*/
	COUNT(*) AS `CANTIDAD_DESPACHADO` /*reporte de los pedidos despachados*/
FROM
	`orders`
GROUP BY
	`DIA`, WEEKDAY(`OrderDate`)
ORDER BY
	WEEKDAY(`OrderDate`);


#Se desea armar parejas de representantes de ventas (Sales Representative) de Estados Unidos (USA). Considerar que no se deben repetir parejas. De cada empleado se desa mostrar concatenados el saludo, nombre y apellido.



#Listar los proveedores junto con el producto más caro que suministran. Mostrar ID del proveedor, nombre de la empresa, ID del producto, nombre del producto. Ordenar por nombre de categoría y nombre de producto



#Muestre los productos cuyo precio es mayor al promedio de precio de todos los productos de su misma categoría, y la longitud del nombre es menor a 15.


#Armar un reporte que incluya a los países y la cantidad de pedidos que se solicitaron despachar a cada país. Hay que considerar que en el listado se deben mostrar todos los países que se encuentran en la base de datos, y aquellos países a los que no solicitaron despachar pedidos deben figurar mostrando como cantidad cero (0). 



#Listar los productos (ID, Nombre, precio unitario, y nombre de su categoría). Mostrar solamente aquellos productos cuyo precio unitario esté por encima del precio promedio de su categoría. Ordenar por nombre de categoría y nombre de producto.



#¿Qué clientes compraron productos que son suministrados por proveedores que residen en la misma región que ellos? Mostrar ID, Nombre de la empresa, nombre del contacto y región. Incluir en el resultado aquellos cuya región es NULL si la región del proveedor también es NULL. Ordenar por región. 


SELECT `categories`.`CategoryName`,AVG(`products`.`UnitPrice`)
FROM `categories`
INNER JOIN `products`
	 ON `products`.`CategoryID` = `categories`.`CategoryID`
GROUP BY `categories`.`CategoryName`;