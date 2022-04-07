--AGGREGATE FONS�YONLAR---

---TAR�H FONKS�YONLARI (DATEPART())---
--Datepart() Kullan�m�:Bir tarih bilgisinden istedi�imiz k�sm� elde etmemize yarar.

SELECT FirstName,LastName,DATEPART(YY,BirthDate) AS [Year]
FROM Employees--YIL B�LG�S�

SELECT FirstName,LastName,DATEPART(DY,BirthDate) AS [Day Of Year]
FROM Employees--YILIN KA�INCI G�N�

--Y�l�n ka��nc� ay�
SELECT FirstName,LastName,DATEPART(M,BirthDate) AS [Month Of Year] FROM Employees
--Y�l�n ka��nc� haftas�
SELECT FirstName,LastName,DATEPART(WK,BirthDate) WeekOfYear FROM Employees
SELECT FirstName,LastName,DATEPART(WW,BirthDate) WeekOfYear FROM Employees

--Haftan�n ka��nc� g�n�

SELECT FirstName,LastName,DATEPART(DW,BirthDate) [Day Of Week] FROM Employees
SELECT FirstName,LastName,DATEPART(W,BirthDate) WeekOfYear FROM Employees
--Saat Bilgisi
SELECT FirstName,LastName,DATEPART(HH,GETDATE()) Saat FROM Employees

SELECT FirstName,LastName,DATEPART(HOUR,BirthDate) Saat FROM Employees

--Dakika Bilgisi
SELECT FirstName,LastName,DATEPART(MI,GETDATE()) AS [MINUTE]
FROM Employees

--Saniye Bilgisi

SELECT FirstName,LastName,DATEPART(SS,GETDATE()) AS [MINUTE]
FROM Employees

--Salise Bilgisi
SELECT FirstName,LastName,DATEPART(MS,GETDATE()) AS [MINUTE]
FROM Employees

--DATEDIFF() Kullan�m�: �ki tarih aras�nda sonu�lana fark� verir.

SELECT (FirstName+' '+LastName) AS [�sim Soyisim],DATEDIFF(YEAR,BirthDate,GETDATE()) AS [Ya�]
FROM Employees

SELECT FirstName,DATEDIFF(HOUR,BirthDate,GETDATE()) AS [Ka� Saat Ge�mi�]
FROM Employees

--AGGREGATE FONKS�YONLARI--

--Toplam,Gruplamal� Fonksiyonlar�.

--COUNT(s�tun ad� veya * yaz�labilir.):Bir tablodaki kay�t say�s�n� ��renmek i�in kullan�l�r.

SELECT COUNT(*) FROM Employees

--Employee tablosunda ID'ye g�re kay�t say�s�n� getir.

select count(EMPLOYEEID) FROM Employees
select count(Region) FROM Employees
--2.de sonu� 9 de�il 5 ��k�yor ��nk� NULL  olanlar� saymaz.

select count(distinct city) from Employees

select sum(employeeid) from Employees

--�al��anlar�n ya�lar�n�n toplam�n� bulunuz.

select sum(datediff(year,birthdate,getdate())) from Employees

--AVG (S�tun Ad�) Bir s�tundaki de�erlerin ortalamas�n� verir.

SELECT AVG(EMPLOYEEID) FROM Employees

--�al��anlar�n ya�lar�n�n ortalamas�
select avg(datediff(year,birthdate,getdate())) from Employees

--MAX (s�tun Ad�) Bir s�tundaki en b�y�k de�eri verir.

SELECT MAX(EMPLOYEEID) FROM Employees
select max(firstname) from Employees
--**execute yerin F5 kullanabilirsin

--Ayn�s� MIN olarak da kullanabiliriz.

--*** CASE WHEN-THEN Kullan�m� ***** ---

select FirstName,LastName,
CASE(Country) 
when 'USA'
THEN 'Amerika Birle�ik Devletleri'
when 'UK'
THEN '�ngiltere Birle�ik Krall���'
end as �lke
from Employees

--** K��EL� PARANTES� KOLON �SM�N� DE���T�R�RKEN KULLANIYORUZ YOKSA '' OLUR ********

--�al��an�n employee ID de�eri 5'den b�y�k ise ID De�eri 5'den b�y�kt�r yazs�n, e�er �al��an�n employee ID de�eri 5'den k���k ise ID De�eri 5'ten k���kt�r yazs�n. Yukar�daki ki durumda do�ru de�ilse ID De�eri 5'e e�ittir olarak listeleyiniz.

