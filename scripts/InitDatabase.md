/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'db_pharmaproject' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'db_pharmaproject' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/


USE master;
GO

-- Drop if exist with this name and recreate the 'db_pharmaproject' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'db_pharmaproject')
BEGIN
    ALTER DATABASE db_pharmaproject SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE db_pharmaproject;
END;
GO


CREATE DATABASE db_pharmaproject;
GO

USE db_pharmaproject;
GO


-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO
