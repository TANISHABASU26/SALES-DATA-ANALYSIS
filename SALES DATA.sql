CREATE DATABASE IF NOT EXISTS saleswalmart ;

CREATE TABLE IF NOT EXISTS sales(
invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
branch VARCHAR(5) NOT NULL,
city VARCHAR(30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(10) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
VAT FLOAT(6,4) NOT NULL,
total DECIMAL(12, 4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment_methods VARCHAR(15) NOT NULL,
cogs DECIMAL(10,2) NOT NULL,
gross_margin_percentage FLOAT(11,9),
gross_income DECIMAL(12,2) NOT NULL,
rating FLOAT(2,1)
);

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
------------------------------------------------- Feature Engineering------------------------------------------------
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

SELECT time,
(CASE
WHEN time >='00:00:00' AND time <= '12:00:00' THEN 'MORNING'
WHEN time >= '12:01:00' AND time <= '16:00:00' THEN 'AFTERNOON'
ELSE 'EVENING'
END
) AS time_of_date
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_date VARCHAR(20);

UPDATE sales
SET time_of_date = (CASE

WHEN time >='00:00:00' AND time <= '12:00:00' THEN 'MORNING'
WHEN time >= '12:01:00' AND time <= '16:00:00' THEN 'AFTERNOON'
ELSE 'EVENING'
END
);

SELECT 
date,
DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales
SET day_name = DAYNAME(date);
----------month name---------------;
SELECT 
date,
MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name = MONTHNAME(date);

----------------generic--------------------
----------how many unique cities does data have?---------------

select 
distinct city
from sales;

select
	distinct city,
		branch
from sales;

---------How many unique lines does the data product have?
select
	count(distinct product_line)
from sales;


-------------what is most common payment method?-----
select
	payment_methods,
	count(payment_methods) as cnt
from sales
group by payment_methods
order by cnt desc;

------------what is the most sold product line?--------------
select
	product_line,
	count(product_line) as cnt
from sales
group by product_line
order by cnt desc;

------------total revenue by month?----------

select 
month_name as month,
sum(total) as total_revenue
from sales
group by month
order by total_revenue desc;	

--------what month has the largests COGS-------------
select 
month_name as months,
sum(cogs) as cogs
from sales
group by month_name
order by cogs desc;

---------------------what product line has the largest value?
select 
	product_line,
    sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;

which city has the largest revenue?
select
	branch,
	city,
	sum(total) as total_revenue
from sales
group by city, branch
order by total_revenue desc;

which product line has the largest VAT?
select
	product_line,
    avg(vat) as avg_tax
from sales
group by product_line
order by avg_tax desc;

---------Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales---------
--------------Which branch sold more products than average product sold?-------------
select
	branch,
    sum(quantity) as qty
from sales
group by branch
having sum(quantity) > (select avg(quantity) from sales);

--------What is the most common product line by gender?--------
select
	gender,
    product_line,
    count(gender) as total_cnt
from sales
group by gender,product_line
order by total_cnt desc;

------------What is the average rating of each product line?-------------------
select
	round(avg(rating),2) as avg_rating,
    product_line
from sales
group by product_line
order by avg_rating desc;

sales
1. Number of sales made in each time of the day per weekday
select 
	time_of_date,
    count(*) as total_sales
from sales
where day_name = "Monday"
group by time_of_date
order by total_sales desc

--------------Which of the customer types brings the most revenue?--------
select
	customer_type,
    sum(total) as total_revenue
from sales
group by customer_type
order by total_revenue desc;

------------Which city has the largest tax percent/ VAT (Value Added Tax)?--------
select
	city,
    avg(VAT) as VAT
from sales
group by city
order by VAT desc;

Which customer type pays the most in VAT?
select
	customer_type,
    avg(VAT) as VAT
from sales
group by customer_type
order by VAT desc;

----------------------customer---------------------------
How many unique customer types does the data have?

select
distinct customer_type
from sales;

How many unique payment methods does the data have?

select
distinct payment_methods
from sales;

What is the most common customer type?
 select
	customer_type,
	count(customer_type) as number_of_customers
 from sales
 group by customer_type
 order by number_of_customers desc;
 
 What is the gender of most of the customers?
select
	gender,
    count(*) as gender_count
from sales
group by gender
order by gender_count desc;

What is the gender distribution per branch?
select
	branch,
    count(gender) as branch_count
from sales
where gender = "Male"
group by branch
order by branch_count;

or

select
	gender,
    count(branch) as brnch_cnt
from sales
where branch = "A"
group by gender
order by brnch_cnt;

Which time of the day do customers give most ratings?

select
	time_of_date,
	round(avg(rating), 2) as rating
from sales
group by time_of_date
order by rating desc;

Which time of the day do customers give most ratings per branch?

select
	time_of_date,
	round(avg(rating), 2) as rating
from sales
where branch = "C"
group by time_of_date
order by rating desc;

Which day fo the week has the best avg ratings?
select
	day_name,
    avg(rating) as avg_rating
from sales
group by day_name
order by avg_rating desc;

Which day of the week has the best average ratings per branch?
Which day fo the week has the best avg ratings?
select
	day_name,
    avg(rating) as avg_rating
from sales
where branch = "A"
group by day_name
order by avg_rating desc;







