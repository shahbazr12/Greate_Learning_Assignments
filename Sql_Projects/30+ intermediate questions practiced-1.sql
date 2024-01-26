                              --///-- 30+ PRACTICE QUESTION --///--
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--q1) A country is big if  
--	it has an area of atleast three million (i.e 3000000km2)
--	it has an polulation of atleast twenty_five million (25000000)
--	Write an SQL query to report the name , polpulation and area of the big countreis
--	return the result in table in any order ????

--ans)

create table world1 
(
country_name nvarchar(200) ,
continent nvarchar(200) ,
area int ,
population int ,
gdp bigint
)

insert into world1 values('afganistan','Asia',652230,25500100,20343000000)
insert into world1 values('albania','Europe',28748,2831741,12960000000)
insert into world1 values('algiria','Africa',2381741,37100000,188681000000)
insert into world1 values('andora','Europe',468,78115,3712000000)
insert into world1 values('angola','Africa',2060929,2060929,100990000000)

select * from world1

select country_name , population , area from world1
where area >3000000
or population >25000000

-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q2) product_id is the primary key for this table.
--	low_fats is an ENUM of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
--	recyclable is an ENUM of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.???

--Write an SQL query to find the ids of products that are both low fat and recyclable.
--Return the result table in any order.

Create table Products              
(
product_id int,
low_fats varchar(100), 
recyclable varchar(100)
)


insert into Products (product_id, low_fats, recyclable) values ('0', 'Y', 'N')
insert into Products (product_id, low_fats, recyclable) values ('1', 'Y', 'Y')
insert into Products (product_id, low_fats, recyclable) values ('2', 'N', 'Y')
insert into Products (product_id, low_fats, recyclable) values ('3', 'Y', 'Y')
insert into Products (product_id, low_fats, recyclable) values ('4', 'N', 'N')

select * from Products

select product_id from products
where low_fats='Y' 
AND recyclable = 'Y'

-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q3) id is the primary key column for this table.
--	Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.

--Write an SQL query to report the names of the customer that are not referred by the customer with id = 2.
--Return the result table in any order???


Create table  Customer 
(
id int,
name varchar(100), 
referee_id int
)

insert into Customer (id, name) values ('1', 'Will')
insert into Customer (id, name) values ('2', 'Jane')
insert into Customer (id, name, referee_id) values ('3', 'Alex', '2')
insert into Customer (id, name) values ('4', 'Bill')
insert into Customer (id, name, referee_id) values ('5', 'Zack', '1')
insert into Customer (id, name, referee_id) values ('6', 'Mark', '2')

SELECT * FROM Customer

SELECT * FROM CUSTOMER
WHERE referee_id IS NULL OR referee_id <> 2


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q4) Write an SQL query to report the name and bonus amount of each employee with a bonus less than 1000.
--	Return the result table in any order???


--TABLE-1
Create table  Employee 
(
empId int,
name varchar(255),
supervisor int, 
salary int
)

--empId is the primary key column for this table.
--Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.

insert into Employee (empId, name, salary) values ('3', 'Brad', '4000')
insert into Employee (empId, name, supervisor, salary) values ('1', 'John', '3', '1000')
insert into Employee (empId, name, supervisor, salary) values ('2', 'Dan', '3', '2000')
insert into Employee (empId, name, supervisor, salary) values ('4', 'Thomas', '3', '4000')

--TABLE-2
Create table  Bonus
(
empId int,
bonus int
)
--empId is the primary key column for this table.
--empId is a foreign key to empId from the Employee table.
--Each row of this table contains the id of an employee and their respective bonus.


insert into Bonus (empId, bonus) values ('2', '500')
insert into Bonus (empId, bonus) values ('4', '2000')

SELECT * FROM Employee
SELECT * FROM BONUS



--Write an SQL query to report the name and bonus amount of each employee with a bonus less than 1000.

SELECT E.NAME , B.bonus
FROM  Employee E
LEFT JOIN BONUS B ON E.empId = B.empId
WHERE bonus <1000 OR bonus IS NULL


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q5) Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. 
--	Note that you are supposed to write a DELETE statement and not a SELECT one???

--TABLE OF CONTENT

Create table  Person 
(
Id int, 
Email varchar(255)
)
--id is the primary key column for this table.
--Each row of this table contains an email. The emails will not contain uppercase letters.

insert into Person (id, email) values ('1', 'john@example.com')
insert into Person (id, email) values ('2', 'bob@example.com')
insert into Person (id, email) values ('3', 'john@example.com')


select * from person


delete p
from Person as P,
(
    select Email, min(Id) as minId from Person
    group by Email having count(*) > 1
)
as q
where p.Email = q.Email and P.Id > q.minId


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q6) Write an SQL query to fix the names so that only the first character is uppercase and the rest are lowercase.
--	Return the result table ordered by user_id???

Create table Users 
(
user_id int, 
name varchar(40)
)

--user_id is the primary key for this table.
--This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.

insert into Users (user_id, name) values ('1', 'aLice')
insert into Users (user_id, name) values ('2', 'bOB')

--Write an SQL query to fix the names so that only the first character is uppercase and the rest are lowercase

SELECT * FROM USERS


SELECT UPPER(LEFT(NAME,1))+LOWER(SUBSTRING(NAME,2,LEN(NAME))) 
FROM USERS

-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q7) Write an SQL query to find for each date the number of different products sold and their names.
--	The sold products names for each date should be sorted lexicographically???
 --TABLE OF CONTENT
Create table  Activities 
(sell_date date,
product varchar(20)
)

--There is no primary key for this table, it may contain duplicates.
--Each row of this table contains the product name and the date it was sold in a market.

