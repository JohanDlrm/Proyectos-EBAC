-- Crea una vista llamada Production.vCostoProductoSimple que incluya los campos ProductID, Name (renombrado como NombreProducto) y ListPrice (renombrado como PrecioLista) de la tabla Production.Product.
CREATE VIEW Production.vCostoProductoSimple AS
SELECT p.ProductID,
		p.Name AS NombrePrducto,
		p.ListPrice AS PrecioLista
FROM Production.Product p;

-- Crea una vista llamada Production.vProductoConCosto que combine las tablas Production.Product y Production.ProductCostHistory para mostrar los campos ProductID, Name (renombrado como NombreProducto), ListPrice (renombrado como PrecioLista), StandardCost (renombrado como CostoEstandar) y StartDate (renombrado como FechaInicio).
CREATE VIEW Production.vProductoConCosto AS
SELECT p.ProductID,
		p.Name AS NombreProducto,
		p.ListPrice AS PrecioLista,
		c.StandardCost AS CostoEstandar,
		c.StartDate AS FechaInicio
FROM Production.Product p
INNER JOIN Production.ProductCostHistory c
	ON p.ProductID = c.ProductID;

-- Crea una funci�n llamada dbo.fnCalcularDescuento que reciba dos par�metros @Precio y @Descuento y devuelva el precio con el descuento aplicado.
CREATE FUNCTION dbo.fnCalcularDescuento (@Precio DECIMAL (10,2), @Descuento DECIMAL (10,2))
RETURNS DECIMAL (10,2) AS
BEGIN 
	DECLARE @PrecioConDescuento DECIMAL (10,2)
	SET @PrecioConDescuento = @Precio - (@Precio * @Descuento / 100)

	RETURN @PrecioConDescuento
END

SELECT dbo.fnCalcularDescuento (100, 10) AS PrecioFinal;

-- Crea una funci�n llamada dbo.fnLimpiarTexto que reciba un texto como par�metro y lo limpie eliminando espacios al principio y al final, convirtiendo a may�sculas y reemplazando letras acentuadas.
ALTER FUNCTION dbo.fnLimpiarTexto (@Texto VARCHAR (255))
RETURNS VARCHAR (255) AS
BEGIN
	DECLARE @TextoLimpio VARCHAR (255)
	SET @TextoLimpio = TRIM(@Texto)
	SET @TextoLimpio = REPLACE(@TextoLimpio, '�','a')
	SET @TextoLimpio = REPLACE(@TextoLimpio, '�','e')
	SET @TextoLimpio = REPLACE(@TextoLimpio, '�','i')
	SET @TextoLimpio = REPLACE(@TextoLimpio, '�','o')
	SET @TextoLimpio = REPLACE(@TextoLimpio, '�','u')
	SET @TextoLimpio = UPPER(@TextoLimpio)

	RETURN @TextoLimpio
END

SELECT dbo.fnLimpiarTexto ('    �����       ')

-- Crea un procedimiento almacenado llamado dbo.uspObtenerProductosCostosos que reciba un par�metro @PrecioMin y devuelva los productos cuyo precio de lista sea mayor que este par�metro. El procedimiento debe consultar la tabla Production.Product y devolver las columnas ProductID, Name (renombrado como NombreProducto) y ListPrice (renombrado como PrecioLista).
CREATE OR ALTER PROCEDURE dbo.uspObtenerProductosCostosos (@PrecioMin DECIMAL (10,2))
AS
BEGIN
SELECT ProductID,
		Name AS NombreProducto,
		ListPrice As PrecioLista
FROM Production.Product
WHERE ListPrice > @PrecioMin
END

DECLARE @PrecioMayorAlMin DECIMAL (10,2);

EXECUTE dbo.uspObtenerProductosCostosos 1000