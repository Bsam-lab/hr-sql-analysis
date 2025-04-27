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

2. Adding a new column for full name for easy access to employee name.
```sql
alter table hr_data add column full_name varchar(100);
update hr_data set full_name= concat(first_name,' ',last_name);
```

3. Creating a new column for age, for easy acess to employee age.
```sql
alter table hr_data add column age int;
select birthdate,round(datediff(current_date(),birthdate)/365,0) as age from hr_data;
update hr_data set age= round(datediff(current_date(),birthdate)/365,0);
```

4. Cloning the table
```sql
create table hr_data_clone as select * from hr_data;
```

### Data Exploration and Insight
1. Basic Data Exploration🔍

   ✅Action
   - Each Employee have a unique id and their department which they work in is specified coupled with their hire date and working status whether contract staff or full staff of the company.
   - Each column is assign with the suitable data type.
   - Summary statistics

   💡Insight
   - In the dataset the inconsistent and missing data is check and change to the appropiate one.
   - Spot outliers in numeric columns.
   - Understand distributions of age, tenure, etc.

3. Demographics & Diversity

   ✅Action
   - Count of employees by gender, age, location, race.

   💡Insight
   - Gender balance in the workforce

4. Performance & Satisfaction

   ✅Action
   - Correlate performance rating with tenure.
   - Distribution of employees who work remotely and physically.

   💡Insigt
   - Higher tenure employee get acknowledgement and get higher paid.
   - The ratio of employee who work remotely and Physically is generated to know mode of work of next hired employee.

### Recommendation
🧍‍♀Employee Retention
    - Implement stay interviews for employees at risk of leaving (e.g., low tenure + low satisfaction).
    - Create personalized retention plans for high-performing employees in high-attrition departments.
    - Identify exit patterns and address root causes (e.g., low satisfaction, poor work-life balance).

  🏢 Diversity & Inclusion
    - Monitor diversity metrics (e.g., gender, age, ethnicity) by role and department.
    - Promote inclusive hiring practices to diversify candidate pipelines.
   
### Conclusion
The HR dataset reveals key insights into employee demographics, performance, satisfaction, and turnover. High attrition among new hires and certain departments suggests a need for stronger onboarding and retention strategies. Job satisfaction and performance are positively influenced by training and fair compensation, highlighting the value of targeted development programs. Additionally, disparities in pay and promotion rates indicate opportunities to improve equity and internal mobility. Overall, data-driven HR practices can enhance employee experience, reduce turnover, and support strategic workforce planning.