insert into Activities (sell_date, product) values ('2020-05-30', 'Headphone')
insert into Activities (sell_date, product) values ('2020-06-01', 'Pencil')
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask')
insert into Activities (sell_date, product) values ('2020-05-30', 'Basketball')
insert into Activities (sell_date, product) values ('2020-06-01', 'Bible')
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask')
insert into Activities (sell_date, product) values ('2020-05-30', 'T-Shirt')

SELECT * FROM Activities

 
WITH CTE AS (
  SELECT DISTINCT * FROM Activities
)

SELECT 
sell_date,
COUNT(product) AS num_sold,
STRING_AGG(product, ',') WITHIN GROUP (ORDER BY product ASC) AS products
FROM CTE
GROUP BY sell_date
ORDER BY 1 ASC

-- MEHTOD--2

 select distinct sell_date ,
count(distinct(product)),
STRING_AGG(product,',') within group (order by product asc) as product
from Activities
group by sell_date


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q8) Write an SQL query to report the patient_id, patient_name and conditions of the patients who have Type I Diabetes. 
--	  Type I Diabetes always starts with DIAB1 prefix???


Create table  Patients 
(patient_id int,
patient_name varchar(30),
conditions varchar(100)
)

--patient_id is the primary key for this table.
--'conditions' contains 0 or more code separated by spaces. 
--This table contains information of the patients in the hospital.

insert into Patients (patient_id, patient_name, conditions) values ('1', 'Daniel', 'YFEV COUGH')
insert into Patients (patient_id, patient_name, conditions) values ('2', 'Alice', '')
insert into Patients (patient_id, patient_name, conditions) values ('3', 'Bob', 'DIAB100 MYOP')
insert into Patients (patient_id, patient_name, conditions) values ('4', 'George', 'ACNE DIAB100')
insert into Patients (patient_id, patient_name, conditions) values ('5', 'Alain', 'DIAB201')

SELECT * FROM Patients

SELECT patient_id ,Patient_NAME FROM Patients
WHERE conditions LIKE '%DIAB1%'


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q9) Write an SQL query to find all the authors that viewed at least one of their own articles???

Create table  Views 
(
article_id int,
author_id int,
viewer_id int, 
view_date date
)

--There is no primary key for this table, it may have duplicate rows.
--Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
--Note that equal author_id and viewer_id indicate the same person

insert into Views (article_id, author_id, viewer_id, view_date) values ('1', '3', '5', '2019-08-01')
insert into Views (article_id, author_id, viewer_id, view_date) values ('1', '3', '6', '2019-08-02')
insert into Views (article_id, author_id, viewer_id, view_date) values ('2', '7', '7', '2019-08-01')
insert into Views (article_id, author_id, viewer_id, view_date) values ('2', '7', '6', '2019-08-02')
insert into Views (article_id, author_id, viewer_id, view_date) values ('4', '7', '1', '2019-07-22')
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '4', '2019-07-21')
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '4', '2019-07-21')

SELECT * FROM Views

SELECT DISTINCT author_id 
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id



-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q10) Write an SQL query to find the IDs of the invalid tweets. The tweet is invalid if the number 
--	 of characters used in the content of the tweet is strictly greater than 15???

Create table  Tweets
(
tweet_id int,
content varchar(50)
)

--tweet_id is the primary key for this table.
--This table contains all the tweets in a social media app.

insert into Tweets (tweet_id, content) values ('1', 'Vote for Biden')
insert into Tweets (tweet_id, content) values ('2', 'Let us make America great again!')


SELECT * FROM Tweets

SELECT TWEET_ID FROM Tweets
WHERE LEN(CONTENT) >15


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q11) Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null???

--TABLE-1
Create table  Employees
(
id int,
name varchar(20)
)

--id is the primary key for this table.
--Each row of this table contains the id and the name of an employee in a company.

Insert into Employees (id, name) values ('1', 'Alice')
insert into Employees (id, name) values ('7', 'Bob')
insert into Employees (id, name) values ('11', 'Meir')
insert into Employees (id, name) values ('90', 'Winston')
insert into Employees (id, name) values ('3', 'Jonathan')

--TABLE-2
Create table  EmployeeUNI
(
id int,
unique_id int
)
--(id, unique_id) is the primary key for this table.
--Each row of this table contains the id and the corresponding unique id of an employee in the company

insert into EmployeeUNI (id, unique_id) values ('3', '1')
insert into EmployeeUNI (id, unique_id) values ('11', '2')
insert into EmployeeUNI (id, unique_id) values ('90', '3')

SELECT * FROM Employees
SELECT * FROM EmployeeUNI


--Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.

SELECT UNIQUE_ID , NAME 
FROM EmployeeS E
LEFT JOIN EmployeeUNI S 
ON E.ID = S.ID


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q12)Write an SQL query that reports the product_name, year, and price for each sale_id in the Sales table.
--    Return the resulting table in any order???
--TABLE-1
Create table  Sales 
(
sale_id int,
product_id int,
year int, 
quantity int,
price int
)

--(sale_id, year) is the primary key of this table.
--product_id is a foreign key to Product table.
--Each row of this table shows a sale on the product product_id in a certain year.
--Note that the price is per unit.


insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000')
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000')
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000')

--TABLE-2
Create table Product 
(
product_id int, 
product_name varchar(10)
)

--product_id is the primary key of this table.
--Each row of this table indicates the product name of each product.
 
insert into Product (product_id, product_name) values ('100', 'Nokia')
insert into Product (product_id, product_name) values ('200', 'Apple')
insert into Product (product_id, product_name) values ('300', 'Samsung')

SELECT * FROM Sales
SELECT * FROM PRODUCT
--Write an SQL query that reports the product_name, year, and price for each sale_id in the Sales table.

SELECT  p.product_name ,s.year , s.price
FROM Sales as s
 left join Product as p
