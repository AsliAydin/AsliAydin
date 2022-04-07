---FUNCTION--------

/*
	Tablo Döndüren Fonksiyonlar
	*Skaler fonksiyonlar gibi dýþarýdan parametre alabilirler.
	*Begin - End kullanýlmaz
	*Fonksiyon kullanýmýnda þema ismi kullanmaya gerek yoktur.
*/

--Id girilerek çalýþan bilgilerini getiren function yaz.

CREATE FUNCTION CalisanBilgileriniGetir
(
@employeeID int
)

RETURNS TABLE

RETURN SELECT *
       FROM Employees
	   WHERE EmployeeID=@employeeID



SELECT * FROM [CalisanBilgileriniGetir](5)


--Ms,Mrs gibi ünvan girilerek çalýþan bilgilerini getiren function yaz.

ALTER FUNCTION CalisanlariUnvanaGoreGetir
(@unvan1 nvarchar(25),@unvan2 nvarchar(25))

RETURNS TABLE
RETURN SELECT *
       FROM Employees
	   WHERE TitleOfCourtesy IN (@unvan1,@unvan2)

SELECT FirstName,LastName,TitleOfCourtesy FROM [dbo].[CalisanlariUnvanaGoreGetir]('Ms.')


--Baþ harf girilerek buna göre FirstName kolonu kullanýlarak çalýþanlar getirilecek.

CREATE FUNCTION BasHarfeGoreGetir
(@basHarf NVARCHAR(1))

RETURNS TABLE
RETURN SELECT *
       FROM Employees
	   WHERE LEFT(FirstName,1)=@basHarf
	   --WHERE FirstName LIKE @basHarf+'%'

SELECT *
FROM [dbo].[BasHarfeGoreGetir]('A')




SELECT * FROM Employees


/*
-------STORED PROCEDURE (Saklý Yordamlar)---------

TSQL komularý ile hazýrladýðýmýz iþlemler bütünün çalýþtýrýlma anýnda derlenmesi ile size bir sonu üreten sql server birleþenidir.Sýk kullanýlan sql komutlarýmýzý (select,insert,update,delete) store procedure içerisinde kullanýrsak bir sonraki aþamada sadece çaðýrýrýz.
Proglama dilinde METHOD ve Sql Serverdaki User Defined Funculara benzerler.

Store Procedurlar;
1.Performans ve güvenlik objeleridir.
2.Tablolardan sonraki en önemli veritabaný objesidir.
3.Input ve Output parametre tipleri vardýr.
4.Geriye birden fazla deðer döndürebilir.(Output parametre)

NOT:Birden fazla dönüþ tipi output parametere ile yapýlýr.SP'lerin dönüþ tipleri her zaman INT olarak tanýmlanmýþtýr.
NOT2: Veritabaný objeleri arasýnda en hýzlý çalýþan ve güvenli eriþim saðlayan iþlemlerden biridir.

--FUNTION (UDF) & PROCEDURE ARASINDAKÝ FARKLILIKLAR

FUNTION
1.Funtion deðer döndürmek zorundadýr.
2.Input parametre tanýmlanýrken,output parametreleri destelemez.
3.Select ifadeleri (Sorgu içerisinde) ile çaðrýlýr.

PROCEDURE
1.Deðer döndürmek zorunda deðillerdir.
2.Input parametre tanýmaliblirken, output parametreler desteklenir.
3.Select ifadeleri içerisinde çalýþtýrýlamazlar,Procedure çaðýrmak için exec veya execute komutu kullanýlmalýdýr.
*/

--calisan bilgileirni getiren sp yaz.

CREATE PROCEDURE sp_CalisanlariGetir
AS
      BEGIN

	    SELECT *
		FROM Employees
		WHERE City IS NOT NULL

	  END

SELECT * FROM sp_CalisanlariGetir--Yanlýþ bir tanýlamadýr.Execute ile çalýþtýrýlýr.1

EXECUTE sp_CalisanlariGetir

--Tüm kategorilerle bu kategorilere ait ürünleri getiren Store Procedure.

CREATE PROCEDURE sp_UrunlerVeKategoriler
AS
    BEGIN

	SELECT CategoryName,ProductName
	FROM Categories INNER JOIN Products 
	ON Categories.CategoryID=Products.CategoryID

	END

EXEC sp_UrunlerVeKategoriler
--view olarak aynýsýný evet yaparsýn ama bu daha hýzlý ve güvenli. Alt yapýsýnda indexleme var. view da parametre alamazsýn, @sayi int gibi. sp de olur. yani dýþarýdan parametre girebilirim splerde.



--Kategorisine göre ürünleri getiren store procedur yazýnýz. 
--(dýþarýdan parametre gireceksin yani category id yazýp sorgulayacaksýn)( Input: veri giriþi olunca geçelidir.)


CREATE PROCEDURE sp_UrunByKategori
@id INT--Procedure'e parametre aktaryoruz.Parametreler yazýlýrken, önce parametre adý (baþýnda @ iþareti ile birlikte) daha sonra ise parametrenin tipi yazýlýr.

