USE BUDT758_DB_0504_06

CREATE TABLE dbo.Customer(
   cusId CHAR(22) NOT NULL,
   cusName VARCHAR(40),
   CONSTRAINT pk_Customer_cusId PRIMARY KEY (cusId)
);

CREATE TABLE dbo.Category(
   categoryId CHAR(4) NOT NULL,
   categoryName VARCHAR(50),
   CONSTRAINT pk_Category_categoryId PRIMARY KEY (categoryId)
);

CREATE TABLE dbo.Stop(
    stopId   CHAR(5) NOT NULL,
    stopName VARCHAR(50),
    stopLat  DECIMAL(7, 5),
    stopLong DECIMAL(7, 5),
    CONSTRAINT pk_Stop_stopId PRIMARY KEY (stopId)
    );

CREATE TABLE dbo.Shuttle(
    busId CHAR(5) NOT NULL,
    busNo VARCHAR(3),
    busName VARCHAR(50),
    busFinalDest VARCHAR(50),
    CONSTRAINT pk_Shuttle_busId PRIMARY KEY (busId)
);

 CREATE TABLE dbo.Review(
   revId     CHAR(22) NOT NULL,
   revRating INTEGER,
   revText   VARCHAR(170),
   revDate DATETIME,
   CONSTRAINT pk_Review_revId PRIMARY KEY (revId)
);

CREATE TABLE dbo.Have(
   busId  CHAR(5)  NOT NULL,
   stopId CHAR(5)  NOT NULL,
   CONSTRAINT pk_Have_busId_stopId PRIMARY KEY(busId, stopId),
   CONSTRAINT fk_Have_busId FOREIGN KEY(busId)
        REFERENCES Shuttle(busId)
		    ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_Have_stopId FOREIGN KEY(stopId)
		REFERENCES dbo.Stop(stopId)
		    ON DELETE CASCADE 
            ON UPDATE CASCADE
            );


CREATE TABLE dbo.Restaurant(
    resId CHAR(22) NOT NULL,
    resName VARCHAR(70),
    resStreet VARCHAR(70),
    resCity VARCHAR(25),
    resState VARCHAR(3),
    resPostalCode VARCHAR(8),
    resPhoneNo VARCHAR(16),
    resLat DECIMAL(8, 6),
    resLong DECIMAL(8, 6),
    resStars NUMERIC(3, 1),
    resRevCNT INTEGER,
    resPrice INTEGER,
    resTransactionType VARCHAR(22),
    monStartTime TIME,
    monEndTime TIME,
    tuesStartTime TIME,
    tuesEndTime TIME,
    wedStartTime TIME,
    wedEndTime TIME,
    thuStartTime TIME,
    thuEndTime TIME,
    friStartTime TIME,
    friEndTime TIME,
    satStartTime TIME,
    satEndTime TIME,
    sunStartTime TIME,
    sunEndTime TIME,
    stopId CHAR(5),
    walktimeToRes DECIMAL(14,10),
    CONSTRAINT pk_Restaurant_resId PRIMARY KEY (resId),
    CONSTRAINT fk_Restaurant_stopId FOREIGN KEY (stopId)
		REFERENCES dbo.Stop(stopId)
		    ON DELETE CASCADE 
            ON UPDATE NO ACTION
        );


CREATE TABLE dbo.Belong(
    resId CHAR(22) NOT NULL,
    categoryId CHAR(4) NOT NULL,
    CONSTRAINT pk_Belong_resId_categoryId PRIMARY KEY (resId, categoryId),
    CONSTRAINT fk_Belong_resId FOREIGN KEY(resId)
        REFERENCES Restaurant(resId)
		    ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_Belong_categoryId FOREIGN KEY(categoryId)
		REFERENCES Category(categoryId)
		    ON DELETE NO ACTION
            ON UPDATE CASCADE      
);


CREATE TABLE dbo.Write(
   cusId CHAR(22) NOT NULL,
   resId CHAR(22) NOT NULL,
   revId CHAR(22) NOT NULL,
   CONSTRAINT pk_Write_cusId_resId_revId PRIMARY KEY (cusId, resId, revId),
   CONSTRAINT fk_Write_cusId FOREIGN KEY(cusId)
        REFERENCES Customer(cusId)
		    ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT fk_Write_resId FOREIGN KEY(resId)
		REFERENCES Restaurant(resId)
		    ON DELETE NO ACTION 
            ON UPDATE NO ACTION,
    CONSTRAINT fk_Write_revId FOREIGN KEY(revId)
		REFERENCES Review(revId)
		    ON DELETE CASCADE 
            ON UPDATE CASCADE
);