ON s.product_id = p.product_id


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q13) Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
--	 Return the result table in any order???

Create table  Weather 
(
id int,
recordDate date,
temperature int
)

--id is the primary key for this table.
--This table contains information about the temperature on a certain day.

insert into Weather (id, recordDate, temperature) values ('1', '2015-01-01', '10')
insert into Weather (id, recordDate, temperature) values ('2', '2015-01-02', '25')
insert into Weather (id, recordDate, temperature) values ('3', '2015-01-03', '20')
insert into Weather (id, recordDate, temperature) values ('4', '2015-01-04', '30')

select * from Weather
--Q13) Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
--	 Return the result table in any order???

SELECT w1.id as Id 
FROM Weather as w1, Weather as w2
WHERE w1.temperature > w2.temperature
AND DATEDIFF( DAY, w2.recordDate, w1.recordDate) = 1

--for the TIME BIENG iam leaving this


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q14) Write a SQL query to find the IDs of the users who visited without making 
--	  any transactions and the number of times they made these types of visits???

--TABLE-1
Create table  Visits
(
visit_id int,
customer_id int
)

--visit_id is the primary key for this table.
--This table contains information about the customers who visited the mall.

insert into Visits (visit_id, customer_id) values ('1', '23')
insert into Visits (visit_id, customer_id) values ('2', '9')
insert into Visits (visit_id, customer_id) values ('4', '30')
insert into Visits (visit_id, customer_id) values ('5', '54')
insert into Visits (visit_id, customer_id) values ('6', '96')
insert into Visits (visit_id, customer_id) values ('7', '54')
insert into Visits (visit_id, customer_id) values ('8', '54')

--TABLE-2
Create table  Transactions
(
transaction_id int,
visit_id int,
amount int
)

--transaction_id is the primary key for this table.
--This table contains information about the transactions made during the visit_id.

insert into Transactions (transaction_id, visit_id, amount) values ('2', '5', '310')
insert into Transactions (transaction_id, visit_id, amount) values ('3', '5', '300')
insert into Transactions (transaction_id, visit_id, amount) values ('9', '5', '200')
insert into Transactions (transaction_id, visit_id, amount) values ('12', '1', '910')
insert into Transactions (transaction_id, visit_id, amount) values ('13', '2', '970')


SELECT * FROM Visits
SELECT * FROM Transactions

select customer_id, count(visit_id) as count_no_trans 
from Visits where visit_id not in 
(select visit_id from Transactions)
group by customer_id;


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q15)There is a factory website that has several machines each running the same number of processes.
--    Write an SQL query to find the average time each machine takes to complete a process.
--   The time to complete a process is the 'end' timestamp minus the 'start' timestamp.
--   The average time is calculated by the total time to complete every process
--   on the machine divided by the number of processes that were run???

Create table Activity 
(
machine_id int,
process_id int,
activity_type varchar(100),
timestamp float
)

--The table shows the user activities for a factory website.
--(machine_id, process_id, activity_type) is the primary key of this table.
--machine_id is the ID of a machine.
--process_id is the ID of a process running on the machine with ID machine_id.
--activity_type is an ENUM of type ('start', 'end').
--timestamp is a float representing the current time in seconds.
--'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
--The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair.

insert into Activity (machine_id, process_id, activity_type, timestamp) values (0, 0, 'start', 0.712)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (0, 0, 'end', 1.52)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (0, 1, 'start', 3.14)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (0, 1, 'end', 4.12)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (1, 0, 'start', 0.55)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (1, 0, 'end', 1.55)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (1, 1, 'start', 0.43)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (1, 1, 'end', 1.42)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (2, 0, 'start', 4.1)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (2, 0, 'end', 4.512)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (2, 1, 'start', 2.5)
insert into Activity (machine_id, process_id, activity_type, timestamp) values (2, 1, 'end', 5)


select * from Activity


WITH t AS (
    SELECT
        machine_id,
        process_id,
        SUM(CASE WHEN activity_type='start' THEN timestamp ELSE 0 END) AS start_time,
        SUM(CASE WHEN activity_type='end' THEN timestamp ELSE 0 END) AS end_time
    FROM Activity
    GROUP BY machine_id, process_id
    
)
SELECT
    machine_id,
    ROUND(AVG(end_time-start_time),3) AS processing_time
FROM t
GROUP BY machine_id
ORDER BY machine_id;


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q16) Write an SQL query to find the number of times each student attended each exam.
--     Return the result table ordered by student_id and subject_name???
--TABLE-1
Create table Students 
(
student_id int, 
student_name varchar(20)
)
--student_id is the primary key for this table.
--Each row of this table contains the ID and the name of one student in the school.

insert into Students (student_id, student_name) values ('1', 'Alice')
insert into Students (student_id, student_name) values ('2', 'Bob')
insert into Students (student_id, student_name) values ('13', 'John')
insert into Students (student_id, student_name) values ('6', 'Alex')

--TABLE-2
Create table Subjects 
(
subject_name varchar(20)
)
--subject_name is the primary key for this table.
--Each row of this table contains the name of one subject in the school.

insert into Subjects (subject_name) values ('Math')
insert into Subjects (subject_name) values ('Physics')
insert into Subjects (subject_name) values ('Programming')

--TABLE-3
Create table  Examinations 
(
student_id int,
subject_name varchar(20)
)
--There is no primary key for this table. It may contain duplicates.
--Each student from the Students table takes every course from the Subjects table.
--Each row of this table indicates that a student with ID student_id attended the exam of subject_name.

insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Programming')
insert into Examinations (student_id, subject_name) values ('2', 'Programming')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Programming')
insert into Examinations (student_id, subject_name) values ('13', 'Physics')
insert into Examinations (student_id, subject_name) values ('2', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Math')

SELECT * FROM Students
SELECT * FROM Subjects
SELECT * FROM Examinations

--Write an SQL query to find the number of times each student attended each exam.
----     Return the result table ordered by student_id and subject_name???

WITH CTE AS (
    SELECT
        *
    FROM
        Students
    CROSS JOIN
        Subjects 
)
,CTE2 AS (
    SELECT DISTINCT
        T1.student_id,
        T2.student_name,
        subject_name,
        COUNT(T1.student_id) OVER(PARTITION BY T1.student_id,subject_name ) attended_exams
    FROM
        Examinations T1
    LEFT JOIN

        Students T2 ON T1.student_id = T2.student_id
)
SELECT
   T1. *,
   ISNULL(T2.attended_exams,0) attended_exams
FROM
    CTE  T1
LEFT JOIN
    CTE2 T2 ON T1.student_id = T2.student_id AND T1.subject_name = T2.subject_name
ORDER BY
    T1.student_id,T1.subject_name



-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q17)Write an SQL query to report the movies with an odd-numbered ID and a description that is not "boring".
--    Return the result table ordered by rating in descending order???

Create table  cinema 
(
id int,
movie varchar(255),
description varchar(255), 
rating float(5)
)

--id is the primary key for this table.
--Each row contains information about the name of a movie, its genre, and its rating.
--rating is a 2 decimal places float in the range [0, 10]

insert into cinema (id, movie, description, rating) values ('1', 'War', 'great 3D', '8.9')
insert into cinema (id, movie, description, rating) values ('2', 'Science', 'fiction', '8.5')
insert into cinema (id, movie, description, rating) values ('3', 'irish', 'boring', '6.2')
insert into cinema (id, movie, description, rating) values ('4', 'Ice song', 'Fantacy', '8.6')
insert into cinema (id, movie, description, rating) values ('5', 'House card', 'Interesting', '9.1')

select * from cinema

select movie ,id ,description,rating from  cinema
where id % 2=1 and description != 'boring'
order by rating desc


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q18)Write an SQL query to find the average selling price for each product. 
--    average_price should be rounded to 2 decimal places???

--TABLE-1
Create table  Prices 
(
product_id int,
start_date date,
end_date date,
price int
)

--(product_id, start_date, end_date) is the primary key for this table.
--Each row of this table indicates the price of the product_id in the period from start_date to end_date.
--For each product_id there will be no two overlapping periods.
--That means there will be no two intersecting periods for the same product_id.

insert into Prices (product_id, start_date, end_date, price) values ('1', '2019-02-17', '2019-02-28', '5')
insert into Prices (product_id, start_date, end_date, price) values ('1', '2019-03-01', '2019-03-22', '20')
insert into Prices (product_id, start_date, end_date, price) values ('2', '2019-02-01', '2019-02-20', '15')
insert into Prices (product_id, start_date, end_date, price) values ('2', '2019-02-21', '2019-03-31', '30')

--TABLE-2
Create table UnitsSold 
(
product_id int,
purchase_date date,
units int
)

--There is no primary key for this table, it may contain duplicates.
--Each row of this table indicates the date, units, and product_id of each product sold. 

insert into UnitsSold (product_id, purchase_date, units) values ('1', '2019-02-25', '100')
insert into UnitsSold (product_id, purchase_date, units) values ('1', '2019-03-01', '15')
insert into UnitsSold (product_id, purchase_date, units) values ('2', '2019-02-10', '200')
insert into UnitsSold (product_id, purchase_date, units) values ('2', '2019-03-22', '30')

SELECT * FROM Prices
SELECT * FROM UnitsSold


select distinct p.product_id, 
round(sum(price * units) / sum(units), 2) as average_price from
Prices as p 
join UnitsSold as U
on
p.product_id  = u.product_id and u.purchase_date between p.start_date and p.end_date
group by p.product_id
order by p.product_id


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q19) Write an SQL query that reports the average experience years of all the employees for each project,
--     rounded to 2 digits???
--TABLE-1
Create table  Project 
(
project_id int,
employee_id int
)

--(project_id, employee_id) is the primary key of this table.
--employee_id is a foreign key to Employee table.
--Each row of this table indicates that the employee with employee_id is working on the project with project_id.

insert into Project (project_id, employee_id) values ('1', '1')
insert into Project (project_id, employee_id) values ('1', '2')
insert into Project (project_id, employee_id) values ('1', '3')
insert into Project (project_id, employee_id) values ('2', '1')
insert into Project (project_id, employee_id) values ('2', '4')

--TABLE-2--
Create table Employee1 
(
employee_id int,
name varchar(10), 
experience_years int
)

--employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
--Each row of this table contains information about one employee.

insert into Employee1 (employee_id, name, experience_years) values ('1', 'Khaled', '3')
insert into Employee1 (employee_id, name, experience_years) values ('2', 'Ali', '2')
insert into Employee1 (employee_id, name, experience_years) values ('3', 'John', '1')
insert into Employee1 (employee_id, name, experience_years) values ('4', 'Doe', '2')


SELECT * FROM Project
SELECT * FROM Employee1

select p.PROJECT_ID  , ROUND(AVG(e.EXPERIENCE_YEARS),2) AS AVG_EXPERIANCE
from Project AS p
join Employee1 AS e
ON p.project_id = e.employee_id
group by project_id


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q20) Write an SQL query to find the percentage of the users registered in each contest rounded to two decimals.
--    Return the result table ordered by percentage in descending order.
--    In case of a tie, order it by contest_id in ascending order???
--TABLE-1
Create table  Users1 
(
user_id int,
user_name varchar(20)
)
--user_id is the primary key for this table.
--Each row of this table contains the name and the id of a user

