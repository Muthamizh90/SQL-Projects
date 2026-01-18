use test;

select * from sales_dataset;

-- DYNAMIC PIVOT
-- Get Product category sold in each region
SELECT DISTINCT Category
FROM sales_dataset;

SELECT DISTINCT City
FROM sales_dataset;

DECLARE @pivotcols NVARCHAR(MAX), @pivotquery NVARCHAR(MAX);

SELECT @pivotcols = 
				STRING_AGG(QUOTENAME(Category),',')
				FROM (SELECT DISTINCT Category FROM sales_dataset) AS PC;

SET @pivotquery = 
				'SELECT *
				FROM (SELECT City, Category, TotalAmount FROM sales_dataset) AS PQS
				PIVOT(
				SUM(TotalAmount) FOR Category IN (' + @pivotcols + ')) AS PVT';

EXEC sp_executesql @pivotquery;