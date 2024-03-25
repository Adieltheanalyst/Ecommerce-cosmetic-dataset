SELECT*
from ['E-commerce  cosmetic dataset$']

--Data cleaning
UPDATE ['E-commerce  cosmetic dataset$']
SET rating = CASE
                 WHEN rating > 6 THEN NULL
				 ELSE rating
			 END;

UPDATE ['E-commerce  cosmetic dataset$']
SET rating = 0
WHERE rating IS NULL;

UPDATE ['E-commerce  cosmetic dataset$']
SET noofratings = 0
WHERE noofratings IS NULL;

UPDATE ['E-commerce  cosmetic dataset$']
SET Color = REPLACE(Color, 'No colour', 'No color')
WHERE Color LIKE 'No colour'

UPDATE ['E-commerce  cosmetic dataset$']
SET Color = REPLACE(Color, 'no', 'No color')
WHERE Color LIKE 'no'


--PRODUCTION DISTRIBUTION ACCROSS DIFFERENT WEBSITES
SELECT COUNT(*) AS products ,website,country
FROM ['E-commerce  cosmetic dataset$']
GROUP BY website,country

--CATEGORY ANALYSIS
SELECT category,COUNT(*) as products
FROM ['E-commerce  cosmetic dataset$']
GROUP BY category

--SUBCATEGORY ANALYSIS
SELECT TOP 10 subcategory,COUNT(*) as products
FROM ['E-commerce  cosmetic dataset$']
GROUP BY subcategory
ORDER BY products desc

--CATEGORY AND SUBCATEGORY ANALYSIS
SELECT TOP 10 category,subcategory,COUNT(*) as products
FROM ['E-commerce  cosmetic dataset$']
GROUP BY category,subcategory
ORDER BY products desc

--PRICE DISTRIBUTION
SELECT TOP 10 ROUND(CAST(AVG(price)AS float),2) as avg_price,category,subcategory
from ['E-commerce  cosmetic dataset$']
GROUP BY category,subcategory
ORDER BY avg_price desc

SELECT TOP 10 ROUND(CAST(AVG(price)AS float),2) as avg_price,category,subcategory
from ['E-commerce  cosmetic dataset$']
GROUP BY category,subcategory
ORDER BY avg_price asc

-- BRAND ANALYSIS
SELECT TOP 10 brand,
       COUNT(*) AS total_products,
	   ROUND(CAST(AVG(rating)AS float),2) AS average_rating,
	   SUM(noofratings) AS total_ratings,
	  ROUND(CAST((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ['E-commerce  cosmetic dataset$']))as float),2) AS market_share

FROM ['E-commerce  cosmetic dataset$']
GROUP BY brand 
ORDER BY market_share desc,average_rating DESC

--FORMULATION ANALYSIS      
SELECT TOP 10 form,
       COUNT(*) AS Frequency
FROM ['E-commerce  cosmetic dataset$']
GROUP BY form
ORDER BY Frequency DESC;

--INGRIDIENT ANALYSIS
SELECT TOP 10 ingredient, COUNT(*) AS ingredient_count
FROM (
    SELECT TRIM(value) AS ingredient
    FROM ['E-commerce  cosmetic dataset$']
    CROSS APPLY STRING_SPLIT(ingredients, ',')
) AS ingredients_table
GROUP BY ingredient
ORDER BY ingredient_count DESC;

--color analysis
SELECT TOP 10 color , count(*) as products
FROM ['E-commerce  cosmetic dataset$']
WHERE color IS NOT NULL
GROUP BY color
ORDER BY products desc

--Rating analysis
SELECT TOP 10 brand, ROUND(CAST(AVG(rating)AS FLOAT),2) AS avg_rating, COUNT(*) AS number_of_products
FROM  ['E-commerce  cosmetic dataset$']
GROUP BY brand
ORDER BY number_of_products desc

--coorelation analysis
SELECT 
     (COUNT(*) * SUM(price * rating) - SUM(price) * SUM(rating)) / 
    (SQRT((COUNT(*) * SUM(price * price) - SUM(price) * SUM(price)) * 
          (COUNT(*) * SUM(rating * rating) - SUM(rating) * SUM(rating)))) AS Price_Rating_Correlation
FROM 
    ['E-commerce  cosmetic dataset$'];


SELECT Price, Rating
FROM ['E-commerce  cosmetic dataset$'];