--3.What are three top most unpopular categories and their average price in each city?
SELECT r.resCity, c.categoryName AS 'Lowest Category', AVG(r.resPrice) AS'average price'
FROM Category c, Restaurant r, Belong b, (
	SELECT TOP 3 c.categoryName, COUNT(b.resId) AS 'Number of Restaurants'
	FROM Category c, Belong b
	WHERE c.categoryId = b.categoryId
	GROUP BY c.categoryName
	ORDER BY COUNT(b.resId)) t
WHERE b.resId = r.resId
AND c.categoryId = b.categoryId
AND c.categoryName = t.categoryName
GROUP BY r.resCity, c.categoryName