insert into Users1 (user_id, user_name) values ('6', 'Alice')
insert into Users1 (user_id, user_name) values ('2', 'Bob')
insert into Users1 (user_id, user_name) values ('7', 'Alex')

--TABLE-2
Create table  Register
(
contest_id int, 
user_id int
)

--(contest_id, user_id) is the primary key for this table.
--Each row of this table contains the id of a user and the contest they registered into.

insert into Register (contest_id, user_id) values ('215', '6')
insert into Register (contest_id, user_id) values ('209', '2')
insert into Register (contest_id, user_id) values ('208', '2')
insert into Register (contest_id, user_id) values ('210', '6')
insert into Register (contest_id, user_id) values ('208', '6')
insert into Register (contest_id, user_id) values ('209', '7')
insert into Register (contest_id, user_id) values ('209', '6')
insert into Register (contest_id, user_id) values ('215', '7')
insert into Register (contest_id, user_id) values ('208', '7')
insert into Register (contest_id, user_id) values ('210', '2')
insert into Register (contest_id, user_id) values ('207', '2')
insert into Register (contest_id, user_id) values ('210', '7')

SELECT * FROM Users1
SELECT * FROM Register



--SLUTION-1
SELECT
    r.contest_id,
    ROUND(COUNT(DISTINCT(r.user_id))*100/COUNT(DISTINCT(u.user_id)), 2) AS percentage
FROM Register r,
 Users1 u
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC

--SLUTION-2
SELECT
    r.contest_id,
    ROUND(COUNT(r.user_id)*100/(SELECT COUNT(*) FROM Users1), 2) AS percentage
FROM Register r
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC

--SLUTION-3

WITH count AS
(
    select count(user_id) num
    from Users1
)
SELECT
    r.contest_id,
    ROUND(COUNT(r.user_id)*100/(SELECT num FROM count), 2) AS percentage
FROM Register r
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC

-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q21)We define query quality as:
--   The average of the ratio between query rating and its position.
--   We also define poor query percentage as:
--   The percentage of all queries with rating less than 3.
--   Write an SQL query to find each query_name, the quality and poor_query_percentage.
--   Both quality and poor_query_percentage should be rounded to 2 decimal places.
   --Return the result table in any order???

Create table  Queries 
(


query_name varchar(30),
result varchar(50), position int,
rating int
)

--There is no primary key for this table, it may have duplicate rows.
--This table contains information collected from some queries on a database.
--The position column has a value from 1 to 500.
--The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.

insert into Queries (query_name, result, position, rating) values ('Dog', 'Golden Retriever', '1', '5')
insert into Queries (query_name, result, position, rating) values ('Dog', 'German Shepherd', '2', '5')
insert into Queries (query_name, result, position, rating) values ('Dog', 'Mule', '200', '1')
insert into Queries (query_name, result, position, rating) values ('Cat', 'Shirazi', '5', '2')
insert into Queries (query_name, result, position, rating) values ('Cat', 'Siamese', '3', '3')
insert into Queries (query_name, result, position, rating) values ('Cat', 'Sphynx', '7', '4')

SELECT * FROM Queries

select query_name, 
round(sum(1.0*rating/position)/count(query_name), 3) as quality, 
round(100 * 1.0 * sum(case 
when rating < 3 then 1 else 0 end)/count(query_name), 3) as poor_query_percentage
from Queries 
group by query_name


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q22) Write an SQL query to report the number of unique subjects each teacher teaches in the university.
--     Return the result table in any order???

Create table Teacher 
(
teacher_id int,
subject_id int,
dept_id int
)

--(subject_id, dept_id) is the primary key for this table.
--Each row in this table indicates that the teacher with teacher_id teaches the subject subject_id in the department dept_id.


insert into Teacher (teacher_id, subject_id, dept_id) values ('1', '2', '3')
insert into Teacher (teacher_id, subject_id, dept_id) values ('1', '2', '4')
insert into Teacher (teacher_id, subject_id, dept_id) values ('1', '3', '3')
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '1', '1')
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '2', '1')
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '3', '1')
insert into Teacher (teacher_id, subject_id, dept_id) values ('2', '4', '1')

select * from Teacher

Write an SQL query to report the number of unique subjects each teacher teaches in the university.
--     Return the result table in any order.

SELECT
        teacher_id, 
        count(distinct subject_id) as cnt 
        FROM Teacher 
        GROUP BY teacher_id;

-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q23) Write an SQL query to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. 
----   A user was active on someday if they made at least one activity on that day???


Create table  Activity1 
(
user_id int, 
session_id int,
activity_date date,
activity_type VARCHAR(200)
)

--There is no primary key for this table, it may have duplicate rows.
--The activity_type column is an ENUM of type ('open_session', 'end_session', 'scroll_down', 'send_message').
--The table shows the user activities for a social media website. 
--Note that each session belongs to exactly one user.


insert into Activity1 (user_id, session_id, activity_date, activity_type) values (1, 1, '2019-07-20', 'open_session')
insert into Activity1 (user_id, session_id, activity_date, activity_type) values (1, 1, '2019-07-20', 'scroll_down')
insert into Activity1 (user_id, session_id, activity_date, activity_type) values (1, 1, '2019-07-20', 'end_session')
insert into Activity1 (user_id, session_id, activity_date, activity_type) values (2, 4, '2019-07-20', 'open_session')
insert into Activity1 (user_id, session_id, activity_date, activity_type) values (2, 4, '2019-07-21', 'send_message')
insert into Activity1 (user_id, session_id, activity_date, activity_type) values (2, 4, '2019-07-21', 'end_session')
insert into Activity1 (user_id, session_id, activity_date, activity_type) values (3, 2, '2019-07-21', 'open_session')
insert into Activity1 (user_id, session_id, activity_date, activity_type) values (3, 2, '2019-07-21', 'send_message')
insert into Activity1 (user_id, session_id, activity_date, activity_type) values (3, 2, '2019-07-21', 'end_session')
insert into Activity1 (user_id, session_id, activity_date, activity_type) values (4, 3, '2019-06-25', 'open_session')
insert into Activity1 (user_id, session_id, activity_date, activity_type) values (4, 3, '2019-06-25', 'end_session')

