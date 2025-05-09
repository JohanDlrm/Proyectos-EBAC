-- Utiliza la tabla Production.Product para crear una consulta que muestre los nombres de los productos y los ID’s de productos que hayan sido ordenados. Utiliza una subconsulta para filtrar los productos ordenados en la tabla Sales.SalesOrderDetail. Ordena el resultado por nombre de manera ascendente.
SELECT DISTINCT p.Name,
		s.ProductID
FROM sales.SalesOrderDetail s
		INNER JOIN production.Product p
		ON s.ProductID = p.ProductID
ORDER BY 1 ASC

-- .Utiliza las tablas HumanResources.Employee, HumanResources.EmployeeDepartmentHistory, HumanResources.Department y Person.Person para crear una consulta que muestre un listado de todos los empleados y el nombre de su departamento actual. Los campos a mostrar serán: BusinessEntityID, FirstName + ' ' + LastName como Nombre del Empleado, y Name como Nombre del Departamento.
SELECT he.BusinessEntityID, CONCAT(pp.FirstName, ' ',pp.LastName) AS Name, hd.Name  AS Departamento
FROM HumanResources.Employee he
		INNER JOIN HumanResources.EmployeeDepartmentHistory hed ON he.BusinessEntityID = hed.BusinessEntityID
		INNER JOIN HumanResources.Department hd ON hed.DepartmentID = hd.DepartmentID
		INNER JOIN Person.Person pp ON he.BusinessEntityID =  pp.BusinessEntityID
ORDER BY 1

--Utiliza las tablas HumanResources.Employee, HumanResources.EmployeeDepartmentHistory y HumanResources.Department para crear una consulta que muestre el mismo resultado que en el ejercicio 2, pero utilizando un CTE. Los campos a mostrar serán: BusinessEntityID, FirstName + ' ' + LastName como Nombre del Empleado, y Name como Nombre del Departamento.
WITH TE AS(
SELECT hed.BusinessEntityID, hed.DepartmentID, hd.Name AS Puesto
FROM HumanResources.EmployeeDepartmentHistory hed
	INNER JOIN HumanResources.Department hd ON hed.DepartmentID = hd.DepartmentID
	)
SELECT TE.BusinessEntityID, hd.Name AS 'Departamento', CONCAT(pp.FirstName, ' ',pp.LastName) AS Name
FROM TE
		INNER JOIN HumanResources.Department hd ON hd.DepartmentID = TE.DepartmentID
		INNER JOIN Person.Person pp ON TE.BusinessEntityID =  pp.BusinessEntityID
ORDER BY 1

--Crea una tabla temporal local y otra global para almacenar los productos ordenados. Utiliza la tabla Production.Product para insertar los datos en ambas tablas temporales. Los campos a incluir serán: ProductID y Name. Inserta los datos en la tabla temporal local.
CREATE TABLE #Local (
ProductID INT,
NameProduct VARCHAR (255)
)

INSERT INTO #Local(ProductID, NameProduct)
SELECT PP.ProductID, PP.Name
fROM Production.Product PP

SELECT *
FROM #Local

-- Crea una tabla temporal local y otra global para almacenar los productos ordenados. Utiliza la tabla Production.Product para insertar los datos en ambas tablas temporales. Los campos a incluir serán: ProductID y Name. Inserta los datos en la tabla temporal local.
CREATE TABLE ##Global (
ProductID INT,
NameProduct VARCHAR (255)
)

INSERT INTO ##Global(ProductID, NameProduct)
SELECT PP.ProductID, PP.Name
fROM Production.Product PP

SELECT *
FROM ##Global

-- Utiliza la tabla Sales.SalesOrderHeader para crear una consulta que muestre los números de orden y números de compra solo para el año 2011.
SELECT SalesOrderNumber, PurchaseOrderNumber
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011

-- .Utiliza la tabla Sales.SalesOrderHeader para crear una consulta que muestre los números de orden y números de compra sin los 2 primeros caracteres y nombra los campos resultantes como NewSalesOrderNumber y NewPurchaseOrderNumber.
SELECT RIGHT(SalesOrderNumber, 5) AS NewSAlesOrderNumber, SUBSTRING(PurchaseOrderNumber, 3, 12) AS NewPurchaseOrderNumber
FROM Sales.SalesOrderHeader

