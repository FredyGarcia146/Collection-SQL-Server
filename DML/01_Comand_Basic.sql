USE [AdventureWorksLT2014]

--TEMPORARY:

SELECT *
INTO #Product
FROM [SalesLT].[Product]

--UPDATE:

UPDATE A
SET A.Color ='VARIANT'
--SELECT *
FROM #Product A 
WHERE COLOR ='VARIANT'


--DELETE:

DELETE A
--SELECT *
FROM #Product A
WHERE COLOR ='BLACK'


--SELECT, CASE WHEN:

SELECT CASE WHEN ListPrice>2000 THEN 'SI' ELSE 'NO' END VALUE_PRICE
,*
FROM #Product 
WHERE COLOR ='BLACK'


-- LIST A-B
SELECT * FROM #Product A RIGHT JOIN [SalesLT].[Product] B 
ON A.ProductID = B.ProductID
WHERE A.ProductID IS NULL