-- Dataset File: sales_dataset.csv

-- View Dataset
select * from sales_dataset;

-- DYNAMIC PIVOT
-- To Get Total Sales by Product category in each region

-- Declare variable for columns and query
DECLARE @pivotcols NVARCHAR(MAX), @pivotquery NVARCHAR(MAX);

-- Get column names dynamically
SELECT @pivotcols = 
				STRING_AGG(QUOTENAME(Category),',')
				FROM (SELECT DISTINCT Category FROM sales_dataset) AS PC;
-- Query
SET @pivotquery = 
				'SELECT *
				FROM (SELECT City, Category, TotalAmount FROM sales_dataset) AS PQS
				PIVOT(
				SUM(TotalAmount) FOR Category IN (' + @pivotcols + ')) AS PVT';

-- Execute Query
EXEC sp_executesql @pivotquery;


