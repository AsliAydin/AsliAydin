--INNER JOIN----

--Suppliers tablosundan CompanyName,ContactName
--Product tablosundan ProductName,UnitPrice
--Categories tablosundan CatergoryName
--CompanyName s�tuna g�re artan s�rada s�ralay�n�z.

SELECT  CompanyName,ContactName,ProductName,UnitPrice,CategoryName
FROM Categories AS C
INNER JOIN Products AS P
ON C.CategoryID=P.CategoryID
INNER JOIN Suppliers AS S
ON P.SupplierID=S.SupplierID
ORDER BY CompanyName ASC


--Kategorilere g�re toplam stok miktar�n� bulunuz.(Categories,Products)

SELECT CategoryName,SUM(UnitsInStock) AS Stock
FROM Categories AS C
INNER JOIN Products AS P
ON C.CategoryID=P.CategoryID
GROUP BY CategoryName
ORDER BY Stock DESC

--2.) OUTER JOIN

--2.1) LEFT OUTER JOIN :Sorguda kat�lan tablolardan soldakinin t�m kay�tlar� getirilirken, sa�daki tablodaki sadece ili�kili olan kay�tlar getirilir.

SELECT ProductName,CategoryName
FROM Products AS P
LEFT OUTER JOIN Categories AS C
ON P.CategoryID=C.CategoryID-- Left Outer Join ifadesinin solunda kalan (Products) tablosundaki t�m kay�tlar gelirken, sa��ndaki (Categories) tablosundaki ili�kili kay�tlar getirilecek.

--T�m �al��anlar ve e�er varsa m�d�rleriyle birlikte listeleyiniz.

SELECT (E1.FirstName+' '+E1.LastName) AS �al��an,
(E2.FirstName+' '+E2.LastName) 
FROM Employees AS E1
LEFT JOIN Employees AS E2
ON E1.EmployeeID=E2.ReportsTo

--**pivot tablo bu asl�nda ve null getiriyor olmas� �nemli.Fanatik �rne�ini unutma.ilk �nce futbol a id veriyorsun, futbol alt�nda haberler varsa mesela onun parentid sine 1 verince onun alt�na ge�iyor.



--2.2)RIGHT OUTER JOIN=>Sorguda kat�lan tablolardan sa�dakinin t�m kay�tlar� getirilirken, soldaki tablodaki sadece ili�kili olan kay�tlar getirilir.

--T�m �al��anlar ve e�er varsa m�d�rleriyle birlikte listeleyiniz.

SELECT (E1.FirstName+' '+E1.LastName) AS �al��an,
(E2.FirstName+' '+E2.LastName) 
FROM Employees AS E1
RIGHT JOIN Employees AS E2
ON E1.EmployeeID=E2.ReportsTo


--3.)FULL JOIN:Her iki tablodaki t�m kay�tlar getirilir.Left ve Right joinin birle�imidir.

SELECT ProductName,CategoryName
FROM Categories 
FULL JOIN Products 
ON Categories.CategoryID=Products.CategoryID



--4.) CROSS JOIN :Bir tablodaki bir kayd�n di�er tablodaki t�m kay�tlarla e�le�tirilmesini sa�lar.

SELECT COUNT(*)
FROM Categories

SELECT COUNT(*)
FROM Products 

SELECT *
FROM Categories CROSS JOIN Products


--**san�r�m; inner da hi� nul gelmiyor, full de sa� sol iki s�tundan da nullar geliyor, left ve right komutlar�nda hangisi �nce yaz�lm�� ise ona g�re tek tarafl� se�er.Cross pek kullan�lmaz her iki tablodaki verileri birle�tirir.





----------------INDEX MEKAN�ZMASI------------------

--INDEX NED�R?

--Sql server mimarisinde index mekanizmas� verilere daha h�zl� eri�mek i�in kullanaca��m�z bir �zelliktir.Bir tabloda sorgulama yapt��m�zda sql server e�er bir index yap�s� kullanm�yorsak veriyi table-scan yapacakt�r.Buda veri boyutumuzu artt�rk�a zaman ve performans maliyetini art�racakt�r.E�er index mekanizmas�n� iyi kullanabilirsek, sorgu performans�m�z� ciddi bir �ekilde art�rabiliriz. Sql server index mekanizmas�nda filtreleme veya taramakarken b-tree(balaced veya binary-tree) yap�s�n� kullanr.Bu yap�da bilinmesi gerekenler.

