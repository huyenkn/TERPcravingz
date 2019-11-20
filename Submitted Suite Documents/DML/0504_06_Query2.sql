--2. What is the number of restaurants in each State and each city?
SELECT resState, COALESCE(resCity, 'All Cities') AS 'City Name', COUNT(resId) AS 'Number of Restaurants'
FROM Restaurant
GROUP BY ROLLUP (resState, resCity)

