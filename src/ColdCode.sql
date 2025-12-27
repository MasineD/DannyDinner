/*
    BEWARE:
        1.It is assumed that on the joining day, the customer joined the program before ordering
        2.This is my first ever SQL project so do not mind the commented code, I might use it for 
          learning purpose in the future
*/

USE DannyDinnerDB;
-- ========== Question 1 ==========
/*TODO:
    1.Join the MENU table with the SALES table
    2.Summarize the prices
    3.GROUP the sums BY the Customer_id
*/

SELECT s.CustomerID, SUM(Price) Total_Spent
FROM sales s
JOIN menu m
ON s.ProductID = m.ProductID
GROUP BY s.CustomerID

-- ========== Question 2 ==========
/*TODO:
    1.COUNT the DISTINCT order_dates
    2.GROUP the counts BY Customer_id
*/
SELECT CustomerID, COUNT(DISTINCT OrderDate) Nr_Of_Days_Visited
FROM sales
GROUP BY CustomerID;

--========== Question 3 ==========
/*TODO:
    1.Join the SALES table with the MENU table
    2.DENSE_RANK the data,
    3.PARTITIONed BY Customer_id, then
    4.ORDERed BY Order_date in ASC order
    5.From the results, Extract the Customer_id,Order_date, and the product details
*/
SELECT CustomerID, OrderDate, ProductID, ProductName, Price
FROM (
SELECT s.*,m.ProductName, m.Price, DENSE_RANK() OVER(PARTITION BY s.CustomerID ORDER BY s.OrderDate)
    dr_OrderDate
FROM sales s
JOIN menu m
ON s.ProductID = m.ProductID
    )sQuery
WHERE dr_OrderDate = 1;

/* Immediately after learning about WINDOW functions
SELECT Customer_id, Order_date, Product_id, Product_name, Price, FirstOrderDate
FROM (
SELECT s.*, m.Product_name, m.Price, MIN(Order_date) OVER(PARTITION BY Customer_id ORDER BY Order_date) FirstOrderDate
FROM sales s
JOIN menu m
ON s.Product_id = m.Product_id
)sQuery
WHERE Order_date = FirstOrderDate;*/
    --Second option(first try, before learning WINDOW functions)
SELECT CustomerID, OrderDate, ProductID, ProductName
FROM (
    SELECT TOP 5 s.*, _m.ProductName 
    FROM sales s
    JOIN menu _m
    ON s.ProductID = _m.ProductID
    ORDER BY s.OrderDate
    )sQuery;

-- ========= Question 4 =========
/*TODO:
    1.Join the MENU table with the SALES table
    2.COUNT everything from the resulting table
    3.PARTITION BY Product_id
    4.From the results, extract everything then
    5.DENSE_RANK, using ORDER BY SalesPerProduct
    6.From the results, extract the DISTINCT Product_id, Product_name,Price, and SalesPerProduct 
      where the DENSE_RANK is 1
*/
SELECT DISTINCT ProductID, ProductName,Price, SalesPerProduct,dr_SalesPerProduct
FROM (
    SELECT *, DENSE_RANK() OVER(ORDER BY SalesPerProduct DESC) dr_SalesPerProduct
    FROM(
        SELECT s.CustomerID, s.OrderDate, m.*, COUNT(*) OVER(PARTITION BY s.ProductID) SalesPerProduct
        FROM sales s
        JOIN menu m
        ON s.ProductID = m.ProductID
        ) sQuery
    ) _s
WHERE dr_SalesPerProduct = 1;

/*
    ******************Immediately after learning WINDOW functions***************
SELECT DISTINCT Product_id, Product_name, Price, SalesPerProduct
FROM (
    SELECT s.*, m.Product_name, m.Price, COUNT(*) OVER(PARTITION BY s.Product_id) SalesPerProduct
    FROM sales s
    JOIN menu m
    ON s.Product_id = m.Product_id
) sQuery
ORDER BY SalesPerProduct DESC;
    ************** Before learning about WINDOW functions) *******************
SELECT TOP 1 s.Product_id, sQuery.Product_name, COUNT(Order_date) Nr_Of_Times_Ordered
FROM sales s
JOIN (
    SELECT Product_name, Product_id
    FROM menu m
    ) sQuery
ON s.Product_id = sQuery.Product_id
GROUP BY s.Product_id, sQuery.Product_name
ORDER BY Nr_Of_Times_Ordered DESC;*/

-- ========== Question 5 ==========
/*TODO:
    1.Join the SALES table and the MENU table
    2.COUNT the Order_date
    3.PARTION BY Customer_id, the BY Product_id
    4.From the results, extract Customer_id, Product_id, Product_name, Price, ProductPopularityPerCustomer
    5.DENSE_RANK, PARTITION BY Customer_id using ORDER BY ProductPopularityPerCustomer
    6.From the results, extract the DISTINCT Customer_id, Product_id, Product_name, Price, ProductPopularityPerCustomer
      where the DENSE_RANK is 1
*/
SELECT DISTINCT CustomerID, ProductID, ProductName, Price, ProductPopularityPerCustomer
FROM(
    SELECT CustomerID, ProductID, ProductName, Price, ProductPopularityPerCustomer
        ,DENSE_RANK() OVER(PARTITION BY Customer_id ORDER BY ProductPopularityPerCustomer DESC) dr_ProductPopularityPerCustomer
    FROM (
        SELECT s.*, m.ProductName, m.Price, COUNT(*) OVER(PARTITION BY s.Customer_id, s.ProductID) ProductPopularityPerCustomer
        FROM sales s
        JOIN menu m
        ON s.ProductID = m.ProductID
        )innerSubQuery
        ) sQuery
WHERE dr_ProductPopularityPerCustomer = 1;

/*
*******************Immediately after learning WINDOW functions *****************
SELECT *,MAX(OrdersPerCustomerPerProduct) OVER(PARTITION BY Customer_id) maxOrdersPerProduct
FROM (
    SELECT s.Customer_id, s.Order_date, s.Product_id, m.Product_name, m.Price, 
    COUNT(s.Order_date) OVER(PARTITION BY s.Customer_id,s.Product_id) OrdersPerCustomerPerProduct
    FROM sales s
    JOIN menu m
    ON s.Product_id = m.Product_id
)sQuery;
  ******************* Before learning about WINDOW functions *************************
SELECT s.Product_id, COUNT(*) Nr_Of_Times_Each_Product_Was_Ordered, Customer_id, m.Product_name
FROM sales s
JOIN menu m
ON s.Product_id = m.Product_id
GROUP BY s.Product_id, s.Customer_id, m.Product_name
ORDER BY Nr_Of_Times_Each_Product_Was_Ordered DESC, s.Customer_id DESC;*/

-- ========= Question 6 =========
/*TODO:
    1.Join the SALES, MEMBERS, and MENU table to get customers that are members and product details
    2.WHERE the Order_date >= Join_Date
    3.DENSE_RANK, PARTITION BY Customer_id, ORDER BY Order_date in ASC order
    4.Extract details such as Customer_id, Order_date, Join_Date, Product_id, Product_name, Price
    5.From the results, extract every detail except dr_OrderDate WHERE DENSE_RANK = 1
*/

SELECT CustomerID,JoinDate, OrderDate, ProductID, ProductName, Price
FROM(
    SELECT s.CustomerID, s.OrderDate,mb.JoinDate, m.ProductID, m.ProductName, m.Price 
        ,DENSE_RANK() OVER(PARTITION BY s.Customer_id ORDER BY s.Order_date) dr_OrderDate
    FROM sales s
    JOIN members mb
    ON s.CustomerID = mb.CustomerID
    JOIN menu m
    ON s.ProductID = m.ProductID
    WHERE s.OrderDate >= mb.JoinDate
    ) sQuery
WHERE dr_OrderDate = 1;

