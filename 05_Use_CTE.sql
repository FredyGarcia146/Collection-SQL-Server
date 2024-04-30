USE [AdventureWorksLT2014]



SELECT *
INTO #Product
FROM [SalesLT].[Product]


-- USE CTE -- SELECT :

	;WITH A AS (
		SELECT * FROM #Product
	) 
	, Pivot_A_COUNT AS (
		SELECT *
		FROM (
			SELECT 
					COLOR				-- HEADERS
					,1 FLAG_COUNT		-- VALUE
					,ProductCategoryID	-- GROUP BY 
		
			FROM A
			) A PIVOT (
				COUNT(FLAG_COUNT) --VALUES
				FOR COLOR IN ([BLACK],[SILVER])
			) PVT
	
	)
	, Pivot_B_PRICE AS (
		SELECT *
		FROM (
			SELECT 
					COLOR				-- HEADERS
					,ListPrice			-- VALUE
					,ProductCategoryID	-- GROUP BY 
		
			FROM A
			) A PIVOT (
				AVG(ListPrice) --VALUES
				FOR COLOR IN ([BLACK],[SILVER])
			) PVT
	
	)
	SELECT * FROM Pivot_B_PRICE A INNER JOIN Pivot_A_COUNT B ON A.ProductCategoryID=B.ProductCategoryID 

-- USE CTE -- UPDATE :
	;WITH A AS (
		SELECT * FROM #Product
	) 
	, Pivot_A_COUNT AS (
		SELECT *
		FROM (
			SELECT 
					COLOR				-- HEADERS
					,1 FLAG_COUNT		-- VALUE
					,ProductCategoryID	-- GROUP BY 
		
			FROM A
			) A PIVOT (
				COUNT(FLAG_COUNT) --VALUES
				FOR COLOR IN ([BLACK],[SILVER],[VARIANT])
			) PVT
	
	)
	, Pivot_B_PRICE AS (
		SELECT *
		FROM (
			SELECT 
					COLOR				-- HEADERS
					,ListPrice			-- VALUE
					,ProductCategoryID	-- GROUP BY 
		
			FROM A
			) A PIVOT (
				AVG(ListPrice) --VALUES
				FOR COLOR IN ([BLACK],[SILVER],[VARIANT])
			) PVT
	
	)
	,PRUEBA_UPDATE AS (
		SELECT A.*,B.BLACK AS BLACK_COUNT, B.SILVER AS SILVER_COUNT , B.VARIANT AS VARIANT_COUNT
		FROM Pivot_B_PRICE A INNER JOIN Pivot_A_COUNT B 
		ON A.ProductCategoryID=B.ProductCategoryID 
		WHERE B.BLACK<B.SILVER
	) 
	  --SELECT * FROM PRUEBA_UPDATE
	  UPDATE A
	  SET COLOR = 'Variant'
	  WHERE ProductCategoryID IN (SELECT ProductCategoryID FROM PRUEBA_UPDATE)



