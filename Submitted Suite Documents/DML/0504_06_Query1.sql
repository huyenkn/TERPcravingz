--Suppose I am a person looking to open a restaurant near UMD:
--1. What is the average price of all restaurants in each city, in the order of descending average price, and then alphabetical order of city?


SELECT r.resState as 'State' , r.resCity AS 'City', ROUND(AVG(CAST(r.resPrice AS FLOAT)), 2) AS 'average price'
FROM Restaurant r
GROUP BY r.resState, r.resCity
HAVING AVG(r.resPrice) > 0
ORDER BY AVG(r.resPrice) DESC,r.resState, r.resCity



