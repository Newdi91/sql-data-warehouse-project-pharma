/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/


--Check or NULLS or duplicates in Primary Key
SELECT
	uniqueID,
	COUNT(*)
FROM silver_drug
GROUP BY uniqueID
HAVING COUNT(*) >1


--Check for unwanted spaces
SELECT drugName
FROM silver_drug
WHERE drugName != TRIM(drugName)

SELECT condition
FROM silver_drug
WHERE condition != TRIM(condition)