select EmployeeID,FirstName,
CASE
WHEN EmployeeID>5
then 'ID de�eri 5''den b�y�kt�r'
when EmployeeID<5
then 'ID De�eri 5''ten k���kt�r'
when EmployeeID=5
then 'ID De�eri 5''e e�ittir'
end
from Employees



--iki �rne�in fark� case den sonra () . >< gibi i�aretler kullanacak ise () kullanm�yorum.



--CRUD--
--INSERT
--UPDATE
--DELETE=>Bir talodan kay�t silmek i�in kullanaca��m�z komuttur.Ayn� update i�lemi gibi dikkat edilmesi gerekir, ��nk� birden fazla kay�t YANLI�LIKLA S�L�NEB�L�R.

/*
 DELETE FROM <tablo_adi>

*/
SELECT * FROM Calisanlar

DELETE  FROM Calisanlar WHERE ID=5

--CREATE,ALTER,DROP
--INSERT,UPDATE,DELETE,SELECT 

--�al��anlar tablosundan ya�lar� 40,45 olan kay�tlar� siliniz.

DELETE FROM Calisanlar WHERE Yas IN (40,45)

DELETE FROM Calisanlar WHERE Yas=40 OR Yas=45

SELECT * FROM Calisanlar

---F�N�TO----


--CRUD ��LEMLER--
--INSERT - UPDATE - DELETE

--DELETE : Bir tabloda kay�t silmek i�in kullanaca��m�z komuttur. Ayn� Update i�lemi gibi dikkat edilmesi gerekir.��nk� birden fazla kay�t yanl��l�kla silinebilir.

/*

DELETE FROM <TABLO ADI> 
DELETE FROM Calisanlar yazarsam tablo kal�r ama i�indeki t�m verileri siler.*/

DELETE FROM Calisanlar WHERE ID=5

--CREATE, ALTER, DROP ��LEMLER�NDE WHERE YOKTUR;
--INSERT,UPDATE, DEELETE, SELECT ��LEMLER�NDE WHERE KOMUTU BULUNUR.

--�al��anlar tablosundan ya�lar� 40,45 olan �al��anlar� siliniz.

DELETE FROM Calisanlar WHERE Ya� IN (40,45)

DELETE FROM Calisanlar WHERE Ya�=40 OR YA�=45

--AGGREGATE FONKS�YONLAR---
--TAR�H FONKS�YONLARI =D ATEPART --

/* Datepart kullan�m�: Bir tarhi bilgisinden istedi�imiz k�sm� elde etmemize yarar.*/

select FirstName,LastName,DATEPART(YY,BirthDate) AS 'YEAR'
from Employees

SELECT FirstName,LastName,DATEPART(DY,BirthDate) AS [Day of Year]
FROM Employees = bu da bana y�l�n ka��nc� g�n� oldu�unu verir.

--YILIN KA�INCI AYI
SELECT FirstName,LastName,DATEPART(MM,BirthDate) AS [Month of Year]
FROM Employees

--y�l�n ka��nc� haftas�--
SELECT FirstName,LastName,datepart(WW,BirthDate) as'Week'
FROM Employees

--haftan�n ka��nc� g�n�--

SELECT FirstName,LastName,datepart(DW,BirthDate) as'Day'
FROM Employees

--saat bilgisi --

SELECT FirstName,LastName,datepart(HH,BirthDate) as'Hour'
FROM Employees 
--( HH yerine Hour yazabilirsin)-

SELECT FirstName,LastName,datepart(HH,getdate()) as'Hour'
FROM Employees

--DAK�KA B�LG�S�--

SELECT FirstName,LastName,datepart(MI,getdate()) as'Minute'
FROM Employees

--Saniye Bilgisi--

SELECT FirstName,LastName,datepart(SS,getdate()) as'Second'
FROM Employees

--Salise Bilgisi--

SELECT FirstName,LastName,datepart(ms,getdate()) as'MSecond'
FROM Employees

-- *** job konusunu ara�t�r: �u saatler aras�nda �u,�u,�u i�lemler olsun istiyorum i�in kullan�l�r. SQL �cretli versiyonunda kullan�l�r***--
--**Otomatik mail atmay� da ara�t�r***---

--DATEDIFF KULLANIMI**--

--2 tarih aras�nda sonu�lanan fark� verir. Ya� hesaplama gibi i�elmler i�in kullan�l�r.FORM�LDE �IKARTMADAN FARKLI OLARAK SIRALAMA TERS YAZILIR--

