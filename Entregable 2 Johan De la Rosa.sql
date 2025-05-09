CREATE DATABASE Entregable2

USE Entregable2; 
GO 
CREATE SCHEMA Ventas; 
GO 
CREATE SCHEMA Productos; 
GO 
CREATE SCHEMA Fecha; 

USE Entregable2; 
GO 
CREATE TABLE Productos.DimProduct(
Manufacturer VARCHAR(255),
Brand VARCHAR(255),
Item VARCHAR(255),
ItemDescription VARCHAR(255),
Category INT,
Format VARCHAR(255),
ATTR1 VARCHAR(255),
ATTR2 VARCHAR(255),
ATTR3 VARCHAR(255),
Segment VARCHAR(255),
ItemCode VARCHAR(255) PRIMARY KEY
)
GO
CREATE TABLE Fecha.DimCalendar(
NomWeek VARCHAR(255) NOT NULL PRIMARY KEY,
Year VARCHAR(255),
Month VARCHAR(255),
WeekNumber VARCHAR(255),
Fecha VARCHAR(255)
)
GO
CREATE TABLE Ventas.FactSales(
NomWeek VARCHAR(255),
ItemCode VARCHAR(255),
TotalUnitSales DECIMAL(10,3),
TotalValueSales DECIMAL (10,3),
TotalUnitAvgWeeklySales DECIMAL(10,3),
Region VARCHAR(255)
CONSTRAINT FKVentasProductos FOREIGN KEY (ItemCode) REFERENCES [Productos].[DimProduct], 
CONSTRAINT FKVentasFecha FOREIGN KEY (NomWeek) REFERENCES [Fecha].[DimCalendar], 
)


BULK INSERT Productos.DimProduct
FROM 'C:\Users\samdl\OneDrive\Escritorio\Cursos\Ebac\Entregable2\DIM_PRODUCT.csv'
WITH
(
FIRSTROW = 2,
FIELDTERMINATOR = ','
);

BULK INSERT Ventas.FactSales
FROM 'C:\Users\samdl\OneDrive\Escritorio\Cursos\Ebac\Entregable2\FACT_SALES.csv'
WITH
(
FIRSTROW = 2,
FIELDTERMINATOR = ','
);

BULK INSERT Fecha.DimCalendar
FROM 'C:\Users\samdl\OneDrive\Escritorio\Cursos\Ebac\Entregable2\DIM_CALENDAR.csv'
WITH
(
FIRSTROW = 2,
FIELDTERMINATOR = ','
);


SELECT *
FROM Fecha.DimCalendar

SELECT *
fROM Productos.DimProduct

SELECT * 
FROM Ventas.FactSales

--Venta total por producto
SELECT p.ItemCode,
		p.ItemDescription,
		SUM(FS.TotalValueSales) AS VentaTotal
FROM Ventas.FactSales FS
	INNER JOIN Productos.DimProduct P 
	ON FS.ItemCode = P.ItemCode
GROUP BY P.ItemCode, P.ItemDescription
ORDER BY VentaTotal DESC;

--Venta total por año
SELECT Year, Month,
		SUM(FS.TotalValueSales) AS VentaTotal
FROM Ventas.FactSales FS
	INNER JOIN Productos.DimProduct P 
	ON FS.ItemCode = P.ItemCode
	INNER JOIN Fecha.DimCalendar C
	ON  FS.NomWeek = C.NomWeek
GROUP BY Year, Month
ORDER BY Month ASC

-- Ventas por region
SELECT FS.Region,
		SUM(FS.TotalValueSales) AS VentaTotal
FROM Ventas.FactSales FS
	INNER JOIN Productos.DimProduct P 
	ON FS.ItemCode = P.ItemCode
	INNER JOIN Fecha.DimCalendar C
	ON  FS.NomWeek = C.NomWeek
GROUP BY fs.Region

--Productos con venta promedio mayor a la venta promedio del 2022
SELECT P.ItemCode,
		P.ItemDescription,
		SUM(FS.TotalValueSales) AS VentaTotal2022
FROM Ventas.FactSales FS
	INNER JOIN Productos.DimProduct P 
	ON FS.ItemCode = P.ItemCode
	INNER JOIN Fecha.DimCalendar C
	ON  FS.NomWeek = C.NomWeek
WHERE C.Year = 2022
GROUP BY
	P.ItemCode,
	P.ItemDescription
HAVING 
	SUM(FS.TotalValueSales) > (
		SELECT AVG(Ventas_agrupadas.Venta_Total)
		FROM( 
		SELECT FS.ItemCode, SUM( FS.TotalUnitSales) AS Venta_Total
	FROM ventas.FactSales FS
	INNER JOIN Fecha.DimCalendar C
		ON	FS.NomWeek = C.NomWeek
	WHERE C.Year = 2022
	GROUP BY FS.ItemCode
	) AS Ventas_agrupadas
	)
ORDER BY VentaTotal2022 DESC;