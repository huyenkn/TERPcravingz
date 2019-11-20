--6.Which restaurants can do delivery on weekends during 6:00-10:00p.m.?
SELECT resId,resName
FROM Restaurant 
WHERE satStartTime <= '18:00:00'
AND satEndTime >= '22:00:00'
AND sunStartTime <= '18:00:00' 
AND sunEndTime >=  '23:00:00'
AND resTransactionType='delivery'