AS
   BEGIN 

   SELECT CategoryName,ProductName
	FROM Categories INNER JOIN Products 
	ON Categories.CategoryID=Products.CategoryID
	WHERE Categories.CategoryID=@id

   END

exec sp_UrunByKategori 1

exec sp_UrunByKategori @id=1


--Çalýþanýn adýna göre arama yapýp listeleyen SP.

CREATE PROCEDURE sp_CalisaninAdinaGoreGetir
@ad nvarchar(10)
AS

   BEGIN

         SELECT *
		 FROM Employees
		 WHERE FirstName LIKE ('%'+(@ad)+'%')

   END


EXEC sp_CalisaninAdinaGoreGetir 'a'


--Adýna ve soyadýna göre çalýþanla1rý listeleyen SP

CREATE PROCEDURE sp_Calisanlar
  @ad NVARCHAR(10),
  @soyad NVARCHAR(20)

AS

   BEGIN

     SELECT * 
	 FROM Employees
	 WHERE FirstName=@ad 
	 AND   LastName=@soyad

   END


EXECUTE sp_Calisanlar 'Nancy','Davolio'

EXECUTE sp_Calisanlar 'Davolio','Nancy'

EXECUTE sp_Calisanlar @soyad='Davolio',@ad='Nancy'


--Procedure deðiþikliði yapýldý.
ALTER PROCEDURE sp_Calisanlar
  @ad NVARCHAR(10),
  @soyad NVARCHAR(20)

AS

   BEGIN

     SELECT FirstName,LastName 
	 FROM Employees
	 WHERE FirstName=@ad 
	 AND   LastName=@soyad

   END

--Procedure silme iþlemini

DROP PROCEDURE sp_Calisanlar


-- Customers tablosuna INSERT iþlemi yapan STORED PROCEDURE  ama tüm veriler dýþarýdan girilecek.

ALTER PROCEDURE sp_InsertCustomer
       @customerID NCHAR(5),
	   @companyName NVARCHAR(40),
	   @contactName NVARCHAR(30)='Belirtilmedi',--Default deðer atanan sütunlar için Proceduren kullanýmý esnasýnda bir deðer belirtilmediyse otomatik olarak Belirtilmedi yazacak ancak deðer giriþi saðlandýysa son girelen deðeri yazacaktýr.
	   @contactTitle NVARCHAR(30)='Belirtilmedi',
	   @address NVARCHAR(60)='Belirtilmedi',
	   @city NVARCHAR(15)='Belirtilmedi',
	   @region NVARCHAR(15)='Belirtilmedi',
	   @postalCode NVARCHAR(10)='Belirtilmedi',
	   @country NVARCHAR(15)='Belirtilmedi',
	   @phone NVARCHAR(24)='Belirtilmedi',
	   @fax NVARCHAR(24)='Belirtilmedi'
AS

     BEGIN

	 INSERT INTO Customers VALUES (@customerID,@companyName,@contactName,@contactTitle,@address,@city,@region,@postalCode,@country,@phone,@fax)

	 END

	 EXEC sp_InsertCustomer 'ALPYN','ALPYN HOLDÝNG'

	 EXEC sp_InsertCustomer @customerID='ALMNY',@companyName='ALMN HOLDÝN',@phone='123456789'

	 SELECT * FROM Customers WHERE CustomerID='ALMNY'



	 SELECT * FROM Customers WHERE [CustomerID]='ALPYN'

	------STORED PROCEDURE-------

---Kullanýcýnýn belirttiði kategoriyi eðer kategoriler tablosunda yok ise ekleyen var ise kategori adýna göre 
--açýklama alanýný güncelleyen SP.

CREATE PROCEDURE sp_KategoriEkle
    @categoryName NVARCHAR(15),
	@description NTEXT
AS

  BEGIN

   IF EXISTS(SELECT * FROM Categories WHERE CategoryName=@categoryName)
      BEGIN
	  --//Bulduðunda
	         UPDATE Categories SET [Description]=@description WHERE  CategoryName=@categoryName

			 PRINT 'Bu kategori daha önceden eklenmiþtir.Kategoriye ait açýklama bilgisi güncellenmiþtir.'
	  END
   ELSE
      BEGIN
	  --//Bulamadýðýnda

	          INSERT INTO Categories(CategoryName,[Description]) VALUES (@categoryName,@description)

	  END

  END

 
 EXEC sp_KategoriEkle 'þaraplar','üzümden yapýlýr.'


 SELECT * FROM Categories

 
 EXEC sp_KategoriEkle 'þaraplar','En ucuzu köpek öldürendir.'



 --Girilen 3 tane sayýnýn toplamýný bulan SP.

CREATE PROCEDURE sp_SayilariTopla
       @sayi1 INT,
	   @sayi2 INT,
	   @sayi3 INT
AS
       BEGIN

	         DECLARE @toplam INT

			 set @toplam=@sayi1+@sayi2+@sayi3

			 RETURN @toplam

	   END

--ÇALIÞTIRMAK 
DECLARE @sonuc INT

EXEC @sonuc= sp_SayilariTopla 1,2,4

PRINT 'Sonuç:'+CAST(@sonuc AS NVARCHAR)


