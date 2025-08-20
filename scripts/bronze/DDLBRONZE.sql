/*
===============================================================================
DDL Script: Create Bronze Table
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/


IF OBJECT_ID ('bronze.drug', 'U') IS NOT NULL
	DROP TABLE bronze.drug;

CREATE TABLE bronze.drug (
uniqueID INT,
drugName NVARCHAR(50),
condition NVARCHAR(50),
review NVARCHAR(50),
rating NVARCHAR(50),
date DATE,
usefulCount INT
);