/*
************ Before learning about the WINDOW functions *****************
SELECT sQuery.Customer_id, sQuery.Join_Date, sQuery.Order_date, sQuery.Product_id, Product_name
FROM menu mn
JOIN (
    SELECT TOP 1 s.Customer_id, m.Join_Date, s.Order_date, s.Product_id
    FROM members m
    JOIN sales s
    ON m.Customer_id = s.Customer_id
    WHERE s.Customer_id = 'A' AND s.Order_date >= m.Join_Date
    ORDER BY Order_date
    ) sQuery
ON mn.Product_id = sQuery.Product_id
UNION
SELECT sQuery.Customer_id, sQuery.Join_Date, sQuery.Order_date, sQuery.Product_id, Product_name
FROM menu mn
JOIN (
SELECT TOP 1 s.Customer_id, m.Join_Date, s.Order_date, s.Product_id
FROM members m
JOIN sales s
ON m.Customer_id = s.Customer_id
WHERE s.Customer_id = 'B' AND s.Order_date >= m.Join_Date
ORDER BY Order_date) sQuery
ON mn.Product_id = sQuery.Product_id;*/

-- ========== Question 7 ==========
/*TODO:
    1.Join the SALES, MEMBERS, and MENU table to get customers that are members and product details
    2.WHERE the Order_date < Join_Date
    3.DENSE_RANK, PARTITION BY Customer_id, ORDER BY Order_date in DESC order
    4.Extract details such as Customer_id, Order_date, Join_Date, Product_id, Product_name, Price
    5.From the results, extract every detail except dr_OrderDate WHERE DENSE_RANK = 1
*/

SELECT CustomerID,JoinDate, OrderDate, ProductID, ProductName, Price
FROM (
SELECT s.CustomerID, s.OrderDate,mb.JoinDate, m.ProductID, m.ProductName, m.Price 
        ,DENSE_RANK() OVER(PARTITION BY s.Customer_id ORDER BY s.Order_date DESC) dr_OrderDate
    FROM sales s
    JOIN members mb
    ON s.CustomerID = mb.CustomerID
    JOIN menu m
    ON s.ProductID = m.ProductID
    WHERE s.OrderDate < mb.JoinDate
    ) sQuery
WHERE dr_OrderDate = 1;

/*
************ Before learning about the WINDOW functions *****************
SELECT sQuery.Customer_id, sQuery.Join_Date, sQuery.Order_date, sQuery.Product_id, Product_name
FROM menu mn
JOIN (
    SELECT TOP 1 s.Customer_id, m.Join_Date, s.Order_date, s.Product_id
    FROM members m
    JOIN sales s
    ON m.Customer_id = s.Customer_id
    WHERE s.Customer_id = 'A' AND s.Order_date < m.Join_Date
    ORDER BY Order_date DESC
    ) sQuery
ON mn.Product_id = sQuery.Product_id
UNION
SELECT sQuery.Customer_id, sQuery.Join_Date, sQuery.Order_date, sQuery.Product_id, Product_name
FROM menu mn
JOIN (
    SELECT TOP 1 s.Customer_id, m.Join_Date, s.Order_date, s.Product_id
    FROM members m
    JOIN sales s
    ON m.Customer_id = s.Customer_id
    WHERE s.Customer_id = 'B' AND s.Order_date < m.Join_Date
    ORDER BY Order_date DESC
    ) sQuery
ON mn.Product_id = sQuery.Product_id;*/

-- ============= Question 8 ===============
/*TODO:
    1.Join the MEMBERS table with the SALES table to get only customers that have joined,
        also join with the MENU table where Order_date < Join_Date
    2.Count the rows, and sum up the prices
    2.GROUP BY Customer_id to get total orders for every customer before joining
*/

/*SELECT sQuery.*, m.Product_name, m.Price, SUM(Price) OVER(PARTITION BY sQuery.Customer_id) AmountBeforeJoining
FROM (
SELECT s.Customer_id, s.Order_date, s.Product_id, mb.Join_Date, COUNT(*) OVER(PARTITION BY s.Customer_id) OrdersBeforeJoining
FROM sales s
JOIN members mb
ON s.Customer_id = mb.Customer_id
WHERE s.Order_date < mb.Join_Date) sQuery
JOIN menu m
ON sQuery.Product_id = m.Product_id;*/

