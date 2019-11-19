Project proposal and Data
Team 0504-06
1. Relations:
?  	Restaurant(resId, resName, resStreet, resCity, resState, resPostalCode, resPhoneNo, resLat, resLong, resStars, resRevCNT, resPrice, resTransactionType, monStartTime, monEndTime, tuesStartTime, tuesEndTime, wedStartTime, wedEndTime, thurStartTime, thurEndTime, friStartTime, friEndTime, satStartTime, satEndTime, sunStartTime, sunEndTime, stopId, walktimeToRes) 
?  	Category(categoryId, categoryName) 
?  	Customer(cusId, cusName) 
?  	Review(revId, revRating, revText) 
?  	Shuttle(busId, busNo, busName, busFinalDest) 
?  	Stop(stopId, stopName, stopLat, stopLong) 
?  	Belong(resId, categoryId)
?  	Have(busId, stopId) 
?  	Write(cusId, resId, revId)

2. Functional Dependency:
?	resId ? resName, resStreet, resCity, resState, resPostalCode, resPhoneNo, resLat, resLong, resStars, resRevCNT, resPrice, resTransactionType,  monStartTime, monEndTime, tuesStartTime, tuesEndTime, wedStartTime, wedEndTime, thurStartTime, thurEndTime, friStartTime, friEndTime, satStartTime, satEndTime, sunStartTime, sunEndTime, stopId, walktimeToRes
?	categoryId ? categoryName
?	cusId ? cusName
?	revId ? revRating, revText
?	busId ? busId, busNo, busName, busFinalDest
?	stopId ? stopId, stopName, stopLat, stopLong
?	resId, categoryId ? 
?	revId, cusId, resId ? 

3. Normalizaton:
?	Restaurant(resId, resName, resStreet, resCity, resState, resPostalCode, resPhoneNo, resLat, resLong, resStars, resRevCNT, resPrice, resTransactionType, monStartTime, monEndTime, tuesStartTime, tuesEndTime, wedStartTime, wedEndTime, thurStartTime, thurEndTime, friStartTime, friEndTime, satStartTime, satEndTime, sunStartTime, sunEndTime, stopId, walktimeToRes) = 3NF
?	Have(busId, stopId) = 3NF
?	Category(categoryId, categoryName) = 3NF
?	Customer(cusId, cusName) = 3NF
?	Review(revId, revRating, revText) = 3NF
?	Shuttle(busId, busNo, busName, busFinalDest) = 3NF
?	Stop(stopId, stopName, stopLat, stopLong) = 3NF
?	Belong(resId, categoryId) = 3NF
?	Write(cusId, resId, revId) = 3NF
4. Business rules:
[R1]  When a stop is deleted from the database, restaurants under its coverage and the walktime between them corresponding to the nearest stop should be deleted in the database.
[R2] When a stop is changed in the database, restaurants corresponding to the nearest stop should be updated accordingly.
[R3] When a stop is deleted from the database, the corresponding information in the shuttle should also be deleted. 
[R4] When a stop is updated in the database, the corresponding information in the shuttle should be updated accordingly. 
[R5] When a restaurant is no longer in the database, the corresponding category information should be deleted from the database.
[R6] When a category is deleted from the database, the corresponding restaurant cannot be deleted in the database.
[R7] When a category of restaurants is changed in the database, the corresponding restaurant information should be changed accordingly.
[R8] When a customer is deleted or changed his information from the database, the restaurant and the review cannot be deleted or changed in the database.
[R9] When a restaurant is deleted or changed in the database for some reason, reviews which customers wrote for it cannot be deleted or changed in the database.
[R10] When a review is deleted from the database, the corresponding restaurant and customer information should be changed accordingly. 
[R11] When a review is being written or modified in the database, the restaurant and the review cannot be deleted or changed in the database.
[R12]When a restaurant changes information in the database, the corresponding category to the restaurant should be changed accordingly.
[R13] When a shuttle line doesn’t run anymore and is deleted from the database, the corresponding stop info should be deleted. 
[R14] When a shuttle line is changed in the database, the corresponding stop info should be updated accordingly.

5. Referential integrity:

Relation	Foreign Key	Base Relation	Primary Key	Business Rule	Constraint: ON DELETE	Business Rule	Constraint: ON UPDATE
Restaurant	stopId	Stop	stopId	R1	CASCADE	R2	NO ACTION
Have	stopId	Stop	stopId	R3	CASCADE	R4	CASCADE
Have	busId	Shuttle	busId	R13	CASCADE	R14	CASCADE
Belong	resId	Restaurant	resId	R5	CASCADE	R12	CASCADE
Belong	categoryId	Category	categoryId	R6	NO ACTION	R7	CASCADE
Write	cusId	Customer	cusId	R8	NO ACTION	R8	NO ACTION
Write	resId	Restaurant	resId	R9	NO ACTION	R9	NO ACTION
Write	revId	Review	revId	R10	CASCADE	R11	CASCADE


6. Describe Sample Data:
Every table in the database has been described using a few rows of the dataset. 







?	Restaurant

 
 
 
 
Text Example:
Restaurant('ZPQD0vQIzZIovtHieUEDKA', 'Frisch's Big Boy', '12150 Mason Montgomery Rd', 'Cincinnati', 'OH', '45249', '(513) 683-2680', 39.291615, -84.315287, 2.5, 19, 1, 'pickup', 0600, 2300, 0600, 2300, 0600, 2300, 0600, 2300, 0600, 2300, 0600, 2300, 0700, 2300, ‘10626’, 7.389309875)

?	Have

 

Text Example : 
Have(‘10101’, ‘10001’)

?	Category
 

Text Example:
Category(‘1001’, 'Ice Cream & Frozen Yogurt')



?	Customer
 

Text Example: 
Customer('K4Z8pVw56l0TnGpnZQulXg', 'Rob P.') 

?	Review

 

Text Example:
Review('RAnoq4EBIpomrG8GQvXA-w', 5, 'On the run (Five Guys isn't fast food but...) No matter which one I go to...Good eats! It's like Mickey D's but Oh So Much Better! Five Guys is proof that...')

?	Shuttle
 

Text Example:
Shuttle(‘10101’, ‘25’, 'Bowie State - Enclave Express', 'Bowie State University')

?	Stop

 

Text Example:
Stop(‘10001’, 'The Enclave', 38.99782, -76.93182)


?	Belong
 

Text Example:
Belong('Mni5c7Ic0yb8F8OBVjDWHA', ‘1001’)

?	Write
 
 

Text Example: 
Write('K4Z8pVw56l0TnGpnZQulXg', 'HbF6Jy01WCp7lJYwx_Nz9g', 'RAnoq4EBIpomrG8GQvXA-w')
