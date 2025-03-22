Create database project1;

use project1;

create table Retail_Sales( 
transactions_id	int primary key,
sale_date	date,
sale_time	time,
customer_id	int,
gender	varchar(15),
age	int,
category	varchar(15),
quantiy	int,
price_per_unit	float,
cogs	float,
total_sale float
)

select * from Retail_Sales;
select count(*) from retail_sales;

-- check null 

select * from Retail_Sales
where 
transactions_id	is null or
sale_date	is null or
 sale_time is null or	
customer_id	is null or
 gender is null or	
age is null or	
category is null or
	quantiy	is null or 
    price_per_unit	is null or 
    cogs	is null or
    total_sale is null ;
    
    -- Total Sales
    
 select sum(total_sale) sales from retail_sales;
 
 -- Total unique Customers 
 
  select count(distinct(Customer_id) ) Total_Customers from retail_sales;
  
   -- Total unique Ctaegories
   
  select count(distinct(category) ) Total_Category from retail_sales;   
   
  
  Data Analysis & Business Key Problems & Answers

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

select * from retail_sales where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * from retail_sales 
where category = 'Clothing' 
AND quantiy >= 4
AND monthname(sale_date) = 'November' 
AND year(sale_date) = '2022';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as sales from retail_sales group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age), 2) age  from retail_sales where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales 
where total_sale > '1000';

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category, gender , count(transactions_id) total_transactions from retail_sales 
group by category, gender order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

Select year, month, avg_sales from 
(
select
 Year(Sale_date) as year, 
monthname(sale_date) month, 
Round(avg(total_sale) , 2) avg_sales,
Rank() over(partition by Year(Sale_date) order by Round(avg(total_sale) , 2) desc) _rank
from retail_sales
group by Year(Sale_date), monthname(sale_date) 
) t 
where _rank = '1';

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id, sum(total_sale) as ts from retail_sales
group by customer_id
order by 2 desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category, count(distinct customer_id) as cust from retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

select Shift, count(transactions_id) as orders from 
(
select*, 
  case 
when
hour(sale_time) <=12 then "Morning"
when hour(sale_time) between '12' and '17'then "Afternoon" 
when hour(sale_time) >17 then "Evening"
end as Shift
 from retail_sales
 ) t 
 group by shift ;
  