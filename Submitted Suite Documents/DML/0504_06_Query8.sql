--8.Which restaurants in College Park AND Hyattsville has affordable price(1-2)?
SELECT resName
FROM Restaurant 
WHERE resCity IN('Hyattsville','College Park')
AND resPrice IN(1,2)
ORDER BY resId