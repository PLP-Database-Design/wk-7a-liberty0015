-- Create a new table in 1NF
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert data into the 1NF table by splitting the Products column
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT 
    OrderID,
    CustomerName,
    TRIM(unnest(string_to_array(Products, ','))) AS Product
FROM ProductDetail;

-- Verify the result
SELECT * FROM ProductDetail_1NF;

-- Create the Orders table (OrderID, CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create the OrderItems table (OrderID, Product, Quantity)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate the Orders table (unique OrderID and CustomerName)
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Populate the OrderItems table (OrderID, Product, Quantity)
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Verify the results
SELECT * FROM Orders;
SELECT * FROM OrderItems;