--1.Root Level=>index arama seviyesi
--2.Intermediate Level=> verileri i�aret eden seviye (K�melenmi� sayfalar)
--3.Leaf Level=> Verinin tutuldu�u seviye (�ndex yap�s�na g�re de�i�iklik g�sterebilir.)

---INDEX T�RLER�?-----

--1.CLUSTERED INDEX--
--2.NON-CLUSTURED INDEX--
--3.CLUSTURED COLUMN STORE INDEX--
--4.NON-CLUSTURED COLUM STORE INDEX--

------1.CLUSTURED INDEX (F�Z�KSEL INDEX)--------

--Verilerin fiziksel bir �ekilde tutulmas�d�r.Bu yap�da veriler leaf level seviyede tutulur ve s�ralan�r.Genelde Unique ve say�sal alnarda tavsiye edilir.E�er unique bir alan d���nda kullan�rsak ve alan i�ersinde tekrar eden veriler varsa index i�in server taraf�ndan bir index belirlenir ve buda perforans kayb�na sebep olur.Ayr�ca Clustured Index belirleyece�imiz alan�n g�ncellenebilen alan olmamas�na dikkat etmeliyiz.Her g�ncellemede indexleme mekanizmas� s�ralama i�in g�ncelleme yapaca�� i�in yine performans kayb� ya�anacakt�r.Clustured Index her tabloda bir tane olmak zorundad�r.

--�nemli:Zaten her tabloda primary key olarak i�areletledi�imiz alanlar, otmatik clustred index olurlar.Talomuzda primary key yoksa ve clustured index index yap�s� olu�mayaca��na g�re eklemek i�in tablo sekmemizden idexes sekmesinden sa� t�k new clustred index diyere kolonu primary key yapabiliriz.E�er tablomuzda bir index varsa veya clustured index tan�ml�ysa bu sekme art�k aktif olmayacakt�r.

/*
--index performans demek. veri geli� s�resini etkiliyor. 1 milyon veri de olsa 0 saniyede gelir.
--Fiziksel asl�nda s�ralama, �rne�in 2-1-4-3 s�ras�an g�re id versen de o rapor �ekti�inde otomatik dizmeyi sa�lar.

Fiziksel olarak s�ralamadan �rnek verecek olursak;

TABLO(Index olmayan tablo)
ID DEGER
2.   A
1.   B
4.   C
3.   D

TABLO(Index olan tablo)
ID DEGER
1. B
2. A
3. D
4. C

*/

CREATE TABLE Urunler
(
 UrunID int,
 UrunAdi nvarchar(40),
 Stok smallInt,
 Fiyat money

)

--product tablosundaki b�t�n �r�nleri �r�nler tablosuna ekliyoruz.

INSERT INTO Urunler
SELECT ProductID,ProductName,UnitsInStock,UnitPrice FROM Products

--** * yerine urunler ad�nda product i�eri�i olu�turmak i�in urunler tablosundaki s�ra ile ba�l�klar� yaz�yorum. yeni ba�l�k adlar�m ile products tablosundaki veriler geliyor.


SELECT * FROM Urunler

exec sp_helpindex Urunler

--10 KEZ �ALI�TIRALIM
INSERT Urunler
SELECT * FROM Urunler


set statistics time on
set statistics io on

SELECT * FROM Urunler WHERE UrunID=70

set statistics time off
set statistics io off

alter table Urunler
 add ID int primary key identity(1,1)

exec sp_helpindex Urunler

set statistics time on
set statistics io on

SELECT * FROM Urunler WHERE ID=6000

set statistics time off
set statistics io off

/*
 Sql sorgusunu �al��t�rd���m�zda;

 INDEX SCAN=>E�er bir kriter belirlemediysek tabloda Index Scan yap�l�r

 INDEX SEEK=>Kriter belirledi�imizde ise Index Seek yap�l�r.
*/