SELECT (FirstName+' '+LastName) AS [ �S�M SOY�S�M], DATEDIFF(YEAR,BirthDate,GETDATE()) AS [YA�]
FROM Employees
--***PEMBE OLANLAR FONKS�YONDUR. FONKS�YONLARDA PARANTEZ KULLANMAN GEREK�R ****---

SELECT FirstName,DATEDIFF(HOUR,BirthDate,GETDATE()) AS 'SAAT'
FROM Employees

--**MM,WW gibi kodlar� internetten bulabilmen laz�m**--

--STRINCT FONKS�YONLAR--

SELECT 5+4 AS TOPLAM,5-9 AS FARK,5*9 AS �ARPAN,5/3 AS B�L�M,5%2 AS MOD

SELECT 'SQL GRUBU-SQL-SQL SERVER E��T�M�' AS MESAJ

PRINT 'SQL GRUBU-SQL-SQL SERVER E��T�M�'

SELECT ASCII('A') AS [ASCII KODU]
--**ASCII KODU MAK�NE D�L� DEMEKT�R. MAK�NE D�L�NDE A, 65 T�R.--

SELECT CHAR(65) AS[KARAKTER]
--**CHAR TEK KARAKTER DEMEK. BURADA DA MAK�NE D�L�N� ALIP YAZI D�L�NE �EV�R�R.--

SELECT CHARINDEX('@','alpay.grurel@bilgeadam.com') AS KONUM
--Aratmak istedi�imzxi karakteleri veya metnin buluundu�u yeri verir e�er bulmaz ise geriye 0 cevab�n� d�nd�r�r.

SELECT LEFT('Bilge Adam',4) as [Soldan Karakter Say�s�]
select right ('Bilge Adam',6) as [Sa�dan Karakter Say�s�]
select LEN('Bilge Adam') as [Karakter Say�s�]
select LOWER('B�LGE AdaM') as [Hepsi K���k]
select UPPER('bilge AdaM') as [Hepsi K���k]
select LTRIM('                    Bilge Adeam') as [soldak� bo�luklar� siler]
select RTRIM('       Bilge Adam           ') as [sa�dak� bo�luklar� siler]
select TRIM('       Bilge Adam           ') as [bo�luklar� siler]
select LTRIM(RTRIM('              Bilge Adam            ')) as [ikinci y�ntem]
SELECT REPLACE ('Birbirbirbirlerine','bir','��') as [Metinlerin yerlerine yenilerini atar]
--** parantez i�indeki metnin i�indeki birleri �� ile de�i�tir demi� oldum.
select SUBSTRING('Bilge Adam Town Center Bili�im Akademisi',4,6) as "Alt Stringleri olu�turur"
select REVERSE('Bilge Adam TOWN CENTER') AS "Tersine �evir"
select 'Bilge Adam'+SPACE(30)+'TOWN CENTER' AS [Belirtilen miktar kadar bo�luk b�rak�r]
select REPLICATE('Bilge',5) AS [Belirtilen metni belirtilen adet kadar �o�alt�r]


--AGGREGATE FONKS�YONLAR--(Toplam Fonsiyonlar�,Gruplamal� Fonksiyonlar�)

--COUNT(s�t�n ad� | *):Bir tablodaki kay�t say�s�n� ��renmek i�in kullan�l�r.

SELECT COUNT(FirstName) FROM Employees

--Employees tablosunda idye g�re kay�t say�n�s� getirmenizi.

SELECT COUNT(EmployeeID) FROM Employees

SELECT COUNT(Region) FROM Employees--Region s�tunundaki kay�t say�s� (Region s�tunu null ge�ilebilece�i i�in bir tablodaki kay�t says�n� bu s�tundan yola ��karak ��renmek yanl�� sonu�lar olu�turablir.��nk� aggragete fonksiyonlar� NULL de�er i�eren kay�tlar� dikkate almaz.Bu nedenle kay�t say�s�n� ��renebilmek i�in ya * karakterini ya da NULL de�er ge�ilemeyen s�tunlardan birisinin ad�n� kullanmam�z gerekir)

SELECT City FROM Employees

SELECT COUNT(City) FROM Employees


SELECT COUNT(DISTINCT City) FROM Employees

SELECT SUM(EmployeeID) FROM Employees

SELECT EmployeeID FROM Employees

--�al��anlar�n ya�lar�n�n toplam�n� bulunuz.

select sum(datediff(year,BirthDate,Getdate())) from Employees

--AVG(S�t�n Adi)=>Bir s�tundaki de�elerin ortalamas�n� verir.

SELECT AVG(EmployeeID) FROM Employees

