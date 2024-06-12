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
#se deben mostrar todos los países que se encuentran en la base de datos, y aquellos países a los que no solicitaron despachar pedidos deben figurar mostrando como cantidad cero (0). 

# ¿Qué clientes compraron productos que son suministrados por proveedores que residen en la misma región que ellos? 
#Mostrar ID, Nombre de la empresa, nombre del contacto y región. Incluir en el resultado aquellos cuya región es NULL si la región del proveedor también es NULL. Ordenar por región. 

#Realizar un reporte de las ventas realizadas por los representantes de ventas (title: Sales Representative) durante el último año en que se registraron ventas en la base.
#Los totales de ventas deberán estar agrupadas y mostradas por mes, en orden cronológico. Los empleados se deberán mostrar ordenados por apellido y luego por nombre.
#Las columnas a mostrar son: Nombre, Apellido, Mes, VentasTotales.

#¿Qué empleados no tienen como jefe al empleado cuyo apellido es Buchanan? Mostrar ID, y saludo, nombre y apellido concatenados.


#Listar los productos (ID, Nombre, precio unitario, y nombre de su categoría).
#Mostrar solamente aquellos productos cuyo precio unitario esté por encima del precio promedio de su categoría. Ordenar por nombre de categoría y nombre de producto.


#Listar los proveedores junto con el producto más caro que suministran.
#Mostrar ID del proveedor, nombre de la empresa, ID del producto, nombre del producto. Ordenar por nombre de categoría y nombre de producto