---NON-CLUSTURED INDEX (Fiziksel Olmayan)---

/*
Non-Clustured index yap�s�n� ni�in kullan�r�z?
1* Tek bir clustured index yap�s� kulland���m�z i�in(Primary key tan�mlad��m�z zaman otomatik tan�mlayor)

2* Pk d���ndaki di�er alanlar�m�za da filtreleme uygulad���m�z i�in kullan�l�r.

Bilgi:Non-Clustured Index maximum 999 tane tan�mlabilir.

�nmli bir knuda �udurki NonClustured Index'ler performans avantaj� varken dezavajt�da vard�r.


�rne�in ad aln�n� non index ve kay�tlar�n� ekledim

ID Ad�
1  A
2  B
3  C
4  D
5  E

tekrar  A de�erinde bir kay�t ekledi�imde veriler �u �ekilde olacakt�r.

ID Ad�
1  A
2  B
3  C
4  D
5  E
6  A

bu �ekilde ki insert i�leminde nonclustured�m�z veriyi IDsi 1 olan kayd�n alt�na aca�� i�in B-tree'de update i�emi yapacakt�r.Index aln� belirleyece�imiz zaman s�rekli update,delete g�ren alanlardan ka��nmal�y�z.Bu y�zden indexleme mekanizmas�n� se�erken perfomrans� olusmzu etkileyecek i�lemlerden ka��nmal�y�z

*/

--kolanlar� clustred yada non clustered yap�yorum. non max999 yap�l�r. Ama non olan� update,delete, �nsert yaomamam gerekir. ayn� veri girersem index yap�m bozulur.

--�imdi Mu�teriler tablosu olu�turun (CompanyName,ContactTitle,ContactName,CustomerID)

CREATE TABLE Musteriler
(
CompanyName nvarchar(40),
ContactTitle nvarchar(30),
ContactName nvarchar(30),
CustomerID nchar(5)
)


--customers tablosundaki verileri m��teriler tablosuna 1 kere ekleyiniz.

INSERT INTO Musteriler
SELECT CompanyName,ContactTitle,ContactName,CustomerID FROM Customers

--Musteriler tablosuna yeni bir kolon ekleyiniz (ID primary key IsIdentity=true) (M��teriler tablosuna Id isimli kolon ekle, primary key yap ve otomatik artan yap)

ALTER TABLE Musteriler
  add ID int primary key identity(1,1)


set statistics time on
set statistics io on

SELECT CompanyName,ContactTitle,ContactName FROM Musteriler WHERE CompanyName='Vaffeljernet' AND ContactName='Palle Ibsen'

set statistics time off
set statistics io off


/*

--ColumnStore index tan�mlan�rken b�t�n tablodaki kolonlar� i�erece�i i�in bir kolon se�miyoruz.Columstore index tan�mlamak i�in clustured index ve nonclustured columst�re index tan�mland� gibi, primary key tan�mlayam�yoruz.


---3.CLUSTURED COLUMNSTORE INDEX--

1.Yeni nesil index t�r�d�r.Sql Server 2014 ile geli�tirilmi�tir.

2.Bir tabloda max. 1 adet tan�mlabilir.

3.Veriler sat�r bazl� de�il,s�tun bazl� depolan�r.

4.S�tun baz� depolamadan (S�k��t�r�lmu� veri) dolay� daha performansl� �al���r

5.B�t�n s�tunlar columnstore index'e ba�lad�r.

*/

--**clustered columnstorelarda primary key yok. clustered ile ayn� anda kullanam�yorsun. yeni nesil ve �ok h�zl� ama primary key olmad��� i�in �ok tercih edilmez. statik datalarda kullan�labilir.
--kolon kolon indexleme yapar. rar gibi s�k��t�r�lm�� olarak saklar. clustered sat�r sat�rd�. kolon kolon oldu�ui�in daha h�zl�d�r.
--iki tane olu�turulamaz zaten bir adet olunca otomatik olarak hepsi oluyor sadece primary key olmuyor.

