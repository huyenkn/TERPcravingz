---Entrepreneur wants to find a shuttle stop that is near 10 to 100 restaurants 
---within 20 min walk

SELECT r.stopId, s.stopName, COUNT(r.resId) AS 'Number of restaurants'
FROM Restaurant r, Stop s
WHERE r.stopId = s.stopId
AND r.walktimeToRes <= 15
GROUP BY r.stopId, s.stopName
HAVING COUNT(r.resId) >=10 AND COUNT(r.resId) <= 100
ORDER BY COUNT(r.resId) DESC

