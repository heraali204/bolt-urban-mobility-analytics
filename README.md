# 🚲 Urban Mobility Analytics Dashboard  
**Product, Operations & User Behavior Analysis**

## 📌 Project Overview
This project analyzes an urban mobility platform offering ride-hailing, e-bikes, and scooters.  
The objective is to evaluate **platform health, operational efficiency, product performance, and user behavior** using structured analytics and BI best practices.

The dashboard is designed to answer **real business questions** faced by mobility companies, using realistic metrics and decision-focused visual storytelling.

---

## 🎯 Key Business Questions
- Are trips being successfully completed at scale?
- How does surge pricing impact cancellations?
- Which products and city segments perform best?
- Are users activating, converting, and repeating usage?
- Where do users drop off in the trip funnel?

---

## 🗂️ Data Model

### Source
- Simulated urban mobility dataset  
- Time period: **January–March**

### Fact Tables
- `fact_trips` – trip-level data (status, fare, surge, product, city)
- `fact_user_daily_metrics` – user activity and engagement
- `fact_experiment_events` – exposure and conversion events

### Dimension Tables
- `dim_user`
- `dim_city`
- `dim_product`
- `dim_date`
- `dim_driver`
- `dim_incentive`
- `dim_experiment`

A **star schema** was implemented with `fact_trips` as the core fact table.

---

## 📊 Dashboard Structure

### 1️⃣ Executive Overview
High-level KPIs for leadership monitoring.

**KPIs**
- Total Trips  
- Completed Trips  
- Cancellation Rate  
- Completion Rate  
- Conversion Rate  
- Activation Rate  
- Average Fare per Trip  
- Fare Revenue  
- Active Drivers  
- Cities Covered  

**Insights**
- Completion rate remains stable (~79%)
- Cancellation rate is ~20%, aligned with surge effects
- Revenue is driven primarily by Car trips

---

### 2️⃣ Product & Operations
Operational health and product performance diagnostics.

**Visuals**
- Cancellation Rate by Surge Bucket
- Completion Rate by Product
- Surge Sensitivity by Product
- Monthly Trips by Product
- Average Fare per Trip by Product
- Completion Rate by City Size
- Trips Over Time by City Tier

**Insights**
- High surge increases cancellations but plateaus at extreme levels
- Completion rates are consistent across products
- Larger cities show higher completion stability
- Cars generate the highest average fare

---

### 3️⃣ User Behavior
User lifecycle and engagement analysis.

**KPIs**
- Registered Users  
- Activated Users  
- Converted Users  
- Rides Requested  
- Rides Completed  

**Visuals**
- User Trip Funnel (Request → Completion)
- Average Trips per User Over Time
- User Trip Frequency Distribution
- Completion Rate by Signup Cohort
- Activation Rate by Acquisition Channel
- Average Trips per User by Acquisition Channel

**Insights**
- All users are repeat users (no one-time users)
- Users average ~3.5 trips per month
- Funnel drop-off is driven by cancellations
- Activation rate is consistent across channels

---

## 📐 Key Metric Definitions

- **Completion Rate** = Completed Trips / Total Trips  
- **Cancellation Rate** = Cancelled Trips / Total Trips  
- **Activation Rate** = Activated Users / Registered Users  
- **Conversion Rate** = Converted Users / Registered Users  
- **Fare Revenue** = Sum of Trip Fare  
- **Repeat Users** = Users with more than one trip  

All KPIs are implemented as **DAX measures**, not visual-level calculations.

---

## 🛠️ Tools & Technologies
- **Google BigQuery** – SQL analysis and data storage  
- **Power BI** – Data modeling, DAX, dashboarding  
- **DAX** – KPI and behavioral metrics  
- **Star Schema Modeling**  
---

## 🚀 Why This Project
This project demonstrates:
- End-to-end analytics thinking
- Strong metric design
- Product and operations intuition
- Executive-ready BI storytelling
- Realistic mobility platform use cases

---

## 🔮 Future Improvements
- Retention cohort analysis
- Incentive cost vs conversion impact
- Driver supply vs demand modeling
- Time-of-day demand patterns

---

## 👤 Author
**Hera Ali**  
Product & Data Analytics  
