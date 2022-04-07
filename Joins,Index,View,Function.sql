--INNER JOIN----

--Suppliers tablosundan CompanyName,ContactName
--Product tablosundan ProductName,UnitPrice
--Categories tablosundan CatergoryName
--CompanyName sütuna göre artan sýrada sýralayýnýz.

SELECT  CompanyName,ContactName,ProductName,UnitPrice,CategoryName
FROM Categories AS C
INNER JOIN Products AS P
ON C.CategoryID=P.CategoryID
INNER JOIN Suppliers AS S
ON P.SupplierID=S.SupplierID
ORDER BY CompanyName ASC


--Kategorilere göre toplam stok miktarýný bulunuz.(Categories,Products)

SELECT CategoryName,SUM(UnitsInStock) AS Stock
FROM Categories AS C
INNER JOIN Products AS P
ON C.CategoryID=P.CategoryID
GROUP BY CategoryName
ORDER BY Stock DESC

--2.) OUTER JOIN

--2.1) LEFT OUTER JOIN :Sorguda katýlan tablolardan soldakinin tüm kayýtlarý getirilirken, saðdaki tablodaki sadece iliþkili olan kayýtlar getirilir.

SELECT ProductName,CategoryName
FROM Products AS P
LEFT OUTER JOIN Categories AS C
ON P.CategoryID=C.CategoryID-- Left Outer Join ifadesinin solunda kalan (Products) tablosundaki tüm kayýtlar gelirken, saðýndaki (Categories) tablosundaki iliþkili kayýtlar getirilecek.

--Tüm çalýþanlar ve eðer varsa müdürleriyle birlikte listeleyiniz.

SELECT (E1.FirstName+' '+E1.LastName) AS Çalýþan,
(E2.FirstName+' '+E2.LastName) 
FROM Employees AS E1
LEFT JOIN Employees AS E2
ON E1.EmployeeID=E2.ReportsTo

--**pivot tablo bu aslýnda ve null getiriyor olmasý önemli.Fanatik örneðini unutma.ilk önce futbol a id veriyorsun, futbol altýnda haberler varsa mesela onun parentid sine 1 verince onun altýna geçiyor.



--2.2)RIGHT OUTER JOIN=>Sorguda katýlan tablolardan saðdakinin tüm kayýtlarý getirilirken, soldaki tablodaki sadece iliþkili olan kayýtlar getirilir.

--Tüm çalýþanlar ve eðer varsa müdürleriyle birlikte listeleyiniz.

SELECT (E1.FirstName+' '+E1.LastName) AS Çalýþan,
(E2.FirstName+' '+E2.LastName) 
FROM Employees AS E1
RIGHT JOIN Employees AS E2
ON E1.EmployeeID=E2.ReportsTo


--3.)FULL JOIN:Her iki tablodaki tüm kayýtlar getirilir.Left ve Right joinin birleþimidir.

SELECT ProductName,CategoryName
FROM Categories 
FULL JOIN Products 
ON Categories.CategoryID=Products.CategoryID



--4.) CROSS JOIN :Bir tablodaki bir kaydýn diðer tablodaki tüm kayýtlarla eþleþtirilmesini saðlar.

SELECT COUNT(*)
FROM Categories

SELECT COUNT(*)
FROM Products 

SELECT *
FROM Categories CROSS JOIN Products


--**sanýrým; inner da hiç nul gelmiyor, full de sað sol iki sütundan da nullar geliyor, left ve right komutlarýnda hangisi önce yazýlmýþ ise ona göre tek taraflý seçer.Cross pek kullanýlmaz her iki tablodaki verileri birleþtirir.





----------------INDEX MEKANÝZMASI------------------

--INDEX NEDÝR?

--Sql server mimarisinde index mekanizmasý verilere daha hýzlý eriþmek için kullanacaðýmýz bir özelliktir.Bir tabloda sorgulama yaptðýmýzda sql server eðer bir index yapýsý kullanmýyorsak veriyi table-scan yapacaktýr.Buda veri boyutumuzu arttýrkça zaman ve performans maliyetini artýracaktýr.Eðer index mekanizmasýný iyi kullanabilirsek, sorgu performansýmýzý ciddi bir þekilde artýrabiliriz. Sql server index mekanizmasýnda filtreleme veya taramakarken b-tree(balaced veya binary-tree) yapýsýný kullanr.Bu yapýda bilinmesi gerekenler.

--1.Root Level=>index arama seviyesi
--2.Intermediate Level=> verileri iþaret eden seviye (Kümelenmiþ sayfalar)
--3.Leaf Level=> Verinin tutulduðu seviye (Ýndex yapýsýna göre deðiþiklik gösterebilir.)

