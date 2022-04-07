--AGGREGATE FONSÝYONLAR---

---TARÝH FONKSÝYONLARI (DATEPART())---
--Datepart() Kullanýmý:Bir tarih bilgisinden istediðimiz kýsmý elde etmemize yarar.

SELECT FirstName,LastName,DATEPART(YY,BirthDate) AS [Year]
FROM Employees--YIL BÝLGÝSÝ

SELECT FirstName,LastName,DATEPART(DY,BirthDate) AS [Day Of Year]
FROM Employees--YILIN KAÇINCI GÜNÜ

--Yýlýn kaçýncý ayý
SELECT FirstName,LastName,DATEPART(M,BirthDate) AS [Month Of Year] FROM Employees
--Yýlýn kaçýncý haftasý
SELECT FirstName,LastName,DATEPART(WK,BirthDate) WeekOfYear FROM Employees
SELECT FirstName,LastName,DATEPART(WW,BirthDate) WeekOfYear FROM Employees

--Haftanýn kaçýncý günü

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

--DATEDIFF() Kullanýmý: Ýki tarih arasýnda sonuçlana farký verir.

SELECT (FirstName+' '+LastName) AS [Ýsim Soyisim],DATEDIFF(YEAR,BirthDate,GETDATE()) AS [Yaþ]
FROM Employees

SELECT FirstName,DATEDIFF(HOUR,BirthDate,GETDATE()) AS [Kaç Saat Geçmiþ]
FROM Employees

--AGGREGATE FONKSÝYONLARI--

--Toplam,Gruplamalý Fonksiyonlarý.

--COUNT(sütun adý veya * yazýlabilir.):Bir tablodaki kayýt sayýsýný öðrenmek için kullanýlýr.

SELECT COUNT(*) FROM Employees

--Employee tablosunda ID'ye göre kayýt sayýsýný getir.

select count(EMPLOYEEID) FROM Employees
select count(Region) FROM Employees
--2.de sonuç 9 deðil 5 çýkýyor çünkü NULL  olanlarý saymaz.

select count(distinct city) from Employees

select sum(employeeid) from Employees

--Çalýþanlarýn yaþlarýnýn toplamýný bulunuz.

select sum(datediff(year,birthdate,getdate())) from Employees

--AVG (Sütun Adý) Bir sütundaki deðerlerin ortalamasýný verir.

SELECT AVG(EMPLOYEEID) FROM Employees

--Çalýþanlarýn yaþlarýnýn ortalamasý
select avg(datediff(year,birthdate,getdate())) from Employees

--MAX (sütun Adý) Bir sütundaki en büyük deðeri verir.

SELECT MAX(EMPLOYEEID) FROM Employees
select max(firstname) from Employees
--**execute yerin F5 kullanabilirsin

--Aynýsý MIN olarak da kullanabiliriz.

--*** CASE WHEN-THEN Kullanýmý ***** ---

select FirstName,LastName,
CASE(Country) 
when 'USA'
THEN 'Amerika Birleþik Devletleri'
when 'UK'
THEN 'Ýngiltere Birleþik Krallýðý'
end as Ülke
from Employees

--** KÖÞELÝ PARANTESÝ KOLON ÝSMÝNÝ DEÐÝÞTÝRÝRKEN KULLANIYORUZ YOKSA '' OLUR ********

--Çalýþanýn employee ID deðeri 5'den büyük ise ID Deðeri 5'den büyüktür yazsýn, eðer çalýþanýn employee ID deðeri 5'den küçük ise ID Deðeri 5'ten küçüktür yazsýn. Yukarýdaki ki durumda doðru deðilse ID Deðeri 5'e eþittir olarak listeleyiniz.

select EmployeeID,FirstName,
CASE
WHEN EmployeeID>5
then 'ID deðeri 5''den büyüktür'
when EmployeeID<5
then 'ID Deðeri 5''ten küçüktür'
when EmployeeID=5
then 'ID Deðeri 5''e eþittir'
end
from Employees



--iki örneðin farký case den sonra () . >< gibi iþaretler kullanacak ise () kullanmýyorum.



--CRUD--
--INSERT
--UPDATE
--DELETE=>Bir talodan kayýt silmek için kullanacaðýmýz komuttur.Ayný update iþlemi gibi dikkat edilmesi gerekir, çünkü birden fazla kayýt YANLIÞLIKLA SÝLÝNEBÝLÝR.

