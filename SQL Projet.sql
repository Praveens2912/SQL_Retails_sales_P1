
Create table retails_sales
	(  
	
	transactions_id	INT Primary key,
	sale_date DATE,
	sale_time TIME,
	customer_id	INT,
	gender	 VARCHAR(15),
	age	 INT,
	category VARCHAR(15),	
	quantityy	 INT,
	price_per_unit	FLOAT,
	cogs	FLOAT,
	total_sale   FLOAT
	
);

Select count (*)
	from retails_sales
-- Data cleaning

Select * from retails_sales
where 
     transactions_id is null
     or 
     sale_date is null
     or
     sale_time is null
     or 
     customer_id is null
     or 
     gender is null
     or 
     age is null
     or 
     category is null
     or 
     quantiy is null
     or 
     price_per_unit is null
     or 
     cogs is null
     or 
     total_sale is null;
     
Delete from retails_sales
Where
    transactions_id is null
     or 
     sale_date is null
     or
     sale_time is null
     or 
     customer_id is null
     or 
     gender is null
     or 
     age is null
     or 
     category is null
     or 
     quantiy is null
     or 
     price_per_unit is null
     or 
     cogs is null
     or 
     total_sale is null;

-- Data Exploration

-- How many sales we have?

Select count(*) as total_sale from retails_sales

-- how many unique customers we have?


Select count(Distinct customer_id) as total_sale from retails_sales


Select distinct category from retails_sales


-- Data Analysis and business solving problems & Answer

--Q1. write a sql query to retrieve  all columns for sales made on '2022-11-05'

Select * from retails_sales
where sale_date = '2022-11-05';

-- Q2: write a sql query to retrieve all transactions where category is 'clothing' and the quality sold is more than 4 in the month of Nov-2022  

Select * from retails_sales
Where 
     category = 'Clothing'
     And
     To_Char(sale_date, 'YYYY-MM') = '2022-11'
     And 
     quantiy >=4;


-- Q3: Write a sql query to calculate the total sales(total_sale) for each category.

Select 
	Category,
	sum (total_sale) as net_sale,
	count(*) as total_order
	from retails_sales
  group by 1


--Q4: Write a sql duery to find the average age of customers who purchase items from the 'Beauty' category.

Select 
   Round(Avg(age),2) as avg_age
from retails_sales
Where category = 'Beauty'


--Q5: Write a sql query to find all transactions where the total_sale is greater than 1000.

Select * from retails_sales
Where total_sale > 1000


-- Q6: Write a sql Query to find the total number of transactions (transaction_id) made by each gender in each category.

Select 
     category,
     gender, 
     count(*) as total_trans
From retails_sales
group by 
      category,
     gender 
order by 1

-- Q7: Write a sql query to calculate the average sale for each month. Find out the best month of each year.

Select 
      year,
      month,
     Avg_sale

From 
(
	Select 
	Extract (year from sale_date) as year,
	Extract (month  from sale_date) as month,
	avg(total_sale) as avg_sale,
	rank() OVER(PARTITION BY EXTRACT (year from sale_date) Order by AVG(total_sale)DESC) as rank
from retails_sales
	group by 1,2
)as t1
where rank = 1


--Q8: Write a sql query to fine top 5 customers based on the high total sales

select 
     customer_id,
     sum(total_sale) as total_sales
from retails_sales
group by 1
Order by 2 Desc
Limit 5


--Q9: Write a sql query to find the number of unique customers who purchase items from each category.

Select 
 Category,
 COUNT(DISTINCT customer_id) as cnt_unique_cs
from retails_sales
GROUP BY category

--Q10: Write a Sql query to create each shift and number of orders (Eample Morning <=12, Afternoon between 12&17, Evening<17)

with hourly_sale
As
(
Select *,
	Case 
	WHEN EXTRACT (HOUR FROM sale_time) <12 THEN 'Morning'
	WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening' 
	END as shift
FROM retails_sales
)
Select 
    Shift,
    Count(*) as total_orders
From hourly_sale
Group by shift











