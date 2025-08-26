/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Data standardization and consistency.
    - Invalid date ranges.
    
Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/


--Check or NULLS or duplicates in Primary Key
SELECT
	unique_id,
	COUNT(*)
FROM silver_drug
GROUP BY uniqueID
HAVING COUNT(*) >1


--Check for still NULL in col condition
SELECT
	unique_id,
	drug_name,
	condition
FROM silver_drug
WHERE condition IS NULL;

--Check for still ASCII char in col review
SELECT
	unique_id,
	drug_name,
	review
FROM silver_drug
WHERE review LIKE '%&%';

--Check for invalid future date in col date
SELECT
    [date]
FROM bronze_drug
WHERE [date] > GETDATE()
