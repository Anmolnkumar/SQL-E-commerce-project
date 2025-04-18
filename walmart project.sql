CREATE DATABASE Walmart;

SELECT *
FROM walmart_customer_purchases;

-- What is the total revenue generated from all purchases?

SELECT ROUND(SUM(Purchase_Amount),2)AS Total_revenue
FROM walmart_customer_purchases;


-- Which product categories generate the highest revenue?


SELECT Category, ROUND(SUM(Purchase_Amount),2)AS Total_revenue
FROM walmart_customer_purchases
GROUP BY Category
ORDER BY Total_revenue DESC;


-- What are the top-selling products based on purchase count?

SELECT Product_Name, COUNT(*) AS Total_sold
FROM walmart_customer_purchases
GROUP BY Product_Name
ORDER BY Total_sold DESC
LIMIT 5;

-- Which cities contribute the most to sales?

SELECT City , ROUND(SUM(Purchase_Amount),2)AS Total_revenue_city
FROM walmart_customer_purchases
GROUP BY City
ORDER BY Total_revenue_city DESC;

-- How does sales performance vary by month or season?


SELECT YEAR(Purchase_Date) AS Year, 
    MONTH(Purchase_Date) AS Month, 
       ROUND(SUM(Purchase_Amount),2)AS Total_Revenue
FROM walmart_customer_purchases
GROUP BY YEAR,MONTH
ORDER BY Total_Revenue DESC;


-- What age group makes the most purchases?


SELECT 
  CASE
  WHEN Age < 20 THEN 'Teen'
        WHEN Age BETWEEN 20 AND 40 THEN 'Young Adult'
        WHEN Age BETWEEN 41 AND 60 THEN 'Middle Aged'
        ELSE 'Senior'
  END AS Age_category,COUNT(*) AS Total_purchase
  FROM walmart_customer_purchases
  GROUP BY Age_category
  ORDER BY Total_purchase DESC;
  
  
  
  -- What percentage of customers are repeat buyers?

SELECT 
    (SUM(CASE WHEN Repeat_Customer = 'Yes' THEN 1 
    ELSE 0 
    END) * 100.0) / COUNT(*) AS Repeat_Customer_Percentage
FROM walmart_customer_purchases;



-- Which city has the most repeat customers?

SELECT city, count(Repeat_Customer) AS Count_repeated_customers
FROM walmart_customer_purchases
GROUP BY city
ORDER BY Count_repeated_customers DESC;

-- What is the impact of discounts on total sales and revenue?


SELECT Discount_Applied, ROUND(AVG(Purchase_Amount),2) AS Avg_Spent
FROM walmart_customer_purchases
GROUP BY Discount_Applied;


-- What are the most preferred payment methods among customers?

SELECT Payment_Method, COUNT(Payment_Method) AS total_payment_method
FROM walmart_customer_purchases
GROUP BY Payment_Method
ORDER BY total_payment_method DESC;

-- Which product categories have the highest percentage of discount usage?


SELECT 
    Category, 
    (SUM(CASE WHEN Discount_Applied = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS Discount_Percentage
FROM walmart_customer_purchases
GROUP BY Category
ORDER BY Discount_Percentage DESC;


-- What is the average rating for each product category?

SELECT Category, ROUND(AVG(Rating),2) AS Avg_rating
FROM walmart_customer_purchases
GROUP BY Category
ORDER BY  Avg_rating DESC;

-- Which products receive the highest and lowest ratings?

-- HIGHTEST RATINGS

SELECT Product_Name, AVG(Rating) AS Avg_Rating
FROM walmart_customer_purchases
GROUP BY Product_Name
ORDER BY Avg_Rating DESC
LIMIT 10;

-- LOWEST RATINGS

SELECT Product_Name, AVG(Rating) AS Avg_Rating
FROM walmart_customer_purchases
GROUP BY Product_Name
ORDER BY Avg_Rating ASC
LIMIT 10;


-- Is there a correlation between purchase amount and customer rating?

SELECT Rating, ROUND(AVG(Purchase_Amount),2) AS Avg_Spending
FROM walmart_customer_purchases
GROUP BY Rating
ORDER BY Rating DESC;

-- Do customers who receive discounts spend more or less than those who don’t?

SELECT 
    Discount_Applied, 
    ROUND(AVG(Purchase_Amount),2) AS Avg_Spending
FROM walmart_customer_purchases
GROUP BY Discount_Applied;


