/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold_dim_drug
-- =============================================================================

IF OBJECT_ID('gold_dim_drug', 'V') IS NOT NULL
    DROP VIEW gold_dim_drug;
GO

CREATE VIEW gold_dim_drug AS
WITH cte_AggregatedDrugs AS (
    SELECT
        STRING_AGG(drug_name, ', ') WITHIN GROUP (ORDER BY drug_name) AS drug_name
    FROM silver_drug
    GROUP BY review
)

SELECT
    ROW_NUMBER() OVER (ORDER BY drug_name) AS drug_key,
    drug_name
FROM cte_AggregatedDrugs
GROUP BY drug_name;

GO

-- =============================================================================
-- Create Dimension: gold_dim_condition
-- =============================================================================

IF OBJECT_ID('gold_dim_condition', 'V') IS NOT NULL
    DROP VIEW gold_dim_condition;
GO

CREATE VIEW gold_dim_condition AS
SELECT
	ROW_NUMBER() OVER(ORDER BY condition) AS condition_key,
	condition
FROM silver_drug
GROUP BY condition;

GO
-- =============================================================================
-- Create Dimension: gold_dim_date
-- =============================================================================

IF OBJECT_ID('gold_dim_date', 'V') IS NOT NULL
    DROP VIEW gold_dim_date;
GO

CREATE VIEW gold_dim_date AS
SELECT
	ROW_NUMBER() OVER(ORDER BY date) AS date_key,
	date,
	YEAR(date) AS year,
	MONTH(date) AS month,
	DATEPART(QUARTER, date) AS quarter
FROM silver_drug
GROUP BY date;

GO
-- =============================================================================
-- Create Dimension: gold_dim_review_text
-- =============================================================================

IF OBJECT_ID('gold_dim_review_text', 'V') IS NOT NULL
    DROP VIEW gold_dim_review_text;
GO

CREATE VIEW gold_dim_review_text AS
SELECT
	ROW_NUMBER() OVER(ORDER BY review) AS review_key,
	review AS review_text	
FROM silver_drug
GROUP BY review;

