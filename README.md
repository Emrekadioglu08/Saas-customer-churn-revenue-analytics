# 📊 Global SaaS Customer Churn & Revenue Analytics

A end-to-end SaaS Data Analytics project designed to analyze **Monthly Recurring Revenue (MRR)**, **Customer Churn Rates**, and **Geographic Revenue Distribution**. This project combines relational database modeling using **PostgreSQL** with interactive executive dashboarding in **Tableau Public**.

---

## 🚀 Live Interactive Dashboard
👉 **[View Interactive Tableau Public Dashboard](https://public.tableau.com/app/profile/emre.kadioglu/viz/SaaSCustomerChurnRevenueAnalytics/GeographicDistribution?publish=yes)**

---

## 🎯 Business Problem & Objectives
SaaS companies heavily rely on recurring revenue metrics to assess health, growth, and retention. The objective of this project is to answer key executive questions:
1. What is our current active **Monthly Recurring Revenue (MRR)** broken down by subscription tiers?
2. Which plan tiers show the highest **Customer Churn Rate**?
3. How is overall revenue distributed across key geographic regions?

---

## 🛠️ Tech Stack & Methodology
* **Database & Data Querying:** PostgreSQL (pgAdmin)
  * Implemented Advanced SQL (CTEs, Window Functions, Aggregate Joins, Conditional Filtering).
* **Data Visualization:** Tableau Public
  * Interactive Executive Dashboard showcasing KPI Cards, Churn Analysis by Tier, and Geographic Distribution.
* **Version Control & Documentation:** GitHub

---

## 💻 SQL Data Pipeline & Analytical Queries

The full database setup, schemas, and analytical scripts are located in [`saas_analytics.sql`](./saas_analytics.sql).

### Key SQL Queries & Analytics Logic:

#### 1. Active MRR Calculation by Plan Type
```sql
SELECT 
    c.plan_type,
    COUNT(DISTINCT s.customer_id) AS active_customers,
    SUM(s.monthly_price) AS mrr
FROM subscriptions s
JOIN customers c ON s.customer_id = c.customer_id
WHERE s.status = 'Active'
GROUP BY c.plan_type
ORDER BY mrr DESC;
