USE ecommerce_analytics;

-- 01. View first 10 rows
SELECT *
FROM cleaned_online_retail
LIMIT 10;

-- 02. TOTAL RECORD COUNT
-- Checking the total number of records in the dataset.
SELECT COUNT(*) FROM cleaned_online_retail;

-- 03. UNIQUE CUSTOMER COUNT
SELECT COUNT(DISTINCT CustomerID) AS Unique_Customers
FROM cleaned_online_retail;

-- 04. DATE RANGE ANALYSIS
SELECT 
   MIN(InvoiceDate) AS First_Invoice_Date,
   MAX(InvoiceDate) AS Last_Invoice_Date
FROM cleaned_online_retail;

-- 05. UNIQUE PRODUCT COUNT
SELECT COUNT(distinct StockCode) AS unique_product 
FROM cleaned_online_retail;

-- 06. UNIQUE COUNTRY COUNT
SELECT COUNT(distinct Country) AS unique_country 
FROM cleaned_online_retail;

-- 07. TOTAL QUANTITY SOLD
SELECT SUM(Quantity) AS total_quantity 
FROM cleaned_online_retail;

-- 08. TOTAL SALES REVENUE
SELECT SUM(TotalPrice) AS revenue
FROM cleaned_online_retail;

-- 09. AVERAGE UNIT PRICE
SELECT AVG(UnitPrice) as avg_price
FROM cleaned_online_retail;

-- 10. PRICE RANGE ANALYSIS
SELECT 
      MIN(UnitPrice) AS lowest_price,
      MAX(UnitPrice) AS highest_price
FROM cleaned_online_retail;

-- 11. AVERAGE ORDER VALUE
SELECT SUM(TotalPrice)/COUNT(distinct InvoiceNo) AS avg_order_value
FROM cleaned_online_retail;

-- 12. MISSING CUSTOMER IDs
SELECT COUNT(*) AS missing_customer_IDs
 FROM cleaned_online_retail
WHERE CustomerID IS NULL;

-- 13. DUPLICATE RECORD CHECK
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    TotalPrice,
    COUNT(*) AS duplicate_count
FROM cleaned_online_retail
GROUP BY
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    TotalPrice
HAVING COUNT(*) > 1;

-- 14. ZERO-PRICE RECORDS
SELECT COUNT(*) AS zero_unitprice
FROM cleaned_online_retail
WHERE UnitPrice =0;

-- 15. NEGATIVE QUANTITY CHECK
SELECT COUNT(*) AS negative_quantity
FROM cleaned_online_retail
WHERE Quantity < 0 ;

-- 16. NEGATIVE UNIT PRICE CHECK
SELECT COUNT(*) AS negative_unitprice
FROM  cleaned_online_retail
WHERE UnitPrice < 0 ;

-- 17. SALES BY COUNTRY
SELECT Country, SUM(TotalPrice) AS revenue
FROM cleaned_online_retail
GROUP BY Country
ORDER BY revenue DESC;

-- 18. TOP 10 COUNTRIES BY SALES
SELECT Country , SUM(TotalPrice) AS revenue
FROM cleaned_online_retail
GROUP BY Country
ORDER BY revenue DESC limit 10 ;

-- 19. MONTHLY SALES ANALYSIS
SELECT
    YEAR(InvoiceDate) AS sales_year,
    MONTH(InvoiceDate) AS sales_month,
    SUM(TotalPrice) AS revenue
FROM cleaned_online_retail
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;

-- 20. MONTHLY ORDER COUNT
SELECT
    YEAR(InvoiceDate) AS sales_year,
    MONTH(InvoiceDate) AS sales_month,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_online_retail
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month ASC;

-- 21. MONTHLY AVERAGE ORDER VALUE
SELECT 
	  YEAR(InvoiceDate) AS sales_year,
      MONTH(InvoiceDate) AS sales_month,
      SUM(TotalPrice) AS revenue,
      COUNT(distinct InvoiceNo) AS Unique_order,
	   SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo) AS monthly_AOV
FROM cleaned_online_retail
GROUP BY sales_year,sales_month
ORDER BY sales_year,sales_month ASC;

-- 22. YEARLY SALES REVENUE
SELECT  
      SUM(TotalPrice) AS revenue,
      YEAR(InvoiceDate) AS sales_year
FROM cleaned_online_retail
GROUP BY sales_year
ORDER BY sales_year ASC;

-- 23. YEARLY ORDER COUNT
SELECT
	 YEAR(InvoiceDate) AS sales_year,
     COUNT(distinct InvoiceNo) AS Total_Orders
FROM cleaned_online_retail
GROUP BY sales_year
ORDER BY sales_year ASC;

-- 24. COUNTRY-WISE ORDER COUNT
SELECT
      Country,
      COUNT(distinct InvoiceNo) AS Total_order
FROM cleaned_online_retail
GROUP BY Country
ORDER BY Total_order DESC;

-- 25. TOP 10 BEST-SELLING PRODUCTS
SELECT
    StockCode,
    Description,
    SUM(Quantity) AS total_quantity
