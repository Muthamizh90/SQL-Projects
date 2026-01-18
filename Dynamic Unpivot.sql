use test;

select * from pivoted_sales_dataset;

-- DYNAMIC UNPIVOT

DECLARE @unpivotcols NVARCHAR(MAX), @unpivotquery NVARCHAR(MAX);

SELECT @unpivotcols = 
					STRING_AGG(QUOTENAME(name),',')
					FROM sys.columns WHERE object_id = OBJECT_ID('pivoted_sales_dataset') AND name NOT IN ('City','Product');

SET @unpivotquery = 
				'SELECT City, Product, SalesPerson, SaleAmount
				FROM pivoted_sales_dataset
				UNPIVOT(
				SaleAmount FOR SalesPerson IN (' +@unpivotcols+ ')) AS UPVT';

EXEC sp_executesql @unpivotquery;