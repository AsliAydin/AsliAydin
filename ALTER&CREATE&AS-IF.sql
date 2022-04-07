
ALTER PROCEDURE sp_GetMenus
AS
BEGIN
  SELECT * FROM [Menu] WHERE ParentMenuID IS NULL AND [Status]=1 ORDER BY AutoID
END

EXEC sp_GetMenus

CREATE PROCEDURE sp_GetParentMenus
@menuId uniqueidentifier
AS
BEGIN
   SELECT * FROM [Menu] WHERE ParentMenuID=@menuId AND [Status]=1
END

EXEC sp_GetParentMenus 'D821D99A-7FF9-4CD7-AC56-C4618F540C24'

CREATE PROCEDURE sp_GetAllMenus
@menuId uniqueidentifier=null
AS
BEGIN
  IF EXISTS(SELECT * FROM [Menu] WHERE ParentMenuID=@menuId)
  BEGIN
   SELECT * FROM [Menu] WHERE ParentMenuID=@menuId AND [Status]=1
  END
  ELSE
  BEGIN
   SELECT * FROM [Menu] WHERE ParentMenuID IS NULL AND [Status]=1 ORDER BY AutoID
  END
END

EXEC sp_GetAllMenus 'D821D99A-7FF9-4CD7-AC56-C4618F540C24'


CREATE PROC sp_GetAllAreaRight
AS
BEGIN
   SELECT * FROM [dbo].[AreaRight] WHERE [Status]=1
END


EXEC sp_GetAllAreaRight


CREATE PROCEDURE sp_GetAreaLefts
AS
BEGIN
  SELECT * FROM [dbo].[AreaLeft] WHERE [Status]=1 ORDER BY OrderNo
END

EXEC sp_GetAreaLefts