SELECT sQuery.CustomerID, COUNT(*) Orders_Before_Membership, SUM(sQuery.Price) Amount_Before_Membership
FROM (
    SELECT m.*, s.OrderDate, _m.*
    FROM members m      --Include members
    JOIN sales s
    ON m.CustomerID = s.CustomerID
    JOIN menu _m        --Get prices from the menu
    ON _m.ProductID = s.ProductID
    WHERE s.OrderDate < m.JoinDate
    ) sQuery
GROUP BY sQuery.CustomerID;

-- =========== Question 9 ================
/*TODO:
    1.Join the SALES table with the MENU table on Product_id
    2.Extraxt all details from the SALES table and only Product_name and Price from the MENU table
    3.If the Product_name is SUSHI, multiply the price by 20, else multiply by 10 to get the point earned
    4.From the results, extract the Customer_id, and add up the points earned
    5.GROUP BY Customer_id
*/

SELECT sQuery.CustomerID, SUM(sQuery.Points_Earned) Total_Points_Earned    --Summarize the points earned...
FROM (
    SELECT s.*, _m.ProductName, _m.Price,
        CASE    -- Multiply every price by 10 for each $1 spent, or 20 for sushi
            WHEN _m.ProductName = LOWER('sushi') THEN _m.Price *20
            ELSE _m.Price*10
        END AS Points_Earned
    FROM sales s
    JOIN menu _m    --Get the prices for the menu table
    ON s.ProductID = _m.ProductID
    ) sQuery
GROUP BY sQuery.CustomerID;    --...for each Cunstomer_id

--============== Question 10 ==============
/*TODO:
    1.Join the SALES, MENU, and MEMBERS table to get customers that joined the program
        considering the rows whereby the Order_date is <= EOMONTH(Join_Date)
    2.Add 7 days to the Join_Date
    3.Multiply every price by 20 for 2x points for every date within (Join_Date + 7days) or product_name of sushi
        and by 10 for everything else
    4.Extract all details from the MEMBERS table and MENU table, and only Order_date from the SALES table
    5.From the results, extract the Customer_id, and add up the points earned
    6.GROUP BY Customer_id
*/

SELECT CustomerID, SUM(Points_After_Joining) End_Of_January_Points
FROM (
    -- Subquery
    SELECT m.*, s.OrderDate, _m.*,
        CASE
            WHEN (s.OrderDate BETWEEN m.JoinDate AND DATEADD(DAY,7,m.JoinDate)) OR _m.ProductName = 'sushi' THEN _m.Price*20
            ELSE _m.Price*10
        END AS Points_After_Joining
    FROM members m
    JOIN sales s
    ON m.CustomerID = s.CustomerID
    JOIN menu _m
    ON s.ProductID = _m.ProductID
    WHERE s.OrderDate <= EOMONTH(m.JoinDate)
    ) sQuery
GROUP BY CustomerID;

/********************* BONUS Questions **********************/
--JOIN all the things
SELECT s.CustomerID, OrderDate, m.ProductName, m.Price
        ,(CASE
            WHEN s.CustomerID = mb.CustomerID AND s.OrderDate >= mb.JoinDate THEN 'Y'
            ELSE 'N'
        END) Member
FROM sales s
JOIN menu m
ON s.ProductID = m.ProductID
LEFT JOIN members mb
ON s.CustomerID = mb.CustomerID;

-- Rank all the things
SELECT *, (CASE
            WHEN Member = 'Y' THEN DENSE_RANK() OVER(PARTITION BY CustomerID, Member ORDER BY OrderDate)
            ELSE NULL
           END) AS Ranking
FROM(
SELECT s.CustomerID, OrderDate, m.ProductName, m.Price
        ,(CASE
            WHEN s.CustomerID = mb.CustomerID AND s.OrderDate >= mb.JoinDate THEN 'Y'
            ELSE 'N'
        END) Member
FROM sales s
JOIN menu m
ON s.ProductID = m.ProductID
LEFT JOIN members mb
ON s.CustomerID = mb.CustomerID
) SubQuery
