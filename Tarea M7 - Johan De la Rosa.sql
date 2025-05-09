--Selecciona todos los datos de la tabla Person.Person.
SELECT *
FROM Person.Person

--Seleccionar todos los empleados de la tabla HumanResources.Employee cuyo JobTitle sea 'Marketing Specialist'.
SELECT *
FROM HumanResources.Employee
WHERE JobTitle = 'Marketing Specialist'

--Ordena los empleados de la tabla de la tabla HumanResources.Employee por HireDate en orden descendente.
Select *
FROM HumanResources.Employee
ORDER BY HireDate DESC

--Seleccione los productos cuyo precio esté entre 20 y 100 (considera la columna ListPrice de la tabla Production.Product)
Select *
FROM Production.Product
WHERE ListPrice BETWEEN 20 AND 100