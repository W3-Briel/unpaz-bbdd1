USE northwind; # seleccionando la base de datos 'northwind'

## EJERCICIOS DE PRACTICA NORTHWIND - EJERCICOS DML (data manupulation lenguage)

#1. Seleccione todos los campos de la tabla cliente, ordenado por nombre del contacto de la compañía,
# alfabéticamente:
#				SELECT * FROM customers ORDER BY ContactName;

#2. Seleccione todos los campos de la tabla órdenes, ordenados por fecha de la orden,
# descendentemente:
#				SELECT * FROM orders ORDER BY OrderDate DESC;

#3. Seleccione todos los campos de la tabla detalle de la orden, ordenada por cantidad pedida.
# Ascendentemente: 
#				SELECT * FROM `order details` ORDER BY Quantity ASC;

#4. Obtener todos los productos, cuyo nombre comienzan con la letra P y tienen un precio unitario
# comprendido entre 10 y 120:
#				SELECT * FROM `products`
#				WHERE substr(`ProductName`,1,1) = 'P' AND (10 < `UnitPrice` < 120);
## se podria usar BETWEEN

#5. Obtener todos los clientes de los países de: USA, Francia y UK:
#				SELECT * FROM `customers`
#				WHERE `Country` in ('USA','UK');

#6. Obtener todos los productos descontinuados y sin stock, que pertenecen a la categoría 1, 3, 4 y 7:
#				SELECT * FROM `products`
#				WHERE `CategoryID` in (1,3,4,7) AND (`Discontinued` = 1 AND `UnitsInStock` = 0);

#7. Obtener todas las órdenes hechas por el empleado con código: 2, 5 y 7 en el año 1996:
#				SELECT * FROM `orders`
#				WHERE `EmployeeID` in (2,5,7) AND substr(`OrderDate`,1,4) = 1996;

#8. Seleccionar todos los clientes que cuenten con FAX:
#				SELECT * FROM `customers`
#				WHERE `Fax` IS NOT NULL;

#9. Seleccionar todos los clientes que no cuenten con FAX, del País de USA:
#				SELECT * FROM `customers`
#				WHERE `Fax` IS NOT NULL AND `Country` = 'USA';

#10. Seleccionar todos los empleados que cuentan con un jefe:
#				SELECT * FROM `employees`
#				WHERE `ReportsTo` IS NOT NULL;

#11. Seleccionar todos los campos del cliente, cuya compañía empiecen con letra O hasta la S y
# pertenezcan al país de USA, ordenarlos por la dirección:
#				SELECT * FROM `customers`
#				WHERE `Country` = 'USA' AND substr(`CompanyName`,1,1) BETWEEN 'O' AND 'S'
#				ORDER BY `Address`;
#se podria usar IN ('O','P','Q','R','S')

#12. Seleccionar todos los campos del cliente, cuya compañía empiecen con las letras de la B a la G, y
# pertenezcan al país de UK, ordenarlos por nombre de la compañía:
#				SELECT * FROM `customers`
#				WHERE (substr(`CompanyName`,1,1) BETWEEN 'B' AND 'G') AND `Country` = 'UK'
#				ORDER BY `CompanyName`;

#13. Seleccionar los productos vigentes cuyos precios unitarios están entre 35 y 250, sin stock en almacén,
# pertenecientes a las categorías 1, 3, 4, 7 y 8, que son distribuidos por los proveedores, 2, 4, 6, 7, 8 y 9:
#				SELECT * FROM `products`
#				WHERE (`CategoryID` in (1,3,4,7,8)) AND (`SupplierID` in (2,4,6,7,8,9)) AND (`UnitPrice` BETWEEN 35 AND 250);
## investigar porque con (35 < `UnitPrice` < 250) da diferentes resultado. ¿podria ser el tipo de dato decimal? o porque no se aceptan este tipo de comparaciones?

#14. Seleccionar todos los campos de los productos descontinuados, que pertenezcan a los proveedores
# con códigos: 1, 3, 7, 8 y 9, que tengan stock en almacén, y al mismo tiempo que sus precios unitarios
# estén entre 39 y 190, ordenados por código de proveedores y precio unitario de manera ascendente:
#				SELECT * FROM `products`
#				WHERE `SupplierID` in (1,3,7,8,9) AND `Discontinued` = 1 AND `UnitsInStock` > 0 /*mayor a cero, por si de alguna manera se ingresa un numero negativo*/
#					AND `UnitPrice` BETWEEN 39 AND 190
#				ORDER BY `SupplierID`,`UnitPrice`;

#15. Seleccionar los 7 productos con precio más caro, que cuenten con stock en almacén:
#				SELECT * FROM `products`
#				WHERE `UnitsInStock` > 0
#				ORDER BY `UnitPrice` DESC
#				LIMIT 7;

#16. Seleccionar los 9 productos, con menos stock en almacén, que pertenezcan a la categoría 3, 5 y 8:
