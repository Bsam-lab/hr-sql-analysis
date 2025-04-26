# Hr Analysis

![hr](https://github.com/user-attachments/assets/5b7f30e3-9fae-4b8f-bbd7-c7b11ef2f12e)

## Table of Contents
- [Introduction](#Introduction)
- [Dataset Overview](#Dataset-Overview)
- [Project Objective](#Project-Objective)
- [Data Cleaning](#Data-Cleaning)
- [Data Exploration and Insight](#Data-Exploration-and-Insight)
- [Recommendation](#Recommendation)
- [Conclusion](#Conclusion)

### Introduction
HR Data Analysis is the process of collecting, analyzing, and interpreting data related to human resources in an organization. The goal is to use this data to make informed decisions about hiring, employee performance, retention, training, and overall workforce management.
It involves working with data like:
- Employee demographics (age, gender, location).
- Job roles and departments.
- Hiring and attrition rates.
- Performance evaluations.
- Employee engagement surveys
  
By applying this analysis techniques, HR teams can identify trends, forecast future workforce needs, measure the impact of HR initiatives, and improve employee satisfaction and productivity.

### Dataset Overview 🧮
The dataset used in the analysis consisits of 22214 rows and 13 columns and 2 created column, here is a sample of the work.

![hr sample](https://github.com/user-attachments/assets/7459e341-76e1-40f9-88ee-f15cb56a65a5)

### Project Objective
You are tasked with analyzing this Hr dataset using SQL. Here are the business questions for which you will write SQL queries to gain insights.

Using the HR Management data, your company requires you to delve into data analysis using SQL to 
uncover insights for HR department, in other to make an 
informed decisions and strategic workforce planning. 

NOTE: Clean data if required 
1. What is the gender breakdown in the Company? 
2. How many employees work remotely for each department? 
3. What is the distribution of employees who work remotely and HQ 
4. What is the race distribution in the Company? 
5. What is the distribution of employee across different states? 
6. What is the number of employees whose employment has been terminated?
7. Who is/are the longest serving employee in the organization. 
8. Return the terminated employees by their race.
9. What is the age distribution in the Company? 
10. How have employee hire counts varied over time? 
11. What is the tenure distribution for each department? 
12. What is the average length of employment in the company? 
13. Which department has the highest turnover rate? 

### Data Cleaning🧹
1. Putting the Date in Birthdate column in order
```sql
set sql_safe_updates=0;
update hr_data set birthdate= replace(birthdate,'-','/');
update hr_data set birthdate= str_to_date(birthdate, '%m/%d/%Y');
select * from hr_data;
select birthdate from hr_data where birthdate > current_date() order by birthdate desc;
update hr_data set birthdate= date_sub(birthdate,interval 100 year) where birthdate between '2065-11-01' and '2069-12-12';
```

2. Adding a new column for full name for easy access to employee name
```sql
alter table hr_data add column full_name varchar(100);
update hr_data set full_name= concat(first_name,' ',last_name);
```
