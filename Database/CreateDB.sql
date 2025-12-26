/*
	PURPOSE:
		Creating a new database- DannyDinnerDB, to store the data tables
	WARNING:
		1.Running the code below will 
			* check if a database DannyDinner exists, if it does then DROP(delete it), and then
			* create a new database called DannyDinnerDB
*/

--********************* Creating the database ***********************
IF EXISTS(SELECT name FROM sys.databases WHERE name = 'DannyDinnerDB')
	BEGIN
	ALTER DATABASE [DannyDinner]
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE

	DROP DATABASE DannyDinnerDB
	END
GO

CREATE DATABASE DannyDinnerDB
GO