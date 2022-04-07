---TRANSACTION-----


BEGIN TRAN

INSERT INTO tbtSample ([Name]) VALUES ('Ahmet')

INSERT INTO tbtSample ([Name]) VALUES ('Mehmet')

INSERT INTO tbtSample ([Name]) VALUES ('Ayşe')


ROLLBACK

COMMIT


BEGIN TRAN 

DELETE FROM [dbo].[tbtSample] WHERE [Name]='Mehmet'

ROLLBACK

COMMIT

SELECT * FROM [dbo].[tbtSample]



----TRIGGER-----


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

INSERT INTO tbtUser (Email,UserName,[Password]) VALUES ('asliaydin_a@yahoo.com','asli.aydin','123')

INSERT INTO tbtUserDetail (FirstName,LastName,Address,UserID)
VALUES('Asli','Aydin','Adresi girildi',@@IDENTITY)

INSERT INTO tbtUser (Email,UserName,[Password]) VALUES ('ulas.sahin@windltf.com','ulas.sahin','123')

INSERT INTO tbtUserDetail (FirstName,LastName,Address,UserID)
VALUES('Ulas','Sahin','Adresi girildi',@@IDENTITY)

INSERT INTO tbtUser (Email,UserName,[Password]) VALUES ('zeynepkarakas@yahoo.com','zeynep.karakas','123')

INSERT INTO tbtUserDetail (FirstName,LastName,Address,UserID)
VALUES('Zeynep','Karakas','Adresi girildi',@@IDENTITY)


SELECT * FROM tbtUser

SELECT * FROM tbtUserDetail

TRUNCATE TABLE tbtUser

TRUNCATE TABLE tbtUserDetail



CREATE TRIGGER RecordAdded ON tbtUser
AFTER INSERT
AS
UPDATE tbtUser SET [Password]=1234 WHERE ID=2


SELECT * FROM tbtUser

INSERT INTO tbtUser (Email,UserName,Password) VALUES ('yesim.ozcan@bilgeadam.com','yesim.ozcan','123')


ALTER TRIGGER RecordDeleted ON tbtUser
AFTER DELETE
AS
DECLARE @userId INT
SELECT @userId=ID FROM deleted
DELETE FROM tbtUserDetail WHERE UserID=@userId
SELECT * FROM tbtUser

DELETE FROM tbtUser WHERE ID=2
DELETE FROM tbtUser WHERE ID=3

CREATE TRIGGER RecosdUpdated ON tbtUser
FOR UPDATE
AS
DECLARE @userId INT,@password NVARCHAR(50)
SELECT @userId=ID,@password=Password FROM inserted
UPDATE tbtUserDetail SET [Address]='UserId='+CAST(@userId AS NVARCHAR(10))+' Password='+CAST(@password AS NVARCHAR(10)) WHERE UserID=@userId

SELECT * FROM tbtUser
SELECT * FROM tbtUserDetail

UPDATE tbtUser SET Password=123456 WHERE ID=1

DROP TRIGGER [RecordAdded]


CREATE TRIGGER WhichTransactionWasmade ON tbtUser
AFTER INSERT,UPDATE,DELETE
AS
   IF EXISTS(SELECT * FROM INSERTED)
       BEGIN
	   
	        IF EXISTS(SELECT * FROM DELETED)
	           BEGIN
	              PRINT 'You have performed an update'
	           END
	        ELSE
	           BEGIN 
	              PRINT 'You have performed an addition'
	            END
      END
   ELSE 
	   BEGIN
	      IF EXISTS(SELECT * FROM DELETED)
	         BEGIN
	             PRINT 'You have performed a deletion'
	         END
      END

INSERT INTO tbtUser (Email,UserName,Password) VALUES ('a','b','c')

UPDATE tbtUser SET Email='b' WHERE Email='a'

DELETE FROM tbtUser WHERE Email='b'

CREATE PROCEDURE NewRecord
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
   print 'Email address registered in the system.'
   end
end


exec NewRecord 'inanulassahin@gmail.com','ascf',E,1,1,1


select * from[dbo].[User]


   CREATE TRIGGER RecordAdding ON TBTUSER
   AFTER INSERT
   AS
   UPDATE TBTUSER SET [PASSWORD]=1234 WHERE ID=2

   INSERT INTO TBTUSER (Email,UserName,Password) VALUES ('yesim.ozcan@bilgeadam.com','yesim.ozcan','123')

   select * from TBTUSER


