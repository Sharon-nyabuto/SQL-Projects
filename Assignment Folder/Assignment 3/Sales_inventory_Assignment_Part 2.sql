
set search_path = assignment;

-- SUBQUERY QUESTIONS

-- 51. Which customers have spent more than the average spending of all customers?
select c.customer_id, c.first_name, c.last_name,s.total_amount
from sales s
join customers c
on s.customer_id = c.customer_id 
where s.total_amount > (select avg(total_amount) from sales); ---if you need just a single value, you use a scalar subquery, as so 
-- 52. Which products are priced higher than the average price of all products?
select avg(price) from products;
select 
	product_name, price 
	from products
	where price >(select avg(price) from products);
-- 53. Which customers have never made a purchase?
select customer_id from sales;
select c.first_name, c.last_name,c.customer_id
from customers c
left join sales s on c.customer_id= s.customer_id
where c.customer_id not in (select customer_id from sales);

-- 54. Which products have never been sold?
customer_id from sales);
select * from products p
left join sales s
on p.product_id= s.product_id
where p.product_id not in (select product_id from sales);

-- 55. Which customer made the single most expensive purchase (total amount)?
select c.customer_id, c.first_name,s.total_amount
from  customers c
join sales s
on c.customer_id = s.sale_id
where s.total_amount = (select max(total_amount) from sales);

-- 56. Which products have total sales greater than the average total sales across all products?
select p.product_id, p.product_name, s.total_amount
from sales s
join products p
on p.product_id = s.product_id 
where s.total_amount > (select avg(total_amount) from sales);

-- 57. Which customers registered earlier than the average registration date?
-- Average of a date column can be calculated using; SELECT TO_TIMESTAMP(AVG(EXTRACT(EPOCH FROM registration_date)))::DATE FROM assignment.customers
select first_name, last_name,registration_date 
from customers
where registration_date< (SELECT TO_TIMESTAMP(AVG(EXTRACT(EPOCH FROM registration_date)))::DATE FROM assignment.customers);

-- 58. Which products have a price higher than the average price within their own category?---may need to get back and figure it out
select p.product_id,p.product_name,p.price, p.category
from products p
join( select category, AVG(price) AS avg_price
    from products p 
    group by category) AS category_avg 
    ON p.category = category_avg.category
WHERE p.price > category_avg.avg_price;

select * from sales;
select * from products;

/* p.category = category ensures the average is category-specific, not general. it's like saying for every item in categry electronics, compare this product's average with the average price of it's category. It will calculate the average price for that product’s category only, then compares the product to that average
p.category = p.category or category = category will calculate the overall average for all products, not by category
*/

-- 59. Which customers have spent more than the customer with ID = 10?
select c.first_name, c.customer_id, sum(s.total_amount) as total_spent
from sales s
inner join customers c on c.customer_id = s.customer_id
group by c.first_name, c.customer_id
having sum(s.total_amount) > (select sum(total_amount)
from sales 
where customer_id = 10);

-- 60. Which products have total quantity sold greater than the overall average quantity sold?
select avg(quantity_sold) from sales;

select p.product_name, p.product_id,sum(s.quantity_sold) as total_sold
from products p
join sales s on p.product_id = s.product_id
group by p.product_name,p.product_id
having sum(s.quantity_sold)>(select avg(quantity_sold) from sales);

/*select avg(quantity_sold) from sales;
select p.product_name, p.product_id, s.quantity_sold
from products p
join sales s
on p.product_id = s.product_id
where sum(quantity_sold) > (select avg(quantity_sold) from sales);*/


-- COMMON TABLE EXPRESSIONS (CTEs)

-- 61. Create an intermediate result that calculates the total amount spent by each customer,
--     then determine which customers are the top 5 highest spenders.

select customer_id, sum(total_amount) as total_spent 
from sales
group by customer_id;---inner query

with spending as
(select customer_id, sum(total_amount) as total_spent 
from sales
group by customer_id)
select*
from spending
ORDER BY total_spent DESC
LIMIT 5;

