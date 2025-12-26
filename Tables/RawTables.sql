USE DannyDinnerDB;

--****************** Creating the SALES table ****************
CREATE TABLE sales (
  CustomerID VARCHAR(1),
  OrderDate DATE,
  ProductID INTEGER
);

INSERT INTO sales (CustomerID, OrderDate, ProductID)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  ProductID INTEGER,
  ProductName VARCHAR(5),
  Price INTEGER
);

INSERT INTO menu (ProductID, ProductName, Price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  CustomerID VARCHAR(1),
  JoinDate DATE
);

INSERT INTO members
  (CustomerID, JoinDate)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');