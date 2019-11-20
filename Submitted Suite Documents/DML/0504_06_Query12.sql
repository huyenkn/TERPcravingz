--12.How many restaurants can provide delivery service in each city and then their category?
SELECT r.resCity, c.categoryName, COUNT(r.resId) AS'the number of restaurant'
FROM Restaurant r, Category c, Belong b
WHERE r.resId = b.resId
AND b.categoryId = c.categoryId
AND r.resTransactionType = 'delivery'
GROUP BY r.resCity,c.categoryName
ORDER BY r.resCity,c.categoryName