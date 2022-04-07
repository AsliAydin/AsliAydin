SAMPLE NORTHWND


--INNER JOIN----

-- From Suppliers table CompanyName,ContactName
--From Product table ProductName,UnitPrice
--From Categories table CatergoryName
--CompanyName sort by column in ascending order.

SELECT  CompanyName,ContactName,ProductName,UnitPrice,CategoryName
FROM Categories AS C
INNER JOIN Products AS P
ON C.CategoryID=P.CategoryID
INNER JOIN Suppliers AS S
ON P.SupplierID=S.SupplierID
ORDER BY CompanyName ASC


--Find the total stock amount by categories.(Categories,Products)

SELECT CategoryName,SUM(UnitsInStock) AS Stock
FROM Categories AS C
INNER JOIN Products AS P
ON C.CategoryID=P.CategoryID
GROUP BY CategoryName
ORDER BY Stock DESC

--2.) OUTER JOIN

--2.1) LEFT OUTER JOIN 
SELECT ProductName,CategoryName
FROM Products AS P
LEFT OUTER JOIN Categories AS C
ON P.CategoryID=C.CategoryID

--List all employees and their managers, if any.

SELECT (E1.FirstName+' '+E1.LastName) AS Çalışan,
(E2.FirstName+' '+E2.LastName) 
FROM Employees AS E1
LEFT JOIN Employees AS E2
ON E1.EmployeeID=E2.ReportsTo


--2.2)RIGHT OUTER JOIN

--List all employees and their managers, if any.

SELECT (E1.FirstName+' '+E1.LastName) AS Çalışan,
(E2.FirstName+' '+E2.LastName) 
FROM Employees AS E1
RIGHT JOIN Employees AS E2
ON E1.EmployeeID=E2.ReportsTo


--3.)FULL JOIN:

SELECT ProductName,CategoryName
FROM Categories 
FULL JOIN Products 
ON Categories.CategoryID=Products.CategoryID

--4.) CROSS JOIN

SELECT COUNT(*)
FROM Categories

SELECT COUNT(*)
FROM Products 

SELECT *
FROM Categories CROSS JOIN Products




*/CREATING NEW TABLE

CREATE TABLE Urunler
(
 UrunID int,
 UrunAdi nvarchar(40),
 Stok smallInt,
 Fiyat money

)

--Add all the products in the product table to the products table.

INSERT INTO Urunler
SELECT ProductID,ProductName,UnitsInStock,UnitPrice FROM Products



SELECT E.FirstName,E.LastName,E.TitleOfCourtesy,E.Title,E.HireDate,C.CompanyName,C.ContactName,C.Phone,P.ProductName,P.UnitsInStock,OD.Quantity,OD.UnitPrice,CA.CategoryName
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID=O.EmployeeID
INNER JOIN Customers AS C
ON C.CustomerID=O.CustomerID
INNER JOIN [Order Details] OD
ON O.OrderID=OD.OrderID
INNER JOIN Products P
ON OD.ProductID=P.ProductID
INNER JOIN Categories AS CA
ON CA.CategoryID=P.CategoryID


CREATE VIEW SatisRaporlari
AS
SELECT E.FirstName,E.LastName,E.TitleOfCourtesy,E.Title,E.HireDate,C.CompanyName,C.ContactName,C.Phone,P.ProductName,P.UnitsInStock,OD.Quantity,OD.UnitPrice,CA.CategoryName
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID=O.EmployeeID
INNER JOIN Customers AS C
ON C.CustomerID=O.CustomerID
INNER JOIN [Order Details] OD
ON O.OrderID=OD.OrderID
INNER JOIN Products P
ON OD.ProductID=P.ProductID
INNER JOIN Categories AS CA
ON CA.CategoryID=P.CategoryID


SELECT * FROM SatisRaporlari


SELECT FirstName,LastName FROM SatisRaporlari


--Create a view for categories. Have the CategoryName and description fields.


CREATE VIEW Kategoriler
AS
SELECT CategoryName,Description
FROM Categories

--Adding data via view

INSERT INTO Kategoriler VALUES ('Mercedes','Bir dünya markasıdır.')


SELECT * FROM Kategoriler


ALTER VIEW Kategoriler
AS
SELECT CategoryID,CategoryName,Description
FROM Categories

SELECT * FROM Kategoriler


DROP VIEW Kategoriler


--VIEW  With Check Option 

--Create a view called EmployeeInfo, get FirstName, LastName, Title, City from the (Employees) table.

CREATE VIEW CalisanBilgileri
AS
SELECT FirstName,LastName,Title,City
FROM Employees

ALTER VIEW CalisanBilgileri
AS
SELECT FirstName,LastName,Title,City
FROM Employees WHERE City='London'


SELECT *
FROM CalisanBilgileri

INSERT INTO CalisanBilgileri VALUES ('Hakan','Yılmaz','Kaldırım enginee','Uşak'


SELECT *
FROM CalisanBilgileri

ALTER VIEW CalisanBilgileri
AS
SELECT FirstName,LastName,Title,City
FROM Employees WHERE City='London'
WITH CHECK OPTION


INSERT INTO CalisanBilgileri
VALUES ('Hikmet','Menevşe','DBA','London')

SELECT *
FROM CalisanBilgileri

ALTER VIEW [dbo].[SatisRaporlari]
WITH Encryption
AS
SELECT        E.FirstName, E.LastName, E.TitleOfCourtesy, E.Title, E.HireDate, C.CompanyName, C.ContactName, C.Phone, P.ProductName, P.UnitsInStock, OD.Quantity, OD.UnitPrice, CA.CategoryName
FROM            dbo.Employees AS E INNER JOIN
                         dbo.Orders AS O ON E.EmployeeID = O.EmployeeID INNER JOIN
                         dbo.Customers AS C ON C.CustomerID = O.CustomerID INNER JOIN
                         dbo.[Order Details] AS OD ON O.OrderID = OD.OrderID INNER JOIN
                         dbo.Products AS P ON OD.ProductID = P.ProductID INNER JOIN
                         dbo.Categories AS CA ON CA.CategoryID = P.CategoryID



*/

CREATE FUNCTION KdvHesapla
(@fiyat MONEY)

RETURNS MONEY
        BEGIN
		  RETURN @fiyat*1.18
		END


SELECT  ProductName AS [Ürün Adı],CategoryName AS [Kategori],UnitPrice AS [Birim Fiyat],[dbo].[KdvHesapla](UnitPrice) AS [Kdv Fiyat]
FROM Products
INNER JOIN Categories 
ON Products.CategoryID=Categories.CategoryID


--Write a UDF that will calculate people's ages.

CREATE FUNCTION YasHesapla
(@dogumTarihi datetime)

RETURNS INT
   BEGIN

   DECLARE @yas INT

   SELECT @yas=DATEDIFF(YY,@dogumTarihi,GETDATE())

   RETURN @yas

   END
 

SELECT [dbo].[YasHesapla]('19911029') AS Yas


DROP FUNCTION YasHesapla


--Write a UDF that finds the sum of two external numbers.

CREATE FUNCTION Topla
(@Sayi1 int,@Sayi2 int)

RETURNS INT

  BEGIN

  RETURN @Sayi1+@Sayi2

  END


SELECT [dbo].[Topla](20,15)

--
Write a function that will calculate the product selling price.

alter  function fiyathesaplama
(@fiyat money,@adet int,@oran real)
returns money
begin
return (@fiyat*@adet)*(1-@oran)
end

select [dbo].[fiyathesaplama]([UnitPrice],[Quantity],[Discount])
from [dbo].[Order Details]