--using the dense rank
with customer_spending as (
select customer_id, sum(total_amount) as sum_total_amount,
dense_rank() over(order by sum(total_amount)desc) as ranking 
from sales
group by customer_id)
select * from customer_spending
where ranking <=5;

-- 62. Create an intermediate result that calculates total quantity sold per product,
--     then determine which products are the top 3 most sold.
with product_sold as(
select product_id,sum(quantity_sold) as total_quantity_sold, 
dense_rank() over(order by sum(quantity_sold)desc) as ranking
from sales 
group by product_id)
select *from product_sold
where ranking <=3;

-- 63. Create an intermediate result showing total sales per product category,
--     then determine which category generates the highest revenue.
with highest_sales as 
(select p.category, sum(s.total_amount) as total_sale_amount
 from sales s
 join products p on  p.product_id = s.product_id
 group by p.category)
select * from highest_sales
where total_sale_amount= ( select max(total_sale_amount)
from highest_sales);

--using dense ranks
with highest_sales as 
	(select p.category, sum(s.total_amount) as total_sale_amount, dense_rank() over (order by sum(s.total_amount) desc) ranking
 	from sales s
 	join products p 
 	on  p.product_id = s.product_id
 	group by p.category)
select * from highest_sales
where ranking =1;

-- 64. Create an intermediate result that calculates the number of purchases per customer,
--     then identify customers who purchased more than twice.
with purchase_count as (
select c.first_name,c.customer_id, count(s.customer_id) as repeat_purchase
from sales s
join customers c 
on s.customer_id= c.customer_id
group by c.customer_id)
select * from purchase_count 
where repeat_purchase>2;

-- 65. Create an intermediate result that calculates the total quantity sold per product,
--     then determine which products sold more than the average quantity sold.
with total_product_sold as (
select p.product_name,p.product_id, sum(s.quantity_sold) as total_quantity_sold 
from sales s 
join products p on s.product_id= p.product_id
group by p.product_id) 
select * from total_product_sold 
where total_quantity_sold > (select avg(total_quantity_sold)
from total_product_sold);

-- 66. Create an intermediate result that calculates total spending per customer,
--     then determine which customers spent more than the average spending.
with customer_spending as (
select c.first_name,c.customer_id, sum(s.total_amount) as sum_amount
from customers c
join sales s on c.customer_id= s.customer_id
group by c.customer_id)
select * from customer_spending
where sum_amount> (select avg(sum_amount) from customer_spending);

-- 67. Create an intermediate result that calculates total revenue per product,
--     then list the products ordered from highest revenue to lowest.
with revenue_ranking as(
select p.product_name,p.product_id, sum(s.total_amount) as revenue_per_product
from products p
join sales s on p.product_id= s.product_id
group by p.product_id)
select * from revenue_ranking r
order by revenue_per_product desc;

-- 68. Create an intermediate result showing monthly sales totals,
--     then determine which month had the highest revenue.
--Get monthly total sales (intermediate result)
--From that, find the month with the highest total

--with dense_rank
with highest_months as(
select dense_rank() over (order by sum(s.total_amount) desc) as rank,
sum (s.total_amount)as total_sales,
extract (month from sale_date)::text as month, 
extract (year from sale_date)::text as year
from sales s
group by month, year)
select * from highest_months
where rank = 1;

--with subquery in CTE
with highest_month as(
select sum(s.total_amount) as total_sales,
extract (month from sale_date)::text as month, 
extract (year from sale_date)::text as year
from sales s
group by month, year)
select * from highest_month 
where total_sales =(select max(total_sales)from highest_month);

--using date_trunc
with highest_month as(
select sum(s.total_amount) as total_sales,
date_trunc('month', sale_date)::text as month
from sales s
group by month)
select * from highest_month 
where total_sales =(select max(total_sales)from highest_month);

select* from sales;

-- 69. Create an intermediate result that calculates the number of sales per product,
--     then determine which products were purchased by more than three customers.  ---get a dataset that has more to try this out
--sales per customer 
--number of sales per customer > than 3
--count of customer
--Number of sales per product

