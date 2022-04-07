---TRANSACTION-----

--Transaction bir sorgu'nun takip edildi�i i� birimidir.Veri b�t�nl��� olmas� istenilen �nemli uygulamalarda s�kl�kla kullan�l�r..

--Transaction k���k par�alara ayrulan ve b�t�nll��� korunmas� istenilen i�lemleri takip eden sistemdir.

--Transaction i�ersindeki komutlar i�lem bitirilene kadar ba�ar�s�z say�l�r.

--TRANSACTION NASIL �ALI�IR?---
--1.Ad�m:�zlem istedi�iniz query s�reci BEGIN TRANSACTION ile ba�lat�l�r.
--2.Ad�m:S�re� s�rekli kontrol edilir.
--3.Ad�m: 
--RollBack=>E�er i�lem a�amas�nda bir hata olursa ROLLBACK ile i�lem ba�lang�� noktas�na kadar geri al�r ve durdurulur.
--Commit=>��lem ba�ar�l� olursa COMMIT transaction ile i�lem onlaylan�l�r.

--NOT:Transaction tan�mland� zaman commit veya rollback yap�lmad� zaman sistem ba�ka i�lemleri izin vermeyecektir.


BEGIN TRAN

INSERT INTO tbtSample ([Name]) VALUES ('Ahmet')

INSERT INTO tbtSample ([Name]) VALUES ('Mehmet')

INSERT INTO tbtSample ([Name]) VALUES ('Ay�e')


ROLLBACK--GER� ALMA 

COMMIT


BEGIN TRAN 

DELETE FROM [dbo].[tbtSample] WHERE [Name]='Mehmet'

ROLLBACK

COMMIT

SELECT * FROM [dbo].[tbtSample]



/*

TRIGGER

Bir tablo �zerinde INSERT,DELETE ve UPDATE i�lemlerinden biri yap�ld��nda otomatik olarak devreye girmesini istedi�imiz i�lemlerimiz varsa bunu TRIGGER ile ��zebiliriz.

Bu i�lemlerde bize yard�mc� olmak i�in iki tane sanal tablo vard�r.Bunlar:

INSERTED ve DELETED

Bu tablolar trigger'in �zerinde tan�ml� oldu�u base tablo ile birebir ayn� yap�dad�r.Yani b�ylece girilen bir kayd� INSERTED tablosundan , silinen bir kayd� DELETED tablsoundan elde edebiliriz.UPDATE i�lemi ise �ncelikle bir kayd�n silinmesi, daha sonra bu kaydn g�ncellenerek tabloya girilmesi durumu oldu�udan UPDATE ieminde INSERTED ve DELETED tablololar�n�n ikisin faydalan�l�r.

Trigger'lar otomatik olarak tetiklenirler.Biz kendimiz istedi�imiz zaman tetikleyemeyiz.


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
VALUES('Alpay','G�rel','Adresi girildi',@@IDENTITY)

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



CREATE TRIGGER Kay�tEklendi ON tbtUser
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

DROP TRIGGER [Kay�tEklendi]


CREATE TRIGGER HangiIslemYapildi ON tbtUser
AFTER INSERT,UPDATE,DELETE
AS
   IF EXISTS(SELECT * FROM INSERTED)
       BEGIN
	   
	        IF EXISTS(SELECT * FROM DELETED)
	           BEGIN
	              PRINT 'G�ncelleme i�lemi yapt�n�z'
	           END
	        ELSE
	           BEGIN 
	              PRINT 'Ekleme i�lemi yapt�n�z'
	            END
      END
   ELSE 
	   BEGIN
	      IF EXISTS(SELECT * FROM DELETED)
	         BEGIN
	             PRINT 'Silme i�lemi yapt�n�z'
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
   print 'Mail adresi sistemde kay�tl�d�r.'
   end
end


exec YeniKayit 'candankilic@gmail.com','ascf',K,1,1,1


select * from[dbo].[User]






/*

 TRUNCATE DELETE G�B� S�L�YOR AMA YEN� EKLED���NDE ID1 DEN BA�LIYOR ��NK� LOG DA S�L�YOR. BU NEDENLE KULLANILMASI
  �STENMEZ. SQL TANIMINDA YETK�LERDE SADECE OKUMA G�B� YETK�LER VER�LEB�L�ND��� G�B� TRUNCATE YETK�S� VERMEYEB�L�R�Z.
  
   */
   /*
   TRIGGER : B�R ��LEM YAPILDI�INDA OTOMAT�K BA�KA ��LEM ���N G�REV VEREB�L�YORSUN.
   */
   /* trigger ve truncate i�in diagramda ba�lant� olmamas� gerekiyor */

   CREATE TRIGGER Kay�tEklendi ON TBTUSER
   AFTER INSERT
   AS
   UPDATE TBTUSER SET [PASSWORD]=1234 WHERE ID=2

   INSERT INTO TBTUSER (Email,UserName,Password) VALUES ('elma.armut@bilgeadam.com','elma.armut','123')

   select * from TBTUSER

   -- shift alt tu�lar�na ayn� anda bas�p hizalama yapabilirim
   --update asl�nda delete ve insert demek.(ctrl bo�luk sana syntax a�ar)

   /*VER� TABANI GENERATE SCRIPT ILE KAYIT EDIP ��ER�YE ALMA ��LEM� ���N: USE SAMPLE1 G�R�NCE �ST� S�L�NECEK 
   KONUYLA �LG�S� YOK. DATABASE MASTER DA OLMALI. 
		USE MASTER
		GO
		CREATE DATABASE SAMPLE1
		GO
	KOMUTUNU �STE YAZIIYORUM VE HERHANG� BR� YERDE EXEC �LE �ALI�TIRIYORUM.

	*/

	/* 

	VER� TABANI YETK�LEND�RMES�

	CONNECT KISMINDA 

	SECURITY-- LOGINS NEM LOGIN A�ILAN EKRANDA �S�M �STER. �S�M YAZDIM.
	SQL SERVER AUTH KISMINA ��FRE YAZDIM.
	SERVER ROLES PUBLIC SE��L� SADECE G�R�NT�LEYEB�L�R. ( OWNER FULL YETK�L� DEMEK)
	USER MAPING TABANI A�ILINCA SADECE �ALI�MASINI �STED���M DB LER� SE��YORUM.
	STATUS ALANINDA B�R ��LEM YAPMIYORUM VE  OK D�YORUM.

	CONNECT KISMINDAN �IKIP TEKRAR G�RERKEN SQL SERVER SE��P KULLANICI ADI VE ��FRE G�REREK �NCE YEN� ��FRE 
	BEL�RLEMEN� �STER SONRA T�M EKRANI G�R�RS�N AMA D��ERLER�NE ULA�AMAZSIN HATA VER�R YETK�N YOK D�YE.
	*/