---TRANSACTION-----

--Transaction bir sorgu'nun takip edildiði iþ birimidir.Veri bütünlüðü olmasý istenilen önemli uygulamalarda sýklýkla kullanýlýr..

--Transaction küçük parçalara ayrulan ve bütünllüðü korunmasý istenilen iþlemleri takip eden sistemdir.

--Transaction içersindeki komutlar iþlem bitirilene kadar baþarýsýz sayýlýr.

--TRANSACTION NASIL ÇALIÞIR?---
--1.Adým:Ýzlem istediðiniz query süreci BEGIN TRANSACTION ile baþlatýlýr.
--2.Adým:Süreç sürekli kontrol edilir.
--3.Adým: 
--RollBack=>Eðer iþlem aþamasýnda bir hata olursa ROLLBACK ile iþlem baþlangýç noktasýna kadar geri alýr ve durdurulur.
--Commit=>Ýþlem baþarýlý olursa COMMIT transaction ile iþlem onlaylanýlýr.

--NOT:Transaction tanýmlandý zaman commit veya rollback yapýlmadý zaman sistem baþka iþlemleri izin vermeyecektir.


BEGIN TRAN

INSERT INTO tbtSample ([Name]) VALUES ('Ahmet')

INSERT INTO tbtSample ([Name]) VALUES ('Mehmet')

INSERT INTO tbtSample ([Name]) VALUES ('Ayþe')


ROLLBACK--GERÝ ALMA 

COMMIT


BEGIN TRAN 

DELETE FROM [dbo].[tbtSample] WHERE [Name]='Mehmet'

ROLLBACK

COMMIT

SELECT * FROM [dbo].[tbtSample]



/*

TRIGGER

Bir tablo üzerinde INSERT,DELETE ve UPDATE iþlemlerinden biri yapýldýðnda otomatik olarak devreye girmesini istediðimiz iþlemlerimiz varsa bunu TRIGGER ile çözebiliriz.

Bu iþlemlerde bize yardýmcý olmak için iki tane sanal tablo vardýr.Bunlar:

INSERTED ve DELETED

Bu tablolar trigger'in üzerinde tanýmlý olduðu base tablo ile birebir ayný yapýdadýr.Yani böylece girilen bir kaydý INSERTED tablosundan , silinen bir kaydý DELETED tablsoundan elde edebiliriz.UPDATE iþlemi ise öncelikle bir kaydýn silinmesi, daha sonra bu kaydn güncellenerek tabloya girilmesi durumu olduðudan UPDATE ieminde INSERTED ve DELETED tablololarýnýn ikisin faydalanýlýr.

Trigger'lar otomatik olarak tetiklenirler.Biz kendimiz istediðimiz zaman tetikleyemeyiz.


*/

CREATE DATABASE [Sample1]

USE [Sample1]

CREATE TABLE tbtUser
(
	ID int primary key identity(1,1),
	Email nvarchar(255),
	UserName nvarchar(50),
	[Password] nvarchar(50)
)

CREATE TABLE tbtUserDetail
(
	ID int primary key identity(1,1),
	FirstName nvarchar(50),
	LastName nvarchar(50),
	[Address] nvarchar(100),
	UserID int
)

INSERT INTO tbtUser (Email,UserName,[Password]) VALUES ('alpay.gurel@bilgeadam.com','alpay.gurel','123')

INSERT INTO tbtUserDetail (FirstName,LastName,Address,UserID)
VALUES('Alpay','Gürel','Adresi girildi',@@IDENTITY)

INSERT INTO tbtUser (Email,UserName,[Password]) VALUES ('veli.medeni@bilgeadam.com','veli.medeni','123')

INSERT INTO tbtUserDetail (FirstName,LastName,Address,UserID)
VALUES('Veli','Medeni','Adresi girildi',@@IDENTITY)

INSERT INTO tbtUser (Email,UserName,[Password]) VALUES ('enis.duman@bilgeadam.com','enis.duman','123')

INSERT INTO tbtUserDetail (FirstName,LastName,Address,UserID)
VALUES('Enis','Duman','Adresi girildi',@@IDENTITY)


SELECT * FROM tbtUser

SELECT * FROM tbtUserDetail

TRUNCATE TABLE tbtUser

TRUNCATE TABLE tbtUserDetail



CREATE TRIGGER KayýtEklendi ON tbtUser
AFTER INSERT
AS
UPDATE tbtUser SET [Password]=1234 WHERE ID=2


SELECT * FROM tbtUser

INSERT INTO tbtUser (Email,UserName,Password) VALUES ('elma.armut@bilgeadam.com','elma.armut','123')


ALTER TRIGGER KayitSilindi ON tbtUser
AFTER DELETE
AS
DECLARE @userId INT
SELECT @userId=ID FROM deleted
DELETE FROM tbtUserDetail WHERE UserID=@userId
SELECT * FROM tbtUser

DELETE FROM tbtUser WHERE ID=2
DELETE FROM tbtUser WHERE ID=3

CREATE TRIGGER KayitGuncellendi ON tbtUser
FOR UPDATE
AS
DECLARE @userId INT,@password NVARCHAR(50)
SELECT @userId=ID,@password=Password FROM inserted
UPDATE tbtUserDetail SET [Address]='UserId='+CAST(@userId AS NVARCHAR(10))+' Password='+CAST(@password AS NVARCHAR(10)) WHERE UserID=@userId