set statistics time on
set statistics io on

SELECT UrunID,UrunAdi,Stok,Fiyat FROM Urunler WHERE UrunID=70

set statistics time off
set statistics io off


/*
 
---4.NON-CLUSTURED COLUMN STORE INDEX---

1.Yeni nesil index t�r�d�r.Sql Server 2012 ile desteklenmi�tir.

2.2016 ile sadece okuma i�lemi de�il, insert,update,delete i�lemleride yap�labilir hale gelmi�tir.

3.Clustered Index olan bir tabloda tan�mlanabilir.

4.Bir tabloda en fazla 1 adet olabilir.

5.ColumSt�re index gibi s�t�nlarda s�k��t�r�larak tutulur.

*/

exec sp_helpindex Urunler

set statistics time on
set statistics io on

SELECT UrunID,UrunAdi,Stok,Fiyat FROM Urunler WHERE UrunID=70

set statistics time off
set statistics io off


--Non-Clustured
set statistics time on
set statistics io on

SELECT UrunID,UrunAdi FROM Urunler WHERE UrunID=70 AND UrunAdi='a'

set statistics time off
set statistics io off

--logical reads 4
--logical reads 0

--non clustered olarak bir tabloya bir ka� adet index yapabilirsin.b�ylece her sorgunun s�resini azaltm�� olursun. non clustered column store ise sadece 1 adet olu�turuldu�u i�in tek bir sabit sorgu varsa kullan�labilir.

--**e�er indexli yap�n varsa ve arada yava�larsa index sa� klik rebuild yapman faydal� olur. hatta haftada 1 kendili�inden yapabilirsin.



set statistics time on
set statistics io on

SELECT Stok FROM Urunler WHERE Stok=12

set statistics time off
set statistics io off

--logical reads 3
--logical reads 0


set statistics time on
set statistics io on

SELECT Fiyat,Stok FROM Urunler WHERE Fiyat=12

set statistics time off
set statistics io off

--logical reads 166
--logical reads 0

 CPU time = 0 ms, elapsed time = 0 ms.--Non Clustured Index

 CPU time = 219 ms, elapsed time = 326 ms. --Non Clustured Column Index
 
 ---V�EW-----

/*
Ger�ek tablolardan veriyi referans alan sanal tablolard�r.
Bir select sonucu olu�an tablo olmas�na ra�men, ger�ek tablo gibi sat�r ve s�tunlardan olu�urlar.View i�erisinde select sorgular� ile birlikte kriterlerde belirtebiliriz.View i�erisinde haz�r veri olan �zet tablo gibi d���n�lebilir.

View i�erisinde join ve subquery i�lemleri yaparak iki tabloyu tek bir tablo gibi olu�turabiliriz.

Ayr�ca Viewlar;

-Query2in tekrar kullan�labilmek i�in
-Karma��k sorugular� sadele�tirmek i�in
--Veri g�venli�i i�in
--Raporlamalar yapmak i�in kullan�l�r.

-----VIEW & TABLO ARASINDAK� FARKLILIKLAR------

1-Her ikisi de veritaban� nesnesidir.
2-Veriler ger�ek tablolarda fizik olarak saklan�rken, viewlarda ise sadece �zet �eklinde tutulur.
3-Viewlar ger�ek tablolardan t�retilen sanal tablolard�r.
4-Viewlar select sonucu olu�turulan tablolard�r.
5-View birden fazla tablo ile olu�turulabilir.
6.View sayesinde veri g�venli�i sa�lanabilir.
*/

--Bir sipari�in hangi �al��an tarafndan hangi m��teriye hangi kategorideki �r�nden hangi fiyattan ka� adet sat�ld���n� listeleyiniz.(Employees,Orders,Customers,Order Details,Products,Categories)
-- �al��an�n ad�, soyad�, �nvan�, g�revi, i�e ba�lama tarihi
-- M��terinin firma ad�n�, temsilcisini ve telefonunu
-- �r�n�n ad�n�, stok miktar�n�, birim fiyat�n�
-- Sipari�in adetini ve sat�� fiyat�n�
-- Kategori ad�n�


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


