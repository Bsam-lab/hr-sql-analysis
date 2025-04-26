select * from hr_data;
-- add a column for full name
alter table hr_data add column full_name varchar(100);
update hr_data set full_name= concat(first_name,' ',last_name);

-- clone it
create table hr_data_clone as select * from hr_data;

-- birthdate
set sql_safe_updates=0;
update hr_data set birthdate= replace(birthdate,'-','/');
update hr_data set birthdate= str_to_date(birthdate, '%m/%d/%Y');
select * from hr_data;
select birthdate from hr_data where birthdate > current_date() order by birthdate desc;
update hr_data set birthdate= date_sub(birthdate,interval 100 year) where birthdate between '2065-11-01' and '2069-12-12';

-- create age column
alter table hr_data add column age int;
select birthdate,round(datediff(current_date(),birthdate)/365,0) as age from hr_data;
update hr_data set age= round(datediff(current_date(),birthdate)/365,0);

-- question
-- 1. What is the gender breakdown in the Company? 
select gender, count(gender) as gender_no from hr_data group by gender;

-- 2. How many employees work remotely for each department? 
select * from hr_data;
select department, count(department) as count from hr_data where location = 'Remote'group by department order by count desc;

-- 3. What is the distribution of employees who work remotely and HQ 
select location, count(location) as total_employees from hr_data group by location order by 2 desc;

-- 4. What is the race distribution in the Company? 
select race, count(race) as count from hr_data group by race;

-- 5. What is the distribution of employee across different states? 
select location_state,count(location_state) as count from hr_data group by location_state order by 2 desc;

-- 6. What is the number of employees whose employment has been terminated 
select count(terminate_date) as no from hr_data where terminate_date < current_date() and terminate_date !='';

-- 7. Who is/are the longest serving employee in the organization. 
select full_name,hire_date from hr_data order by 2 asc limit 1;

-- 8. Return the terminated employees by their race 
select * from hr_data;
select full_name,terminate_date,race from hr_data where terminate_date < current_date() and terminate_date != '';

-- 9. What is the age distribution in the Company? 
select case when age between 0 and 20 then 'young' when age between 21 and 40 then 'adult' else 'old' end as distribution,count(*) as number_of_distribution
from hr_data group by 1;

-- 10. How have employee hire counts varied over time? 
select case when year(hire_date) between '2000' and '2005' then 'old employee' when year(hire_date) between '2006' and '2010' then '2nd generation employer'
when year(hire_date) between '2011' and '2015' then '3rd generation employer' else 'recent employer' end as rating, count(*) as count from hr_data group by 1; 

-- 11. What is the tenure distribution for each department? 
select department, concat(floor(avg(datediff(current_date(),hire_date)/365)),' ','years') as tenure from hr_data group by department order by 2 desc;

-- 12. What is the average length of employment in the company?
select concat(floor(avg(datediff(current_date(),hire_date)/365)),' ','years') as tenure from hr_data;
 
-- 13. Which department has the highest turnover rate?
select * from hr_data;
select department, count(department) as count from hr_data group by department order by 2 desc limit 1;