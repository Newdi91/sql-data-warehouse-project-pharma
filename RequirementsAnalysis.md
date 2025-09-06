# Business Requirements for Drug Review Data Warehouse

## 1. Project Overview
The goal of this project is to build a Data Warehouse using **SQL** that transforms raw drug review data into structured information. This will allow the team to extract actionable insights regarding product performance, patient satisfaction, and marketing strategies. The ETL process will follow a **3-layer architecture**: Bronze (raw), Silver (cleaned/processed), and Gold (aggregated/analytical).

## 2. Data Source
- **Dataset**: UCI ML Drug Review Dataset (CSV format)
- **Key fields**: `drugName`, `condition`, `review`, `rating`, `date`
- **Characteristics**: ~20,000 reviews, static dataset, English language

## 3. Business Objectives
1. Understand which drugs perform best in terms of patient satisfaction.
2. Identify drugs with low ratings that may require further investigation.
3. Monitor trends in reviews over time to detect shifts in perception.
4. Provide insights to the marketing team for targeted campaigns.
5. Support product development decisions based on patient feedback.

## 4. Business Questions
- Which drugs have the highest and lowest average ratings?
- Which drugs are most frequently reviewed per medical condition?
- How do patient ratings change over time for each drug?
- What are common keywords or topics in positive versus negative reviews?
- Are there patterns in reviews based on patient conditions?

## 5. Key Metrics (KPIs)
- Average Rating per Drug
- Total Number of Reviews per Drug
- Number of Reviews per Condition
- Review Trends over Time (daily, monthly)
- Sentiment Score per Drug (optional, text analysis)

## 6. Technical Requirements
- **SQL-based Data Warehouse**
- Implement a **3-layer ETL architecture**:
  1. **Bronze Layer**: raw CSV data loaded as-is
  2. **Silver Layer**: cleaned and normalized data (e.g., standardizing drug names, handling missing values)
  3. **Gold Layer**: aggregated and analytical tables ready for reporting and insights
- Create a core Data Warehouse schema with:
  - **Fact table**: Drug Reviews
  - **Dimension tables**: Drugs, Conditions, Time
- Support analytical queries for reporting and visualization
- Maintain data integrity and handle missing or inconsistent values

## 7. Constraints and Assumptions
- Dataset is static
- Focus on structured CSV input only
- Data Warehouse will be implemented using SQL 
- Initial project scope limited to one dataset for simplicity
