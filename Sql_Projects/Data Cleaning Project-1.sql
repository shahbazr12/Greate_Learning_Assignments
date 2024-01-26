		          ///--DATA CLEANING IN SSMS USING SQL QUERY--///

SELECT * FROM Nashville_housing

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
 ---Standedized the Date Formate -----
 --- we just doing here the date formate standedize from extracting date from date_time using the convert function ---

SELECT [Sale Date] , CONVERT(date,[Sale Date])
FROM Nashville_housing

update Nashville_housing
set [Sale Date] =CONVERT(date,[Sale Date]) 

alter table Nashville_housing
add SalesDateConverted date

update Nashville_housing
set SalesDateConverted = CONVERT(date,[Sale Date]) 

alter table Nashville_housing
drop column [Sale Date]


------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
----POpulate PORPERTY ADDRESS
--HERE IS AN PROBLEM SAME PARCELID HAVING THE SAME PROPERTY_ADDRESS

SELECT *
FROM Nashville_housing
--WHERE [Property Address] IS NULL
ORDER BY [Parcel ID]


SELECT a.[Parcel ID],a.[Property Address],b.[Parcel ID],b.[Property Address],ISNULL(a.[Property Address],b.[Property Address])
FROM Nashville_housing a
join Nashville_housing b
	ON a.[Parcel ID]=b.[Parcel ID]
	and a.[Unnamed: 0]<>b.[Unnamed: 0]
where a.[Property Address] is null


update a ---(a is here alising in joins otherwise it would have nashvilla _housing)
set [Property Address]=ISNULL(a.[Property Address],b.[Property Address])
FROM Nashville_housing a
join Nashville_housing b
	ON a.[Parcel ID]=b.[Parcel ID]
	and a.[Unnamed: 0]<>b.[Unnamed: 0]
where a.[Property Address] is null

select * from Nashville_housing
where [Property Address] is null


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
---Breaking out address into indivisuals columnc (address,city,state)

select *
from Nashville_housing

select
SUBSTRING([Property Address],1,CHARINDEX(' ' ,[Property Address])) as Address
from Nashville_housing

update Nashville_housing
set property_code = SUBSTRING([Property Address],1,CHARINDEX(' ' ,[Property Address]))


alter table Nashville_housing
add Property_City varchar(100)

update Nashville_housing
set Property_City =SUBSTRING([Property Address],CHARINDEX(' ' ,[Property Address]),len([Property Address]))


-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
--- Change Y and N  to Yes and No in "Sold as Vacant" feild

SELECT distinct([Sold As Vacant]),COUNT([Sold As Vacant])
FROM Nashville_housing
group by [Sold As Vacant]
order by 2 


select [Sold As Vacant],
case 
	when [Sold As Vacant] ='Y' then 'Yes'
	when [Sold As Vacant] = 'N' then 'NO'
	ELSE [Sold As Vacant]
	END
FROM Nashville_housing

UPDATE Nashville_housing
SET [Sold As Vacant] = case 
	when [Sold As Vacant] ='Y' then 'Yes'
	when [Sold As Vacant] = 'N' then 'NO'
	ELSE [Sold As Vacant]
	END
FROM Nashville_housing


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-----REMOVES THE DUPLICATES VALUES----

SELECT *
FROM Nashville_housing


with RowNumCTE AS (
select *,
	ROW_NUMBER() over(partition by  [Parcel ID],
	[Property Address],
	[Sale Price],
	SalesDateConverted,
	[Legal Reference] 
	order by [Unnamed: 0]) as row_num
from Nashville_housing
---order by [Parcel ID]
)
SELECT * FROM RowNumCTE
where row_num>1
OR 
DELETE FROM RowNumCTE
where row_num>1


--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
----Delete Unused columns

select * from Nashville_housing

alter table Nashville_housing
drop column [Multiple Parcels Involved in Sale],[Tax District]



						---------------***///Thank You ///***-------------------
						---------------***///Thank You ///***-------------------