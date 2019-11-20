--14.What are restaurants that have lowerest walktimeToRes or can be reached by the most shuttles(within every category)?
--Accessbility
SELECT c.categoryName, r.resName, r.resStreet + ', ' + r.resCity + ', ' + r.resState AS 'resAddress', r.resPhoneNo
FROM Restaurant r, Category c, Belong b, Stop s, Have h, (
	SELECT top 1 stopId, COUNT(busId) AS CNTbusId FROM Have
	GROUP BY stopId
	ORDER BY COUNT(busId) DESC) m
WHERE r.resId = b.resId
AND b.categoryId = c.categoryId
AND r.stopId = s.stopId
AND s.stopId = h.stopId
AND (r.walktimeToRes > ALL(
	SELECT e.walktimeToRes FROM Restaurant e
	WHERE e.resId <> r.resId) 
OR r.stopId = m.stopId)