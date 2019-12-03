SELECT r.stopId AS 'Stop ID' , s.stopName AS 'Stop Name', COUNT(r.resId) AS 'Number of restaurants'
FROM Restaurant r, Stop s
WHERE r.stopId = s.stopId
AND r.walktimeToRes <= 15
GROUP BY r.stopId, s.stopName
HAVING COUNT(r.resId) >= 10 AND COUNT(r.resId) <= 100
ORDER BY COUNT(r.resId) DESC