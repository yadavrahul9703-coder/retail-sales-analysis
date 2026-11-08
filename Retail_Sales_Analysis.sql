-- SQL Salesdashboard
Create database ANALYTIC_MEMBRANCE;
use ANALYTIC_MEMBRANCE;
-- create table 
Create table retail_sales
             ( transactions_id int ,
             sale_date Date ,
             sale_time Time ,
             customer_id int ,
             gender varchar(15) ,
             age int ,
             category varchar(25) ,
             quantiy int ,
             price_per_unit float,
             cogs float ,
             total_sale float
                          ) ;
-- now inserting data into the table
select* from retail_sales limit 10;
-- Data exploaration
   select 
       count(*)
       from retail_sales;
-- NULL condition
   select * from retail_sales
   where
   transactions_id is Null
         or
   sale_date is Null
		or
   sale_time is Null
        or
   customer_id is Null
        or
   gender is Null
        or
   age is Null
        or
   category is Null
        or
   quantiy is Null
	 or
   price_per_unit is Null
     or
   cogs	is Null
	or
   total_sale is Null ;
-- How many sales we have ?
select count(*) as total_sales 
from retail_sales;
-- How many unique customers we have 
select count(distinct (customer_id))
 AS Total_customer
  from retail_sales;
  -- How many distinct category we have 
  select count(distinct(category) )
  as distinct_category 
  from retail_sales;
  
  ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;
  
-- -- Data Analysis & Business Key Problems & Answers
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select* from retail_sales
where sale_date ='2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from 
retail_sales 
where category = 'Clothing'
and
quantity >= 4
;
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category , sum(total_sale) ,
count(total_sale)
from retail_sales
group by category
;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category , Round(avg(age))
from retail_sales
where category = 'Beauty'
order by 2
asc;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select 
transactions_id , total_sale 
from retail_sales 
where total_sale > 1000
order by total_sale
ASC;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
category , gender ,
count(*) AS total_trans
 from retail_sales
group by 
1,2 ;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT *
FROM
(
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale)) AS total_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS ranking
    FROM retail_sales
    GROUP BY 1, 2
) AS t1
WHERE ranking = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select 
customer_id , 
sum(total_sale) as total_revenue
from retail_sales
group by 1
order by 1 
desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category ,
count(distinct(customer_id))as Unique_customer 
from retail_sales 
group by 1;
 
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale 
as (
select * ,
case 
 when hour(sale_time) < 12 then 'morning'
 when hour(sale_time) between 12 and 17 then 'afternoon'
 else 'evening'
 end as shift 
 from retail_sales )
 select shift ,
 count(transactions_id) as Total_orders
 from hourly_sale
 group by shift;
  
  --- END OF PROJECT --
  