---INDEX TÜRLERÝ?-----

--1.CLUSTERED INDEX--
--2.NON-CLUSTURED INDEX--
--3.CLUSTURED COLUMN STORE INDEX--
--4.NON-CLUSTURED COLUM STORE INDEX--

------1.CLUSTURED INDEX (FÝZÝKSEL INDEX)--------

--Verilerin fiziksel bir þekilde tutulmasýdýr.Bu yapýda veriler leaf level seviyede tutulur ve sýralanýr.Genelde Unique ve sayýsal alnarda tavsiye edilir.Eðer unique bir alan dýþýnda kullanýrsak ve alan içersinde tekrar eden veriler varsa index için server tarafýndan bir index belirlenir ve buda perforans kaybýna sebep olur.Ayrýca Clustured Index belirleyeceðimiz alanýn güncellenebilen alan olmamasýna dikkat etmeliyiz.Her güncellemede indexleme mekanizmasý sýralama için güncelleme yapacaðý için yine performans kaybý yaþanacaktýr.Clustured Index her tabloda bir tane olmak zorundadýr.

--Önemli:Zaten her tabloda primary key olarak iþareletlediðimiz alanlar, otmatik clustred index olurlar.Talomuzda primary key yoksa ve clustured index index yapýsý oluþmayacaðýna göre eklemek için tablo sekmemizden idexes sekmesinden sað týk new clustred index diyere kolonu primary key yapabiliriz.Eðer tablomuzda bir index varsa veya clustured index tanýmlýysa bu sekme artýk aktif olmayacaktýr.

/*
--index performans demek. veri geliþ süresini etkiliyor. 1 milyon veri de olsa 0 saniyede gelir.
--Fiziksel aslýnda sýralama, örneðin 2-1-4-3 sýrasýan göre id versen de o rapor çektiðinde otomatik dizmeyi saðlar.

Fiziksel olarak sýralamadan örnek verecek olursak;

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

--product tablosundaki bütün ürünleri ürünler tablosuna ekliyoruz.

INSERT INTO Urunler
SELECT ProductID,ProductName,UnitsInStock,UnitPrice FROM Products

--** * yerine urunler adýnda product içeriði oluþturmak için urunler tablosundaki sýra ile baþlýklarý yazýyorum. yeni baþlýk adlarým ile products tablosundaki veriler geliyor.


SELECT * FROM Urunler

exec sp_helpindex Urunler

--10 KEZ ÇALIÞTIRALIM
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
 Sql sorgusunu çalýþtýrdýðýmýzda;

 INDEX SCAN=>Eðer bir kriter belirlemediysek tabloda Index Scan yapýlýr

 INDEX SEEK=>Kriter belirlediðimizde ise Index Seek yapýlýr.
*/


---NON-CLUSTURED INDEX (Fiziksel Olmayan)---

/*
Non-Clustured index yapýsýný niçin kullanýrýz?
1* Tek bir clustured index yapýsý kullandýðýmýz için(Primary key tanýmladðýmýz zaman otomatik tanýmlayor)

2* Pk dýþýndaki diðer alanlarýmýza da filtreleme uyguladýðýmýz için kullanýlýr.

Bilgi:Non-Clustured Index maximum 999 tane tanýmlabilir.

Önmli bir knuda þudurki NonClustured Index'ler performans avantajý varken dezavajtýda vardýr.


Örneðin ad alnýný non index ve kayýtlarýný ekledim

ID Adý
1  A
2  B
3  C
4  D
5  E

tekrar  A deðerinde bir kayýt eklediðimde veriler þu þekilde olacaktýr.

ID Adý
1  A
2  B
3  C
4  D
5  E
6  A

bu þekilde ki insert iþleminde nonclusturedýmýz veriyi IDsi 1 olan kaydýn altýna acaðý için B-tree'de update iþemi yapacaktýr.Index alný belirleyeceðimiz zaman sürekli update,delete gören alanlardan kaçýnmalýyýz.Bu yüzden indexleme mekanizmasýný seçerken perfomransý olusmzu etkileyecek iþlemlerden kaçýnmalýyýz

*/

--kolanlarý clustred yada non clustered yapýyorum. non max999 yapýlýr. Ama non olaný update,delete, ýnsert yaomamam gerekir. ayný veri girersem index yapým bozulur.

--þimdi Muþteriler tablosu oluþturun (CompanyName,ContactTitle,ContactName,CustomerID)

