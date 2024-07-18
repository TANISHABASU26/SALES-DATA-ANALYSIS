# Walmart Sales Data Analysis

## About
This project explores Walmart sales data to identify top-performing branches and products, analyze sales trends, and understand customer behavior. The goal is to optimize sales strategies based on these insights. The dataset used for this analysis is from the Kaggle Walmart Sales Forecasting Competition.

### Project Overview
In this competition, participants are provided with historical sales data from 45 Walmart stores across various regions. Each store includes multiple departments, and the challenge is to forecast sales for each department. Additionally, holiday markdown events are included in the dataset, which impact sales unpredictably, adding complexity to the forecasting task.

### Purpose of the Project
The primary objective is to gain insights into Walmart's sales data to understand factors influencing sales across different branches.

### Data Overview
The dataset, sourced from the Kaggle Walmart Sales Forecasting Competition, includes sales transactions from three Walmart branches in Mandalay, Yangon, and Naypyitaw. It consists of 17 columns and 1000 rows:

| Column                 | Description                          | Data Type        |
|------------------------|--------------------------------------|------------------|
| invoice_id             | Invoice of the sales made            | VARCHAR(30)      |
| branch                 | Branch at which sales were made      | VARCHAR(5)       |
| city                   | Location of the branch               | VARCHAR(30)      |
| customer_type          | Type of customer                     | VARCHAR(30)      |
| gender                 | Gender of the customer               | VARCHAR(10)      |
| product_line           | Product line of the item sold        | VARCHAR(100)     |
| unit_price             | Price of each product                | DECIMAL(10,2)    |
| quantity               | Amount of the product sold           | INT              |
| VAT                    | Tax amount on the purchase           | FLOAT(6,4)       |
| total                  | Total cost of the purchase           | DECIMAL(10,2)    |
| date                   | Date of the purchase                 | DATE             |
| time                   | Time of the purchase                 | TIMESTAMP        |
| payment_method         | Payment method                       | VARCHAR(15)      |
| cogs                   | Cost of Goods Sold                   | DECIMAL(10,2)    |
| gross_margin_percentage| Gross margin percentage              | FLOAT(11,9)      |
| gross_income           | Gross income                         | DECIMAL(10,2)    |
| rating                 | Customer rating                      | FLOAT(2,1)       |

### Analysis List

#### Product Analysis
Analyze data to understand product lines, identify best-performing products, and determine areas for improvement.

#### Sales Analysis
Examine sales trends to measure the effectiveness of sales strategies and identify areas for modification to boost sales.

#### Customer Analysis
Uncover customer segments, purchase trends, and the profitability of each segment.

### Approach Used

#### Data Wrangling
1. Inspect the data for NULL and missing values.
2. Build a database.
3. Create tables and insert data.
4. Select columns with NULL values (if any) and handle them appropriately.

#### Feature Engineering
1. Add a column named `time_of_day` to categorize sales by Morning, Afternoon, and Evening.
2. Add a column named `day_name` to extract the day of the week from the date.
3. Add a column named `month_name` to extract the month from the date.

#### Exploratory Data Analysis (EDA)
Perform EDA to answer key questions and achieve project objectives.

### Conclusion

#### Business Questions to Answer
1. **Generic Questions**
   - How many unique cities are in the data?
   - Which city is each branch located in?
   
2. **Product Analysis**
   - How many unique product lines are in the data?
   - What is the most common payment method?
   - Which product line is the best-seller?
   - What is the total monthly revenue?
   - Which month had the highest COGS?
   - Which product line generated the highest revenue?
   - Which city had the highest revenue?
   - Which product line had the highest VAT?
   - Add a column indicating "Good" or "Bad" based on sales performance relative to the average.
   - Which branch sold more products than the average?
   - Which product line is most common by gender?
   - What is the average rating for each product line?

3. **Sales Analysis**
   - Number of sales made at different times of the day per weekday.
   - Which customer type generates the most revenue?
   - Which city has the highest VAT percentage?
   - Which customer type pays the most VAT?

4. **Customer Analysis**
   - How many unique customer types are in the data?
   - How many unique payment methods are in the data?
   - What is the most common customer type?
   - Which customer type purchases the most?
   - What is the gender distribution of customers?
   - What is the gender distribution per branch?
   - Which time of day receives the most ratings?
   - Which day of the week has the best average ratings?

5. **Revenue and Profit Calculations**
   - COGS = unit_price * quantity
   - VAT = 5% * COGS
   - Total (gross sales) = VAT + COGS
   - Gross Profit (gross income) = total (gross sales) - COGS
   - Gross Margin = (gross income / total revenue) * 100

### Example Calculation
Given the following data for a single transaction:
- Unit Price: 45.79
- Quantity: 7
- COGS = 45.79 * 7 = 320.53
- VAT = 5% * 320.53 = 16.0265
- Total = 320.53 + 16.0265 = 336.5565
- Gross Margin Percentage = (16.0265 / 336.5565) * 100 ≈ 4.76%

### SQL Code

```sql
-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;

-- Create table
CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATE NOT NULL,
    time TIMESTAMP NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12,4),
    rating FLOAT(2,1)
);
```
FOR MORE DETAILS VISIT SALES DATA.SQL FILE IN THE REPROSITORY
