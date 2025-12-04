USE EightWeekChallenge1;

--****************** Creating the SALES table ****************

CREATE TABLE sales(
	Row_id INTEGER,
	Customer_id VARCHAR(1) NOT NULL,
	Order_date DATE NOT NULL,
	Product_id INTEGER NOT NULL,
	CONSTRAINT sPrimaryKey PRIMARY KEY(Row_id)
)

-- Inserting data into the SALES table
INSERT INTO sales(Row_id,Customer_id,Order_date,Product_id)
VALUES(1,'A','2021-01-01',1),
	(2,'A','2021-01-01',2),
	(3,'A','2021-01-07',2),
	(4,'A','2021-01-10',3),
	(5,'A','2021-01-11',3),
	(6,'A','2021-01-11',3),
	(7,'B','2021-01-01',2),
	(8,'B','2021-01-02',2),
	(9,'B','2021-01-04',1),
	(10,'B','2021-01-11',1),
	(11,'B','2021-01-16',3),
	(12,'B','2021-02-01',3),
	(13,'C','2021-01-01',3),
	(14,'C','2021-01-01',3),
	(15,'C','2021-01-07',3)

--******************** Creating the MENU table ******************
CREATE TABLE menu(
Product_id INTEGER,
Product_name VARCHAR(50) NOT NULL,
Price INTEGER NOT NULL,
CONSTRAINT mPrimaryKey PRIMARY KEY(Product_id)
)
--Inserting data into the MENU table
INSERT INTO menu(Product_id,Product_name, Price)
VALUES(1,'sushi',10),
	(2,'curry',15),
	(3,'ramen',12)
--***************** Creating the MEMBERS table ***************
CREATE TABLE members(
	Customer_id VARCHAR(1) NOT NULL,
	Join_Date DATE NOT NULL,
	CONSTRAINT mbPrimaryKey PRIMARY KEY(Customer_id)
)
-- Inserting data into the MEMBERS table
INSERT INTO members(Customer_id, Join_Date)
VALUES('A','2021-01-07'),
	('B','2021-01-09')