USE DataDB

SELECT * FROM retail_sales_analysis_practice

SELECT product, SUM(REVENUE_NGN) AS Total_revenue
FROM retail_sales_analysis_practice;

--WHICH PRODUCTS GENERATE THE HIGHEST REVENUE?

SELECT product,SUM(Revenue_NGN) AS Total_revenue
FROM retail_sales_analysis_practice
GROUP BY Product
ORDER BY Total_revenue DESC;

-- WHICH REGION GENERATE THE HIGEST REVENUE?

SELECT Region,SUM(Revenue_ngn) AS Total_revenue
FROM retail_sales_analysis_practice
WHERE Region IS NOT NULL
GROUP BY Region
ORDER BY Total_revenue DESC;

-- REGION, PRODUCT WITH TOTAL REVENUE

SELECT Region,product, SUM(revenue_ngn) AS Total_revEnue
FROM retail_sales_analysis_practice
WHERE Region IS NOT NULL
Group by Region,product 
ORDER BY Region, Total_revenue DESC;

-- WHAT PERCENTAGE OF TOTAL REVENUE COMES FROM EACH REGION

SELECT Region,SUM(Revenue_NGN)AS Total_revenue,ROUND(SUM (Revenue_NGN) *100.0/(SELECT SUM(Revenue_NGN)
FROM retail_sales_analysis_practice
WHERE Region IS NOT NULL),2) AS Revenue_contribution_percent
FROM retail_sales_analysis_practice
WHERE Region IS NOT NULL
GROUP BY Region
ORDER BY Total_Revenue DESC;

-- WHAT IS OVERALL SALES PERFORMANCE

WITH RegionalSales AS (SELECT REGION,SUM(Revenue_NGN) AS Total_Revenue
FROM retail_sales_analysis_practice
WHERE Region IS NOT NULL
GROUP BY Region
)
SELECT Region, Total_Revenue,
CASE WHEN Total_Revenue >= 4000000 THEN 'High Performer'
WHEN Total_Revenue >= 2000000 THEN 'Average Perfomer'
ELSE 'Low Performer'
END AS Performance_Category
FROM RegionalSales
ORDER BY Total_Revenue DESC;


-- PRODUCTS PERFORMANCE
--PRODUCTS & REGION WITH TOTAL REVENUE AND TOTAL QUANTITY

SELECT product, region, SUM(Revenue_NGN) AS Total_revenue, SUM(Quantity) AS Total_Quantity 
FROM retail_sales_analysis_practice
WHERE region IS NOT NULL
GROUP BY Region, product
ORDER BY Total_Revenue DESC;

-- PRODUCT & REGION WITH HIGHEST QUANTITY SOLD

SELECT Product,Region, SUM(Quantity) AS Highest_Quantity_Sold
FROM retail_sales_analysis_practice
WHERE region IS NOT NULL
GROUP BY Product, Region
ORDER BY Highest_Quantity_Sold DESC;

-- PRODUCTS WITH HIGHEST QUANTITY SOLD

SELECT Product, SUM(Quantity) AS Highest_Quantity_Sold
FROM retail_sales_analysis_practice
WHERE product IS NOT NULL
GROUP BY Product
ORDER BY Highest_Quantity_Sold DESC;

--  WHAT PERCENTAGE OF TOTAL QUANTITY SOLD CONTRIBUTED BY EACH PRODUCT

SELECT Product, SUM(Quantity) AS Highest_Quantity_Sold, ROUND (SUM(Quantity) * 100.0/ (SELECT SUM(Quantity)
FROM retail_sales_analysis_practice
WHERE Product IS NOT NULL),2) AS Quantity_Sold_Percent
FROM retail_sales_analysis_practice
WHERE Product IS NOT NULL
GROUP BY Product
ORDER BY Highest_Quantity_Sold DESC;

--  WHAT IS OVERALL Product PERFORMANCE

WITH ProductSales AS (SELECT Product, SUM(Quantity) AS Total_Quantity_Sold
FROM retail_sales_analysis_practice
WHERE product IS NOT NULL
GROUP BY Product)
SELECT product,Total_Quantity_Sold,
CASE WHEN Total_Quantity_Sold >= 13 THEN 'High Sales'
WHEN Total_Quantity_Sold BETWEEN 10 AND 12 THEN 'Medium Sales'
ELSE 'Low Sales'
END AS Sale_Category
FROM ProductSales
ORDER BY Total_Quantity_Sold DESC;


--  REVENUE PERFORMANCE BY PRODUCT

SELECT Product, SUM(Quantity) AS Total_Quantity_Sold, SUM(Revenue_NGN) AS Total_Revenue, AVG(Unit_Price_NGN) AS Average_Unit_Price
FROM retail_sales_analysis_practice
WHERE product IS NOT NULL
GROUP BY Product
ORDER BY Total_Revenue DESC;

-- OVERALL SALES KPIS

SELECT SUM(Revenue_NGN) AS Total_Revenue,SUM(Quantity) AS Total_Quantity_Sold,COUNT(DISTINCT Order_ID) AS Total_Order,
ROUND(SUM(Revenue_NGN)/NULLIF(COUNT(DISTINCT Order_ID),0),2) AS Average_Order_Value
FROM retail_sales_analysis_practice;