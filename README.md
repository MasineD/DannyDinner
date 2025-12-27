# Danny's Dinner

## Introduction
Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky
venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.

Danny’s Diner is in need of assistance to help the restaurant stay afloat - the restaurant has
captured some very basic data from their few months of operation but have no idea how to use their data
to help them run the business.

## Problem Description
Danny wants to use the data to answer a few simple questions about his customers, especially about
their visiting patterns, how much money they’ve spent and also which menu items are their favourite.
Having this deeper connection with his customers will help him deliver a better and more personalised
experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer 
loyalty program - additionally he needs help to generate some basic datasets so his team can easily
inspect the data without needing to use SQL.

Danny provided you with a sample of his overall customer data due to privacy issues - but he hopes that
these examples are enough for you to write fully functioning SQL queries to help him answer his questions!

The provided 3 key datasets for this case study are:

	1.sales
	2.menu
	3.members

Moreover, the case study questions are as follows:

	1.What is the total amount each customer spent at the restuarant?
	2.How many days has each customer visited the restuarant?
	3.What was the first item from the menu purchased by each customer?
	4.What is the most purchased item on the menu and how many times was it purchased by all customers?
	5.Which item was the most popular for each customer?
	6.Which item was purchased first by a customer after they became a member?
	7.Which item was purchased just before a customer became a member?
	8.What is the total items and amount spent for each member before they became a member?
	9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would
	  each customer have?
	10.In the first week after a customer joins the program (including their join date) they earn 2x points
	   on all items,not just sushi - how many points do customer A and B have at the end of January?

## Technologies used

	1.SQL - to analyse the data
	2.SQL Server Management Studio 21 - to write and execute the SQL queries

## Folder Structure

```
	├── DannyDinner/:
	  ├──AnswersToQuestions/:
		└──AnswersToQuestions.txt : A text file that contains the answers to the case study questions
	  ├──Database/:
		└──CreateDB.sql: Contains the SQL code to create the database used to store data tables
	  ├──src/:
		├──ColdCode.sql : Contains the cold SQL code used to analyse the data
		└──DataCleaning.sql: Contains the sql code used for data cleaning 
	  └── Tables/ :
		└── RawTables.sql : Contains the SQL code to create tables, and insert data into the tables
```
## How to run the SQL code

	1.Download the DannyDinner zip folder on Github to your device
	2.Unzip the downloaded folder
	3.Open SQL Server Management Studio
	4.Navigate to the 'File' tab and select 'Open Folder'
	5.Select the unzipped folder
	6.Execute the query in Database.sql
	7.Execute the queries in Tables.sql
	8.Execute the queries in ColdCode.sql

## Project Status

COMPLETE

## Contributors

	1.Masine Donald
		- SQL Developer
		- Email: masinedonald@gmail.com
		- Phone: +27 714 366 053
				 +27 647 266 704

## Acknoledgements

This project is mainly formed by Case Study 1 of the 8WeekSQLChallenge. All the case study details can 
be found on https://8weeksqlchallenge.com/case-study-1/
