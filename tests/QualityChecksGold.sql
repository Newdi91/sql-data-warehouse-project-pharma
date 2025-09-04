/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the Gold Layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/


-- ====================================================================
-- Checking 'gold_fact_review'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions

SELECT * 
FROM gold_fact_review f

LEFT JOIN gold_dim_drug dr
ON f.drug_key = dr.drug_key

LEFT JOIN gold_dim_condition con
ON f.condition_key = con.condition_key

JOIN gold_dim_date d
ON f.date_key = d.date_key

JOIN gold_dim_review_text txt
ON f.review_key = txt.review_key

WHERE f.drug_key IS NULL
