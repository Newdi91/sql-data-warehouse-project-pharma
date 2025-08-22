/*
===============================================================================
DDL Script: Create Silver Table
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	Standardized the schema by aligning column names with the naming convention
	and appended a creation_date metadata field.
	
	  Run this script to re-define the DDL structure of 'silver' Tables
===============================================================================
*/


IF OBJECT_ID ('silver.drug', 'U') IS NOT NULL
	DROP TABLE silver.drug;

CREATE TABLE silver.drug (
    unique_id INT,              
    drug_name VARCHAR(255),     
    condition VARCHAR(255),        
    review VARCHAR(MAX),         
    rating INT,                  
    date DATE,                    
    useful_count INT,   
    dwh_create_date DATETIME2 DEFAULT GETDATE()  
);