/*
 DELETE FROM <tablo_adi>

*/
SELECT * FROM Calisanlar

DELETE  FROM Calisanlar WHERE ID=5

--CREATE,ALTER,DROP
--INSERT,UPDATE,DELETE,SELECT 

--Çalýþanlar tablosundan yaþlarý 40,45 olan kayýtlarý siliniz.

DELETE FROM Calisanlar WHERE Yas IN (40,45)

DELETE FROM Calisanlar WHERE Yas=40 OR Yas=45

SELECT * FROM Calisanlar

---FÝNÝTO----


--CRUD ÝÞLEMLER--
--INSERT - UPDATE - DELETE

--DELETE : Bir tabloda kayýt silmek için kullanacaðýmýz komuttur. Ayný Update iþlemi gibi dikkat edilmesi gerekir.Çünkü birden fazla kayýt yanlýþlýkla silinebilir.

/*

DELETE FROM <TABLO ADI> 
DELETE FROM Calisanlar yazarsam tablo kalýr ama içindeki tüm verileri siler.*/

DELETE FROM Calisanlar WHERE ID=5

--CREATE, ALTER, DROP ÝÞLEMLERÝNDE WHERE YOKTUR;
--INSERT,UPDATE, DEELETE, SELECT ÝÞLEMLERÝNDE WHERE KOMUTU BULUNUR.

--Çalýþanlar tablosundan yaþlarý 40,45 olan çalýþanlarý siliniz.

DELETE FROM Calisanlar WHERE Yaþ IN (40,45)

DELETE FROM Calisanlar WHERE Yaþ=40 OR YAÞ=45

--AGGREGATE FONKSÝYONLAR---
--TARÝH FONKSÝYONLARI =D ATEPART --

/* Datepart kullanýmý: Bir tarhi bilgisinden istediðimiz kýsmý elde etmemize yarar.*/

select FirstName,LastName,DATEPART(YY,BirthDate) AS 'YEAR'
from Employees

SELECT FirstName,LastName,DATEPART(DY,BirthDate) AS [Day of Year]
FROM Employees = bu da bana yýlýn kaçýncý günü olduðunu verir.

--YILIN KAÇINCI AYI
SELECT FirstName,LastName,DATEPART(MM,BirthDate) AS [Month of Year]
FROM Employees

--yýlýn kaçýncý haftasý--
SELECT FirstName,LastName,datepart(WW,BirthDate) as'Week'
FROM Employees

--haftanýn kaçýncý günü--

SELECT FirstName,LastName,datepart(DW,BirthDate) as'Day'
FROM Employees

--saat bilgisi --

SELECT FirstName,LastName,datepart(HH,BirthDate) as'Hour'
FROM Employees 
--( HH yerine Hour yazabilirsin)-

SELECT FirstName,LastName,datepart(HH,getdate()) as'Hour'
FROM Employees

--DAKÝKA BÝLGÝSÝ--

SELECT FirstName,LastName,datepart(MI,getdate()) as'Minute'
FROM Employees

--Saniye Bilgisi--

SELECT FirstName,LastName,datepart(SS,getdate()) as'Second'
FROM Employees

--Salise Bilgisi--

SELECT FirstName,LastName,datepart(ms,getdate()) as'MSecond'
FROM Employees

-- *** job konusunu araþtýr: þu saatler arasýnda þu,þu,þu iþlemler olsun istiyorum için kullanýlýr. SQL ücretli versiyonunda kullanýlýr***--
--**Otomatik mail atmayý da araþtýr***---

--DATEDIFF KULLANIMI**--

--2 tarih arasýnda sonuçlanan farký verir. Yaþ hesaplama gibi iþelmler için kullanýlýr.FORMÜLDE ÇIKARTMADAN FARKLI OLARAK SIRALAMA TERS YAZILIR--

SELECT (FirstName+' '+LastName) AS [ ÝSÝM SOYÝSÝM], DATEDIFF(YEAR,BirthDate,GETDATE()) AS [YAÞ]
FROM Employees
--***PEMBE OLANLAR FONKSÝYONDUR. FONKSÝYONLARDA PARANTEZ KULLANMAN GEREKÝR ****---

SELECT FirstName,DATEDIFF(HOUR,BirthDate,GETDATE()) AS 'SAAT'
FROM Employees

