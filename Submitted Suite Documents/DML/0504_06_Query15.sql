--15-Find Number of restaurants, category wise in each city only if number of restaurants are more than 10
SELECT r.resCity, c.categoryName, COUNT(r.resId) AS 'Number of restaurants'
FROM Restaurant r, Category c, Belong b
WHERE c.categoryId = b.categoryId
AND b.resId = r.resId
GROUP BY r.resCity, c.categoryName
HAVING COUNT(r.resId) > 10
ORDER BY r.resCity