SELECT * FROM Activity1

select activity_date , count(distinct user_id) as active_users from Activity1
where activity_date between '2019-06-28' and '2019-07-27' 
group by activity_date

--Q23) Write an SQL query to report all the classes that have at least five students.
     --Return the result table in any order???

Create table Courses 
(
student varchar(255),
class varchar(255)
)

--(student, class) is the primary key column for this table.
--Each row of this table indicates the name of a student and the class in which they are enrolled.

insert into Courses (student, class) values ('A', 'Math')
insert into Courses (student, class) values ('B', 'English')
insert into Courses (student, class) values ('C', 'Math')
insert into Courses (student, class) values ('D', 'Biology')
insert into Courses (student, class) values ('E', 'Math')
insert into Courses (student, class) values ('F', 'Computer')
insert into Courses (student, class) values ('G', 'Math')
insert into Courses (student, class) values ('H', 'Math')
insert into Courses (student, class) values ('I', 'Math')

SELECT * FROM Courses

select class from courses group by class having count(distinct student) >= 5;

-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q24) Write an SQL query that will, for each user, return the number of followers.
--   Return the result table ordered by user_id in ascending order???

Create table  Followers
(
user_id int,
follower_id int
)

--(user_id, follower_id) is the primary key for this table.
--This table contains the IDs of a user and a follower in a social media app where the follower follows the user.

insert into Followers (user_id, follower_id) values ('0', '1')
insert into Followers (user_id, follower_id) values ('1', '0')
insert into Followers (user_id, follower_id) values ('2', '0')
insert into Followers (user_id, follower_id) values ('2', '1')

select * from Followers

SELECT DISTINCT user_id,
COUNT(DISTINCT follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q25) A single number is a number that appeared only once in the MyNumbers table.
--     Write an SQL query to report the largest single number. If there is no single number, report null???

Create table MyNumbers 
(
num int
)

--There is no primary key for this table. It may contain duplicates.
--Each row of this table contains an integer.

insert into MyNumbers (num) values ('8')
insert into MyNumbers (num) values ('8')
insert into MyNumbers (num) values ('3')
insert into MyNumbers (num) values ('3')
insert into MyNumbers (num) values ('1')
insert into MyNumbers (num) values ('4')
insert into MyNumbers (num) values ('5')
insert into MyNumbers (num) values ('6')

SELECT * FROM MyNumbers

 --HERE WE FINDING THE LARGEST SINGLE NO

select max(num) as num from
(
    select num from mynumbers group by num having count(num) = 1
) as n


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q26)For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.
--   Write an SQL query to report the ids and the names of all managers, the number of employees who report directly to them,
--   and the average age of the reports rounded to the nearest integer???

Create table  Employees1
(
employee_id int, 
name varchar(20),
reports_to int,
age int
)

--employee_id is the primary key for this table.
--This table contains information about the employees and the id of the manager they report to.
--Some employees do not report to anyone (reports_to is null).

insert into Employees1 (employee_id, name, age) values ('9', 'Hercy',  '43')
insert into Employees1 (employee_id, name, reports_to, age) values ('6', 'Alice', '9', '41')
insert into Employees1 (employee_id, name, reports_to, age) values ('4', 'Bob', '9', '36')
insert into Employees1 (employee_id, name,  age) values ('2', 'Winston',  '37')

select * from Employees1

SELECT 
emp1.employee_id AS employee_id,
emp1.name AS name,
COUNT(emp2.reports_to) AS reports_count,
ROUND(AVG(emp2.age),2) AS average_age
FROM Employees1 AS emp1
JOIN Employees1 as emp2 ON emp1.employee_id = emp2.reports_to
GROUP BY emp1.employee_id,emp1.name
HAVING COUNT(emp2.reports_to) > 0
ORDER BY employee_id ASC


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q27)Write an SQL query to report for every three line segments whether they can form a triangle???

Create table  Triangle
(
x int,
y int, 
z int
)

--(x, y, z) is the primary key column for this table.
--Each row of this table contains the lengths of three line segments.

insert into Triangle (x, y, z) values ('13', '15', '30')
insert into Triangle (x, y, z) values ('10', '20', '15')

select * from Triangle

select x, y, z,
case
when x + y > z and x + z > y and y + z > x then 'Yes'
else 'No'
end as triangle
from triangle


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--28)Write an SQL query to report the IDs of the employees whose salary is strictly less than $30000 
--and whose manager left the company. When a manager leaves the company, their information is deleted from 
--the Employees table,but the reports still have their manager_id set to the manager that left???

Create table  Employees2
(
employee_id int,
name varchar(20),
manager_id int, 
salary int
)

--employee_id is the primary key for this table.
--This table contains information about the employees, their salary, and the ID of their manager. 
--Some employees do not have a manager (manager_id is null). 

insert into Employees2 (employee_id, name, manager_id, salary) values ('3', 'Mila', '9', '60301')
insert into Employees2 (employee_id, name,  salary) values ('12', 'Antonella',  '31000')
insert into Employees2 (employee_id, name, salary) values ('13', 'Emery',  '67084')
insert into Employees2 (employee_id, name, manager_id, salary) values ('1', 'Kalel', '11', '21241')
insert into Employees2 (employee_id, name,  salary) values ('9', 'Mikaela',  '50937')
insert into Employees2 (employee_id, name, manager_id, salary) values ('11', 'Joziah', '6', '28485')