--**MM,WW gibi kodlarý internetten bulabilmen lazým**--

--STRINCT FONKSÝYONLAR--

SELECT 5+4 AS TOPLAM,5-9 AS FARK,5*9 AS ÇARPAN,5/3 AS BÖLÜM,5%2 AS MOD

SELECT 'SQL GRUBU-SQL-SQL SERVER EÐÝTÝMÝ' AS MESAJ

PRINT 'SQL GRUBU-SQL-SQL SERVER EÐÝTÝMÝ'

SELECT ASCII('A') AS [ASCII KODU]
--**ASCII KODU MAKÝNE DÝLÝ DEMEKTÝR. MAKÝNE DÝLÝNDE A, 65 TÝR.--

SELECT CHAR(65) AS[KARAKTER]
--**CHAR TEK KARAKTER DEMEK. BURADA DA MAKÝNE DÝLÝNÝ ALIP YAZI DÝLÝNE ÇEVÝRÝR.--

SELECT CHARINDEX('@','alpay.grurel@bilgeadam.com') AS KONUM
--Aratmak istediðimzxi karakteleri veya metnin buluunduðu yeri verir eðer bulmaz ise geriye 0 cevabýný döndürür.

SELECT LEFT('Bilge Adam',4) as [Soldan Karakter Sayýsý]
select right ('Bilge Adam',6) as [Saðdan Karakter Sayýsý]
select LEN('Bilge Adam') as [Karakter Sayýsý]
select LOWER('BÝLGE AdaM') as [Hepsi Küçük]
select UPPER('bilge AdaM') as [Hepsi Küçük]
select LTRIM('                    Bilge Adeam') as [soldaký boþluklarý siler]
select RTRIM('       Bilge Adam           ') as [saðdaký boþluklarý siler]
select TRIM('       Bilge Adam           ') as [boþluklarý siler]
select LTRIM(RTRIM('              Bilge Adam            ')) as [ikinci yöntem]
SELECT REPLACE ('Birbirbirbirlerine','bir','üç') as [Metinlerin yerlerine yenilerini atar]
--** parantez içindeki metnin içindeki birleri üç ile deðiþtir demiþ oldum.
select SUBSTRING('Bilge Adam Town Center Biliþim Akademisi',4,6) as "Alt Stringleri oluþturur"
select REVERSE('Bilge Adam TOWN CENTER') AS "Tersine Çevir"
select 'Bilge Adam'+SPACE(30)+'TOWN CENTER' AS [Belirtilen miktar kadar boþluk býrakýr]
select REPLICATE('Bilge',5) AS [Belirtilen metni belirtilen adet kadar çoðaltýr]


--AGGREGATE FONKSÝYONLAR--(Toplam Fonsiyonlarý,Gruplamalý Fonksiyonlarý)

--COUNT(sütün adý | *):Bir tablodaki kayýt sayýsýný öðrenmek için kullanýlýr.

SELECT COUNT(FirstName) FROM Employees

--Employees tablosunda idye göre kayýt sayýnýsý getirmenizi.

SELECT COUNT(EmployeeID) FROM Employees

SELECT COUNT(Region) FROM Employees--Region sütunundaki kayýt sayýsý (Region sütunu null geçilebileceði için bir tablodaki kayýt saysýný bu sütundan yola çýkarak öðrenmek yanlýþ sonuçlar oluþturablir.Çünkü aggragete fonksiyonlarý NULL deðer içeren kayýtlarý dikkate almaz.Bu nedenle kayýt sayýsýný öðrenebilmek için ya * karakterini ya da NULL deðer geçilemeyen sütunlardan birisinin adýný kullanmamýz gerekir)

SELECT City FROM Employees

SELECT COUNT(City) FROM Employees


SELECT COUNT(DISTINCT City) FROM Employees

SELECT SUM(EmployeeID) FROM Employees

SELECT EmployeeID FROM Employees

--Çalýþanlarýn yaþlarýnýn toplamýný bulunuz.

select sum(datediff(year,BirthDate,Getdate())) from Employees

--AVG(Sütün Adi)=>Bir sütundaki deðelerin ortalamasýný verir.

SELECT AVG(EmployeeID) FROM Employees

--Çalýþanlarýn yaþlarýnýn ortalamasý 

select avg(datediff(year,BirthDate,Getdate())) from Employees


