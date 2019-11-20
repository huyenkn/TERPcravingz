--9.What are the top 5 customers/foodies who have highest numbers of reviews on various restaurants?
SELECT TOP 5 c.cusName, COUNT(w.revId) 
FROM Customer c, write w
WHERE w.cusId = c.cusId
GROUP BY c.cusId,c.cusName
ORDER BY COUNT(w.revId) DESC