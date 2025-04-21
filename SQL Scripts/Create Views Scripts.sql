USE [Sales_data]
GO

/****** Object:  View [stg].[v_Dim_Product]    Script Date: 4/18/2025 12:48:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [stg].[v_Dim_Product] AS
SELECT DISTINCT
	dense_rank() over(order by [Product ID],[Product Name]) ID,
    [Product ID],
    Category,
    [Sub-Category],
    [Product Name]
FROM [stg].[Sales_Data];
GO

/****** Object:  View [stg].[v_Dim_Location]    Script Date: 4/18/2025 12:48:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [stg].[v_Dim_Location] AS
SELECT DISTINCT
    CAST(DENSE_RANK() OVER (ORDER BY Country, [State], City, [Postal Code], Region) AS INT) AS LocationID,
    Country,
    [State],
    City,
    [Postal Code],
    Region
FROM [stg].[Sales_Data];
GO

/****** Object:  View [stg].[v_Fact_Sales]    Script Date: 4/18/2025 12:48:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [stg].[v_Fact_Sales] AS
SELECT
    [Order ID],
    p.ID as[Product ID],
    [Customer ID],
    CAST([Order Date] AS DATE) AS OrderDate,
    CAST([Ship Date] AS DATE) AS ShipDate,
    [Ship Mode],
    CAST(Sales AS float(2))AS Sales, 
    Quantity,
    Discount,
    CAST(Profit AS float(4)) AS Profit,
	l.LocationID as LocationID,
    [Last Modify Date],
    HashValue
FROM [stg].[Sales_Data] s
left JOIN stg.v_Dim_Location AS l
    ON s.Country = l.Country
    AND s.[State] = l.[State]
    AND s.City = l.City
    AND s.[Postal Code] = l.[Postal Code]
    AND s.Region = l.Region
left join stg.[v_Dim_Product] p
	on s.[Product ID] = p.[Product ID]
	and s.Category = p.Category
	and s.[Sub-Category] = p.[Sub-Category]
	and s.[Product Name] = p.[Product Name]
GO

/****** Object:  View [stg].[v_Dim_Customer]    Script Date: 4/18/2025 12:48:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [stg].[v_Dim_Customer] AS
SELECT DISTINCT
    [Customer ID],
    [Customer Name],
    Segment
FROM [stg].[Sales_Data] 
GO

/****** Object:  View [stg].[v_Dim_Date]    Script Date: 4/18/2025 12:48:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [stg].[v_Dim_Date] AS
SELECT DISTINCT
    CAST([Order Date] AS DATE) AS FullDate,
    YEAR([Order Date]) AS Year,
	case when MONTH([Order Date]) = '1' then 'January'
		 when MONTH([Order Date]) = '2' then 'February'
		 when MONTH([Order Date]) = '3' then 'March'
		 when MONTH([Order Date]) = '4' then 'April'
		 when MONTH([Order Date]) = '5' then 'May'
		 when MONTH([Order Date]) = '6' then 'June'
		 when MONTH([Order Date]) = '7' then 'July'
		 when MONTH([Order Date]) = '8' then 'August'
		 when MONTH([Order Date]) = '9' then 'September'
		 when MONTH([Order Date]) = '10' then 'October'
		 when MONTH([Order Date]) = '11' then 'November'
		 when MONTH([Order Date]) = '12' then 'December'
    end AS Month,
    DAY([Order Date]) AS Day,
	DATEPART(dw, [Order Date]) AS [WeekDay],
    DATEPART(QUARTER, [Order Date]) AS Quarter
FROM [stg].[Sales_Data];

GO