SELECT AVG(LastName) FROM Employees

--MAX(Sütün Adý):Bir sütündaki en büyük deðeri verir.

SELECT MAX(EmployeeID) FROM Employees
	
SELECT MAX(FirstName) FROM Employees

SELECT MIN(EmployeeID) FROM Employees

SELECT MIN(FirstName) FROM Employees




--CASE WHEN -THEN Kullami

SELECT FirstName,LastName,
CASE(Country)
 WHEN 'USA'
 THEN 'Amerika Birleþik Devletleri'
 WHEN 'UK'
 THEN 'Ýngiltere Birleþik Krallýðý'
 END AS Ulke
FROM Employees


--Çalýþanýn EmployeeID deðeri 5den büyük ise 'Id deðeri 5''ten büyüktür'
--Çalýþanýn EmployeeID deðeri 5den küçük ise 'Id deðeri 5'ten küçüktür'
--Yukarý da ki iki durumda doðru deðilse 'Id deðeri 5'e eþittir' olarak listeleyiniz

SELECT EmployeeID,FirstName,

CASE 
  WHEN EmployeeID>5
   THEN 'Id deðeri 5''ten büyüktür'
  WHEN EmployeeID<5
   THEN 'Id deðeri 5''ten küçüktür'
  ELSE 'Id deðeri 5''e eþittir'
   END AS Durum
FROM Employees

--GROUP BY---

--Sadece gruplamak için kullanýlýr.
--Çalýþanlarýn ülkelerine göre gruplanmasý

SELECT Country AS Ülke, Count(*) as [Kiþi Sayýsý]
FROM Employees
WHERE Country IS NOT NULL
GROUP BY Country

--Çalýþanlarýn yapmýþ olduðu sipariþ adedi.

SELECT EmployeeID AS Çalýþan,Count(*) as [Sipariþ Sayýsý]
FROM Orders
Group by EmployeeID
Order by [Sipariþ Sayýsý] desc

--**group by son olur ama order by en altta yine

--Ürün bedeli 35 Dolardan az olan ürünlerin kategorilerine göre gruplanmasý

SELECT CategoryID AS Kategoriler,Count(*) AS Adet
FROM Products
WHERE UnitPrice<35
GROUP BY CategoryID
Order by Adet

--Baþ harfi A-K aralýðýnda olan ve stok miktarý 5-50 arasýnda olan ürünleri kategorilerine göre gruplayýnýz

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

--Her bir sipariþteki toplam ürün sayýsýný bulunuz.

SELECT OrderID, SUM(Quantity)AS Adet
FROM [Order Details]
GROUP BY OrderID
ORDER BY Adet DESC

--HAVING--

--Sorgu sonucu gelen sonuç kümesi üzerinde önemli aggregate fonksiyonlarýna baðlý olacak þekilde bir filtreleme iþlemi yapacaksak WHERE yerine HAVING kullanýlýr. Bu sayede Aggregate fonksiyonlarýný da filtreleme iþlemlerine katabiliriz. Eðer Aggregate fonksiyonlarýný sorgumuzda yoksa HAVING kullanýmý WHERE ile ayný filtreleme iþlemi yapacaktýr.

--Her bir sipariþteki toplam ürün sayýsý 200'den az olanlar

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

--**bu da sonuç verir. having ve where birlikte kullanýlýr. Having aggregate fonksiyon þartlarý için kullanýlýr.


--ÝÇ ÝÇE SORGULAR--

--USE Northwind : Nortwind DB kullanýcam demek

--DECLARE = Deðiþken anlamýna gelir. Ýçerisinde veri tutuma ve veriyi getirme iþlemi yapýlýr. Declare'e isimlendirme yapýlacaðý zaman kesinlikle @ iþareti konulmasý gerekir. Veri tipini de tanýmlamamýz gerekir.

DECLARE @MaxFiyat MONEY=(SELECT MAX(UnitPrice) FROM Products)

SELECT*FROM Products WHERE UnitPrice=@MaxFiyat



--Fiyatý ortalama fiyatýn üstünde olan ürünleri listeleyiniz.

DECLARE @AvgFiyat MONEY=(Select avg(UnitPrice) FROM Products)

SELECT * FROM Products WHERE UnitPrice>@AvgFiyat

--2.yol
select *
from Products
where UnitPrice>(select avg(unitprice) from products)

