-- Dataset file: pivoted_sales_dataset.csv

select * from pivoted_sales_dataset;


-- DYNAMIC UNPIVOT


--Declare variables for Dynamic columns and Query

DECLARE @unpivotcols NVARCHAR(MAX), @unpivotquery NVARCHAR(MAX);

-- Get Column names
SELECT @unpivotcols = 
					STRING_AGG(QUOTENAME(name),',')
					FROM sys.columns WHERE object_id = OBJECT_ID('pivoted_sales_dataset') AND name NOT IN ('City','Product');
-- Query
SET @unpivotquery = 
				'SELECT City, Product, SalesPerson, SaleAmount
				FROM pivoted_sales_dataset
				UNPIVOT(
				SaleAmount FOR SalesPerson IN (' +@unpivotcols+ ')) AS UPVT';

-- Execute Query
EXEC sp_executesql @unpivotquery;
