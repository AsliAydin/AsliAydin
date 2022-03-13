select dateadd (day,5,'20191111')

select dateadd (MONTH,1,'20191111')

select dateadd (year,1,'20191111')


declare @date1 as date = '20180201'
declare @date2 as date ='20180301'

select DATEDIFF(YEAR,@date1,@date2)

declare @date as datetime = '20180501 17:35'
select datepart(MINUTE,@date)

declare @date as datetime = '20180501 17:35'
select day(@date)

declare @date as datetime = '20180501 17:35'
select month(@date)

declare @date as datetime = '20180501 17:35'
select year(@date)

select DATEFROMPARTS (2018,3,15)