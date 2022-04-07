---FUNCTION--------

/*
	Tablo D�nd�ren Fonksiyonlar
	*Skaler fonksiyonlar gibi d��ar�dan parametre alabilirler.
	*Begin - End kullan�lmaz
	*Fonksiyon kullan�m�nda �ema ismi kullanmaya gerek yoktur.
*/

--Id girilerek �al��an bilgilerini getiren function yaz.

CREATE FUNCTION CalisanBilgileriniGetir
(
@employeeID int
)

RETURNS TABLE

RETURN SELECT *
       FROM Employees
	   WHERE EmployeeID=@employeeID



SELECT * FROM [CalisanBilgileriniGetir](5)


--Ms,Mrs gibi �nvan girilerek �al��an bilgilerini getiren function yaz.

ALTER FUNCTION CalisanlariUnvanaGoreGetir
(@unvan1 nvarchar(25),@unvan2 nvarchar(25))

RETURNS TABLE
RETURN SELECT *
       FROM Employees
	   WHERE TitleOfCourtesy IN (@unvan1,@unvan2)

SELECT FirstName,LastName,TitleOfCourtesy FROM [dbo].[CalisanlariUnvanaGoreGetir]('Ms.')


--Ba� harf girilerek buna g�re FirstName kolonu kullan�larak �al��anlar getirilecek.

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
-------STORED PROCEDURE (Sakl� Yordamlar)---------

TSQL komular� ile haz�rlad���m�z i�lemler b�t�n�n �al��t�r�lma an�nda derlenmesi ile size bir sonu �reten sql server birle�enidir.S�k kullan�lan sql komutlar�m�z� (select,insert,update,delete) store procedure i�erisinde kullan�rsak bir sonraki a�amada sadece �a��r�r�z.
Proglama dilinde METHOD ve Sql Serverdaki User Defined Funculara benzerler.

Store Procedurlar;
1.Performans ve g�venlik objeleridir.
2.Tablolardan sonraki en �nemli veritaban� objesidir.
3.Input ve Output parametre tipleri vard�r.
4.Geriye birden fazla de�er d�nd�rebilir.(Output parametre)

NOT:Birden fazla d�n�� tipi output parametere ile yap�l�r.SP'lerin d�n�� tipleri her zaman INT olarak tan�mlanm��t�r.
NOT2: Veritaban� objeleri aras�nda en h�zl� �al��an ve g�venli eri�im sa�layan i�lemlerden biridir.

--FUNTION (UDF) & PROCEDURE ARASINDAK� FARKLILIKLAR

FUNTION
1.Funtion de�er d�nd�rmek zorundad�r.
2.Input parametre tan�mlan�rken,output parametreleri destelemez.
3.Select ifadeleri (Sorgu i�erisinde) ile �a�r�l�r.

PROCEDURE
1.De�er d�nd�rmek zorunda de�illerdir.
2.Input parametre tan�maliblirken, output parametreler desteklenir.
3.Select ifadeleri i�erisinde �al��t�r�lamazlar,Procedure �a��rmak i�in exec veya execute komutu kullan�lmal�d�r.
*/

--calisan bilgileirni getiren sp yaz.

CREATE PROCEDURE sp_CalisanlariGetir
AS
      BEGIN

	    SELECT *
		FROM Employees
		WHERE City IS NOT NULL

	  END

SELECT * FROM sp_CalisanlariGetir--Yanl�� bir tan�lamad�r.Execute ile �al��t�r�l�r.1

EXECUTE sp_CalisanlariGetir

--T�m kategorilerle bu kategorilere ait �r�nleri getiren Store Procedure.

CREATE PROCEDURE sp_UrunlerVeKategoriler
AS
    BEGIN

	SELECT CategoryName,ProductName
	FROM Categories INNER JOIN Products 
	ON Categories.CategoryID=Products.CategoryID

	END

EXEC sp_UrunlerVeKategoriler
--view olarak ayn�s�n� evet yapars�n ama bu daha h�zl� ve g�venli. Alt yap�s�nda indexleme var. view da parametre alamazs�n, @sayi int gibi. sp de olur. yani d��ar�dan parametre girebilirim splerde.



