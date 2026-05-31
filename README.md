# 🌐 Global Supply Chain & Sales Performance Analytics

A comprehensive, enterprise-level 3-page Power BI dashboard operating on a **1-million-row SQL Server dataset**, focused on Executive, Sales, and Customer insights. Designed with a custom dark cyber-gold theme optimized for corporate decision-making.

---

## 📊 Dashboard Pages & Visualizations

### 1. Executive Summary
*Provides high-level tracking of global logistics, revenues, and key financial performance indicators.*
<img width="1320" height="739" alt="page1" src="https://github.com/user-attachments/assets/dc38baf8-c9d5-40e6-9ce9-437f277407d3" />


### 2. Sales & Product Performance
*A visual-heavy analytics interface highlighting revenue shares, top-performing product units, and pricing matrices without cluttered tables.*
<img width="1319" height="739" alt="page2" src="https://github.com/user-attachments/assets/614ef203-494e-4647-b768-f019026e0069" />

### 3. Customer & Regional Insights
*Tracks customer profiles, regional shipping metrics against target thresholds, and high-value corporate accounts.*
<img width="1322" height="741" alt="page3" src="https://github.com/user-attachments/assets/e790f489-7b61-4967-8659-2ee9b6239502" />

---

## 🛠️ Database & Data Engineering (SQL)
The backbone of this project runs on a robust relational database model optimized for big data performance.

* **Database Schema:** Formed a highly optimized Star Schema architecture to handle 1 Million+ records seamlessly without degradation.
* **SQL View Optimization:** Developed custom database views to aggregate and pre-filter massive transactional tables before importing into Power BI, ensuring instantaneous cross-filtering response times.

👉 You can review all the raw SQL production scripts used for table creation and view optimizations in the [database_queries.sql](./database_queries.sql) file.

---

## 🧠 Key DAX Measures Developed
* **Total Net Sales:** Core revenue aggregator handling complex discounts.
* **Average Shipping Delay:** Dynamic multi-table calculation using `AVERAGEX` and `DATEDIFF` to benchmark supply chain velocity against enterprise targets.
* **Top-N Filtering:** Context-aware ranking for dynamic high-value asset detection.
