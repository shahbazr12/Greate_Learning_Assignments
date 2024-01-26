                      /*	Question Set 1 - Easy */

/* Q1: Who is the senior most employee based on job title? */

select * from employee1

select top 1 * from employee1
order by levels desc


/* Q2: Which countries have the most Invoices? */

select * from invoice1

select billing_country ,count(*) as most_invoice from invoice1
group by billing_country
order by most_invoice desc


/* Q3: What are top 3 values of total invoice? */

select top 3 
* from 
invoice1
order by total desc


/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select top 1 billing_city,sum(total)
from invoice1
group by billing_city
order by sum(total) desc



/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

select * from customer1
select * from invoice1

select c.first_name,c.last_name, i.total
from customer1 C
join invoice1 I ON I.customer_id = C.customer_id
order by i.total desc





                /* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */


select distinct c.email , c.first_name , c.last_name ,g.name
from customer1 c
join invoice1 i ON i.customer_id = c.customer_id
join invoice_line1 il ON il.invoice_id = i.invoice_id
join Track1 t ON t.track_id = il.track_id
join genre1 g ON g.genre_id = t.genre_id
where g.name like 'Rock'


/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select top 10 a.artist_id, a.name , COUNT(a.artist_id) as no_Song
from artist1 A 
join album1 AB ON AB.artist_id = a.artist_id 
join track1 T ON t.album_id = ab.album_id
join genre1 G ON G.genre_id = t.genre_id
where g.name like 'Rock'
group by a.artist_id,a.name
order by no_Song desc


/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */
----Method -1 
select top 10 name , milliseconds from track1 
where milliseconds>393599.212103911 
order by milliseconds

---Method -2 (DYNAMIC)
select name , milliseconds 
from track1 
WHERE milliseconds>
		(SELECT AVG(milliseconds) FROM track1)
ORDER BY milliseconds




                 /* Question Set 3 - Advance */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

/* Steps to Solve: First, find which artist has earned the most according to the InvoiceLines. Now use this artist to find 
which customer spent the most on this artist. For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, 
Album, and Artist tables. Note, this one is tricky because the Total spent in the Invoice table might not be on a single product, 
so you need to use the InvoiceLine table to find out how many of each product was purchased, and then multiply this by the price
for each artist. */

SELECT CONCAT_WS(' ', C.first_name, C.last_name)Full_Name, (A.name)artist_name, SUM(IL.unit_price * IL.quantity)total_spent
FROM customer1 C
INNER JOIN invoice1 I
ON C.customer_id = I.customer_id
INNER JOIN invoice_line1 IL
ON I.invoice_id = IL.invoice_id
INNER JOIN track1 T
ON IL.track_id = T.track_id
INNER JOIN album1 AL
ON T.album_id = AL.album_id
INNER JOIN artist1 A
ON AL.artist_id = A.artist_id
GROUP BY C.first_name, C.last_name, A.name
ORDER BY total_spent DESC


/* Q2: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

/* Steps to Solve:  Similar to the above question. There are two parts in question- 
first find the most spent on music for each country and second filter the data for respective customers. */

WITH CTE AS(
SELECT (I.billing_country)country,
CONCAT_WS(' ',C.first_name, C.last_name)cust_name ,
SUM(I.total)total_spendings,
DENSE_RANK() OVER(PARTITION BY I.billing_country ORDER BY SUM(I.total) DESC)ran
FROM customer1 C
INNER JOIN invoice1 I
ON C.customer_id = I.customer_id
GROUP BY I.billing_country, C.first_name, C.last_name)

SELECT country, cust_name, total_spendings
FROM CTE
WHERE ran = 1
order by total_spendings desc


                                           /////**** Thank You :) ****/////