CREATE TABLE Musteriler
(
CompanyName nvarchar(40),
ContactTitle nvarchar(30),
ContactName nvarchar(30),
CustomerID nchar(5)
)


--customers tablosundaki verileri müþteriler tablosuna 1 kere ekleyiniz.

INSERT INTO Musteriler
SELECT CompanyName,ContactTitle,ContactName,CustomerID FROM Customers

--Musteriler tablosuna yeni bir kolon ekleyiniz (ID primary key IsIdentity=true) (Müþteriler tablosuna Id isimli kolon ekle, primary key yap ve otomatik artan yap)

ALTER TABLE Musteriler
  add ID int primary key identity(1,1)


set statistics time on
set statistics io on

SELECT CompanyName,ContactTitle,ContactName FROM Musteriler WHERE CompanyName='Vaffeljernet' AND ContactName='Palle Ibsen'

set statistics time off
set statistics io off


/*

--ColumnStore index tanýmlanýrken bütün tablodaki kolonlarý içereceði için bir kolon seçmiyoruz.Columstore index tanýmlamak için clustured index ve nonclustured columstýre index tanýmlandý gibi, primary key tanýmlayamýyoruz.


---3.CLUSTURED COLUMNSTORE INDEX--

1.Yeni nesil index türüdür.Sql Server 2014 ile geliþtirilmiþtir.

2.Bir tabloda max. 1 adet tanýmlabilir.

3.Veriler satýr bazlý deðil,sütun bazlý depolanýr.

4.Sütun bazý depolamadan (Sýkýþtýrýlmuþ veri) dolayý daha performanslý çalýþýr

5.Bütün sütunlar columnstore index'e baðladýr.

*/

--**clustered columnstorelarda primary key yok. clustered ile ayný anda kullanamýyorsun. yeni nesil ve çok hýzlý ama primary key olmadýðý için çok tercih edilmez. statik datalarda kullanýlabilir.
--kolon kolon indexleme yapar. rar gibi sýkýþtýrýlmýþ olarak saklar. clustered satýr satýrdý. kolon kolon olduðuiçin daha hýzlýdýr.
--iki tane oluþturulamaz zaten bir adet olunca otomatik olarak hepsi oluyor sadece primary key olmuyor.

set statistics time on
set statistics io on

SELECT UrunID,UrunAdi,Stok,Fiyat FROM Urunler WHERE UrunID=70

set statistics time off
set statistics io off


/*
 
---4.NON-CLUSTURED COLUMN STORE INDEX---

1.Yeni nesil index türüdür.Sql Server 2012 ile desteklenmiþtir.

2.2016 ile sadece okuma iþlemi deðil, insert,update,delete iþlemleride yapýlabilir hale gelmiþtir.

3.Clustered Index olan bir tabloda tanýmlanabilir.

4.Bir tabloda en fazla 1 adet olabilir.

5.ColumStýre index gibi sütünlarda sýkýþtýrýlarak tutulur.

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

--non clustered olarak bir tabloya bir kaç adet index yapabilirsin.böylece her sorgunun süresini azaltmýþ olursun. non clustered column store ise sadece 1 adet oluþturulduðu için tek bir sabit sorgu varsa kullanýlabilir.

--**eðer indexli yapýn varsa ve arada yavaþlarsa index sað klik rebuild yapman faydalý olur. hatta haftada 1 kendiliðinden yapabilirsin.



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
 
 ---VÝEW-----

/*
Gerçek tablolardan veriyi referans alan sanal tablolardýr.
Bir select sonucu oluþan tablo olmasýna raðmen, gerçek tablo gibi satýr ve sütunlardan oluþurlar.View içerisinde select sorgularý ile birlikte kriterlerde belirtebiliriz.View içerisinde hazýr veri olan özet tablo gibi düþünülebilir.

View içerisinde join ve subquery iþlemleri yaparak iki tabloyu tek bir tablo gibi oluþturabiliriz.

Ayrýca Viewlar;

-Query2in tekrar kullanýlabilmek için
-Karmaþýk sorugularý sadeleþtirmek için
--Veri güvenliði için
--Raporlamalar yapmak için kullanýlýr.

-----VIEW & TABLO ARASINDAKÝ FARKLILIKLAR------

1-Her ikisi de veritabaný nesnesidir.
2-Veriler gerçek tablolarda fizik olarak saklanýrken, viewlarda ise sadece özet þeklinde tutulur.
3-Viewlar gerçek tablolardan türetilen sanal tablolardýr.
4-Viewlar select sonucu oluþturulan tablolardýr.
5-View birden fazla tablo ile oluþturulabilir.
6.View sayesinde veri güvenliði saðlanabilir.
*/

