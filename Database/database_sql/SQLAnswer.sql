/*TASK_1*/
/*List IDs and addresses of all stores, sorted ascending according to their Postcode.*/
SELECT StoreID, Streetaddress, Postcode FROM Store ORDER BY Postcode ASC;

/*TASK_2*/
/*For each filling, list its ID, name, and category name. Orders result alphabetically in descending order according to the price.*/
SELECT Filling.FillingID, Filling.Name AS Filling_name, Category.Name AS Category_name FROM Filling JOIN Category USING (CategoryID)  ORDER BY Filling.Name ASC;

/*TASK_3*/
/*For each completed order, list the OrderID, full name of the manager, name of
the sandwich used in the order as well as the name of the bread used in the
order. The result needs to be sorted by order date - most recent first for the
first instance, followed by sandwich name alphabetically. */
SELECT Ordertab.Orderid, 
Manager.FName || ' ' || Manager.LName AS Manager_Name, Sandwich.name AS Sandwich_name, Bread.name AS Bread_name
FROM Ordertab
JOIN Store USING(StoreID)
JOIN Manager USING(ManagerID)
JOIN Sandwich USING(sandwichid)
JOIN Bread USING(BreadID)
WHERE Ordertab.Completiondate IS NOT NULL 
ORDER BY Ordertab.Orderdate DESC, Sandwich.name ASC;