FROM cleaned_online_retail
GROUP BY StockCode, Description
ORDER BY total_quantity DESC
LIMIT 10;

-- 26. TOP 10 PRODUCTS BY REVENUE
SELECT 
	StockCode,
    description,
	SUM(TotalPrice) AS revenue
FROM cleaned_online_retail
GROUP BY StockCode,description
ORDER BY revenue DESC 
LIMIT 10;

-- 27. TOP 10 CUSTOMERS BY REVENUE
SELECT
      CustomerID,
      SUM(totalPrice) AS revenue
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY revenue DESC 
LIMIT 10;

-- 28. CUSTOMER ORDER FREQUENCY
SELECT CustomerID , COUNT(distinct InvoiceNo) AS total_order 
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_order DESC;

-- 29. REPEAT VS ONE-TIME CUSTOMERS
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS total_orders
    FROM cleaned_online_retail
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS customer_orders
GROUP BY customer_type;

-- 30. CUSTOMER REVENUE SEGMENTATION
SELECT
    CASE
        WHEN customer_revenue >= 5000 THEN 'High Value'
        WHEN customer_revenue >= 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    COUNT(*) AS total_customers
FROM (
    SELECT
        CustomerID,
        SUM(TotalPrice) AS customer_revenue
    FROM cleaned_online_retail
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS customer_spending
GROUP BY customer_segment
ORDER BY total_customers DESC;

-- 31. AVERAGE REVENUE PER CUSTOMER
SELECT
    AVG(customer_revenue) AS avg_customer_revenue
FROM (
    SELECT
        CustomerID,
        SUM(TotalPrice) AS customer_revenue
    FROM cleaned_online_retail
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS customer_spending;    
     
-- 32. SALES BY DAY OF WEEK
SELECT 
     DAYNAME(InvoiceDate) AS Day_name,
     SUM(TotalPrice) AS revenue
FROM cleaned_online_retail
GROUP BY Day_name
ORDER BY revenue DESC;
     
-- 33. SALES BY HOUR
SELECT
     HOUR(InvoiceDate) AS sale_hour,
     SUM(TotalPrice) AS revenue
FROM cleaned_online_retail
GROUP BY sale_hour
ORDER BY revenue DESC;

-- 34. SALES BY MONTH NAME
SELECT 
     MONTHNAME(InvoiceDate) AS month_name,
     SUM(TotalPrice) AS revenue
FROM cleaned_online_retail
GROUP BY month_name
ORDER BY revenue DESC;

-- 35. COUNTRY-WISE MONTHLY SALES
SELECT
     Country,
     MONTHNAME(InvoiceDate) AS month_name,
     SUM(TotalPrice) AS revenue
FROM cleaned_online_retail
GROUP BY Country,month_name
ORDER BY revenue DESC;

-- 36. COUNTRY-WISE AVERAGE ORDER VALUE
SELECT
    Country,
    SUM(TotalPrice) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo) AS average_order_value
FROM cleaned_online_retail
GROUP BY Country
ORDER BY average_order_value DESC
LIMIT 10;

-- 37. COUNTRY-WISE SALES CONTRIBUTION
SELECT
    Country,
    SUM(TotalPrice) AS country_revenue,
    ROUND(
        SUM(TotalPrice) * 100 /
        (SELECT SUM(TotalPrice) FROM cleaned_online_retail),
        2
    ) AS sales_percentage
FROM cleaned_online_retail
GROUP BY Country
ORDER BY sales_percentage DESC;

-- 38. TOP 10 CUSTOMERS BY ORDER COUNT
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_orders DESC
LIMIT 10;

-- 39. CUSTOMER AVERAGE SPENDING
SELECT
    CustomerID,
    SUM(TotalPrice) AS total_spending,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    ROUND(
        SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo), 2
    ) AS average_spending
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY average_spending DESC
LIMIT 10;

-- 40. CUSTOMER PURCHASE FREQUENCY SEGMENTATION
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time'
        WHEN total_orders BETWEEN 2 AND 5 THEN 'Occasional'
        WHEN total_orders BETWEEN 6 AND 10 THEN 'Regular'
        ELSE 'Frequent'
    END AS customer_segment,
    COUNT(*) AS total_customers
FROM (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS total_orders
    FROM cleaned_online_retail
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS customer_frequency
GROUP BY customer_segment
ORDER BY total_customers DESC;

-- 41. CUSTOMER PURCHASE HISTORY
SELECT
    CustomerID,
    MIN(InvoiceDate) AS first_purchase,
    MAX(InvoiceDate) AS last_purchase,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY first_purchase ASC;

-- 42. CUSTOMER RECENCY ANALYSIS
SELECT
    CustomerID,
    MAX(InvoiceDate) AS last_purchase,
    DATEDIFF(
        (SELECT MAX(InvoiceDate) FROM cleaned_online_retail),
        MAX(InvoiceDate)
    ) AS recency_days
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY recency_days ASC;

-- 43. CUSTOMER LIFETIME VALUE
SELECT
    CustomerID,
    SUM(TotalPrice) AS lifetime_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM cleaned_online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY lifetime_revenue DESC
LIMIT 10;