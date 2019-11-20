--11.Which shuttle goes to restaurants that are in zipcode 20740 AND have pick-up service?
SELECT s.busNo,s.busName
FROM Shuttle s,Stop p,restaurant r,have h
WHERE h.busId=s.busId 
AND h.stopId=p.stopId
AND r.stopId=p.stopId
AND r.resPostalCode=20740
AND r.resTransactionType= 'pickup'
