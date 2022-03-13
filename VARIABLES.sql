DECLARE @NAME AS VARCHAR(100) 
SET @NAME='OMER'
SELECT @NAME -- ÜÇÜNÜ BÝRDEN ÇALIÞTIRMAK GEREKÝR.--

DECLARE @NUMBER1 AS INT
SET @NUMBER1=18
SELECT @NUMBER1

DECLARE @NUMBER2 AS INT
SET @NUMBER2=9
SELECT @NUMBER2


DECLARE @NUMBER1 AS INT
SET @NUMBER1=18
DECLARE @NUMBER2 AS INT
SET @NUMBER2=9
SELECT @NUMBER1,@NUMBER2--HEPSÝNÝ BÝRDEN ÇALIÞTIRMAK GEREKÝR--


DECLARE @NUMBER1 AS INT
SET @NUMBER1=18
DECLARE @NUMBER2 AS INT
SET @NUMBER2=9
DECLARE @TOTAL AS INT
SET @TOTAL=@NUMBER1+@NUMBER2
SELECT @NUMBER1,@NUMBER2,@TOTAL


CREATE VIEW VW_TOPSALES
AS

SELECT top 10 PRC.Name AS MAINCATEGORY,PRS.Name AS SUBCATEGORY,PRO.ProductNumber,PRO.Name,SOD.LineTotal
 FROM [Production].[ProductCategory] AS PRC
INNER JOIN [Production].[ProductSubcategory] PRS ON PRC.ProductCategoryID=PRS.ProductCategoryID
INNER JOIN Production.Product AS PRO ON PRO.ProductSubcategoryID=PRS.ProductSubcategoryID
INNER JOIN [Sales].[SalesOrderDetail] AS SOD ON PRO.ProductID=SOD.ProductID
INNER JOIN [Sales].[SalesOrderHeader] AS SOH ON SOH.SalesOrderID=SOD.SalesOrderID
order by sod.LineTotal desc

select top 1 * from VW_TOPSALES order by LineTotal desc

declare @topsale_category as varchar(100)
declare @topsale_subcategory as varchar(100)
declare @topsale_productnumer as varchar(100)
declare @topsale_name as varchar(100)
declare @topsale_totalsale as float

select top 1 
@topsale_category =maincategory,
@topsale_subcategory=subcategory,
@topsale_productnumer=productnumber,
@topsale_name=Name,
@topsale_totalsale=LineTotal
from VW_TOPSALES order by LineTotal desc

select @topsale_category, @topsale_subcategory,@topsale_productnumer,@topsale_name, @topsale_totalsale