# 🍽️ Restaurant & Consumer Data Analysis (SQL Project)

## 🚀 From Raw CSV Data to Structured Insights Using SQL

---

## 📖 Project Overview  
This project focuses on analyzing restaurant and consumer data by designing a structured SQL database from raw CSV files and extracting meaningful insights using SQL queries.

The goal is to simulate a real-world scenario where businesses use data to:
- Understand customer preferences  
- Analyze restaurant performance  
- Build recommendation systems  

---

## 🎯 Objectives  
- Design a relational database from raw CSV data  
- Understand and implement **ER relationships**  
- Perform data analysis using **SQL queries**  
- Extract insights about **customers, restaurants, and ratings**  
- Apply advanced SQL concepts like **CTEs, Window Functions, Views, and Stored Procedures**

---

## 🛠️ Tech Stack  
- **SQL (MySQL / PostgreSQL)**  
- **CSV Files** (Raw Data Source)  

---

## 📂 Dataset Description  

### Consumers Table  
Contains customer details:
- Consumer_ID, Age, Occupation, Budget  
- Lifestyle (Smoker, Drink Level)  
- Location (City, State, Country)

### Consumer Preferences Table  
- Consumer_ID  
- Preferred Cuisine  

### Restaurants Table  
- Restaurant_ID, Name, City  
- Price, Franchise, Parking  
- Services (Alcohol, Smoking)

### Restaurant Cuisines Table  
- Restaurant_ID  
- Cuisine  

### Ratings Table  
- Consumer_ID, Restaurant_ID  
- Overall Rating, Food Rating, Service Rating  

### Data Dictionary  
- Metadata describing each column  

---

## 🧩 Database Design (ER Model)  
- Established relationships using:
  - **Consumer_ID** (Consumers ↔ Preferences ↔ Ratings)  
  - **Restaurant_ID** (Restaurants ↔ Cuisines ↔ Ratings)  
- Ensured proper normalization and relational structure  

---

## ⚙️ Key SQL Concepts Used  

### 🔹 Basic Queries  
- Filtering using `WHERE` clause  
- Logical conditions (`AND`, `OR`)  

### 🔹 Joins & Subqueries  
- INNER JOIN, LEFT JOIN  
- Nested queries for complex filtering  

### 🔹 Aggregations  
- COUNT, AVG, GROUP BY, HAVING  

### 🔹 Advanced SQL  
- Common Table Expressions (**CTEs**)  
- Window Functions (`RANK()`, `ROW_NUMBER()`)  
- Views creation  
- Stored Procedures  

---

## 📊 Key Analysis Performed  

### 🔹 Consumer Analysis  
- Identified students, smokers, and spending behavior  
- Segmented customers based on budget  

### 🔹 Restaurant Analysis  
- Found top-rated restaurants  
- Analyzed franchise vs non-franchise performance  
- Evaluated cuisine popularity  

### 🔹 Ratings Analysis  
- Calculated average ratings per restaurant  
- Identified low-performing restaurants  
- Compared food vs service ratings  

### 🔹 Advanced Insights  
- Ranked restaurants within each cuisine  
- Identified consumers who avoid specific cuisines  
- Found top customers based on rating behavior  
- Compared individual ratings with overall averages  

---

## 📈 Sample Business Questions Solved  
- Which restaurants have the highest ratings?  
- Which consumers prefer specific cuisines?  
- Which restaurants perform below average?  
- Who are the most active or valuable customers?  
- How do customer preferences impact restaurant ratings?  

---

## 💡 Key Insights  
- Certain cuisines consistently receive higher ratings  
- Customer preferences strongly influence ratings  
- Some restaurants perform below average despite popularity  
- High engagement consumers provide more reliable insights  
- Budget and lifestyle impact consumer behavior  

---

## 🚀 How to Use  
1. Import CSV files into your SQL database  
2. Create tables and define relationships  
3. Run the provided `.sql` file  
4. Execute queries to explore insights  

---