--�al��anlar�n ya�lar�n�n ortalamas� 

select avg(datediff(year,BirthDate,Getdate())) from Employees


SELECT AVG(LastName) FROM Employees

--MAX(S�t�n Ad�):Bir s�t�ndaki en b�y�k de�eri verir.

SELECT MAX(EmployeeID) FROM Employees
	
SELECT MAX(FirstName) FROM Employees

SELECT MIN(EmployeeID) FROM Employees

SELECT MIN(FirstName) FROM Employees




--CASE WHEN -THEN Kullami

SELECT FirstName,LastName,
CASE(Country)
 WHEN 'USA'
 THEN 'Amerika Birle�ik Devletleri'
 WHEN 'UK'
 THEN '�ngiltere Birle�ik Krall���'
 END AS Ulke
FROM Employees


--�al��an�n EmployeeID de�eri 5den b�y�k ise 'Id de�eri 5''ten b�y�kt�r'
--�al��an�n EmployeeID de�eri 5den k���k ise 'Id de�eri 5'ten k���kt�r'
--Yukar� da ki iki durumda do�ru de�ilse 'Id de�eri 5'e e�ittir' olarak listeleyiniz

SELECT EmployeeID,FirstName,

CASE 
  WHEN EmployeeID>5
   THEN 'Id de�eri 5''ten b�y�kt�r'
  WHEN EmployeeID<5
   THEN 'Id de�eri 5''ten k���kt�r'
  ELSE 'Id de�eri 5''e e�ittir'
   END AS Durum
FROM Employees

--GROUP BY---

--Sadece gruplamak i�in kullan�l�r.
--�al��anlar�n �lkelerine g�re gruplanmas�

SELECT Country AS �lke, Count(*) as [Ki�i Say�s�]
FROM Employees
WHERE Country IS NOT NULL
GROUP BY Country

--�al��anlar�n yapm�� oldu�u sipari� adedi.

SELECT EmployeeID AS �al��an,Count(*) as [Sipari� Say�s�]
FROM Orders
Group by EmployeeID
Order by [Sipari� Say�s�] desc

--**group by son olur ama order by en altta yine

--�r�n bedeli 35 Dolardan az olan �r�nlerin kategorilerine g�re gruplanmas�

SELECT CategoryID AS Kategoriler,Count(*) AS Adet
FROM Products
WHERE UnitPrice<35
GROUP BY CategoryID
Order by Adet

--Ba� harfi A-K aral���nda olan ve stok miktar� 5-50 aras�nda olan �r�nleri kategorilerine g�re gruplay�n�z

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

--Her bir sipari�teki toplam �r�n say�s�n� bulunuz.

SELECT OrderID, SUM(Quantity)AS Adet
FROM [Order Details]
GROUP BY OrderID
ORDER BY Adet DESC

--HAVING--

--Sorgu sonucu gelen sonu� k�mesi �zerinde �nemli aggregate fonksiyonlar�na ba�l� olacak �ekilde bir filtreleme i�lemi yapacaksak WHERE yerine HAVING kullan�l�r. Bu sayede Aggregate fonksiyonlar�n� da filtreleme i�lemlerine katabiliriz. E�er Aggregate fonksiyonlar�n� sorgumuzda yoksa HAVING kullan�m� WHERE ile ayn� filtreleme i�lemi yapacakt�r.

--Her bir sipari�teki toplam �r�n say�s� 200'den az olanlar

SELECT OrderID,sum(quantity) AS ADET
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity)<200
ORDER BY ADET desc

SELECT OrderID,sum(quantity) AS ADET
FROM [Order Details]
WHERE ProductID=1
GROUP BY OrderID
HAVING SUM(QUANTITY)<200
ORDER BY ADET

--**bu da sonu� verir. having ve where birlikte kullan�l�r. Having aggregate fonksiyon �artlar� i�in kullan�l�r.


--�� ��E SORGULAR--

--USE Northwind : Nortwind DB kullan�cam demek

--DECLARE = De�i�ken anlam�na gelir. ��erisinde veri tutuma ve veriyi getirme i�lemi yap�l�r. Declare'e isimlendirme yap�laca�� zaman kesinlikle @ i�areti konulmas� gerekir. Veri tipini de tan�mlamam�z gerekir.

DECLARE @MaxFiyat MONEY=(SELECT MAX(UnitPrice) FROM Products)

SELECT*FROM Products WHERE UnitPrice=@MaxFiyat



--Fiyat� ortalama fiyat�n �st�nde olan �r�nleri listeleyiniz.