with sale_count as(
select  product_id, count(distinct customer_id) as count_of_customers,
 count(sale_id) as No_of_sales
from sales
group by product_id) 
select * from sale_count 
where count_of_customers >3;

-- 70. Create an intermediate result showing total quantity sold per product,
--     then identify products that sold less than the average quantity sold.
--find average quantity sold per product
--products with quanitity sold less than average
with Average_quantity_sold as(
select p.product_id, p.product_name, sum(s.quantity_sold) as Sum_of_quantity
from sales s
join products p
on p.product_id =s.product_id
group by p.product_id)
select * from Average_quantity_sold
where Sum_of_quantity < (select avg(quantity_sold)from sales);

-- WINDOW FUNCTION QUESTIONS

-- 71. Rank customers based on the total amount they have spent.
select * from customers;
select * from sales;
select c.customer_id, c.first_name, sum(total_amount) as Amount_totals, 
dense_rank() over (order by sum(s.total_amount)desc) as Amount_Ranks
from sales s
join customers c
on c.customer_id = s.customer_id
group by c.customer_id;

-- 72. Rank products based on total quantity sold.
--rank
select p.product_id, p.product_name, sum(s.quantity_sold) as Total_sold,
rank()over (order by sum(s.quantity_sold)desc) as Quantity_rank
from products p
join sales s
on s.product_id = p.product_id
group by p.product_id;
--dense_rank
select p.product_id, p.product_name, sum(s.quantity_sold) as Total_sold,
dense_rank()over (order by sum(s.quantity_sold)desc) as Quantity_rank
from products p
join sales s
on s.product_id = p.product_id
group by p.product_id;
-- 73. Identify the 3rd highest spending customer.
---rank all customers with spending, then filter 3
with Customer_spending as(
select c.customer_id, c.first_name, sum(s.total_amount) as Totals,
dense_rank()over (order by sum(s.total_amount)desc) as Spending_rank
from sales s
join customers c
on c.customer_id = s.customer_id
group by c.customer_id)
select * from Customer_spending
where Spending_rank = 3;

-- 74. Identify the 2nd most expensive product. 
with Product_cost as (
select p.product_id, p.product_name, p.price,
dense_rank()over (order by p.price desc) as Price_rank
from products p)
select * from Product_cost
where price_rank = 2;
-- 75. Show the ranking of products within each category based on price.

select p.product_id,p.product_name, p.category, p.price,
dense_rank()over (partition by category order by price desc) as Category_rank
from products p;

-- 76. Show the ranking of customers based on the number of purchases they made.
--customers and their purchases, then rank them
select s.customer_id, c.first_name, count(s.sale_id) as no_of_sales, 
dense_rank()over (order by count(sale_id)) as Rank_of_Purchases
from sales s
join customers c
on c.customer_id = s.customer_id
group by  s.customer_id,c.first_name;

-- 77. Show the running total of sales amounts ordered by sale_date.

select sale_date, total_amount,
sum(total_amount) over(order by sale_date) as Running_totals
from sales;

-- 78. Show the previous sale amount for each sale ordered by sale_date.
--order by sale_date
--then use lag to find the previous
select total_amount, sale_date,
lag(total_amount) over (order by sale_date) as Previous_sale_Amount
from sales;
--lag skippin every 2 days
select total_amount, sale_date,
lag(total_amount,2) over (order by sale_date) as Previous_sale_Amount
from sales;

--lag skippin every 2 days ---figure out how to add input by month
select sum(total_amount), sale_date,
lag(sum(total_amount)) over (order by date_trunc('month', sale_date)) as Previous_sale_Amount
from sales
group by date_trunc('month', sale_date), sale_date;

-- 79. Show the next sale amount for each sale ordered by sale_date.
select total_amount, sale_date,
lead(total_amount) over (order by sale_date) as next_sale_amount
from sales;

-- 80. Divide customers into 4 groups based on total spending.
select c.customer_id, c.first_name, sum(total_amount) as total_spending,
ntile(4) over (order by sum(total_amount)desc) as Ntile_Groups
from customers c
join sales s
on c.customer_id = s.customer_id
group by c.customer_id;