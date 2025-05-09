--crear una consulta que obtenga el ProductID, el número total de ventas (OrderQty) y el valor total de ventas (LineTotal) por cada producto usando la cláusula GROUP BY.
SELECT ProductID,
SUM(OrderQty) AS 'TotalQuantity',
SUM(LineTotal) AS 'TotalSales'
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY 3 DESC

-- Utiliza la tabla Sales.SalesOrderDetail para crear una consulta que agrupe los datos por ProductID y obtenga el número total de ventas (OrderQty) por producto. Filtra los grupos para mostrar solo aquellos productos que han tenido más de 50 ventas usando la cláusula HAVING.
SELECT ProductID,
SUM(OrderQty) AS 'TotalQuantity'
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 50
ORDER BY 2

-- Utiliza la tabla Sales.SalesOrderDetail para crear una consulta que muestre el SalesOrderID, ProductID, LineTotal y el valor total de ventas (LineTotal) para cada SalesOrderID usando la cláusula OVER con PARTITION BY.
SELECT SalesOrderID,
		ProductID,
		LineTotal,
		SUM (LineTotal) OVER(PARTITION BY SalesOrderID) AS 'TotalOrderValue'
FROM Sales.SalesOrderDetail
ORDER BY 4 DESC

-- Utiliza la tabla Sales.SalesOrderDetail para crear una consulta que muestre el SalesOrderID, SalesOrderDetailID, ProductID y LineTotal. Usa la función ROW_NUMBER() para numerar cada línea de pedido dentro de cada SalesOrderID.
SELECT SalesOrderID,
		SalesOrderDetailID,
		ProductID,
		LineTotal,
		ROW_NUMBER() OVER (PARTITION BY SalesOrderID ORDER BY SalesOrderDetailID) AS 'RowNum'
FROM Sales.SalesOrderDetail

-- Utiliza la tabla Sales.SalesOrderDetail para crear una consulta que muestre el SalesOrderID, ProductID y LineTotal. Asigna un rango a cada producto dentro de cada SalesOrderID basado en el LineTotal usando la función RANK().
SELECT SalesOrderID,
		ProductID,
		LineTotal,
		RANK() OVER (ORDER BY LineTotal DESC) AS 'Rank'
FROM Sales.SalesOrderDetail

-- Utiliza la tabla Sales.SalesOrderDetail para crear una consulta que muestre el SalesOrderID, ProductID y LineTotal. Asigna un rango denso a cada producto dentro de cada SalesOrderID basado en el LineTotal usando la función DENSE_RANK().
SELECT SalesOrderID,
		ProductID,
		SUM (LineTotal) AS LineTotal,
		DENSE_RANK() OVER (ORDER BY ProductID) AS DenseRank
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID, ProductID
ORDER BY 1, 3 DESC

-- Utiliza la tabla Sales.SalesOrderDetail para crear una consulta que agrupe los datos por ProductID y obtenga el valor total de ventas (LineTotal). Filtra para mostrar solo aquellos productos con un valor total de ventas superior a $5000 usando la cláusula HAVING. Ordena los resultados por el valor total de ventas en orden descendente.
SELECT ProductID,
		SUM(LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LineTotal) > 50000
ORDER BY 2 DESC