--Girilen 3 sayýnýn toplamýný ve ayný sayýlarýn ortalamasýný birlikte gösteriniz.

ALTER PROCEDURE sp_ToplaVeOrtala
   @sayi1 INT,
   @sayi2 INT,
   @sayi3 INT,
   @ortalama DECIMAL(18,2) OUTPUT
AS
   BEGIN 
        DECLARE @toplam INT
        
        SELECT @toplam=@sayi1+@sayi2+@sayi3
        
        SELECT @ortalama=@toplam/3.0
        
        RETURN @toplam

   END

--Çalýþtýrma

DECLARE @sonuc INT,@ort DECIMAL(18,2)

EXEC @sonuc=sp_ToplaVeOrtala 1,50,3,@ort OUTPUT

SELECT @sonuc AS[Sayýlarým Toplamý],@ort AS [Sayýlarýn Ortalamasý]

--** BÝRDEN FAZLA VERÝYÝ DIÞARI ÇIKARTMAK ÝÇÝN OUTPUT KULLANILIR. SADECE 1 RETURN YAZABÝLRÝÝM. GERÝ KALAN ÝÇÝN OUTPUT KULLANIYORUM. DECLARE ÝLE GEREKLÝ TANIMLAMALARI YAPMAM GEREKÝYOR.SON 3 SATIR  BÝRLÝKTE ÇALIÞTIRILIYOR.



------------****************-----------------------

--SP. kullanarak ürün ve kategori ekleme (eðer kategori daha önceden eklenmiþse yeniden eklemek yerine o kategorinin 
--ýd bulunarak ürün eklenmelidir.)

CREATE PROCEDURE sp_UrunVeKategori
       @urunAdi NVARCHAR(40),
	   @kategoriAdi NVARCHAR(15),
	   @girilenUrunID INT OUTPUT
AS

       BEGIN
	        DECLARE @kategoriID INT
			
			IF EXISTS(SELECT * FROM Categories WHERE CategoryName=@kategoriAdi)
			   BEGIN 

			      SELECT @kategoriID =CategoryID
				  FROM Categories
				  WHERE CategoryName=@kategoriAdi
			   END
			ELSE
			   BEGIN

			    INSERT INTO Categories (CategoryName) VALUES (@kategoriAdi)
			   
			    SELECT @kategoriID=@@IDENTITY--Girilen son kaydýn ID bilgisini döndüren SQL Server'da tanýmlý olan global bir deðiþkendir.
			   END
            INSERT INTO Products (CategoryID,ProductName) VALUES (@kategoriID,@urunAdi)

			SELECT @girilenUrunID=@@IDENTITY
	   END

	    --SORU: Kategori adý varsa bile ürünü Products tablosuna eklemesi için buraya neden insert into yapmýyoruz?

			   --Buraya söylediðin gibi insert into yazabilirim.Fakat buraya Insert Into yazarsam else bloðu içerisinde de yine Product tablosuna Insert Into yazmam gerekecek.Kod tekrarý olmasýn diye buradan sadece id bilgisini aldým ve else bloðundanda sadece id bilgisini alarak en altta tek kodla ekleme iþlemini gerçekleþtirdim.

DECLARE @id INT -- SORU:Bunu neden tanýmlamalýyýz?

				--Çünkü Stored Procedure'da ki OUTPUT girilenUrunID bilgisinin sonucunu almam gerekiyor.Eklenen ürün id'yi bulabilmek için.

				--OUTPUT PARAMETRE varsa bir stored procedure'da o sana sonuç dönüyordur.Onu da karþýlayabilmek için ayný tipte deðiþkenle karþýlamak gerekir.

--NOT:Yukarýda bulunan @id aslýndan procedure çalýþtýkdan sonran cevap dönen girilenUrunID parametresidir.

EXEC sp_UrunVeKategori 'Doluca2','þaraplar2',@id OUTPUT

PRINT 'Son girilen ürün no'+CAST(@id AS NVARCHAR)

SELECT * FROM Products WHERE ProductID=81

SELECT * FROM Categories WHERE CategoryID=13

--@@IDENTITY -- EN SON KAYIT NE ÝSE EN SON ONU GETÝRÝR.
--PRINT: SADECE METÝN DÖNER. BU YÜZDEN SAYI GETÝRMEK ÝSTERSEM CAST KULLANMAK ZORUNDAYIM.



--SP ile yeni bir bölge ekleme iþlemi yapýnýz(Eðer daha önceden ayný bölge eklemiþ ise hata mesajý fýrlatýnýz)(Region)

CREATE PROCEDURE sp_BolgeEkle
       @regionId INT,
	   @regionDescription NCHAR(50)
AS

       BEGIN

	   IF EXISTS(SELECT * FROM Region WHERE RegionID=@regionId OR RegionDescription=@regionDescription)
	       BEGIN

		   PRINT 'Daha önceden böyle bir kayýt eklenmiþ!'

		   END
	   ELSE
	       BEGIN

		   INSERT INTO Region (RegionID,RegionDescription) VALUES (@regionId,@regionDescription)

		   END

	   END

EXEC sp_BolgeEkle 6,'Güney'










































































	   










































































































