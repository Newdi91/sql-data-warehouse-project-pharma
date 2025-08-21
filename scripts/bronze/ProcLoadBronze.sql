/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Stored Procedure Error Monitoring and Load Tracking:
    This stored procedure includes comprehensive error logging, capturing the type of error,
    its numeric code, and the line number where it occurred. For debugging purposes,
    it also tracks the duration of the loading process.

Usage Example:
    EXEC load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME
    BEGIN TRY
        PRINT '========================================';
        PRINT 'Loading Bronze Layer';
        PRINT '========================================';

        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.drug';
        TRUNCATE TABLE bronze.drug;
          PRINT '>>Inserting Data Into: bronze.drug';
        BULK INSERT bronze.drug
        FROM 'C:\sqlDWpharmaSOURCE\drugsComTrain_raw.csv'
        WITH (
            FORMAT = 'CSV',           
            FIELDQUOTE = '"',         
            FIRSTROW = 2,             
            FIELDTERMINATOR = ',',    
            ROWTERMINATOR = '0x0a',   
            CODEPAGE = '65001',       
            TABLOCK,                  
            KEEPNULLS                 
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'; 
        END TRY
    BEGIN CATCH
    PRINT '========================================';
    PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error Message: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Error Message: ' + CAST(ERROR_MESSAGE() AS NVARCHAR);
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR);
    PRINT '========================================';
    END CATCH
END
