# 💊 Data Warehouse Project – db_pharmaproject

Welcome to the **Data Warehouse Project** repository!  
This project showcases a **data engineering workflow** for building a **pharma-focused data warehouse** using **SQL Server (SSMS 21)**, preparing it for future analytics.

---

## 🌟 Overview

Goal: Build a **structured, multi-layer warehouse** for pharmaceutical project data.  

Key points:

- 🏗️ **Warehouse design**: Star schema with fact and dimension tables  
- 🔄 **ETL pipeline**: Layered processing with **Bronze → Silver → Gold**  
- 📦 **Analytics-ready**: Data cleaned and structured, ready for queries and dashboards  
- 🏆 **Portfolio showcase**: Highlights **SQL, ETL, and data modeling skills**

---

## 🛠 Tools

- 🖥️ SQL Server 2022 (SSMS 21)  
- 🔄 T-SQL scripts for ETL  
- 🗂️ Star schema with fact & dimension tables  
- 🌐 Git & GitHub  

---

## 📊 Warehouse Structure

**Layered Architecture**:

1. **Bronze Layer** – Raw data ingestion  
2. **Silver Layer** – Data cleaning, transformation, normalization  
3. **Gold Layer** – Analytics-ready views  

**Gold Views**:

- **Dimensions**:  
  - `dim_drug`  
  - `dim_condition`  
  - `dim_date`  
  - `dim_review_text`  

- **Fact Table**:  
  - Contains FKs to dimensions  
  - Measures: `useful_count`, `rating`  

This design supports **efficient analytics** and prepares the warehouse for **future insights**.

---

## 🔍 Potential Insights

Warehouse structure allows future exploration of:

- ⏱️ Project or review trends over time  
- 💊 Drug and condition performance metrics  
- ⭐ Review usefulness and rating analysis  
- 🔮 Predictive analytics for project outcomes  

---

## 🚀 Future Enhancements

- SQL-based **dashboards**  
- Predictive models on review usefulness or drug trends  
- Automated **report generation**  
- Integration of **additional pharma datasets**

---

## 📂 Repository Structure
```
db_pharmaproject/
├─ data/ # Raw datasets (Bronze layer)
├─ sql/ # T-SQL scripts for ETL and Gold views
├─ docs/ # Documentation and design notes
└─ README.md # This file
```

yaml
Copia codice

> Clear structure, easy for recruiters to navigate.

---

## 💡 Conclusion

This project demonstrates **end-to-end data engineering**:

- SQL / T-SQL development  
- ETL pipeline design with Bronze/Silver/Gold layers  
- Star schema data modeling  
- Preparation for analytics in pharmaceutical datasets

Ideal as a **portfolio project** for showcasing pharma data engineering skills.
