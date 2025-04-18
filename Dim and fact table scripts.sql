CREATE TABLE FactSales (
    RowID INT PRIMARY KEY,
    OrderID VARCHAR(20),
    ProductID VARCHAR(20),
    CustomerID VARCHAR(20),
    OrderDate DATE,
    ShipDate DATE,
    Sales DECIMAL(18, 2),
    Quantity INT,
    Discount DECIMAL(4, 2),
    Profit DECIMAL(18, 2),
    LastModifyDate DATETIME,
    HashValue VARBINARY(64)

    -- Foreign Keys (if you define dimension tables separately)
    -- CONSTRAINT FK_FactSales_Customer FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    -- CONSTRAINT FK_FactSales_Product FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID)
);

CREATE TABLE DimCustomer (
    CustomerID VARCHAR(20) PRIMARY KEY,
    CustomerName VARCHAR(100),
    Segment VARCHAR(50)
);

CREATE TABLE DimProduct (
    ProductID VARCHAR(20) PRIMARY KEY,
    Category VARCHAR(50),
    SubCategory VARCHAR(50),
    ProductName VARCHAR(255)
);

CREATE TABLE DimLocation (
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    PostalCode VARCHAR(20),
    Region VARCHAR(50),
    PRIMARY KEY (Country, City, PostalCode)
);

