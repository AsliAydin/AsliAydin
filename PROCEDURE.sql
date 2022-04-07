ALTER PROCEDURE TOPMENU
AS
BEGIN
   SELECT * FROM MENU WHERE ParentMenuID IS NULL and Status=1
   ORDER BY AutoID
END

EXEC TOPMENU

ALTER PROCEDURE sp_IDILESORGULA
(
@id UNIQUEIDENTIFIER
)
AS
BEGIN
        SELECT * FROM MENU WHERE ParentMenuID=@id and Status=1
END

EXEC [dbo].[IDILESORGULA] 'EA61620B-EC90-48B4-95F8-5393BF66C04F'

CREATE PROCEDURE sp_GetAllMenus
@menuId UNIQUEIDENTIFIER=null
AS
BEGIN
	IF EXISTS (SELECT * FROM Menu WHERE ParentMenuID=@menuId) 
	   BEGIN
	            SELECT *FROM Menu WHERE ParentMenuID=@menuId AND Status=1
	   END
	ELSE
	    BEGIN
	            SELECT * FROM Menu WHERE ParentMenuID IS NULL AND Status=1
	           ORDER BY AutoID
	    END
END


EXEC sp_GetAllMenus 'EA61620B-EC90-48B4-95F8-5393BF66C04F'

EXEC sp_GetAllMenus

CREATE PROCEDURE sp_GetAreaLefts
AS
BEGIN
		SELECT * FROM AreaLeft2 WHERE Status=1
		Order By OrderNo
END
 

EXEC sp_GetAreaLefts

CREATE PROCEDURE sp_GetAreaRight
AS

BEGIN
		SELECT * FROM AREARIGHT WHERE Status=1 
		ORDER BY OrderNo
END

EXEC sp_GetAreaRight


CREATE PROCEDURE sp_NewRecord
@status int,
@email nvarchar,
@sifre nvarchar,
@cinsiyet char,
@kampanya bit,
@kontrat bit
AS

BEGIN
		IF EXISTS (SELECT * FROM [User] WHERE @email=EmailAddress)
			BEGIN 
				
				PRINT 'Bu email adresi ile abonelik yapýlmýþtýr.'
			END
		ELSE
			BEGIN
				INSERT INTO [User] (Status,EmailAddress,Password,Gender,Iscampaign,IsContract) 
				VALUES (@status,@email,@sifre,@cinsiyet,@kampanya,@kontrat)
				PRINT 'Abonelik kaydýnýz yapýlmýþtýr.'
			END
END

EXEC sp_NewRecord 1,'asli.aydin@gmail.com', '456789','K','1','0'