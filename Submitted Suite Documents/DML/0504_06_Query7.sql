--7.What is the list of restaurants with pick-up service in each postal code?
SELECT resPostalCode, resName
FROM Restaurant
WHERE resTransactionType = 'pickup'
ORDER BY resPostalCode, resId