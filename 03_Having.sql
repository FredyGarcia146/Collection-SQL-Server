USE AdventureWorksLT2014

--SELECT * FROM SalesLT.Product


-- USE HAVING

	-- COUNT 
	SELECT Color, COUNT(*) Q FROM SalesLT.Product
	GROUP BY Color
	HAVING COUNT(*)>30


	-- fuction AND ORDER BY 
	SELECT Color, AVG(ListPrice) average, MAX(ListPrice) Max_price FROM SalesLT.Product
	GROUP BY Color
	HAVING AVG(ListPrice)>900
	ORDER BY MAX(ListPrice) DESC


	-- FUCTION AND ORDER BY WITH ROW_NUMBER COLUMN

	SELECT Color, AVG(ListPrice) average, MAX(ListPrice) Max_price,ROW_NUMBER() OVER(ORDER BY MAX(ListPrice) DESC) ID FROM SalesLT.Product
	GROUP BY Color
	HAVING AVG(ListPrice)>900

	
