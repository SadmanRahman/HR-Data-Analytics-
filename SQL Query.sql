select * from compensation; 
select * from employee_information;
select * from performance_evaluation;
select * from training_and_development; 

-- Location wise employee
select 
	Location,
    count(employee_id) as Total_Employee
from employee_information
group by location 
order by Total_Employee desc;


-- Department Wise Employee
select 
	department, 
    count(employee_id) Total_employee
from employee_information
group by Department
order by total_employee desc; 


-- Department Wise Average Salary
with cte as (
select 
	e. employee_id,
    e. department,
    c. salary
from
	employee_information e
inner join
	compensation c 
on
	e. Employee_ID= c. Employee_ID)

select
		department, 
		round(avg(salary)) as avg_salary
from cte
	group by department
    order by avg_salary desc
;
    
-- Gender Wise Employee

SELECT 
    gender,
    COUNT(gender) AS gender_count,
    ROUND((COUNT(gender) / (SELECT COUNT(*) FROM employee_information)) * 100, 2) AS percentage
FROM 
    employee_information
GROUP BY 
    gender;


-- Department Wise no. of promotions

with cte as (
Select
	e. employee_id,
    e. department, 
    p. promotions
from
	employee_information as e
inner join
	performance_evaluation as p
on
	e. Employee_ID = p.Employee_ID)
    
select 	
	department, 
    sum(promotions) as No_of_Promotions
    from cte
group by department
order by No_of_Promotions desc
    ;
    
    
-- Employee INFO Table

select 
	e. Employee_id, 
    e. first_name, 
    e. department,
    c. salary,
    p. Promotions
from
	employee_information as e 
inner join
	compensation as c
on
	e. Employee_ID = c. Employee_ID
inner join
	performance_evaluation as p
on
	e. Employee_ID = p.Employee_ID
    ;

-- Visual Card-1
select 
	count(employee_id) as Total_no_of_employee
from 
	employee_information;

-- Visual Card-2
select 
	round(avg(salary))	as Avg_Salary
    from compensation;

-- Visual Card-3

with cte as (
SELECT 
    employee_id, 
    first_name, 
    last_name,
    gender, 
    date_of_birth, 
    department, 
    job_title,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS employees_age
FROM
    employee_information)
    
select 
    gender,
    avg(employees_age)
    from cte
group by gender
;

with cte as (
SELECT 
    employee_id, 
    first_name, 
    last_name,
    gender, 
    date_of_birth, 
    department, 
    job_title,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS employees_age
FROM
    employee_information)
    
select 

    avg(employees_age) as Average_Age
    from cte
;

-- visual card 4

with cte as (
SELECT 
    employee_id, 
    first_name, 
    gender, 
    hire_date, 
    department, 
    job_title,
    ROUND(
        TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) + 
        (MOD(TIMESTAMPDIFF(MONTH, hire_date, CURDATE()), 12) / 12), 1
    ) AS serving_period
FROM
    employee_information)

select 
	avg(serving_period)
    from cte
    ;
	
with cte as (
SELECT 
    employee_id, 
    first_name, 
    gender, 
    hire_date, 
    department, 
    job_title,
    ROUND(
        TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) + 
        (MOD(TIMESTAMPDIFF(MONTH, hire_date, CURDATE()), 12) / 12), 1
    ) AS serving_period
FROM
    employee_information)

select 
	gender,
    avg(serving_period) as average_serving_period
    from cte
group by gender
order by gender 
    ;
    
-- visual card 5

select 
	count(completion_status) as training_completed
from
	training_and_development
where 
	completion_status= 'completed'
    ;




    


    


    