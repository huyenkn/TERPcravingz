--13.What are all details about restaurants which are above average rating and has more than average reviews with every category?
SELECT c.categoryName, resName, resStreet + ', ' + resCity + ', ' + resState AS 'resAddress', 
resPhoneNo, resStars, resRevCNT
FROM Restaurant r, Category c, Belong b, (
	SELECT AVG(resStars) AS avgResStars, AVG(resRevCNT) AS avgResRevCNT 
	FROM Restaurant) s
WHERE r.resId = b.resId
AND b.categoryId = c.categoryId
AND r.resStars > s.avgResStars
AND r.resRevCNT > s.avgResRevCNT