SELECT * FROM Employees2

SELECT  emp.employee_id , EMP.NAME
FROM   employees2 emp
 LEFT JOIN employees2 mng
 ON( emp.manager_id = mng.employee_id )
WHERE  emp.manager_id IS NOT NULL
       AND emp.salary < 30000
       AND mng.employee_id IS NULL
ORDER  BY emp.employee_id 


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q29)Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount???
--TABLE-1
Create table  Products1 
(
product_id int,
product_name varchar(40),
product_category varchar(40)
)
SELECT * FROM PRODUCTS1

insert into Products1 (product_id, product_name, product_category) values ('1', 'Leetcode Solutions', 'Book')
insert into Products1 (product_id, product_name, product_category) values ('2', 'Jewels of Stringology', 'Book')
insert into Products1 (product_id, product_name, product_category) values ('3', 'HP', 'Laptop')
insert into Products1 (product_id, product_name, product_category) values ('4', 'Lenovo', 'Laptop')
insert into Products1 (product_id, product_name, product_category) values ('5', 'Leetcode Kit', 'T-shirt')

--TABLE-2--
Create table  Orders 
(
product_id int,
order_date date,
unit int
)

insert into Orders (product_id, order_date, unit) values ('1', '2020-02-05', '60')
insert into Orders (product_id, order_date, unit) values ('1', '2020-02-10', '70')
insert into Orders (product_id, order_date, unit) values ('2', '2020-01-18', '30')
insert into Orders (product_id, order_date, unit) values ('2', '2020-02-11', '80')
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-17', '2')
insert into Orders (product_id, order_date, unit) values ('3', '2020-02-24', '3')
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-01', '20')
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '30')
insert into Orders (product_id, order_date, unit) values ('4', '2020-03-04', '60')
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-25', '50')
insert into Orders (product_id, order_date, unit) values ('5', '2020-02-27', '50')
insert into Orders (product_id, order_date, unit) values ('5', '2020-03-01', '50')

SELECT * FROM PRODUCTS1
SELECT * FROM Orders


select p.product_name,
sum(o.unit) as unit
from Products1 p
join Orders o
on p.product_id = o.product_id
where Left(order_date, 7) = '2020-02'
group by p.product_name
having sum(o.unit) >= 100

SELECT * FROM  ORDERS 
ORDER BY ORDER_DATE


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q30)Write an SQL query to find the users who have valid emails???

Create table  Users2
(
user_id int,
name varchar(30), 
mail varchar(50)
)

--user_id is the primary key for this table.
--This table contains information of the users signed up in a website. Some e-mails are invalid.

insert into Users2 (user_id, name, mail) values ('1', 'Winston', 'winston@leetcode.com')
insert into Users2 (user_id, name, mail) values ('2', 'Jonathan', 'jonathanisgreat')
insert into Users2 (user_id, name, mail) values ('3', 'Annabelle', 'bella-@leetcode.com')
insert into Users2 (user_id, name, mail) values ('4', 'Sally', 'sally.come@leetcode.com')
insert into Users2 (user_id, name, mail) values ('5', 'Marwan', 'quarz#2020@leetcode.com')
insert into Users2 (user_id, name, mail) values ('6', 'David', 'david69@gmail.com')
insert into Users2 (user_id, name, mail) values ('7', 'Shapiro', '.shapo@leetcode.com')


--Write an SQL query to find the users who have valid emails.
SELECT * FROM Users2

SELECT
    *
FROM
    Users2
WHERE
    mail LIKE '[a-zA-Z]%@leetcode.com'
AND
    mail NOT 
	LIKE '%[#%^$!&*()+=@]%@leetcode.com'


--MEDIUM LEVEL QUESTIONS

-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q31) Write an SQL query to report the managers with at least five direct reports.

Create table  Employee2 
(
id int,
name varchar(255),
department varchar(255),
managerId int
)

--id is the primary key column for this table.
--Each row of this table indicates the name of an employee, their department, and the id of their manager.
--If managerId is null, then the employee does not have a manager.
--No employee will be the manager of themself.

insert into Employee2 (id, name, department) values (101, 'John', 'A')
insert into Employee2 (id, name, department, managerId) values (102, 'Dan', 'A', 101)
insert into Employee2 (id, name, department, managerId) values (103, 'James', 'A', 101)
insert into Employee2 (id, name, department, managerId) values (104, 'Amy', 'A', 101)
insert into Employee2 (id, name, department, managerId) values (105, 'Anne', 'A', 101)
insert into Employee2 (id, name, department, managerId) values (106, 'Ron', 'B', 101)

select * from Employee2

--SOLUTION 1
select DISTINCT(E.name) 
from Employee2 e
join Employee2 d
ON E.ID =D.managerId 
WHERE D.managerId>=5

--SOLUTION 2
SELECT      e1.name 
FROM        Employee e1
JOIN        Employee e2
ON          e1.id = e2.managerId
GROUP BY    e1.name
HAVING      COUNT(*) >= 5;

-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q32)The confirmation rate of a user is the number of 'confirmed' 
--messages divided by the total number of requested confirmation messages. 
--The confirmation rate of a user that did not request any confirmation messages is 0.
--Round the confirmation rate to two decimal places.
--Write an SQL query to find the confirmation rate of each user.

Create table  Signups 
(
user_id int,
time_stamp datetime
)

--user_id is the primary key for this table.
--Each row contains information about the signup time for the user with ID user_id.

