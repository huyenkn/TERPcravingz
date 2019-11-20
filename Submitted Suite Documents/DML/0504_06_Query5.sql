--5.What are the restaurants that open at late hours on weekends(11:00p.m.-5:00a.m.)?
SELECT resId,resName
FROM Restaurant 
WHERE SatEndTime Between '23:00:00'AND '05:00:00'