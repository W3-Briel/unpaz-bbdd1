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
## 3 productos por categoria??? -> y los empates de precios??
/*
SELECT *
FROM `products`
WHERE `CategoryID` IN (3,5,8)
ORDER BY `UnitPrice` ASC
LIMIT 3;
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