insert into Signups (user_id, time_stamp) values ('3', '2020-03-21 10:16:13')
insert into Signups (user_id, time_stamp) values ('7', '2020-01-04 13:57:59')
insert into Signups (user_id, time_stamp) values ('2', '2020-07-29 23:09:44')
insert into Signups (user_id, time_stamp) values ('6', '2020-12-09 10:39:37')



Create table  Confirmations 
(
user_id int,
time_stamp datetime,
action VARCHAR(100)           
)

--('confirmed','timeout')
--(user_id, time_stamp) is the primary key for this table.
--user_id is a foreign key with a reference to the Signups table.
--action is an ENUM of the type ('confirmed', 'timeout')
--Each row of this table indicates that the user with ID user_id requested a confirmation message 
--at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').


insert into Confirmations (user_id, time_stamp, action) values ('3', '2021-01-06 03:30:46', 'timeout')
insert into Confirmations (user_id, time_stamp, action) values ('3', '2021-07-14 14:00:00', 'timeout')
insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-12 11:57:29', 'confirmed')
insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-13 12:58:28', 'confirmed')
insert into Confirmations (user_id, time_stamp, action) values ('7', '2021-06-14 13:59:27', 'confirmed')
insert into Confirmations (user_id, time_stamp, action) values ('2', '2021-01-22 00:00:00', 'confirmed')
insert into Confirmations (user_id, time_stamp, action) values ('2', '2021-02-28 23:59:59', 'timeout')

SELECT * FROM Signups
SELECT * FROM Confirmations

WITH CTE AS (
      SELECT
        user_id,
        (COUNT(CASE WHEN action = 'confirmed' THEN 1 ELSE NULL END) / 
        CAST(COUNT(user_id) AS DECIMAL(10,2))) [confirmation_rate]
      FROM
        Confirmations
      GROUP BY
        user_id
)
SELECT
  T2.user_id,
  ROUND(ISNULL([confirmation_rate],0),2) [confirmation_rate]
FROM
  CTE T1
RIGHT JOIN

  Signups T2 ON T1.user_id = T2.user_id


-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q33)Write an SQL query to find for each month and country, the number of transactions and their total amount,
--the number of approved transactions and their total amount.

Create table  Transactions1
(
id int, 
country varchar(4), 
state   VARCHAR(100),                    
amount int, 
trans_date date
)

--id is the primary key of this table.
--The table has information about incoming transactions.
--The state column is an enum of type ["approved", "declined"].

insert into Transactions1 (id, country, state, amount, trans_date) values ('121', 'US', 'approved', '1000', '2018-12-18')
insert into Transactions1 (id, country, state, amount, trans_date) values ('122', 'US', 'declined', '2000', '2018-12-19')
insert into Transactions1 (id, country, state, amount, trans_date) values ('123', 'US', 'approved', '2000', '2019-01-01')
insert into Transactions1 (id, country, state, amount, trans_date) values ('124', 'DE', 'approved', '2000', '2019-01-07')

SELECT * FROM Transactions1

select 
    FORMAT(trans_date, 'yyyy-MM') as month, 
    country, 
    count(id) as trans_count,
    sum(case when state ='approved' then 1 else 0 end) approved_count,
    sum(amount) as trans_total_amount,
    sum(case when state='approved' then amount else 0 end) approved_total_amount
from Transactions1
group by FORMAT(trans_date, 'yyyy-MM'), country



-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--Q34)If the customer's preferred delivery date is the same as the order date, then the order is called immediate;
--otherwise, it is called scheduled.
--The first order of a customer is the order with the earliest order date that the customer made.
--It is guaranteed that a customer has precisely one first order.
--Write an SQL query to find the percentage of immediate orders in the first orders of all customers, 
--rounded to 2 decimal places

Create table  Delivery 
(
delivery_id int,
customer_id int,
order_date date,
customer_pref_delivery_date date
)

--delivery_id is the primary key of this table.
--The table holds information about food delivery to customers that make orders
--at some date and specify a preferred delivery date (on the same order date or after it).

insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('1', '1', '2019-08-01', '2019-08-02')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('2', '2', '2019-08-02', '2019-08-02')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('3', '1', '2019-08-11', '2019-08-12')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('4', '3', '2019-08-24', '2019-08-24')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('5', '3', '2019-08-21', '2019-08-22')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('6', '2', '2019-08-11', '2019-08-13')
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values ('7', '4', '2019-08-09', '2019-08-09')

SELECT * FROM Delivery

WITH cte AS (
    SELECT
        customer_id,
        order_date,
        rank() OVER (PARTITION BY customer_id ORDER BY order_date) AS r,
        customer_pref_delivery_date
    FROM
        Delivery
)
SELECT
    ROUND(
        CAST(100*COUNT(CASE WHEN order_date = customer_pref_delivery_date THEN 1 END) AS decimal) /
        CAST(COUNT(customer_id) AS decimal),
    2) AS immediate_percentage
FROM
    cte
WHERE r = 1;

--35)Each node in the tree can be one of this type 
--	"Leaf" if the node is leaf node
--	"Root" if the node is root node
--	"Inner" if the node is neither a leaf or nor a root leaf 
--	Write an SQL query to report the type of each node in the tree

 --Summary
 --If a number is null in p_id then it is root node
 --IF a number apeares in both id and p_id it is an inner node
 --if a number only appers in id and not p_id it is leaf


create table input
(
id int,
p_id int
)
insert into input(id) values(1)
insert into input values(2,1)
insert into input values(3,1)
insert into input values(4,2)
insert into input values(5,2)

select * from input

select id,
case 
	when p_id is null then 'Root_Node'
	when p_id in (select id from input) and  p_id in (select p_id from input) then 'Inner_Node'
	else 'Leaf' 
	end as type
	from input
                      
                            ---------------***///THANK YOU ///***-------------------
							---------------***///THANK YOU ///***-------------------