--Bir sipariþin hangi çalýþan tarafndan hangi müþteriye hangi kategorideki üründen hangi fiyattan kaç adet satýldýðýný listeleyiniz.(Employees,Orders,Customers,Order Details,Products,Categories)
-- Çalýþanýn adý, soyadý, ünvaný, görevi, iþe baþlama tarihi
-- Müþterinin firma adýný, temsilcisini ve telefonunu
-- Ürünün adýný, stok miktarýný, birim fiyatýný
-- Sipariþin adetini ve satýþ fiyatýný
-- Kategori adýný


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


--Kategoriler diye view yaratýnýz. CategoryName ve description alanlarý olsun 


CREATE VIEW Kategoriler
AS
SELECT CategoryName,Description
FROM Categories

--View üzerinden veri eklemek

INSERT INTO Kategoriler VALUES ('Mercedes','Bir dünya markasýdýr.')


SELECT * FROM Kategoriler


ALTER VIEW Kategoriler
AS
SELECT CategoryID,CategoryName,Description
FROM Categories

SELECT * FROM Kategoriler


DROP VIEW Kategoriler


--VIEW ile With Check Option Kullanýmý

--ÇalýþanBilgileri diye bir view oluþturunuz (Employees) tablosundan FirstName,LastName,Title,City getiriniz.

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

INSERT INTO CalisanBilgileri VALUES ('Hakan','Yýlmaz','Kaldýrým enginee','Uþak')


--**böyle yapýnca employees tablosuna da doðru þekilde ekler. çünkü bir üstte create view daki sýraya göre yazdýk.  ama çalýþanbilgilerini  çaðýrýnca uþak olduðu için gelmez.



SELECT *
FROM CalisanBilgileri

ALTER VIEW CalisanBilgileri
AS
SELECT FirstName,LastName,Title,City
FROM Employees WHERE City='London'
WITH CHECK OPTION
--**son þartý koyarsam alttakini yapamam. London olsa eklerdi.

INSERT INTO CalisanBilgileri
VALUES ('Hikmet','Menevþe','DBA','London')

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



--Kullanýcý Tanýmlý Fonksiyonlar(User Defined Function-UDF)

--Fonsiyonlar deðer döndüren yapýsal birmlerdir.Parametre alabilirler.

--Fonksiyonlar geriye tek bir deðer veya bir tablo döndürebilir.

--SP'lerden en büyük farký sorgu içerisinde kullanýlabilirler.

--View'lerdan en büyük farký parametre alan yapýlarý saðlayabilmeleridir.

--Deðer döndüren fonksiyonlara Scalar Function, Tablo döndüren fonksiyonlara da Table Value Function denir.

/*
   SCALAR Fonsiyonlar (Tek Deðer Döndüren)

   *Geriye tek bir deðer döndürürler.Genellikle matematiksel iþlemlerde kullanýlýr.

   *RETURNS<TÝP> ile geriye hangi tipte deðer döndürüleceði bildirilmelidir.

   *RETURN ifadesi ile geriye fonksiyonun döndüreceði deðer belirtilir.

   INT SONUC= 5+5

   RETURN SONUC

   *Fonksiyonu oluþturan kod bloðu BEGIN-END aralýðýnda yazýlýr ve kullanýrken tablonun þemasý belirtilir

*/

CREATE FUNCTION KdvHesapla
(@fiyat MONEY)

RETURNS MONEY
        BEGIN
		  RETURN @fiyat*1.18
		END


SELECT  ProductName AS [Ürün Adý],CategoryName AS [Kategori],UnitPrice AS [Birim Fiyat],[dbo].[KdvHesapla](UnitPrice) AS [Kdv Fiyat]
FROM Products
INNER JOIN Categories 
ON Products.CategoryID=Categories.CategoryID


--Kiþilerin yaþlarýný hesaplayacak bir UDF yazýnýz.

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


--Dýþarýdan iki sayýnýn toplamýný bulan UDF yazýnýz.

CREATE FUNCTION Topla
(@Sayi1 int,@Sayi2 int)

RETURNS INT

  BEGIN

  RETURN @Sayi1+@Sayi2

  END


SELECT [dbo].[Topla](20,15)

--Product satýþ fiyatýný hesaplayacak function yaz.

alter  function fiyathesaplama
(@fiyat money,@adet int,@oran real)
returns money
begin
return (@fiyat*@adet)*(1-@oran)
end

select [dbo].[fiyathesaplama]([UnitPrice],[Quantity],[Discount])
from [dbo].[Order Details]








































































































































































































































