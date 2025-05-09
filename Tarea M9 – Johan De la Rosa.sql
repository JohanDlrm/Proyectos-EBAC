-- Utiliza las T HR y P para crear una consulta que obtenga FirstName y LastName  y el título de su puesto JobTitle. INNER JOIN
SELECT
P. FirstName,
P. LastName,
HR. JobTitle
FROM Person.Person P
	INNER JOIN HumanResources.Employee HR
		ON p.BusinessEntityID = HR.BusinessEntityID

-- Utiliza las T Sales.Customer y Person.Person para una consulta que obtenga FirstName y LastName. Incluir incluso aquellos que no tienen un registro en la t PP. LEFT JOIN.
SELECT SC.CustomerID,
	PP.FirstName,
	PP.LastName
FROM Person.Person PP
LEFT OUTER JOIN Sales.Customer SC
	ON PP.BusinessEntityID = SC.CustomerID

-- Usa las t SO y SC para crear una consulta que muestre SalesOrderID) y CustomerID. Incluir todas las órdenes, incluso si no hay un cliente asociado usando un RIGHT JOIN.
SELECT SO.SalesOrderID,
SO.CustomerID
FROM Sales.Customer SC
LEFT OUTER JOIN Sales.SalesOrderHeader SO
	ON SC.CustomerID = SO.CustomerID

-- Utiliza las t P y R para crear una consulta que muestre el Name y Comments. Incluye todos los productos y todas las reseñas con FULL OUTER JOIN.
SELECT P.name,
R.Comments
FROM Production.Product P
FULL OUTER JOIN Production.ProductReview R
	ON P.ProductID = R.ProductID

-- Utiliza las t P y C para crear una consulta que devuelva una combinación de todos los productos con todas las categorías usando un CROSS JOIN.
SELECT P.Name AS 'ProductName',
C.Name AS 'CategoryName'
FROM Production.Product P
	CROSS JOIN Production.ProductCategory C

-- utilice UNION para combinar los nombres de productos de las tablas Production.Product y Production.ProductModel
SELECT Name
FROM Production.Product
UNION
SELECT Name
FROM Production.ProductModel

-- -- utilice UNION ALL para combinar los nombres de productos de las tablas Production.Product y Production.ProductModel
SELECT Name
FROM Production.Product
UNION ALL
SELECT Name
FROM Production.ProductModel

--  Utiliza la tabla HumanResources.Employee para crear una consulta que muestre el BusinessEntityID, el JobTitle, y una columna adicional que indique si el título del puesto contiene la palabra 'Manager' usando la expresión CASE. Si el título del puesto es nulo, usa COALESCE para mostrar 'No Title'.
SELECT 
BusinessEntityID,
JobTitle,
CASE 
	WHEN JobTitle LIKE '%Manager%' THEN 'Manager'
	ELSE 'No Manager'
	END AS JobCategory 
FROM
HumanResources.Employee

-- Utiliza la tabla Sales.SalesPerson para crear una consulta que muestre el BusinessEntityID, la SalesQuota, y una columna que indique 'No Quota' si SalesQuota es nulo usando la función ISNULL.
SELECT
BusinessEntityID,
SalesQuota,
ISNULL (SalesQuota, 0) AS 'Quota'
FROM Sales.SalesPerson;

