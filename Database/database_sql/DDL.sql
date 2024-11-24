CREATE TABLE Manager(
ManagerID NUMBER (10) PRIMARY KEY,
Fname VARCHAR (20)NOT NULL,
Lname VARCHAR (20) NOT NULL
);

INSERT INTO Manager (ManagerID, Fname, Lname) VALUES (01,'Mark', 'Lee');
INSERT INTO Manager (ManagerID, Fname, Lname) VALUES (02,'Lisa', 'Brown');
INSERT INTO Manager (ManagerID, Fname, Lname) VALUES (03,'Andy','Park');
SELECT * FROM Manager;

CREATE TABLE Store(
StoreID NUMBER (10) PRIMARY KEY,
City_name VARCHAR (20)NOT NULL,
Street_address VARCHAR (20)NOT NULL,
Postcode NUMBER (8)NOT NULL,
ManagerID NUMBER (10) REFERENCES Manager(ManagerID),
StartDate DATE NOT NULL
);

INSERT INTO Store (StoreID, City_name,Street_address, Postcode, ManagerID, StartDate) VALUES (11,'Kathmandu','Sanepa Chowk','00977155',01,(TO_DATE('2022-01-12','yyyy-mm-dd')));
INSERT INTO Store (StoreID, City_name,Street_address, Postcode, ManagerID, StartDate) VALUES (12,'Pokhara',' Paknajol','12345678',02,(TO_DATE('2019-01-14','yyyy-mm-dd')));
INSERT INTO Store (StoreID, City_name,Street_address, Postcode, ManagerID, StartDate) VALUES (13,'Kathmandu','Thamel','11223344',03,(TO_DATE('2017-09-08','yyyy-mm-dd')));
INSERT INTO Store (StoreID, City_name,Street_address, Postcode, ManagerID, StartDate) VALUES (14,'Kathmandu','Sanepa Chowk','00977155',01,(TO_DATE('2018-11-20','yyyy-mm-dd')));
SELECT * FROM Store;

CREATE TABLE Customer(
CustomerID NUMBER(5) PRIMARY KEY,
Fname VARCHAR (20)NOT NULL,
Lname VARCHAR(20)NOT NULL
);

INSERT INTO Customer (CustomerID, Fname, Lname) VALUES (111,'Prashanna','Nakarmi');
INSERT INTO Customer (CustomerID, Fname, Lname) VALUES (222,'Priya','Lama');
INSERT INTO Customer (CustomerID, Fname, Lname) VALUES (333,'Sastina','Magar');
INSERT INTO Customer (CustomerID, Fname, Lname) VALUES (444,'Jennie','Kim');
SELECT * FROM Customer;

CREATE TABLE Orders(
Orderno NUMBER (10) PRIMARY KEY,
Order_date_time TIMESTAMP NOT NULL,
Completion_date_time TIMESTAMP,
StoreID NUMBER (10) REFERENCES Store(StoreID),
MenuID NUMBER (10)REFERENCES Menu_items(MenuID),
BreadID NUMBER (10)REFERENCES Bread(breadID),
CustomerID NUMBER (5) REFERENCES Customer(CustomerID),
Cost_order NUMBER (10,5)
);

INSERT INTO Orders (Orderno, Order_date_time, Completion_date_time, StoreID, MenuID, BreadID, CustomerID,Cost_order)VALUES (77,(TO_DATE('2022-01-12 10:55:10','yyyy-mm-dd hh24:mi:ss')),(TO_DATE('2022-01-12 11:00:00','yyyy-mm-dd HH24:mi:SS')),11,10,07,111,295);
INSERT INTO Orders (Orderno, Order_date_time, Completion_date_time,StoreID, MenuID, BreadID, CustomerID, Cost_order)VALUES (88,(TO_DATE('2022-02-09 09:05:00','yyyy-mm-dd hh24:mi:ss')),(TO_DATE('2022-02-09 09:10:20','yyyy-mm-dd HH24:mi:SS')),12,22,08,222,500);
INSERT INTO Orders (Orderno, Order_date_time, Completion_date_time,StoreID, MenuID, BreadID, CustomerID,Cost_order)VALUES (99,(TO_DATE('2022-03-02 16:00:50','yyyy-mm-dd hh24:mi:ss')),(TO_DATE('2022-03-02 17:05:00','yyyy-mm-dd HH24:mi:SS')),13,33,09,333,300);
INSERT INTO Orders (Orderno, Order_date_time, Completion_date_time,StoreID, MenuID, BreadID, CustomerID, Cost_order)VALUES (100,(TO_DATE('2022-04-11 08:12:10','yyyy-mm-dd hh24:mi:ss')),(TO_DATE('2022-04-11 18:35:00','yyyy-mm-dd HH24:mi:SS')),14,44,04,444,245);
SELECT * FROM Orders;

