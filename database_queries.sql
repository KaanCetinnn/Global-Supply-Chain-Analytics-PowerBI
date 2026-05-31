/*******************************************************************************
   GLOBAL SUPPLY CHAIN & SALES PERFORMANCE ANALYTICS - DATABASE SCRIPTS
   Author: Kaan Çetin
   Date: 2026
   Description: This script contains the optimized relational database schema 
                (Star Schema) and custom View structures designed to handle 
                1 Million+ rows efficiently for Power BI importing.
*******************************************************************************/

-- =============================================================================
-- 1. DATABASE DIMENSION TABLES (Boyut Tabloları)
-- =============================================================================

-- Create Product Dimension Table
CREATE TABLE Dim_Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    SubCategory VARCHAR(100) NOT NULL,
    Category VARCHAR(100) NOT NULL
);

-- Create Customer Dimension Table
CREATE TABLE Dim_Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    Segment VARCHAR(50) NOT NULL
);

-- Create Geography Dimension Table
CREATE TABLE Dim_Geography (
    CityID INT PRIMARY KEY,
    City VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL
);


-- =============================================================================
-- 2. DATABASE FACT TABLE (Olgu Tablosu - 1 Million+ Rows)
-- =============================================================================

-- Create Sales Fact Table with Explicit Foreign Keys for Star Schema
CREATE TABLE Fact_Sales (
    RowID INT PRIMARY KEY,
    OrderID VARCHAR(50) NOT NULL,
    OrderDate DATE NOT NULL,
    ShipDate DATE NOT NULL,
    CustomerID INT FOREIGN KEY REFERENCES Dim_Customers(CustomerID),
    CityID INT FOREIGN KEY REFERENCES Dim_Geography(CityID),
    ProductID INT FOREIGN KEY REFERENCES Dim_Products(ProductID),
    UnitPrice DECIMAL(18,2) NOT NULL,
    Quantity INT NOT NULL,
    ShippingCost DECIMAL(18,2) NOT NULL,
    TotalNetSales DECIMAL(18,2) NOT NULL,
    Status VARCHAR(50) NOT NULL
);


-- =============================================================================
-- 3. VIEW OPTIMIZATION FOR POWER BI (Veri Ambarı ve Performans Görünümü)
-- =============================================================================
GO

IF OBJECT_ID('View_SalesPerformance', 'V') IS NOT NULL
    DROP VIEW View_SalesPerformance;
GO

-- Custom View created to pre-aggregate and denormalize key operational data.
-- This reduces Power BI memory load and optimizes direct visual interactions.
CREATE VIEW View_SalesPerformance AS
SELECT 
    f.RowID,
    f.OrderID,
    f.OrderDate,
    f.ShipDate,
    f.CustomerID,
    f.ProductID,
    f.UnitPrice,
    f.Quantity,
    f.ShippingCost,
    f.TotalNetSales,
    f.Status,
    -- Time Hierarchy Dimensions for Slicer Syncing
    YEAR(f.OrderDate) AS [Year],
    MONTH(f.OrderDate) AS [Month],
    DATENAME(WEEKDAY, f.OrderDate) AS [DayOfWeek],
    -- Geography Dimensions for Global Mapping
    g.City,
    g.Country
FROM 
    Fact_Sales f
INNER JOIN 
    Dim_Geography g ON f.CityID = g.CityID;
GO


-- =============================================================================
-- 4. ANALYTICAL INTEGRITY VERIFICATION (Veri Doğrulama Sorguları)
-- =============================================================================

-- Check Total Row Count and Financial Integrity across the Star Schema
SELECT 
    COUNT(*) AS Total_Sales_Rows,
    SUM(TotalNetSales) AS Total_Revenue,
    AVG(UnitPrice) AS Average_Unit_Price
FROM 
    View_SalesPerformance;