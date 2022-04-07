
SELECT FirstName,LastName,DATEPART(DW,BirthDate) [Day Of Week] FROM Employees

SELECT FirstName,LastName,DATEPART(W,BirthDate) WeekOfYear FROM Employees

SELECT FirstName,LastName,DATEPART(HH,GETDATE()) Saat FROM Employees

SELECT FirstName,LastName,DATEPART(HOUR,BirthDate) Saat FROM Employees

SELECT FirstName,LastName,DATEPART(MI,GETDATE()) AS [MINUTE]
FROM Employees

SELECT FirstName,LastName,DATEPART(SS,GETDATE()) AS [MINUTE]
FROM Employees

SELECT FirstName,LastName,DATEPART(MS,GETDATE()) AS [MINUTE]
FROM Employees

SELECT (FirstName+' '+LastName) AS [İsim Soyisim],DATEDIFF(YEAR,BirthDate,GETDATE()) AS [Yaş]
FROM Employees

SELECT FirstName,DATEDIFF(HOUR,BirthDate,GETDATE()) AS [Kaç Saat Geçmiş]
FROM Employees


SELECT COUNT(*) FROM Employees

select count(EMPLOYEEID) FROM Employees
select count(Region) FROM Employees
select count(distinct city) from Employees

select sum(employeeid) from Employees


select sum(datediff(year,birthdate,getdate())) from Employees


SELECT AVG(EMPLOYEEID) FROM Employees

select avg(datediff(year,birthdate,getdate())) from Employees


SELECT MAX(EMPLOYEEID) FROM Employees
select max(firstname) from Employees

--*** CASE WHEN-THEN  ***** ---

select FirstName,LastName,
CASE(Country) 
when 'USA'
THEN 'Amerika Birleşik Devletleri'
when 'UK'
THEN 'İngiltere Birleşik Krallığı'
end as Ülke
from Employees

select EmployeeID,FirstName,
CASE
WHEN EmployeeID>5
then 'ID değeri 5''den büyüktür'
when EmployeeID<5
then 'ID Değeri 5''ten küçüktür'
when EmployeeID=5
then 'ID Değeri 5''e eşittir'
end
from Employees


--CRUD--
--INSERT
--UPDATE
--DELETE

SELECT * FROM Calisanlar

DELETE  FROM Calisanlar WHERE ID=5

--CREATE,ALTER,DROP
--INSERT,UPDATE,DELETE,SELECT 


DELETE FROM Calisanlar WHERE Yas IN (40,45)

DELETE FROM Calisanlar WHERE Yas=40 OR Yas=45

SELECT * FROM Calisanlar


--INSERT - UPDATE - DELETE

DELETE FROM Calisanlar WHERE ID=5


DELETE FROM Calisanlar WHERE Yaş IN (40,45)

DELETE FROM Calisanlar WHERE Yaş=40 OR YAŞ=45


--STRINCT FUNCTIONS--

SELECT 5+4 AS TOPLAM,5-9 AS FARK,5*9 AS ÇARPAN,5/3 AS BÖLÜM,5%2 AS MOD

SELECT ASCII('A') AS [ASCII KODU]

SELECT CHAR(65) AS[KARAKTER]

SELECT CHARINDEX('@','alpay.grurel@bilgeadam.com') AS KONUM

SELECT LEFT('Bilge Adam',4) as [Soldan Karakter Sayısı]
select right ('Bilge Adam',6) as [Sağdan Karakter Sayısı]
select LEN('Bilge Adam') as [Karakter Sayısı]
select LOWER('BİLGE AdaM') as [Hepsi Küçük]
select UPPER('bilge AdaM') as [Hepsi Küçük]


SELECT COUNT(FirstName) FROM Employees

SELECT COUNT(EmployeeID) FROM Employees

SELECT COUNT(Region) FROM Employees

SELECT City FROM Employees

SELECT COUNT(City) FROM Employees

SELECT COUNT(DISTINCT City) FROM Employees

SELECT SUM(EmployeeID) FROM Employees

SELECT EmployeeID FROM Employees


SELECT sum(datediff(year,BirthDate,Getdate())) from Employees

SELECT AVG(EmployeeID) FROM Employees

select avg(datediff(year,BirthDate,Getdate())) from Employees


SELECT AVG(LastName) FROM Employees

SELECT MAX(EmployeeID) FROM Employees
	
SELECT MAX(FirstName) FROM Employees

SELECT MIN(EmployeeID) FROM Employees

SELECT MIN(FirstName) FROM Employees

--CASE WHEN -THEN --

SELECT FirstName,LastName,
CASE(Country)
 WHEN 'USA'
 THEN 'Amerika Birleşik Devletleri'
 WHEN 'UK'
 THEN 'İngiltere Birleşik Krallığı'
 END AS Ulke
FROM Employees


