--4.What is the number of restaurants nearest to each stop?
SELECT p.stopId, COUNT(r.resId) AS 'the number of restaurant'
FROM Stop p LEFT OUTER JOIN Restaurant r
ON p.stopId = r.stopId
GROUP BY p.stopId