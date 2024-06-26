USE AdventureWorksLT2014


-- USE CURSOR
---------------------------------------------------------------------------------------------------------------------
-- DECLARATION: / START: OPEN / FINISH: CLOSE
	-- CREATE CURSOR:
	DECLARE EXAMPLE_CURSOR CURSOR FOR
	SELECT * FROM SalesLT.Product ORDER BY ListPrice

	-- OPENNING
		OPEN EXAMPLE_CURSOR

	-- READING AND ROUTE 
			
			FETCH NEXT FROM EXAMPLE_CURSOR


	-- CLOSING
		CLOSE EXAMPLE_CURSOR

	-- DROP CURSOR:

	DEALLOCATE EXAMPLE_CURSOR


---------------------------------------------------------------------------------------------------------------------
-- DECLARATION: / START: OPEN / FINISH: CLOSE
	-- CREATE CURSOR: AND USING UPDATE


	DROP TABLE IF EXISTS #PRODUCTS

	SELECT ROW_NUMBER() OVER (ORDER BY PRODUCTID ASC) ID,*
	INTO #PRODUCTS
	FROM SalesLT.Product ORDER BY PRODUCTID ASC
	

	ALTER TABLE #PRODUCTS ADD Average_Calc MONEY


	-- DECLARE PARAMETERS
	DECLARE @PRICE_PREV MONEY,@ID_PREV INT, 
			@PRICE_POST MONEY,@ID_POST INT ,
			@PRICE MONEY, @ID INT

	DECLARE EXAMPLE_CURSOR CURSOR STATIC SCROLL FOR
	SELECT ID,ListPrice FROM #PRODUCTS ORDER BY ID ASC

	-- OPENNING
		OPEN EXAMPLE_CURSOR

	-- READING AND ROUTE 
			-- DECLARE @PRICE_PREV MONEY, @PRICE_POST MONEY,@PRICE MONEY, @ID INT
			FETCH NEXT FROM EXAMPLE_CURSOR INTO @ID, @PRICE

			WHILE @@FETCH_STATUS = 0  -- WHILE FETCH DO NOT FINISH
			BEGIN
				IF ( @ID= 1 OR @ID=295)
					BEGIN
						PRINT  CAST(@ID AS VARCHAR) + ' ' +  CAST(@PRICE AS VARCHAR)
						FETCH NEXT FROM EXAMPLE_CURSOR INTO @ID, @PRICE
					END 
				ELSE 
					BEGIN 
						FETCH RELATIVE -1 FROM EXAMPLE_CURSOR INTO @ID_PREV, @PRICE_PREV
						FETCH RELATIVE 2 FROM EXAMPLE_CURSOR INTO @ID_POST, @PRICE_POST

						UPDATE #PRODUCTS
						SET Average_Calc = (@PRICE_PREV+@PRICE_POST +@PRICE)/3
						WHERE ID =@ID

						FETCH RELATIVE 0 FROM EXAMPLE_CURSOR INTO @ID, @PRICE
					END
			END

	-- CLOSING
		CLOSE EXAMPLE_CURSOR

	-- DROP CURSOR:

	DEALLOCATE EXAMPLE_CURSOR



	-- VIEW RESULT 
	SELECT * FROM #PRODUCTS ORDER BY ID ASC