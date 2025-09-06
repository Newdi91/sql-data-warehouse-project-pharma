# Data Catalog for Gold Layer

## Overview
The **Gold Layer** is the business-level data representation, structured to support analytical and reporting use cases.  
It consists of **dimension tables** and a **fact table** for drug reviews, ratings, and usefulness metrics.

---

## Table of Contents
- [1. gold.dim_drug](#1-golddim_drug)  
- [2. gold.dim_condition](#2-golddim_condition)  
- [3. gold.dim_date](#3-golddim_date)  
- [4. gold.dim_review_text](#4-golddim_review_text)  
- [5. gold.fact_review](#5-goldfact_review)  

---

## 1. gold_dim_drug

**Purpose**: Stores drug details with a surrogate key for analytical joins.  

| Column Name | Data Type     | Description                                                                 |
|-------------|--------------|------------------------------------------------------------------------------|
| drug_key    | BIGINT          | Surrogate key uniquely identifying each drug in the dimension table.      |
| drug_name   | NVARCHAR(255)| Name of the drug, cleaned and standardized.                                  |

---

## 2. gold_dim_condition

**Purpose**: Stores medical conditions associated with drug usage and reviews.  

| Column Name     | Data Type     | Description                                                                 |
|-----------------|--------------|-----------------------------------------------------------------------------|
| condition_key   | BIGINT          | Surrogate key uniquely identifying each condition.                       |
| condition_name  | NVARCHAR(255)| Cleaned and standardized medical condition name.                            |

---

## 3. gold_dim_date

**Purpose**: Provides temporal attributes for reviews to support time-based analysis.  

| Column Name  | Data Type     | Description                                                                 |
|--------------|--------------|------------------------------------------------------------------------------|
| date_key     | BIGINT       | Surrogate key in `YYYYMMDD` format, uniquely identifying each date.          |
| date         | DATE         | Calendar date in standard format.                                            |
| year         | INT          | Year of the review date.                                                     |
| month        | INT          | Month number (1–12).                                                         | 
| quarter      | INT          | Quarter of the year (1–4).                                                   |

---

## 4. gold_dim_review_text

**Purpose**: Stores the textual content of reviews.  

| Column Name   | Data Type     | Description                                                                 |
|---------------|--------------|------------------------------------------------------------------------------|
| review_key    | BIGINT          | Surrogate key uniquely identifying each review text record.               |
| review_text   | NVARCHAR(MAX)| The full text of the user’s review.                                          |

---

## 5. gold_fact_review

**Purpose**: Stores drug review facts with numerical measures and foreign keys linking to dimensions.  

| Column Name       | Data Type     | Description                                                                 |
|-------------------|--------------|------------------------------------------------------------------------------|
| drug_key          | BIGINT       | Foreign key linking to `gold.dim_drug`.                                      |
| condition_key     | BIGINT       | Foreign key linking to `gold.dim_condition`.                                 |
| date_key          | BIGINT       | Foreign key linking to `gold.dim_date`.                                      |
| review_key        | BIGINT       | Foreign key linking to `gold.dim_review_text`.                               |
| source_review_id  | INT          | Original review identifier from the raw dataset (for traceability).          | 
| rating            | INT          | User rating score (0–10 scale, as provided by source).                       |
| useful_count      | INT          | Number of users who marked the review as useful.                             |

---

## Notes for Readers

- **Surrogate Keys (`*_key`)**: Artificial identifiers used for joins, ensuring consistency and performance.  
- **Source Tracking**: `source_review_id` allows traceability back to the raw dataset.  
- **No Text in Fact Table**: All textual content is stored in `dim_review_text` for performance optimization.