DECLARE @AvgFiyat MONEY=(Select avg(UnitPrice) FROM Products)

SELECT * FROM Products WHERE UnitPrice>@AvgFiyat

--2.yol
select *
from Products
where UnitPrice>(select avg(unitprice) from products)

--�r�nler tablosundaki sat�lan �r�nlerin listesi

SELECT *
FROM Products

SELECT *
FROM [Order Details]

--*BAKIYORUM �K�S�NE VE ORTAK BA�LIK PRODUCTID.

SELECT *
FROM Products
WHERE ProductID IN (SELECT ProductID from [Order Details])

--�r�nler tablosundaki sat�lmayan �r�nlerin listesi
SELECT *
FROM Products
WHERE ProductID NOT IN (SELECT ProductID from [Order Details])

SELECT 
p.ProductName,
p.UnitPrice,
p.UnitsInStock,
(SELECT CategoryName FROM Categories AS C WHERE C.CategoryID=P.CategoryID)
FROM Products AS P

--Bu bir SUBQUERY i�lemidir.

--EX�STS--

--��erisinde anlam� ta��r.

--Sat�� alan �al��anlar.

SELECT *
FROM Employees e1
WHERE EXISTS(SELECT EmployeeID FROM Orders e2 WHERE e1.EmployeeID=e2.EmployeeID) 
--**Buradan hangi �al��anlar�n sat��� vard�r sorusunun cevab�n� vermi� oluyor.

--NOTEXISTS--

--sipari� alamayan �al��anlar�m
SELECT *
FROM Employees e1
WHERE not EXISTS(SELECT EmployeeID FROM Orders e2 WHERE e1.EmployeeID=e2.EmployeeID) 

--IN yaz�lan SUBQUERY den d�nen t�m kay�tlar i�inde e�leme yap�ld�ktan sonra ana query'nin �al��mas�n� tamamlar.

--exits ise subquery yi e�leme yap�lan kay�tlara g�re sonu�land�r�r ve ilave olarak gelen kay�tlar i�inde e�leme yapmaya gerek kalmaz. Exists zaten subqueryden ihtiyac� olan kay�tlar� getirmi� olacakt�r.

--NOT: IN'ler EXISTS'lerden performans olarak daha k�t� �al���rlar.

SELECT *
FROM Employees e1
where EmployeeID IN(SELECT EmployeeID FROM Orders)

SELECT *
FROM Employees e1
WHERE EXISTS(SELECT EmployeeID FROM Orders e2 WHERE e1.EmployeeID=e2.EmployeeID) 

--** �K�S� DE AYNI AMA �LK�NDE 3 SORGU YAPARKEN �K�NC�S�NDE TEK SORGUDA YAPMASINI SA�LIYORUZ. BU Y�ZDEN PERFORMANSI DAHA �Y�. ** IN YAVA� DE��L AMA SUBQUERY �LE KULLANILIRSA PERFORMANS OLARAK YAVA� KALIR, DAHA YAVA� SONU� VER�R.

--JOIN ��LEMLER�--

--1.Inner Join: Bir tablodaki her bir kayd�n di�er bir tabloda bir kar��l��� olan kay�tlar listelenir. Inner join ifadesini yazarken inner ifadesini yazmasak da sadece join yazsak bile bu yine inner join olarak i�leme al�n�r.ON ile beraber kullan�l�r.

SELECT *
FROM Products INNER JOIN Categories ON Products. CategoryID=Categories.CategoryID

SELECT ProductName,Categories.CategoryID
FROM Products INNER JOIN Categories ON Products. CategoryID=Categories.CategoryID

--**�K�NC�S�NDE BAZI KOLONLARI ALDIM

--Product tablosundan ProductID,ProductName,CategoriID ile Categories tablosundaki CategoriName, Descripton verecek �ekilde birle�tiriniz.

SELECT ProductID,ProductName,Products.CategoryID,CategoryName,Description
FROM Products INNER JOIN Categories ON Products. CategoryID=Categories.CategoryID

--Hangi sipari� hangi �al��an taraf�ndan hangi m��teriye yap�lm��.

select*
from orders

select *
from Customers

select*
from Employees

select OrderID AS [Sipari� ID],OrderDate AS [Sipari� Tarihi],CompanyName AS [�irket Ad�], ContactName as [Yetkili Ki�i],(FirstName+' '+LastName) as [�al��an], Title as [G�rev]
from Orders INNER JOIN Employees ON Orders.EmployeeID=Employees.EmployeeID
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID



































































