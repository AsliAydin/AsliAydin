---FUNCTION--------

CREATE FUNCTION BringEmployeesInformation
(
@employeeID int
)

RETURNS TABLE

RETURN SELECT *
       FROM Employees
	   WHERE EmployeeID=@employeeID



SELECT * FROM [BringEmployeesInformation](5)


--Write a function that returns employee information by entering a title such as Ms, Mrs.

ALTER FUNCTION BringEmployeesbyTitleOfCourtesy
(@unvan1 nvarchar(25),@unvan2 nvarchar(25))

RETURNS TABLE
RETURN SELECT *
       FROM Employees
	   WHERE TitleOfCourtesy IN (@unvan1,@unvan2)

SELECT FirstName,LastName,TitleOfCourtesy FROM [dbo].[BringEmployeesbyTitleOfCourtesyr]('Ms.')


--Employees will be brought in by entering the initials and using the FirstName column accordingly.

CREATE FUNCTION FetchbyInitials
(@Initials NVARCHAR(1))

RETURNS TABLE
RETURN SELECT *
       FROM Employees
	   WHERE LEFT(FirstName,1)=@Initials
	   --WHERE FirstName LIKE @Initials+'%'

SELECT *
FROM [dbo].[FetchbyInitials]('A')




SELECT * FROM Employees


/*
-------STORED PROCEDURE---------

CREATE PROCEDURE sp_BringEmployees
AS
      BEGIN

	    SELECT *
		FROM Employees
		WHERE City IS NOT NULL

	  END

EXECUTE sp_BringEmployees

--Write Store Procedure, which brings all categories and products belonging to these categories.

CREATE PROCEDURE sp_ProductsandCategories
AS
    BEGIN

	SELECT CategoryName,ProductName
	FROM Categories INNER JOIN Products 
	ON Categories.CategoryID=Products.CategoryID

	END

EXEC sp_ProductsandCategories


--Write the store procedure that brings the products by category.
--(you will enter parameters from outside, so you will write category id and query)( Input: valid when data entry.)


CREATE PROCEDURE sp_ProductByCategory
@id INT

AS
   BEGIN 

   SELECT CategoryName,ProductName
	FROM Categories INNER JOIN Products 
	ON Categories.CategoryID=Products.CategoryID
	WHERE Categories.CategoryID=@id

   END

exec sp_ProductByCategory 1

exec sp_ProductByCategory @id=1


--Searching and listing by employee's name SP.

CREATE PROCEDURE sp_BringByYourEmployeesName
@ad nvarchar(10)
AS

   BEGIN

         SELECT *
		 FROM Employees
		 WHERE FirstName LIKE ('%'+(@ad)+'%')

   END


EXEC sp_BringByYourEmployeesName 'a'


--Write SP that lists employees by first and last name

CREATE PROCEDURE sp_Employees
  @ad NVARCHAR(10),
  @soyad NVARCHAR(20)

AS

   BEGIN

     SELECT * 
	 FROM Employees
	 WHERE FirstName=@ad 
	 AND   LastName=@soyad

   END


EXECUTE sp_Employees 'Nancy','Davolio'

EXECUTE sp_Employees 'Davolio','Nancy'

EXECUTE sp_Employees @soyad='Davolio',@ad='Nancy'


--Changing Procedure
ALTER PROCEDURE sp_Employees
  @ad NVARCHAR(10),
  @soyad NVARCHAR(20)

AS

   BEGIN

     SELECT FirstName,LastName 
	 FROM Employees
	 WHERE FirstName=@ad 
	 AND   LastName=@soyad

   END

--Dropping Procedure

DROP PROCEDURE sp_Employees

-- Write SP that INSERT to the Customers table, but all data will be entered externally.

ALTER PROCEDURE sp_InsertCustomer
       @customerID NCHAR(5),
	   @companyName NVARCHAR(40),
	   @contactName NVARCHAR(30)='Belirtilmedi',
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

	 EXEC sp_InsertCustomer 'ALPYN','ALPYN HOLDİNG'

	 EXEC sp_InsertCustomer @customerID='ALMNY',@companyName='ALMN HOLDİN',@phone='123456789'

	 SELECT * FROM Customers WHERE CustomerID='ALMNY'


	 SELECT * FROM Customers WHERE [CustomerID]='ALPYN'

	------STORED PROCEDURE-------

---Write SP that updates the description field, if the category specified by the user is not in the categories table, if there is someone who adds it, according to the
category name.

CREATE PROCEDURE sp_AddCategory
    @categoryName NVARCHAR(15),
	@description NTEXT
AS

  BEGIN

   IF EXISTS(SELECT * FROM Categories WHERE CategoryName=@categoryName)
      BEGIN
	         UPDATE Categories SET [Description]=@description WHERE  CategoryName=@categoryName

			 PRINT 'This category has been added before. The description information of the category has been updated.'
	  END
   ELSE
      BEGIN
	          INSERT INTO Categories(CategoryName,[Description]) VALUES (@categoryName,@description)

	  END

  END

 
 EXEC sp_AddCategory 'wine','made from grapes.'


 SELECT * FROM Categories

 
 EXEC sp_AddCategory 'wine','France tops the chart as the best wine producing country.'



 --Write SP to find the sum of 3 entered numbers

CREATE PROCEDURE sp_SumNumbers
       @number1 INT,
	   @number2 INT,
	   @number3 INT
AS
       BEGIN

	         DECLARE @sum INT

			 set @sum=@number1+@number2+@number3

			 RETURN @sum

	   END


DECLARE @result INT

EXEC @result= sp_SumNumbers 1,2,4

PRINT 'result:'+CAST(@result AS NVARCHAR)


--Find the sum and the average of three numbers

CREATE PROCEDURE sp_SumandAverage
   @number1 INT,
   @number2 INT,
   @number3 INT,
   @average DECIMAL(18,2) OUTPUT
AS
   BEGIN 
        DECLARE @sum INT
        
        SELECT @sum=@number1+@number2+@number3
        
        SELECT @average=@sum/3.0
        
        RETURN @sum

   END


DECLARE @result INT,@average DECIMAL(18,2)

EXEC @result=sp_SumandAverage 1,50,3,@average OUTPUT

SELECT @result AS[Sum Of Numbers],@average AS [Average Of Numbers]



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
			   
			    SELECT @kategoriID=@@IDENTITY
			   END
            INSERT INTO Products (CategoryID,ProductName) VALUES (@kategoriID,@urunAdi)

			SELECT @girilenUrunID=@@IDENTITY
	   END




--Add a new region with SP(If it has added the same region before, turnback an error message)

CREATE PROCEDURE sp_AddRegion
       @regionId INT,
	   @regionDescription NCHAR(50)
AS

       BEGIN

	   IF EXISTS(SELECT * FROM Region WHERE RegionID=@regionId OR RegionDescription=@regionDescription)
	       BEGIN

		   PRINT 'Such a record has already been added!'

		   END
	   ELSE
	       BEGIN

		   INSERT INTO Region (RegionID,RegionDescription) VALUES (@regionId,@regionDescription)

		   END

	   END

EXEC sp_AddRegion 6,'South'