SELECT * FROM tbtUser
SELECT * FROM tbtUserDetail

UPDATE tbtUser SET Password=123456 WHERE ID=1

DROP TRIGGER [KayýtEklendi]


CREATE TRIGGER HangiIslemYapildi ON tbtUser
AFTER INSERT,UPDATE,DELETE
AS
   IF EXISTS(SELECT * FROM INSERTED)
       BEGIN
	   
	        IF EXISTS(SELECT * FROM DELETED)
	           BEGIN
	              PRINT 'Güncelleme iþlemi yaptýnýz'
	           END
	        ELSE
	           BEGIN 
	              PRINT 'Ekleme iþlemi yaptýnýz'
	            END
      END
   ELSE 
	   BEGIN
	      IF EXISTS(SELECT * FROM DELETED)
	         BEGIN
	             PRINT 'Silme iþlemi yaptýnýz'
	         END
      END

INSERT INTO tbtUser (Email,UserName,Password) VALUES ('a','b','c')

UPDATE tbtUser SET Email='b' WHERE Email='a'

DELETE FROM tbtUser WHERE Email='b'

CREATE PROCEDURE YeniKayit
(@emailAddress nvarchar(255),@password NVARCHAR(MAX),@gender char(1),@isCompaing bit,@isContract bit,@status int )
as
begin
   
   if not exists ( select * from [dbo].[User] where [EmailAddress]=@emailAddress)

   begin
   insert into 
   [dbo].[User]([EmailAddress],[Password],[Gender],[IsCampaign],[IsContract],[Status]) 
   values (@emailAddress,@password,@gender,@isCompaing,@isContract,@status  )
   end
   else
   begin
   print 'Mail adresi sistemde kayýtlýdýr.'
   end
end


exec YeniKayit 'candankilic@gmail.com','ascf',K,1,1,1


select * from[dbo].[User]






/*

 TRUNCATE DELETE GÝBÝ SÝLÝYOR AMA YENÝ EKLEDÝÐÝNDE ID1 DEN BAÞLIYOR ÇÜNKÜ LOG DA SÝLÝYOR. BU NEDENLE KULLANILMASI
  ÝSTENMEZ. SQL TANIMINDA YETKÝLERDE SADECE OKUMA GÝBÝ YETKÝLER VERÝLEBÝLÝNDÝÐÝ GÝBÝ TRUNCATE YETKÝSÝ VERMEYEBÝLÝRÝZ.
  
   */
   /*
   TRIGGER : BÝR ÝÞLEM YAPILDIÐINDA OTOMATÝK BAÞKA ÝÞLEM ÝÇÝN GÖREV VEREBÝLÝYORSUN.
   */
   /* trigger ve truncate için diagramda baðlantý olmamasý gerekiyor */

   CREATE TRIGGER KayýtEklendi ON TBTUSER
   AFTER INSERT
   AS
   UPDATE TBTUSER SET [PASSWORD]=1234 WHERE ID=2

   INSERT INTO TBTUSER (Email,UserName,Password) VALUES ('elma.armut@bilgeadam.com','elma.armut','123')

   select * from TBTUSER

   -- shift alt tuþlarýna ayný anda basýp hizalama yapabilirim
   --update aslýnda delete ve insert demek.(ctrl boþluk sana syntax açar)

   /*VERÝ TABANI GENERATE SCRIPT ILE KAYIT EDIP ÝÇERÝYE ALMA ÝÞLEMÝ ÝÇÝN: USE SAMPLE1 GÖRÜNCE ÜSTÜ SÝLÝNECEK 
   KONUYLA ÝLGÝSÝ YOK. DATABASE MASTER DA OLMALI. 
		USE MASTER
		GO
		CREATE DATABASE SAMPLE1
		GO
	KOMUTUNU ÜSTE YAZIIYORUM VE HERHANGÝ BRÝ YERDE EXEC ÝLE ÇALIÞTIRIYORUM.

	*/

	/* 

	VERÝ TABANI YETKÝLENDÝRMESÝ

	CONNECT KISMINDA 

	SECURITY-- LOGINS NEM LOGIN AÇILAN EKRANDA ÝSÝM ÝSTER. ÝSÝM YAZDIM.
	SQL SERVER AUTH KISMINA ÞÝFRE YAZDIM.
	SERVER ROLES PUBLIC SEÇÝLÝ SADECE GÖRÜNTÜLEYEBÝLÝR. ( OWNER FULL YETKÝLÝ DEMEK)
	USER MAPING TABANI AÇILINCA SADECE ÇALIÞMASINI ÝSTEDÝÐÝM DB LERÝ SEÇÝYORUM.
	STATUS ALANINDA BÝR ÝÞLEM YAPMIYORUM VE  OK DÝYORUM.

	CONNECT KISMINDAN ÇIKIP TEKRAR GÝRERKEN SQL SERVER SEÇÝP KULLANICI ADI VE ÞÝFRE GÝREREK ÖNCE YENÝ ÞÝFRE 
	BELÝRLEMENÝ ÝSTER SONRA TÜM EKRANI GÖRÜRSÜN AMA DÝÐERLERÝNE ULAÞAMAZSIN HATA VERÝR YETKÝN YOK DÝYE.
	*/