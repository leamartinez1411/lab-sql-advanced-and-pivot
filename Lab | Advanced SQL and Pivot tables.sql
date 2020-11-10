-- Lab | Advanced SQL and Pivot tables.sql


-- Select the first name, last name, and email address of all the customers who have rented a movie.

select first_name, last_name, email 
from customer 
where customer_id in (
select distinct customer_id 
from rental
) ; 

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select distinct payment.customer_id, CONCAT(first_name, ' ', last_name) AS customer_name, avg(amount) as avg_payment_made
from payment, customer 
where customer.customer_id=payment.customer_id 
group by customer_id ; 

-- Select the name and email address of all the customers who have rented the "Action" movies.

    -- Write the query using multiple join statements
SELECT distinct CONCAT(first_name, ' ', last_name) AS customer_name, email
FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id 
INNER JOIN inventory on inventory.inventory_id=rental.inventory_id 
INNER JOIN film_category on film_category.film_id=inventory.film_id 
WHERE film_category.category_id=1 ; 

    -- Write the query using sub queries with multiple WHERE clause and IN condition
select CONCAT(first_name, ' ', last_name) AS customer_name, email 
from customer 
where customer_id in (select distinct customer_id 
from rental where inventory_id in (select inventory_id from inventory where film_id in (select film_id from film_category where category_id=1))) ; 

     -- Verify if the above two queries produce the same results or not
     
     
-- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

select payment_id, amount,
 CASE 
      WHEN avg(amount)<2 THEN 'Low'
      WHEN avg(amount)>2 and avg(amount)<4 THEN 'Medium'
      ELSE 'High'
    END
from payment 
group by payment_id ;


select distinct payment.customer_id, CONCAT(first_name, ' ', last_name) AS customer_name, avg(amount) as avgpayment, 
 CASE 
      WHEN avg(amount)<2 THEN 'Low'
      WHEN avg(amount)>2 and avg(amount)<4 THEN 'Medium'
      ELSE 'High'
    END
from payment, customer 
where customer.customer_id=payment.customer_id 
group by customer_id ; 