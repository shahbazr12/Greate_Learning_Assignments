## Solution tab ::
##1)1.	What is the total revenue generated from all rentals in the database? (2 Marks).
show tables;
select * from  payment;

select rental_id,sum(amount) from payment
group by  rental_id ;


##2)2.	How many rentals were made in each month_name? 
select * from rental;

select monthname(rental_date),count(rental_id) from rental
group by monthname(rental_date) ;


##3) What is the rental rate of the film with the longest title in the database? (2 Marks)
show tables;

select * from film;
## this is the answer based on the longest charector in each title
select rental_rate from film
where length(title) = (select max(length(title)) from film);

## in this i got confused becoz it has the column of length that to be on safe side i have done this like it.
select rental_rate,length from film
order by length desc limit  1;

##4)4.	What is the average rental rate for films that were taken from the last 30 days from the date("2005-05-05 22:04:30")? (2 Marks)
select * from film;
select * from inventory;
select * from rental;

select f.film_id,avg(rental_rate) ,rental_date
from film f 
join inventory  i ON f.film_id = i.film_id
join rental r ON r.inventory_id = i.inventory_id
where rental_date between "2005-05-05 22:04:30" and "2005-06-05 22:04:30"
group by f.film_id ;

##5)5.	What is the most popular category of films in terms of the number of rentals? (3 Marks)
select * from film;
select * from film_category;
select * from category;
select * from inventory;
select * from rental;

select name,count(rental_id) as total_rental
from category c
join film_category fc ON c.category_id = fc.category_id
join film f ON f.film_id = fc.film_id
join inventory i ON i.film_id = f.film_id
join rental  r ON r.inventory_id=i.inventory_id
group by name
order by total_rental desc ;

##6)6.	Find the longest movie duration from the list of films that have not been rented by any customer. 
select * from film;
select * from inventory;
select * from rental;

select f.film_id,max(f.length)
from rental r
right join inventory i ON i.inventory_id = r.inventory_id
right join film f ON f.film_id = i.film_id
where rental_id is null
group by f.film_id;


##7) What is the average rental rate for films, broken down by category? (3 Marks)
select * from film;
select * from film_category;
select * from category;
select * from inventory;
select * from rental;

select name,avg(rental_rate) as total_rental
from category c
join film_category fc ON c.category_id = fc.category_id
join film f ON f.film_id = fc.film_id
join inventory i ON i.film_id = f.film_id
join rental  r ON r.inventory_id=i.inventory_id
group by name
order by total_rental desc ;

##8) What is the total revenue generated from rentals for each actor in the database? 
select * from film;
select * from inventory;
select * from film_actor;
select * from rental;
select * from payment;

select actor_id,sum(amount)
from film f 
join inventory i ON  i.film_id = f.film_id
join film_actor fa ON fa.film_id = f.film_id
join rental r ON r.inventory_id = i.inventory_id
join payment  P ON p.rental_id = r.rental_id
group by actor_id;

##9) Show all the actresses who worked in a film having a "Wrestler" in the description. (3 Marks)
select * from actor;
select * from film_actor;
select * from film;
select distinct first_name,last_name,description
from film f 
join film_actor fa ON fa.film_id = f.film_id
join actor a ON a.actor_id = fa.actor_id
where description like "%Wrestler%" ;

## Gender is not present so that we can get only the actresses;

##10) Which customers have rented the same film more than once? (3 Marks)
select * from film;
select * from inventory;
select * from rental;
select * from customer;
select * from customer;


SELECT c.customer_id,COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY c.customer_id
HAVING COUNT(r.rental_id) > 1;


#11) How many films in the comedy category have a rental rate higher than the average rental rate? (3 Marks)
SELECT * FROM FILM;
SELECT * FROM FILM_CATEGORY;
SELECT * FROM CATEGORY;

