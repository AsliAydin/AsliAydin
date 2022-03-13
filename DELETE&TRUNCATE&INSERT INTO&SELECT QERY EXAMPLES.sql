--DELETE&TRUNCATE&INSERT INTO&SELECT QERY EXAMPLES



---ADVENTUREWORKS2017---


SELECT * INTO SALES.STOREINFO
FROM AdventureWorks2017.Sales.vStoreWithDemographics

select * from sales.STOREINFO
select * from sales.STOREINFO where BusinessEntityID=294
select * from sales.STOREINFO where Name='Riders Company'
select * from sales.STOREINFO where name like 'bi%'
select * from sales.STOREINFO where name like '%bike%'
select * from sales.STOREINFO where name like '%bicycle%'
select * from sales.STOREINFO where name like '%company'
select * from sales.STOREINFO where YearOpened>=1990 and YearOpened<=2000
select * from sales.STOREINFO where YearOpened between 1990 and 2000
select * from sales.STOREINFO where name like 'B%' and YearOpened=1990
select * from sales.STOREINFO where name like 'B%'
select * from sales.STOREINFO where YearOpened=1990
select * from sales.STOREINFO where name like 'B%' or YearOpened=1990
select * from sales.STOREINFO where name like 'B'
select * from sales.STOREINFO where Internet='DSL' or Internet ='T1'
select * from sales.STOREINFO where Internet='DSL'
select * from sales.STOREINFO where Internet ='T1'
select * from sales.STOREINFO where Internet In('DSL','T1')

UPDATE SALES.STOREINFO SET AnnualSales=AnnualSales*2
WHERE BusinessEntityID=304

DELETE FROM  SALES.STOREINFO WHERE BusinessEntityID=304

select Distinct BankName from sales.STOREINFO
select Distinct Internet from sales.STOREINFO
select Distinct NumberEmployees from sales.STOREINFO
select distinct Specialty from sales.STOREINFO
select distinct BankName,Specialty from sales.STOREINFO

select * from sales.STOREINFO
order by Name 

select * from sales.STOREINFO
order by Name desc

select * from sales.STOREINFO
where Specialty='mountain'
order by AnnualSales 

select * from sales.STOREINFO
where Specialty='mountain'
order by AnnualSales  desc


select * from sales.STOREINFO
where Specialty='mountain'
order by YearOpened


select * from sales.STOREINFO
where Specialty='mountain'
order by YearOpened desc


select * from sales.STOREINFO
where Specialty='mountain' and NumberEmployees between 20 and 50 
order by YearOpened desc,name asc


--C--

SELECT BankName,SUM(ANNUALSALES) AS TOPLAMSATIS,COUNT(NAME) AS 'MAGAZA ADI'
FROM [Sales].[STOREINFO]
GROUP BY BankName
ORDER BY SUM(ANNUALSALES) DESC

SELECT BankName,SUM(ANNUALSALES) AS TOPLAMSATIS,COUNT(NAME) AS 'MAGAZA ADI'
FROM [Sales].[STOREINFO]
GROUP BY BankName
ORDER BY COUNT(NAME) DESC

--GROUP BY JOB TYPES--

SELECT BusinessType,SUM(ANNUALSALES) AS TOPLAMSATIS,COUNT(NAME) AS 'MAGAZA ADI'
FROM [Sales].[STOREINFO]
GROUP BY BusinessType
ORDER BY COUNT(NAME) DESC

--BUSINESS TYPES GROUP BY BANKS--

SELECT * FROM[Sales].[STOREINFO]

SELECT BusinessType,BankName,
SUM(ANNUALSALES) AS SATISLAR, COUNT(NAME) AS MAGAZAADETI
FROM [Sales].[STOREINFO]
GROUP BY BusinessType,BankName
ORDER BY BusinessType

--SPEACIALTY BY BRANDS --

SELECT Specialty,Brands,SUM(ANNUALSALES) AS SATISLAR,COUNT(NAME) AS MAGAZAADETI
FROM [Sales].[STOREINFO]
GROUP BY Specialty,Brands
ORDER BY Specialty

SELECT Specialty,Brands,SUM(ANNUALSALES) AS SATISLAR,COUNT(NAME) AS MAGAZAADETI
FROM [Sales].[STOREINFO]
GROUP BY Specialty,Brands
ORDER BY Specialty,COUNT(NAME) DESC

SELECT Brands,Specialty,SUM(ANNUALSALES) AS SATISLAR,COUNT(NAME) AS MAGAZAADETI
FROM [Sales].[STOREINFO]
GROUP BY Specialty,Brands
ORDER BY Brands,COUNT(NAME) DESC