--Kategorisine g�re �r�nleri getiren store procedur yaz�n�z. 
--(d��ar�dan parametre gireceksin yani category id yaz�p sorgulayacaks�n)( Input: veri giri�i olunca ge�elidir.)


CREATE PROCEDURE sp_UrunByKategori
@id INT--Procedure'e parametre aktaryoruz.Parametreler yaz�l�rken, �nce parametre ad� (ba��nda @ i�areti ile birlikte) daha sonra ise parametrenin tipi yaz�l�r.

AS
   BEGIN 

   SELECT CategoryName,ProductName
	FROM Categories INNER JOIN Products 
	ON Categories.CategoryID=Products.CategoryID
	WHERE Categories.CategoryID=@id

   END

exec sp_UrunByKategori 1

exec sp_UrunByKategori @id=1


--�al��an�n ad�na g�re arama yap�p listeleyen SP.

CREATE PROCEDURE sp_CalisaninAdinaGoreGetir
@ad nvarchar(10)
AS

   BEGIN

         SELECT *
		 FROM Employees
		 WHERE FirstName LIKE ('%'+(@ad)+'%')

   END


EXEC sp_CalisaninAdinaGoreGetir 'a'


--Ad�na ve soyad�na g�re �al��anla1r� listeleyen SP

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


--Procedure de�i�ikli�i yap�ld�.
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

--Procedure silme i�lemini

DROP PROCEDURE sp_Calisanlar


-- Customers tablosuna INSERT i�lemi yapan STORED PROCEDURE  ama t�m veriler d��ar�dan girilecek.

ALTER PROCEDURE sp_InsertCustomer
       @customerID NCHAR(5),
	   @companyName NVARCHAR(40),
	   @contactName NVARCHAR(30)='Belirtilmedi',--Default de�er atanan s�tunlar i�in Proceduren kullan�m� esnas�nda bir de�er belirtilmediyse otomatik olarak Belirtilmedi yazacak ancak de�er giri�i sa�land�ysa son girelen de�eri yazacakt�r.
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

	 EXEC sp_InsertCustomer 'ALPYN','ALPYN HOLD�NG'

	 EXEC sp_InsertCustomer @customerID='ALMNY',@companyName='ALMN HOLD�N',@phone='123456789'

	 SELECT * FROM Customers WHERE CustomerID='ALMNY'



	 SELECT * FROM Customers WHERE [CustomerID]='ALPYN'

	------STORED PROCEDURE-------

---Kullan�c�n�n belirtti�i kategoriyi e�er kategoriler tablosunda yok ise ekleyen var ise kategori ad�na g�re 
--a��klama alan�n� g�ncelleyen SP.

CREATE PROCEDURE sp_KategoriEkle
    @categoryName NVARCHAR(15),
	@description NTEXT
AS

  BEGIN

   IF EXISTS(SELECT * FROM Categories WHERE CategoryName=@categoryName)
      BEGIN
	  --//Buldu�unda
	         UPDATE Categories SET [Description]=@description WHERE  CategoryName=@categoryName

			 PRINT 'Bu kategori daha �nceden eklenmi�tir.Kategoriye ait a��klama bilgisi g�ncellenmi�tir.'
	  END
   ELSE
      BEGIN
	  --//Bulamad���nda

	          INSERT INTO Categories(CategoryName,[Description]) VALUES (@categoryName,@description)

	  END

  END

 
 EXEC sp_KategoriEkle '�araplar','�z�mden yap�l�r.'


 SELECT * FROM Categories

 
 EXEC sp_KategoriEkle '�araplar','En ucuzu k�pek �ld�rendir.'



 --Girilen 3 tane say�n�n toplam�n� bulan SP.

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

--�ALI�TIRMAK 
DECLARE @sonuc INT

EXEC @sonuc= sp_SayilariTopla 1,2,4

PRINT 'Sonu�:'+CAST(@sonuc AS NVARCHAR)


