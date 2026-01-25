# Titanic Dataset Analysis using MATLAB

## 📌 Project Overview

This project performs an **exploratory data analysis (EDA)** on the famous **Titanic dataset** using MATLAB.
The goal is to understand how different factors such as **sex, passenger class, and age** influenced survival rates, while also practicing data cleaning, visualization, and statistical analysis.

The script walks step-by-step through:

* Handling missing data
* Measuring data variation
* Visualizing distributions and survival patterns
* Comparing survival rates across multiple demographic groups

---

## 📂 Dataset

* **File used:** `titanic - titanic.csv`
* **Source:** Titanic passenger dataset (commonly used for data analysis and machine learning practice)

---

## 🛠 Tools & Technologies

* **MATLAB**
* Built-in MATLAB functions:

  * `readtable`
  * `groupsummary`
  * `heatmap`
  * `boxplot`
  * `discretize`
  * `bar`

---

## 🔍 Analysis Workflow

### 1. Data Loading & Inspection

* Load the dataset using `readtable`
* Preview the data using `head` and `summary`

---

### 2. Missing Data Visualization

* Compute missing values per variable
* Display a **heatmap** to visualize missing data patterns

---

### 3. Data Cleaning

* Remove columns with excessive or unnecessary missing data:

  * `Ticket`, `Cabin`, `Embarked`, `Fare`, `Parch`, `SibSp`
* Remove rows where **Age** is missing

---

### 4. Variation Measures

For all numeric variables:

* **Range**
* **Variance**
* **Standard Deviation**

Results are displayed in a summary table.

---

### 5. Outlier Detection

* Generate **boxplots** for numeric features to visually inspect outliers

---

### 6. Survival Analysis

The script analyzes survival rates across different dimensions:

#### 🔹 Survival by Sex

* Mean survival rate calculated and visualized using a bar chart

#### 🔹 Survival by Passenger Class

* Survival rate comparison across **1st, 2nd, and 3rd class**

#### 🔹 Survival by Age Group

Passengers are grouped into:

* Child (0–12)
* Teen (13–18)
* Young (19–30)
* Adult (31–45)
* Mature (46–60)
* Senior (60+)

Survival rates are computed and plotted.

#### 🔹 Survival by Sex & Class

* Grouped bar chart showing survival differences between males and females across passenger classes

#### 🔹 Survival by Age Group & Class

* Grouped bar chart comparing survival rates for age groups across passenger classes

---

## 📊 Visual Outputs

The script generates multiple figures, including:

* Missing data heatmap
* Boxplots for numeric variables
* Bar charts for survival rates by:

  * Sex
  * Passenger class
  * Age group
  * Combined demographic factors

---

## ▶️ How to Run

1. Place the MATLAB script and `titanic - titanic.csv` in the same folder.
2. Open MATLAB.
3. Run the script from the Command Window or Editor.
4. Figures and tables will be generated automatically.

---

## 🎯 Key Learning Outcomes

* Practical experience with **data cleaning**
* Statistical analysis using **variation measures**
* Effective **data visualization** in MATLAB
* Understanding how demographic factors affect survival outcomes

---

## 📌 Notes

* This project focuses on **exploratory analysis**, not prediction or machine learning.
* All calculations use MATLAB’s built-in statistical functions.


Just tell me 🌿