SELECT COUNT(F.TITLE)
FROM FILM F
JOIN FILM_CATEGORY FC ON FC.FILM_ID=F.FILM_ID
JOIN CATEGORY C ON C.CATEGORY_ID=FC.CATEGORY_ID
WHERE NAME  = "comedy"
AND RENTAL_RATE >(SELECT AVG(RENTAL_RATE) FROM FILM);


#12) Which films have been rented the most by customers living in each city? 

SELECT * FROM FILM;
SELECT * FROM INVENTORY;
SELECT * FROM RENTAL;
SELECT * FROM ADDRESS;
SELECT * FROM CUSTOMER;

select * from (
select *,row_number() over(partition by city_id order by dd desc) as rnk  from (
select f.film_id,a.city_id,count(r.rental_id) as dd
from film f 
join inventory i ON f.film_id = i.film_id
join rental r ON r.inventory_id = i.inventory_id
join store s ON s.store_id = i.store_id
join customer c ON c.store_id = s.store_id
join address a ON a.address_id = s.address_id
group by f.film_id,a.city_id ) a ) w 
where rnk=1;


#13) What is the total amount spent by customers whose rental payments exceed $200? (3 Marks)
select * from rental;
select * from  payment;
select * from customer;

select c.customer_id,sum(amount)
from customer c
join payment p on c.customer_id = p.customer_id
join rental r ON r.rental_id = p.rental_id
group by c.customer_id  having sum(amount)>200
;



#14)14.	Display the fields which are having foreign key constraints related to the "rental" table. [Hint: using Information_schema] (2 Marks)
## 1st method
select * from information_schema.table_constraints
where table_name = "rental" and REFERENCED_TABLE_NAME IS NOT NULL;

#2nd Method::
SELECT
    *
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    TABLE_NAME = 'rental'
    AND REFERENCED_TABLE_NAME IS NOT NULL;

#)15.Create a View for the total revenue generated by each staff member, broken down by store city with the country name. (4 Marks)

select * from staff;
select * from payment ;


create view total_revenue
as
select s.staff_id,sum(amount)
from staff s 
join payment p ON p.staff_id = s.staff_id
group by s.staff_id
;

#16)16.	Create a view based on rental information consisting of visiting_day, customer_name, the title of the film,  no_of_rental_days,
# the amount paid by the customer along with the percentage of customer spending. (4 Marks).

select * from film;
select * from rental;
select * from customer;


CREATE VIEW RentalView AS
SELECT
    DATE_FORMAT(r.rental_date, '%Y-%m-%d') AS visiting_day,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    f.title AS film_title,
    DATEDIFF(r.return_date, r.rental_date) AS no_of_rental_days,
    SUM(p.amount) AS amount_paid,
    (SUM(p.amount) / (SELECT SUM(amount) FROM payment WHERE customer_id = c.customer_id)) * 100 AS spending_percentage
FROM
    rental r
JOIN
    customer c ON r.customer_id = c.customer_id
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    film f ON i.film_id = f.film_id
LEFT JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY
    r.rental_id, c.customer_id, f.film_id;












#17).Display the customers who paid 50% of their total rental costs within one day. (5 Marks)
select * from payment ;
select * from rental;


WITH CustomerRentalCosts AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        r.rental_id,
        SUM(p.amount) AS total_payment_amount,
        MIN(r.rental_date) AS first_rental_date
    FROM
        customer c
    JOIN
        rental r ON c.customer_id = r.customer_id
    LEFT JOIN
        payment p ON r.rental_id = p.rental_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name, r.rental_id
)

SELECT
    customer_id,
    first_name,
    last_name
FROM
    CustomerRentalCosts
WHERE
    total_payment_amount >= 0.5 * (SELECT SUM(rental_rate) FROM rental r JOIN inventory i ON r.inventory_id = i.inventory_id JOIN film f ON i.film_id = f.film_id)
    AND DATEDIFF(NOW(), first_rental_date) <= 1;