--employees EmployeeID if higher than 5 'Id is higher than 5'
--employees EmployeeID if lower than 5 'Id is lower than 5'
--if not both abow , 'Id is lower than 5' 

SELECT EmployeeID,FirstName,

CASE 
  WHEN EmployeeID>5
   THEN 'Id is higher than 5'
  WHEN EmployeeID<5
   THEN 'Id is lower than 5'
  ELSE 'Id is equal to 5'
   END AS Durum
FROM Employees

--GROUP BY---

--group employees by country--

SELECT Country AS Ülke, Count(*) as [Number of employees]
FROM Employees
WHERE Country IS NOT NULL
GROUP BY Country

--The number of orders made by the employees.

SELECT EmployeeID AS Employee,Count(*) as [Number of orders]
FROM Orders
Group by EmployeeID
Order by [Number of Orders] desc


--Grouping of products with a product price of less than 35 dollars according to their categories

SELECT CategoryID AS Kategoriler,Count(*) AS Adet
FROM Products
WHERE UnitPrice<35
GROUP BY CategoryID
Order by Adet

--Group the products whose initials are in the range of A-K and whose stock amount is between 5-50, according to their categories.

SELECT CategoryID as Kategoriler, Count(*) As Adet
FROM Products
WHERE 
(ProductName LIKE '[A-K]%')
AND
(UnitsInStock BETWEEN 5 AND 50)
GROUP BY CategoryID
ORDER BY Adet desc

SELECT Productname,CategoryID as Kategoriler, Count(*) As Adet
FROM Products
WHERE 
(ProductName LIKE '[A-K]%')
AND
(UnitsInStock BETWEEN 5 AND 50)
GROUP BY ProductName,CategoryID
ORDER BY Adet desc

--Find the total number of items in each order.

SELECT OrderID, SUM(Quantity)AS Adet
FROM [Order Details]
GROUP BY OrderID
ORDER BY Adet DESC

--HAVING--

--The total number of products in each order is less than 200

SELECT OrderID,sum(quantity) AS ADET
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity)<200
ORDER BY ADET desc

OR

SELECT OrderID,sum(quantity) AS ADET
FROM [Order Details]
WHERE ProductID=1
GROUP BY OrderID
HAVING SUM(QUANTITY)<200
ORDER BY ADET



--Nested Queries--

DECLARE @MaxFiyat MONEY=(SELECT MAX(UnitPrice) FROM Products)

SELECT*FROM Products WHERE UnitPrice=@MaxFiyat



--List the products whose price is above the average price.

DECLARE @AvgFiyat MONEY=(Select avg(UnitPrice) FROM Products)

SELECT * FROM Products WHERE UnitPrice>@AvgFiyat

--2.way
Select *
from Products
Where UnitPrice>(select avg(unitprice) from products)

--List of products sold in the Products table

SELECT *
FROM Products

SELECT *
FROM [Order Details]


SELECT *
FROM Products
WHERE ProductID IN (SELECT ProductID from [Order Details])

--List of unsold products in the products table
SELECT *
FROM Products
WHERE ProductID NOT IN (SELECT ProductID from [Order Details])

SELECT 
p.ProductName,
p.UnitPrice,
p.UnitsInStock,
(SELECT CategoryName FROM Categories AS C WHERE C.CategoryID=P.CategoryID)
FROM Products AS P


SELECT *
FROM Employees e1
WHERE EXISTS(SELECT EmployeeID FROM Orders e2 WHERE e1.EmployeeID=e2.EmployeeID) 

--NOTEXISTS--

-- employees who didn't take orders
SELECT *
FROM Employees e1
WHERE not EXISTS(SELECT EmployeeID FROM Orders e2 WHERE e1.EmployeeID=e2.EmployeeID) 

SELECT *
FROM Employees e1
where EmployeeID IN(SELECT EmployeeID FROM Orders)

SELECT *
FROM Employees e1
WHERE EXISTS(SELECT EmployeeID FROM Orders e2 WHERE e1.EmployeeID=e2.EmployeeID) 

--JOIN --

FROM Products INNER JOIN Categories ON Products. CategoryID=Categories.CategoryID

SELECT ProductName,Categories.CategoryID
FROM Products INNER JOIN Categories ON Products. CategoryID=Categories.CategoryID


--Select ProductID,ProductName,CategoriID,CategoriName, Descripton in one table

SELECT ProductID,ProductName,Products.CategoryID,CategoryName,Description
FROM Products INNER JOIN Categories ON Products. CategoryID=Categories.CategoryID

--Which order was made by which employee to which customer.

select*
from orders

select *
from Customers

select*
from Employees

Select OrderID AS [Sipariş ID],OrderDate AS [Sipariş Tarihi],CompanyName AS [Şirket Adı], ContactName as [Yetkili Kişi],(FirstName+' '+LastName) as [Çalışan], Title as [Görev]
from Orders INNER JOIN Employees ON Orders.EmployeeID=Employees.EmployeeID
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID
