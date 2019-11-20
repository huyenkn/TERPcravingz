--Suppose I am a person looking to open a restaurant near UMD:
--1. What is the average price of all restaurants in each city, in the order of descending average price, and then alphabetical order of city?
SELECT r.resCity AS 'City', COALESCE(AVG(r.resPrice),0)  AS 'Average Price'
FROM Restaurant r
GROUP BY r.resCity
ORDER BY AVG(r.resPrice) DESC, r.resCity


--2. What is the number of restaurants in each State and each city?
SELECT resState, COALESCE(resCity, 'All Cities') AS 'City Name', COUNT(resId) AS 'Number of Restaurants'
FROM Restaurant
GROUP BY ROLLUP (resState, resCity)

--3.Whar are Top 5 categories to each city and then postal code?
SELECT r.resCity, r.resPostalCode, c.categoryName
FROM Category c, Restaurant r, Belong b, (
	SELECT TOP 5 c.categoryName, COUNT(b.resId) AS 'Number of Restaurants'
	FROM Category c, Belong b
	WHERE c.categoryId = b.categoryId
	GROUP BY c.categoryName
	ORDER BY COUNT(b.resId) DESC) t
WHERE c.categoryId = b.categoryId
AND b.resId = r.resId
AND c.categoryName = t.categoryName
ORDER BY r.resCity

--4.What are three top most popular categories and their average price in each city?
SELECT r.resCity, c.categoryName AS 'Highest Category', AVG(r.resPrice) AS'average price'
FROM Category c, Restaurant r, Belong b, (
	SELECT TOP 3 c.categoryName, COUNT(b.resId) AS 'Number of Restaurants'
	FROM Category c, Belong b
	WHERE c.categoryId = b.categoryId
	GROUP BY c.categoryName
	ORDER BY COUNT(b.resId) DESC) t
WHERE b.resId = r.resId
AND c.categoryId = b.categoryId
AND c.categoryName = t.categoryName
GROUP BY r.resCity, c.categoryName

--5.What are three top most unpopular categories and their average price in each city?
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

--6.What is the number of restaurants nearest to each stop?
SELECT p.stopId, COUNT(r.resId) AS 'the number of restaurant'
FROM Stop p LEFT OUTER JOIN Restaurant r
ON p.stopId = r.stopId
GROUP BY p.stopId

--Suppose I am an individual searching for a restaurant:
--1.What are the restaurants that open at late hours on weekends(11:00p.m.-5:00a.m.)?
SELECT resId,resName
FROM Restaurant 
WHERE SatEndTime Between '23:00:00'AND '05:00:00'

--2.Which restaurants can do delivery on weekends during 6:00-10:00p.m.?
SELECT resId,resName
FROM Restaurant 
WHERE satStartTime <= '18:00:00'
AND satEndTime >= '22:00:00'
AND sunStartTime <= '18:00:00' 
AND sunEndTime >=  '23:00:00'
AND resTransactionType='delivery'

--3.What is the list of restaurants with pick-up service in each postal code?
SELECT resPostalCode, resName
FROM Restaurant
WHERE resTransactionType = 'pickup'
ORDER BY resPostalCode, resId

--4.Which restaurants in College Park AND Hyattsville has affordable price(1-2)?
SELECT resName
FROM Restaurant 
WHERE resCity IN('Hyattsville','College Park')
AND resPrice IN(1,2)
ORDER BY resId

--5.What are the top 5 customers/foodies who have highest numbers of reviews on various restaurants?
SELECT TOP 5 c.cusName, COUNT(w.revId) 
FROM Customer c, write w
WHERE w.cusId = c.cusId
GROUP BY c.cusId,c.cusName
ORDER BY COUNT(w.revId) DESC

--6.What are the names, addresses, phone numbers for restaurants that have high ranking AND are open on the weekend and has Review that includes: family OR friends?
SELECT r.resId,r.resName,r.resStreet, r.resCity,r.resState,r.resPhoneNo, r.resStars, r.resPrice
FROM Restaurant r,review e,write w, (
	SELECT w.resId, r.resStars 
	FROM Restaurant r, Write w, Review e
	WHERE w.revId = e.revId
	AND r.resId = w.resId
	AND (e.revText Like '%family%'
	OR e.revText Like '%friend%')) f
WHERE r.resId=w.resId AND e.revId=w.revId
AND r.resId = f.resId 
AND (r.satStartTime IS NOT NULL
OR r.sunStartTime IS NOT NULL)
AND r.resStars IN (4,5)
ORDER BY r.resStars DESC

--7.Which shuttle goes to restaurants that are in zipcode 20740 AND have pick-up service?
SELECT s.busNo,s.busName
FROM Shuttle s,Stop p,restaurant r,have h
WHERE h.busId=s.busId 
AND h.stopId=p.stopId
AND r.stopId=p.stopId
AND r.resPostalCode=20740
AND r.resTransactionType= 'pickup'

--8.How many restaurants can provide delivery service in each city and then their category?
SELECT r.resCity, c.categoryName, COUNT(r.resId) AS'the number of restaurant'
FROM Restaurant r, Category c, Belong b
WHERE r.resId = b.resId
AND b.categoryId = c.categoryId
AND r.resTransactionType = 'delivery'
GROUP BY r.resCity,c.categoryName
ORDER BY r.resCity,c.categoryName

--9.What are all details about restaurants which are above average rating and has more than average reviews with every category?
SELECT c.categoryName, resName, resStreet + ', ' + resCity + ', ' + resState AS 'resAddress', 
resPhoneNo, resStars, resRevCNT
FROM Restaurant r, Category c, Belong b, (
	SELECT AVG(resStars) AS avgResStars, AVG(resRevCNT) AS avgResRevCNT 
	FROM Restaurant) s
WHERE r.resId = b.resId
AND b.categoryId = c.categoryId
AND r.resStars > s.avgResStars
AND r.resRevCNT > s.avgResRevCNT

--10.What are restaurants that have lowerest walktimeToRes or can be reached by the most shuttles(within every category)?
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