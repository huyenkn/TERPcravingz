--3.What are three top most popular categories and their average price in each city?
SELECT ccity, cName AS 'Highest Category', AVG(rePrice) AS'average price'
FROM (SELECT c.categoryName as cName,r.resPrice as rePrice, r.resCity as ccity, count(r.resId) as nmbre,
ROW_NUMBER() OVER( PARTITION BY r.resCity ORDER BY r.resCity,count(r.resId)) as rnmb
FROM  Restaurant r,Category c,belong b
WHERE b.resId=r.resId
AND c.categoryId=b.categoryId
GROUP BY  c.categoryName,r.resCity,r.resPrice) n
WHERE n.rnmb<4
GROUP BY ccity, cName
ORDER BY ccity