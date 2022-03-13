SELECT * FROM [Sales].[SalesOrderHeader]
SELECT * FROM [Sales].[SalesOrderDetail]
SELECT * FROM [Production].[ProductSubcategory]
SELECT * FROM [Production].[Product]
SELECT * FROM [Production].[ProductCategory]

SELECT 
CAT.Name as MainCat,PSC.Name AS SUBCAT,PRO.Name AS PRODUCT,
SUM(SOD.linetotal) AS TOTALPRICE,SUM(SOD.ORDERQTY) AS AMOUNT
FROM  [Sales].[SalesOrderHeader] AS SOH
JOIN [Sales].[SalesOrderDetail] AS SOD ON SOH.SalesOrderID=SOD.SalesOrderID
JOIN [Production].[Product] AS PRO ON PRO.ProductID=SOD.ProductID
LEFT JOIN [Production].[ProductSubcategory] AS PSC ON PSC.ProductSubcategoryID=PRO.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] AS CAT ON CAT.ProductCategoryID=PSC.ProductCategoryID
group by CAT.Name,PSC.Name,PRO.Name
ORDER BY TOTALPRICE DESC

SELECT 
SOH.OrderDate,SOH.DueDate,SOH.ShipDate,SOH.SalesOrderNumber,SOH.SubTotal,SOH.TotalDue,
SOD.CarrierTrackingNumber,SOD.OrderQty,SOD.UnitPrice,SOD.UnitPriceDiscount,SOD.LineTotal,
PRO.Name,PRO.ProductNumber,PRO.Color,PRO.StandardCost,PRO.ListPrice,PRO.Size,PRO.Weight,PRO.Class,
PSC.NAME AS SUBCAT,
CAT.Name AS MAINCAT
FROM  [Sales].[SalesOrderHeader] AS SOH
JOIN [Sales].[SalesOrderDetail] AS SOD ON SOH.SalesOrderID=SOD.SalesOrderID
JOIN [Production].[Product] AS PRO ON PRO.ProductID=SOD.ProductID
LEFT JOIN [Production].[ProductSubcategory] AS PSC ON PSC.ProductSubcategoryID=PRO.ProductSubcategoryID
LEFT JOIN [Production].[ProductCategory] AS CAT ON CAT.ProductCategoryID=PSC.ProductCategoryID