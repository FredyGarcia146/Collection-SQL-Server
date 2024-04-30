USE AdventureWorksLT2014


-- PIVOT -----------------------------------------------------------------------------------------------------

	-- CALCULATE COUNT
		SELECT * FROM (
			SELECT 
				IsNull(Color,'N/A') Color	-- HEADERS
				,1 Flag_Count				-- VALUE TO CALCULATE
				,Size						-- OTHER GROUPS
			FROM [SalesLT].[Product]
		) A PIVOT(
			COUNT(Flag_Count) 
				FOR Color IN (
							[N/A],
							[Black],
							[Blue],
							[Grey],
							[Multi],
							[Red],
							[Silver],
							[Silver/Black],
							[White],
							[Yellow]
							)
			) PVT



	-- CALCULATE VALUE SUM

		SELECT * FROM (
			SELECT 
				IsNull(Color,'N/A') Color		-- HEADERS
				,IsNull(ListPrice,0)ListPrice	-- VALUE TO CALCULATE
				,ProductCategoryID				-- OTHER GROUPS
				--,Size
			FROM [SalesLT].[Product]
		) A PIVOT(
			SUM(ListPrice)
				FOR Color IN (
							[N/A],
							[Black],
							[Blue],
							[Grey],
							[Multi],
							[Red],
							[Silver],
							[Silver/Black],
							[White],
							[Yellow]
							)
			) PVT
		ORDER BY ProductCategoryID 






-- UNPIVOT -----------------------------------------------------------------------------------------------------

	-- EXAMPLE PIVOT 

		DROP TABLE IF EXISTS #TABLE_PIVOT

		SELECT *
		INTO #TABLE_PIVOT
		FROM (
			SELECT 
				IsNull(Color,'N/A') Color		-- CABECERAS
				,IsNull(ListPrice,0)ListPrice	-- VALUE TO CALCULATE
				,ProductCategoryID				-- OTHER GROUPS
				,Size
			FROM [SalesLT].[Product]
		) A PIVOT(
				SUM(ListPrice)
				FOR Color IN (
							[Black],
							[Blue],
							[Grey]
							)
			) PVT
		ORDER BY ProductCategoryID 

	-- TABLE

		SELECT * FROM #TABLE_PIVOT

	-- UNPIVOT 

		SELECT ProductCategoryID,size,	-- GROUPS
			Color,						-- HEADERS
			Sum_Group					-- VALUE
		FROM (
			SELECT *
			FROM #TABLE_PIVOT
		) AS s
		UNPIVOT
		(
			Sum_Group FOR Color IN (Black, Blue, Grey)
		) AS unpvt;




--EXAMPLE 01 ------------------
SELECT * FROM 
(
	SELECT 
			TITLE			-- HEADERS
			,1 FLAG_COUNT	-- VALUE
			,MiddleName		-- OTHER GROUPS BY
	FROM [SalesLT].[Customer]
) A PIVOT (
	COUNT(FLAG_COUNT)
	FOR TITLE IN ([Mr.],[Ms.],[Sr.],[Sra.])
) PVT



--EXAMPLE 02 ------------------
SELECT * 
FROM 
(
	SELECT MiddleName, 1 FLAG_COUNT, TITLE 
	FROM [SalesLT].[Customer]
) A PIVOT 
	( 
		COUNT(FLAG_COUNT) 
		FOR MIDDLENAME IN ([A.],[B],[B.])
	) PVT