--Kategoriler diye view yarat�n�z. CategoryName ve description alanlar� olsun 


CREATE VIEW Kategoriler
AS
SELECT CategoryName,Description
FROM Categories

--View �zerinden veri eklemek

INSERT INTO Kategoriler VALUES ('Mercedes','Bir d�nya markas�d�r.')


SELECT * FROM Kategoriler


ALTER VIEW Kategoriler
AS
SELECT CategoryID,CategoryName,Description
FROM Categories

SELECT * FROM Kategoriler


DROP VIEW Kategoriler


--VIEW ile With Check Option Kullan�m�

--�al��anBilgileri diye bir view olu�turunuz (Employees) tablosundan FirstName,LastName,Title,City getiriniz.

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

INSERT INTO CalisanBilgileri VALUES ('Hakan','Y�lmaz','Kald�r�m enginee','U�ak')


--**b�yle yap�nca employees tablosuna da do�ru �ekilde ekler. ��nk� bir �stte create view daki s�raya g�re yazd�k.  ama �al��anbilgilerini  �a��r�nca u�ak oldu�u i�in gelmez.



SELECT *
FROM CalisanBilgileri

ALTER VIEW CalisanBilgileri
AS
SELECT FirstName,LastName,Title,City
FROM Employees WHERE City='London'
WITH CHECK OPTION
--**son �art� koyarsam alttakini yapamam. London olsa eklerdi.

INSERT INTO CalisanBilgileri
VALUES ('Hikmet','Menev�e','DBA','London')

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



--Kullan�c� Tan�ml� Fonksiyonlar(User Defined Function-UDF)

--Fonsiyonlar de�er d�nd�ren yap�sal birmlerdir.Parametre alabilirler.

--Fonksiyonlar geriye tek bir de�er veya bir tablo d�nd�rebilir.

--SP'lerden en b�y�k fark� sorgu i�erisinde kullan�labilirler.

--View'lerdan en b�y�k fark� parametre alan yap�lar� sa�layabilmeleridir.

--De�er d�nd�ren fonksiyonlara Scalar Function, Tablo d�nd�ren fonksiyonlara da Table Value Function denir.

/*
   SCALAR Fonsiyonlar (Tek De�er D�nd�ren)

   *Geriye tek bir de�er d�nd�r�rler.Genellikle matematiksel i�lemlerde kullan�l�r.

   *RETURNS<T�P> ile geriye hangi tipte de�er d�nd�r�lece�i bildirilmelidir.

   *RETURN ifadesi ile geriye fonksiyonun d�nd�rece�i de�er belirtilir.

   INT SONUC= 5+5

   RETURN SONUC

   *Fonksiyonu olu�turan kod blo�u BEGIN-END aral���nda yaz�l�r ve kullan�rken tablonun �emas� belirtilir

*/

CREATE FUNCTION KdvHesapla
(@fiyat MONEY)

RETURNS MONEY
        BEGIN
		  RETURN @fiyat*1.18
		END


SELECT  ProductName AS [�r�n Ad�],CategoryName AS [Kategori],UnitPrice AS [Birim Fiyat],[dbo].[KdvHesapla](UnitPrice) AS [Kdv Fiyat]
FROM Products
INNER JOIN Categories 
ON Products.CategoryID=Categories.CategoryID


--Ki�ilerin ya�lar�n� hesaplayacak bir UDF yaz�n�z.

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


--D��ar�dan iki say�n�n toplam�n� bulan UDF yaz�n�z.

CREATE FUNCTION Topla
(@Sayi1 int,@Sayi2 int)

RETURNS INT

  BEGIN

  RETURN @Sayi1+@Sayi2

  END


SELECT [dbo].[Topla](20,15)

--Product sat�� fiyat�n� hesaplayacak function yaz.

alter  function fiyathesaplama
(@fiyat money,@adet int,@oran real)
returns money
begin
return (@fiyat*@adet)*(1-@oran)
end

select [dbo].[fiyathesaplama]([UnitPrice],[Quantity],[Discount])
from [dbo].[Order Details]








































































































































































































