CREATE TABLE Bread(
BreadID NUMBER (10) PRIMARY KEY,
Name_bread VARCHAR (10)NOT NULL UNIQUE,
Calories_per_gram NUMBER (10) NOT NULL,
Price_per_loaf NUMBER (10) NOT NULL
);

INSERT INTO Bread (BreadID,Name_bread,Calories_per_gram,Price_per_loaf) VALUES (07,'Brown',265,300);
INSERT INTO Bread (BreadID,Name_bread,Calories_per_gram,Price_per_loaf) VALUES (08,'White',300,200);
INSERT INTO Bread (BreadID,Name_bread,Calories_per_gram,Price_per_loaf) VALUES (09,'Garlic',285,400);
INSERT INTO Bread (BreadID,Name_bread,Calories_per_gram,Price_per_loaf) VALUES (04,'Cheese',308,500);
SELECT * FROM Bread;

CREATE TABLE Menu_items(
MenuID NUMBER(10)PRIMARY KEY,
Name_menu VARCHAR(20) UNIQUE NOT NULL,
BreadID NUMBER (10) REFERENCES Bread(BreadID)
);

INSERT INTO Menu_items (MenuID, Name_menu,BreadID) VALUES (10,'Tuna Heaven',07);
INSERT INTO Menu_items (MenuID, Name_menu,BreadID) VALUES (22,'French Bread',08);
INSERT INTO Menu_items (MenuID, Name_menu,BreadID) VALUES (33,'Hamburger',09);
INSERT INTO Menu_items (MenuID, Name_menu,BreadID) VALUES (44,'Club Sandwich',04);
SELECT * FROM Menu_items;

CREATE TABLE Sandwich_filling(
MenuID NUMBER(10) NOT NULL REFERENCES Menu_items(MenuID),
FillingID NUMBER (10) REFERENCES Fillings(FillingID),
Quantity NUMBER (10)
);

INSERT INTO Sandwich_filling(MenuID, FillingID, Quantity) VALUES (10,74,3);
INSERT INTO Sandwich_filling(MenuID, FillingID, Quantity) VALUES (22,75,4);
INSERT INTO Sandwich_filling(MenuID, FillingID, Quantity) VALUES (33,76,5);
INSERT INTO Sandwich_filling(MenuID, FillingID, Quantity) VALUES (44,78,6);
SELECT * FROM Sandwich_filling;

CREATE TABLE Fillings(
FillingID NUMBER(10) PRIMARY KEY,
Name_filling VARCHAR (10) UNIQUE NOT NULL,
CategoryID NUMBER (10)REFERENCES Categories(CategoryID),
Calories NUMBER (10) NOT NULL,
Price NUMBER (10)NOT NULL
);

INSERT INTO Fillings (FillingID, Name_filling,CategoryID, Calories, Price) Values (74,'Tomato', 01,45, 120);
INSERT INTO Fillings (FillingID, Name_filling,CategoryID, Calories, Price) Values (75,'Tuna', 02,55, 200);
INSERT INTO Fillings (FillingID, Name_filling,CategoryID, Calories, Price) Values (76,'Cucumber', 01,65, 190);
INSERT INTO Fillings (FillingID, Name_filling,CategoryID, Calories, Price) Values (78,'Gherkin', 01,75, 190);
INSERT INTO Fillings (FillingID, Name_filling,CategoryID, Calories, Price) Values (79,'Chicken', 04,85, 190);
INSERT INTO Fillings (FillingID, Name_filling,CategoryID, Calories, Price) Values (73,'Lettuce', 03,95, 190);
SELECT * FROM Fillings;

CREATE TABLE Categories (
CategoryID NUMBER (10) PRIMARY KEY,
Name_category VARCHAR(20) NOT NULL UNIQUE
);

INSERT INTO Categories (CategoryID, Name_category) Values (01, 'Vegetable');
INSERT INTO Categories (CategoryID, Name_category) Values (02, 'Marine');
INSERT INTO Categories (CategoryID, Name_category) Values (03, 'Vegetable');
INSERT INTO Categories (CategoryID, Name_category) Values (04, 'Poultry');
SELECT * FROM Categories;

SELECT * FROM TAB;
