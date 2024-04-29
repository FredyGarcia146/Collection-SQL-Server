USE AdventureWorksLT2014

-- ADD COLUMN ORDER BY

	-- ORDER BY FOR ListPrice Ascending
	SELECT ROW_NUMBER() OVER (ORDER BY ListPrice ASC) Order_Price,
	* FROM SalesLT.Product


	-- ORDER BY FOR ListPrice Descending
	SELECT ROW_NUMBER() OVER (ORDER BY ListPrice DESC) Order_Price,
	* FROM SalesLT.Product


-- ADD COLUMN PARTITION BY ORDER BY

	-- ORDER BY FOR ListPrice Descending
	SELECT ROW_NUMBER() OVER (PARTITION BY ProductCategoryID ORDER BY ListPrice ASC) Partition_BY,
	* FROM SalesLT.Product













