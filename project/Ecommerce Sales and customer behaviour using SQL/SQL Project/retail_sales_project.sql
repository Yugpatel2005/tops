 create database retail_db;
 use retail_db;
 
CREATE TABLE retail_sales_dataset (
    Transaction_ID INT,
    Date VARCHAR(20),
    Customer_ID VARCHAR(20),  
    Gender VARCHAR(10),
    Age INT,
    Product_Category VARCHAR(50),
    Quantity INT,
    Price_per_Unit DECIMAL(10,2),
    Total_Amount DECIMAL(10,2)
);

select count(*) from retail_sales_dataset;
select * from retail_sales_dataset limit 10;

ALTER TABLE retail_sales_dataset RENAME TO retail_sales;

-- 1. total revenue
select sum(Total_Amount) as total_revenue  from retail_sales;

-- 2. Number of transactions per product category:
select product_category, count(*) as num_transations
from retail_sales 
group by product_category
order by num_transations desc;

-- 3.Average order value:
select avg(total_amount) as Avg_Order_Value from retail_sales;

-- 4.Customer demographics:
select gender,count(*) as count, avg(age) as avg_age from retail_sales
group by gender;

-- Top 5 products by revenue:
SELECT Product_Category, SUM(Total_Amount) AS Revenue
FROM Retail_Sales
GROUP BY Product_Category
ORDER BY Revenue DESC
LIMIT 5;


-- Top customers by spending:
SELECT Customer_ID, SUM(Total_Amount) AS Total_Spent
FROM Retail_Sales
GROUP BY Customer_ID
ORDER BY Total_Spent DESC
LIMIT 10;

-- High, Medium, Low customer segmentation:
SELECT Customer_ID, SUM(Total_Amount) AS Total_Spent,
       CASE 
           WHEN SUM(Total_Amount) > 1000 THEN 'High'
           WHEN SUM(Total_Amount) BETWEEN 500 AND 1000 THEN 'Medium'
           ELSE 'Low'
       END AS Segment
FROM Retail_Sales
GROUP BY Customer_ID;


-- "Performed advanced retail sales data analysis using SQL:
-- top-selling products, monthly sales trends, customer segmentation, and revenue insights."
