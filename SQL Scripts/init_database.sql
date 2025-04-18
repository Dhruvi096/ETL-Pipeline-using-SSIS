/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'Sales_data' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'lnd', 'stg', and 'metadata'.
	
WARNING:
    Running this script will drop the entire 'Sales_data' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'Sales_data' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Sales_data')
BEGIN
    ALTER DATABASE Sales_data SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Sales_data;
END;
GO

-- Create the 'Sales_data' database
CREATE DATABASE Sales_data;
GO

USE Sales_data;
GO

-- Create Schemas
CREATE SCHEMA lnd;
GO

CREATE SCHEMA stg;
GO

CREATE SCHEMA metadata;
GO