--Ürünler tablosundaki satýlan ürünlerin listesi

SELECT *
FROM Products

SELECT *
FROM [Order Details]

--*BAKIYORUM ÝKÝSÝNE VE ORTAK BAÞLIK PRODUCTID.

SELECT *
FROM Products
WHERE ProductID IN (SELECT ProductID from [Order Details])

--Ürünler tablosundaki satýlmayan ürünlerin listesi
SELECT *
FROM Products
WHERE ProductID NOT IN (SELECT ProductID from [Order Details])

SELECT 
p.ProductName,
p.UnitPrice,
p.UnitsInStock,
(SELECT CategoryName FROM Categories AS C WHERE C.CategoryID=P.CategoryID)
FROM Products AS P

--Bu bir SUBQUERY iþlemidir.

--EXÝSTS--

--Ýçerisinde anlamý taþýr.

--Satýþ alan çalýþanlar.

SELECT *
FROM Employees e1
WHERE EXISTS(SELECT EmployeeID FROM Orders e2 WHERE e1.EmployeeID=e2.EmployeeID) 
--**Buradan hangi çalýþanlarýn satýþý vardýr sorusunun cevabýný vermiþ oluyor.

--NOTEXISTS--

--sipariþ alamayan çalýþanlarým
SELECT *
FROM Employees e1
WHERE not EXISTS(SELECT EmployeeID FROM Orders e2 WHERE e1.EmployeeID=e2.EmployeeID) 

--IN yazýlan SUBQUERY den dönen tüm kayýtlar içinde eþleme yapýldýktan sonra ana query'nin çalýþmasýný tamamlar.

--exits ise subquery yi eþleme yapýlan kayýtlara göre sonuçlandýrýr ve ilave olarak gelen kayýtlar içinde eþleme yapmaya gerek kalmaz. Exists zaten subqueryden ihtiyacý olan kayýtlarý getirmiþ olacaktýr.

--NOT: IN'ler EXISTS'lerden performans olarak daha kötü çalýþýrlar.

SELECT *
FROM Employees e1
where EmployeeID IN(SELECT EmployeeID FROM Orders)

SELECT *
FROM Employees e1
WHERE EXISTS(SELECT EmployeeID FROM Orders e2 WHERE e1.EmployeeID=e2.EmployeeID) 

--** ÝKÝSÝ DE AYNI AMA ÝLKÝNDE 3 SORGU YAPARKEN ÝKÝNCÝSÝNDE TEK SORGUDA YAPMASINI SAÐLIYORUZ. BU YÜZDEN PERFORMANSI DAHA ÝYÝ. ** IN YAVAÞ DEÐÝL AMA SUBQUERY ÝLE KULLANILIRSA PERFORMANS OLARAK YAVAÞ KALIR, DAHA YAVAÞ SONUÇ VERÝR.

--JOIN ÝÞLEMLERÝ--

--1.Inner Join: Bir tablodaki her bir kaydýn diðer bir tabloda bir karþýlýðý olan kayýtlar listelenir. Inner join ifadesini yazarken inner ifadesini yazmasak da sadece join yazsak bile bu yine inner join olarak iþleme alýnýr.ON ile beraber kullanýlýr.

SELECT *
FROM Products INNER JOIN Categories ON Products. CategoryID=Categories.CategoryID

SELECT ProductName,Categories.CategoryID
FROM Products INNER JOIN Categories ON Products. CategoryID=Categories.CategoryID

--**ÝKÝNCÝSÝNDE BAZI KOLONLARI ALDIM

--Product tablosundan ProductID,ProductName,CategoriID ile Categories tablosundaki CategoriName, Descripton verecek þekilde birleþtiriniz.

SELECT ProductID,ProductName,Products.CategoryID,CategoryName,Description
FROM Products INNER JOIN Categories ON Products. CategoryID=Categories.CategoryID

--Hangi sipariþ hangi çalýþan tarafýndan hangi müþteriye yapýlmýþ.

select*
from orders

select *
from Customers

select*
from Employees

select OrderID AS [Sipariþ ID],OrderDate AS [Sipariþ Tarihi],CompanyName AS [Þirket Adý], ContactName as [Yetkili Kiþi],(FirstName+' '+LastName) as [Çalýþan], Title as [Görev]
from Orders INNER JOIN Employees ON Orders.EmployeeID=Employees.EmployeeID
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID



































































