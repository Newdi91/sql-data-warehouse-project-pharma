# Business Requirements for Drug Review Data Warehouse

## 1. Project Overview

The objective of this project is to develop a SQL-based Data Warehouse that transforms raw drug review data into structured information. This transformation will enable the extraction of actionable insights regarding product performance, patient satisfaction, and marketing strategies. The ETL process will adhere to a **3-layer architecture**:

- **Bronze Layer**: Raw data ingestion
- **Silver Layer**: Data cleaning and transformation
- **Gold Layer**: Aggregated and analytical data ready for reporting

## 2. Data Source

- **Dataset**: UCI ML Drug Review Dataset (CSV format)
- **Key Fields**: `drugName`, `condition`, `review`, `rating`, `date`
- **Characteristics**: Approximately 20,000 reviews; static dataset; English language

## 3. Business Objectives

The primary objectives of this project are:

- **Enhance Product Understanding**: Analyze patient reviews to identify which drugs are most effective and well-received, providing insights into product performance.
- **Identify Areas for Improvement**: Detect drugs with low ratings or recurring negative feedback, highlighting areas that may require further investigation or improvement.
- **Monitor Trends Over Time**: Track changes in patient satisfaction and perceptions over time, identifying emerging issues or improvements.
- **Support Marketing Strategies**: Provide data-driven insights to inform targeted marketing campaigns and promotional strategies.
- **Inform Product Development**: Use patient feedback to guide decisions in product development and improvement.

## 4. Business Questions

Key questions to address include:

- **Drug Performance**: Which drugs have the highest and lowest average ratings?
- **Condition-Specific Usage**: Which drugs are most frequently reviewed for each medical condition?
- **Temporal Trends**: How do patient ratings change over time for each drug?
- **Review Sentiment**: What are common keywords or topics in positive versus negative reviews?
- **Condition-Based Patterns**: Are there patterns in reviews based on patient conditions?

## 5. Key Metrics (KPIs)

The following KPIs are essential for evaluating the project's success:

- **Average Rating per Drug**: Measures overall patient satisfaction with each drug.
- **Total Number of Reviews per Drug**: Indicates the volume of feedback and potential popularity or usage of the drug.
- **Number of Reviews per Condition**: Assesses the prevalence of each drug in treating specific conditions.
- **Review Trends Over Time**: Tracks changes in patient feedback over time, identifying improvements or declines in satisfaction.
- **Sentiment Score per Drug**: Analyzes the sentiment of reviews to gauge overall patient sentiment towards each drug.

## 6. Technical Requirements

- **SQL-based Data Warehouse**
- Implement a **3-layer ETL architecture**:
  1. **Bronze Layer**: Raw CSV data loaded as-is
  2. **Silver Layer**: Cleaned and normalized data (e.g., standardizing drug names, handling missing values)
  3. **Gold Layer**: Aggregated and analytical tables ready for reporting and insights
- Create a core Data Warehouse schema with:
  - **Fact Table**: Drug Reviews
  - **Dimension Tables**: Drugs, Conditions, Time
- Support analytical queries for reporting and visualization
- Maintain data integrity and handle missing or inconsistent values

## 7. Constraints and Assumptions

- Dataset is static
- Focus on structured CSV input only
- Data Warehouse will be implemented using SQL
- Initial project scope limited to one dataset for simplicity
