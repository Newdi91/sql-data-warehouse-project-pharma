/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Stored Procedure Error Monitoring and Load Tracking:
    This stored procedure includes comprehensive error logging, capturing the type of error,
    its numeric code, and the line number where it occurred. For debugging purposes,
    it also tracks the duration of the loading process.

Usage Example:
    EXEC load_silver;
===============================================================================
*/


CREATE OR ALTER PROCEDURE load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
    BEGIN TRY
        PRINT '================================================';
        PRINT 'Loading Silver Layer';
        PRINT '================================================';
        -- Loading silver_drug
        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: silver.crm_cust_info';
        TRUNCATE TABLE silver_drug;
        PRINT '>> Inserting Data Into: silver.crm_cust_info';

        -- Replace ASCII char in col review using multiple CTE, to not reach the max number of replace	
        WITH step1 AS (
            SELECT
                uniqueID,
                drugName,
                [condition] AS orig_condition,
                rating,
                [date],
                usefulCount,
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        review,
                                        N'&#039;', NCHAR(39)),
                                    N'&rsquo;', NCHAR(8217)),
                                N'&lsquo;', NCHAR(8216)),
                            N'&amp;', N'and'),
                        N'&gt;', NCHAR(62)),
                    N'&lt;', NCHAR(60)
                ) AS review_1
            FROM bronze_drug
        ),
        step2 AS (
            SELECT
                uniqueID,
                drugName,
                orig_condition,
                rating,
                [date],
                usefulCount,
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        review_1,
                                        N'&quot;', NCHAR(34)),
                                    N'&quote;', NCHAR(34)),
                                N'&bull;', NCHAR(8226)),
                            N'&ldquo;', NCHAR(8220)),
                        N'&rdquo;', NCHAR(8221)),
                    N'&hellip;', NCHAR(8230)
                ) AS review_2
            FROM step1
        ),
        step3 AS (
            SELECT
                uniqueID,
                drugName,
                orig_condition,
                rating,
                [date],
                usefulCount,
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        review_2,
                                        N'&mdash;', NCHAR(8212)),
                                    N'&ndash;', NCHAR(8211)),
                                N'&deg;', NCHAR(176)),
                            N'&frac12;', NCHAR(189)),
                        N'&frac14;', NCHAR(188)),
                    N'&frac34;', NCHAR(190)
                ) AS review_3
            FROM step2
        ),
        step4 AS (
            SELECT
                uniqueID,
                drugName,
                orig_condition,
                rating,
                [date],
                usefulCount,
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        review_3,
                                        N'&divide;', NCHAR(247)),
                                    N'&times;', NCHAR(215)),
                                N'&reg;', NCHAR(174)),
                            N'&nbsp;', N' '),
                        N'&acute;', NCHAR(180)),
                    N'&euro;', NCHAR(8364)
                ) AS review_4
            FROM step3
        ),
        step5 AS (
            SELECT
                uniqueID,
                drugName,
                orig_condition,
                rating,
                [date],
                usefulCount,
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        review_4,
                                        N'&pound;', NCHAR(163)),
                                    N'&agrave;', NCHAR(224)),
                                N'&eacute;', NCHAR(233)),
                            N'&eoacute;', NCHAR(243)),  -- gestisce anche la possibile variante non standard
                        N'&oacute;', NCHAR(243)),
                    N'&egrave;', NCHAR(232)
                ) AS review_5
            FROM step4
        ),
        step6 AS (
            SELECT
                uniqueID,
                drugName,
                orig_condition,
                rating,
                [date],
                usefulCount,
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        review_5,
                                        N'&ecirc;', NCHAR(234)),
                                    N'&iacute;', NCHAR(237)),
                                N'&Lacute;', NCHAR(313)),
                            N'&acirc;', NCHAR(226)),
                        N'&aacute;', NCHAR(225)),
                    N'&macr;', NCHAR(175)
                ) AS review_6
            FROM step5
        ),
        step7 AS (
            SELECT
                uniqueID,
                drugName,
                orig_condition,
                rating,
                [date],
                usefulCount,
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        review_6,
                                        N'&lrm;', N''),         
                                    N'&micro;', NCHAR(181)),
                                N'&ntilde;', NCHAR(241)),
                            N'&oslash;', NCHAR(248)),
                        N'&ocirc;', NCHAR(244)),
                    N'&igrave;', NCHAR(236)
                ) AS review_7
            FROM step6
        ),
        step8 AS (
            SELECT
                uniqueID,
                drugName,
                orig_condition,
                rating,
                [date],
                usefulCount,
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    review_7,
                                    N'&ouml;', NCHAR(246)),
                                N'&Prime;', NCHAR(8243)),
                            N'&ge;', NCHAR(8805)),
                        N'&iquest;', NCHAR(191)),
                    N'&bull;', NCHAR(8226)   
                ) AS review_clean
            FROM step7
        )
        INSERT INTO silver_drug (
            unique_id,
            drug_name,
            condition,
            review,
            rating,
            [date],
            useful_count
        )
        SELECT
            s.uniqueID,
            s.drugName,
            --Handling NULL in col condition
            CASE
                WHEN s.drugName = 'Acetaminophen / butalbital / caffeine / codeine' THEN 'Headache'
                WHEN s.drugName = 'Acetaminophen / butalbital / caffeine' THEN 'Headache'
                WHEN s.drugName = 'Acetaminophen / caffeine' THEN 'Headache'
                WHEN s.drugName = 'Acetaminophen / dexbrompheniramine / pseudoephedrine' THEN 'Allergic Rhinitis'
                WHEN s.drugName = 'Acetaminophen / dextromethorphan / doxylamine' THEN 'Cold Symptoms'
                WHEN s.drugName = 'Acetaminophen / hydrocodone' AND (s.orig_condition IS NULL OR s.orig_condition NOT IN ('Back Pain','Rheumatoid Arthritis','Cough')) THEN 'Pain'
                WHEN s.drugName = 'Acetaminophen / oxycodone' AND (s.orig_condition IS NULL OR s.orig_condition NOT IN ('Chronic Pain')) THEN 'Pain'
                WHEN s.drugName = 'Acetaminophen / propoxyphene' AND (s.orig_condition IS NULL OR s.orig_condition NOT IN ('Osteoarthritis')) THEN 'Pain'
                WHEN s.drugName = 'Acetaminophen / pseudoephedrine' THEN 'Sinus Symptoms'
                WHEN s.drugName = 'Acyclovir' AND (s.orig_condition = 'Herpes Zoste' OR s.orig_condition IS NULL) THEN 'Herpes Zoster'
                WHEN s.drugName IN ('Adapalene','Adapalene / benzoyl peroxide') THEN 'Acne'
                WHEN s.drugName IN ('Albuterol','Albuterol / ipratropium') THEN 'Asthma, Maintenance'
                WHEN s.drugName = 'Alcaftadine' THEN 'Conjunctivitis, Allergic'
                WHEN s.drugName = 'Aliskiren' THEN 'High Blood Pressure'
                WHEN s.uniqueID IN (147487, 147329, 201640) AND s.drugName = 'Alprazolam' THEN 'Anxiety'
                WHEN s.uniqueID = 147669 AND s.drugName = 'Alprazolam' THEN 'Depression'
                WHEN s.uniqueID IN (201639, 201783) AND s.drugName = 'Alprazolam' THEN 'Panic Disorder'
                WHEN s.drugName = 'Aluminum chloride hexahydrate' THEN 'Hyperhidrosis'
                WHEN s.uniqueID IN (218051, 218459) AND s.drugName = 'Amoxicillin / clavulanate' THEN 'Bacterial Infection'
                WHEN s.uniqueID = 218148 AND s.drugName = 'Amoxicillin / clavulanate' THEN 'Strep Throat'
                WHEN s.uniqueID IN (13695, 13676, 13692, 13683, 13774, 13631) AND s.drugName = 'Amphetamine / dextroamphetamine' THEN 'ADHD'
                WHEN s.drugName = 'Amphetamine / dextroamphetamine' AND s.orig_condition IS NULL THEN 'ADHD'
                WHEN s.uniqueID IN (13661, 139545) THEN 'Narcolepsy'
                WHEN s.orig_condition LIKE '%Disorde%' THEN REPLACE(s.orig_condition, 'Disorde', 'Disorder')
                WHEN s.uniqueID = 139545 AND s.drugName = 'Armodafinil' THEN 'Hypersomnia'
                WHEN s.drugName = 'Armodafinil' AND s.orig_condition IS NULL THEN 'Not Listed / Other'
                WHEN s.uniqueID IN (140137, 140311, 140343) THEN 'Not Listed / Other'
                WHEN s.uniqueID = 187635 AND s.drugName = 'Aspirin / oxycodone' THEN 'Pain'
                WHEN s.uniqueID IN (209795, 106127) THEN 'Headache'
                WHEN s.uniqueID IN (123182, 187292) THEN 'Allergic Rhinitis'
                WHEN s.orig_condition LIKE 'Not Listed%' OR s.uniqueID IN (146933, 146834, 218357, 13777, 13468, 13748, 102955, 140203, 58759, 51452, 51455) OR s.orig_condition IS NULL THEN 'Not Listed / Other'
                WHEN s.orig_condition LIKE 'Panic Disorde%' THEN 'Panic Disorder'
                WHEN s.orig_condition LIKE '%atigue' THEN 'Fatigue'
                WHEN s.orig_condition LIKE '%ibromyalgia' THEN 'Fibromyalgia'
                ELSE s.orig_condition
            END AS condition,
            s.review_clean AS review,
            s.rating,
            s.[date],
            s.usefulCount
        FROM step8 AS s;

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';
    END TRY

    BEGIN CATCH
        PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
