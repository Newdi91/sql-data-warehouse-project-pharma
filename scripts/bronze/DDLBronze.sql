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


IF OBJECT_ID ('bronze_drug', 'U') IS NOT NULL
	DROP TABLE bronze_drug;

CREATE TABLE bronze_drug (
    uniqueID INT,              
    drugName VARCHAR(255),     
    condition VARCHAR(255),        
    review VARCHAR(MAX),         
    rating INT,                  
    date DATE,                    
    usefulCount INT        
);