--Girilen 3 say�n�n toplam�n� ve ayn� say�lar�n ortalamas�n� birlikte g�steriniz.

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

--�al��t�rma

DECLARE @sonuc INT,@ort DECIMAL(18,2)

EXEC @sonuc=sp_ToplaVeOrtala 1,50,3,@ort OUTPUT

SELECT @sonuc AS[Say�lar�m Toplam�],@ort AS [Say�lar�n Ortalamas�]

--** B�RDEN FAZLA VER�Y� DI�ARI �IKARTMAK ���N OUTPUT KULLANILIR. SADECE 1 RETURN YAZAB�LR��M. GER� KALAN ���N OUTPUT KULLANIYORUM. DECLARE �LE GEREKL� TANIMLAMALARI YAPMAM GEREK�YOR.SON 3 SATIR  B�RL�KTE �ALI�TIRILIYOR.



------------****************-----------------------

--SP. kullanarak �r�n ve kategori ekleme (e�er kategori daha �nceden eklenmi�se yeniden eklemek yerine o kategorinin 
--�d bulunarak �r�n eklenmelidir.)

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
			   
			    SELECT @kategoriID=@@IDENTITY--Girilen son kayd�n ID bilgisini d�nd�ren SQL Server'da tan�ml� olan global bir de�i�kendir.
			   END
            INSERT INTO Products (CategoryID,ProductName) VALUES (@kategoriID,@urunAdi)

			SELECT @girilenUrunID=@@IDENTITY
	   END

	    --SORU: Kategori ad� varsa bile �r�n� Products tablosuna eklemesi i�in buraya neden insert into yapm�yoruz?

			   --Buraya s�yledi�in gibi insert into yazabilirim.Fakat buraya Insert Into yazarsam else blo�u i�erisinde de yine Product tablosuna Insert Into yazmam gerekecek.Kod tekrar� olmas�n diye buradan sadece id bilgisini ald�m ve else blo�undanda sadece id bilgisini alarak en altta tek kodla ekleme i�lemini ger�ekle�tirdim.

DECLARE @id INT -- SORU:Bunu neden tan�mlamal�y�z?

				--��nk� Stored Procedure'da ki OUTPUT girilenUrunID bilgisinin sonucunu almam gerekiyor.Eklenen �r�n id'yi bulabilmek i�in.

				--OUTPUT PARAMETRE varsa bir stored procedure'da o sana sonu� d�n�yordur.Onu da kar��layabilmek i�in ayn� tipte de�i�kenle kar��lamak gerekir.

--NOT:Yukar�da bulunan @id asl�ndan procedure �al��t�kdan sonran cevap d�nen girilenUrunID parametresidir.

EXEC sp_UrunVeKategori 'Doluca2','�araplar2',@id OUTPUT

PRINT 'Son girilen �r�n no'+CAST(@id AS NVARCHAR)

SELECT * FROM Products WHERE ProductID=81

SELECT * FROM Categories WHERE CategoryID=13

--@@IDENTITY -- EN SON KAYIT NE �SE EN SON ONU GET�R�R.
--PRINT: SADECE MET�N D�NER. BU Y�ZDEN SAYI GET�RMEK �STERSEM CAST KULLANMAK ZORUNDAYIM.



--SP ile yeni bir b�lge ekleme i�lemi yap�n�z(E�er daha �nceden ayn� b�lge eklemi� ise hata mesaj� f�rlat�n�z)(Region)

CREATE PROCEDURE sp_BolgeEkle
       @regionId INT,
	   @regionDescription NCHAR(50)
AS

       BEGIN

	   IF EXISTS(SELECT * FROM Region WHERE RegionID=@regionId OR RegionDescription=@regionDescription)
	       BEGIN

		   PRINT 'Daha �nceden b�yle bir kay�t eklenmi�!'

		   END
	   ELSE
	       BEGIN

		   INSERT INTO Region (RegionID,RegionDescription) VALUES (@regionId,@regionDescription)

		   END

	   END

EXEC sp_BolgeEkle 6,'G�ney'










































































	   










































































































