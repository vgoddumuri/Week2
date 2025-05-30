-- create database
create database week2;

-- use database
use week2;

-- no of tables
show tables;
-- display dataset values
select * from raw_sales_data; 

-- data types of each column
describe raw_sales_data;

-- Identifying missing values
select * from raw_sales_data where Email is null or TRIM(Email) = ''or `Discount (%)` is null or TRIM(`Discount (%)`) = '';

-- update email id
update raw_sales_data set email='not_provided@gmail.com' where email is null or trim(email)= '';

-- update discount
update raw_sales_data set `Discount (%)` = 0 where `Discount (%)` is null or TRIM(`Discount (%)`) = '';

-- Identifying duplicate customers
select Customer_Name, count(*) as count from raw_sales_data group by Customer_Name having count >1;

-- Inconsistance date formate
select Order_Date from raw_sales_data where 
Order_Date regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4}' 
or Order_Date regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}'
or Order_Date regexp '^[0-9]{4}/[0-9]{2}/[0-9]{2}'; 

-- updating Order_Date column in 'YYYY-MM-DD' formate
update raw_sales_data set Order_Date = date_format(str_to_date(Order_Date, '%m/%d/%Y'),'%Y-%m-%d') 
where Order_Date regexp '^[0-9]{2}/[0-9]{2}/[0-9]{4}';

-- Identify missing phone number
select * from raw_sales_data where phone is null or trim(phone)= '';

-- update phone number
update raw_sales_data set phone='0000000000' where phone is null or trim(phone)= '';

-- final dataset 
select * from raw_sales_data;

-- 1.Calculate total revenue per product category to determine the most profitable segments. 

select Product_Category, sum(Revenue) as Total_Revenue from raw_sales_data group by Product_Category 
order by Total_Revenue;

-- 2.Find the average discount applied across different customer segments to analyse discount effectiveness. 

select Product_Category, avg('Discount (%)') as Avg_Discount from raw_sales_data group by Product_Category
order by Avg_Discount;

-- 3.Analyse monthly sales trends to identify peak sales periods. 

select date_format(Order_Date,'%Y-%m') as month, sum(Revenue) as Total_Sales from raw_sales_data 
where Order_Date  group by date_format(Order_Date,'%Y-%m')
order by month;








