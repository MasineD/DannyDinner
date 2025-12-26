USE DannyDinnerDB;
/************* Members table **************/
--1.Setting a default value for the members.CustomerID
UPDATE members
	SET CustomerID = ''
WHERE CustomerID IS NULL

/************* Menu table ***************/
--1.Setting a default value for the menu.ProductName, menu.Price
--2.Capitalizing the ProductNames
UPDATE menu
	SET ProductName = (CASE
						WHEN ProductName IS NULL THEN 'N/A'
						ELSE CONCAT(UPPER(LEFT(ProductName,1)),SUBSTRING(ProductName,2,LEN(ProductName)))
						END),
		Price = (CASE
				WHEN Price = NULL THEN 0
				ELSE Price
				END)
