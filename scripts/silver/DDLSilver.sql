/* We fixed the DDL by renaming the columns to align with the defined naming convention
and added a metadata column to capture the table creation timestamp.*/

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
    dwh_create_date DATETIME2 DEFAULT GETDATE()  --metadata column--
);
