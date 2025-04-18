USE [Sales_data]
GO

/****** Object:  Table [metadata].[stglogs]    Script Date: 4/18/2025 12:10:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[metadata].[stglogs]') AND type in (N'U'))
DROP TABLE [metadata].[stglogs]
GO

/****** Object:  Table [stg].[Sales_Data]    Script Date: 4/18/2025 12:10:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[stg].[Sales_Data]') AND type in (N'U'))
DROP TABLE [stg].[Sales_Data]
GO

/****** Object:  Table [lnd].[Sales_Data]    Script Date: 4/18/2025 12:10:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[lnd].[Sales_Data]') AND type in (N'U'))
DROP TABLE [lnd].[Sales_Data]
GO

/****** Object:  Table [metadata].[Logs]    Script Date: 4/18/2025 12:10:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[metadata].[Logs]') AND type in (N'U'))
DROP TABLE [metadata].[Logs]
GO

/****** Object:  Table [metadata].[Logs]    Script Date: 4/18/2025 12:10:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [metadata].[Logs](
	[ID] [int] IDENTITY(0,1) NOT NULL,
	[FilePath] [varchar](100) NOT NULL,
	[InsertedRows] [int] NOT NULL,
	[IDateTime] [date] DEFAULT (getdate())
) ON [PRIMARY]
GO

/****** Object:  Table [lnd].[Sales_Data]    Script Date: 4/18/2025 12:10:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [lnd].[Sales_Data](
	[Row ID] [int] NOT NULL,
	[Order ID] [nvarchar](255) NULL,
	[Order Date] [datetime] NULL,
	[Ship Date] [datetime] NULL,
	[Ship Mode] [nvarchar](255) NULL,
	[Customer ID] [nvarchar](255) NULL,
	[Customer Name] [nvarchar](255) NULL,
	[Segment] [nvarchar](255) NULL,
	[Country] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Postal Code] [float] NULL,
	[Region] [nvarchar](255) NULL,
	[Product ID] [nvarchar](255) NULL,
	[Category] [nvarchar](255) NULL,
	[Sub-Category] [nvarchar](255) NULL,
	[Product Name] [nvarchar](255) NULL,
	[Sales] [float] NULL,
	[Quantity] [float] NULL,
	[Discount] [float] NULL,
	[Profit] [float] NULL,
	[Last Modify Date] [datetime] DEFAULT (getdate()),
	[HashValue] [varchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[Row ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [stg].[Sales_Data]    Script Date: 4/18/2025 12:10:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[Sales_Data](
	[Row ID] [int] NOT NULL,
	[Order ID] [varchar](15) NULL,
	[Order Date] [datetime] NULL,
	[Ship Date] [datetime] NULL,
	[Ship Mode] [varchar](20) NULL,
	[Customer ID] [varchar](10) NULL,
	[Customer Name] [varchar](30) NULL,
	[Segment] [varchar](20) NULL,
	[Country] [varchar](20) NULL,
	[City] [varchar](20) NULL,
	[State] [varchar](25) NULL,
	[Postal Code] [float] NULL,
	[Region] [varchar](10) NULL,
	[Product ID] [varchar](20) NULL,
	[Category] [varchar](20) NULL,
	[Sub-Category] [varchar](20) NULL,
	[Product Name] [varchar](150) NULL,
	[Sales] [float] NULL,
	[Quantity] [float] NULL,
	[Discount] [float] NULL,
	[Profit] [float] NULL,
	[Last Modify Date] [datetime] NULL,
	[HashValue] [nvarchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[Row ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [metadata].[stglogs]    Script Date: 4/18/2025 12:10:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [metadata].[stglogs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [varchar](100) NULL,
	[RowsInserted] [int] NULL,
	[RowsUpdated] [int] NULL,
	[RowsDeleted] [int] NULL,
	[DateTime] [datetime] DEFAULT (getdate())
) ON [PRIMARY]
GO


-- Create trigger
USE [Sales_data]
GO

/****** Object:  Trigger [lnd].[trg_Calculate_Hash_On_Orders]    Script Date: 4/18/2025 12:12:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [lnd].[trg_Calculate_Hash_On_Orders]
ON [lnd].[Sales_Data]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE T
    SET 
        HashValue = SUBSTRING(CONVERT(NVARCHAR(64), HASHBYTES('SHA2_256', 
            COALESCE(CAST(T.[Row ID] AS VARCHAR(30)), '') + 
            COALESCE(T.[Order ID], '') + 
            COALESCE(CAST(T.[Order Date] AS VARCHAR(30)), '') + 
            COALESCE(CAST(T.[Ship Date] AS VARCHAR(30)), '') + 
            COALESCE(T.[Ship Mode], '') + 
            COALESCE(T.[Customer ID], '') + 
            COALESCE(T.[Customer Name], '') + 
            COALESCE(T.[Segment], '') + 
            COALESCE(T.[Country], '') + 
            COALESCE(T.[City], '') + 
            COALESCE(T.[State], '') + 
            COALESCE(CAST(T.[Postal Code] AS VARCHAR(30)), '') + 
            COALESCE(T.[Region], '') + 
            COALESCE(T.[Product ID], '') + 
            COALESCE(T.[Category], '') + 
            COALESCE(T.[Sub-Category], '') + 
            COALESCE(T.[Product Name], '') + 
            COALESCE(CAST(T.[Sales] AS VARCHAR(30)), '') + 
            COALESCE(CAST(T.[Quantity] AS VARCHAR(30)), '') + 
            COALESCE(CAST(T.[Discount] AS VARCHAR(30)), '') + 
            COALESCE(CAST(T.[Profit] AS VARCHAR(30)), '')
        ), 2), 3, 64),
        [Last Modify Date] = GETDATE()
    FROM LND.Sales_Data T
    INNER JOIN inserted i ON T.[Row ID] = i.[Row ID];
END;
GO

ALTER TABLE [lnd].[Sales_Data] ENABLE TRIGGER [trg_Calculate_Hash_On_Orders]
GO

