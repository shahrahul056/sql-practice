/*
=====================================================
SQL Practice Project
Author  : Rahul Shah
Database: PostgreSQL 18
Tables  : employees, departments, staff, emp_practice
Topics  : SELECT, WHERE, GROUP BY, HAVING, JOINs,
          INSERT, UPDATE, DELETE
How to use: run SECTION 1 first, then run the queries
one by one (select a query, then press F5).
=====================================================
*/

-- =====================================================
-- SECTION 1: TABLE SETUP
-- =====================================================
drop table if exists staff;
drop table if exists departments;
drop table if exists employees;

create table employees (
  id int, name varchar(50), city varchar(50),
  department varchar(50), salary int
);
insert into employees values
(1, 'Amit', 'Mumbai', 'Testing', 35000),
(2, 'Neha', 'Pune', 'Support', 28000),
(3, 'Rohan', 'Mumbai', 'Data', 40000),
(4, 'Sneha', 'Thane', 'Testing', 32000),
(5, 'Karan', 'Pune', 'Data', 45000),
(6, 'Pooja', 'Mumbai', 'Support', 26000),
(7, 'Vikas', 'Nashik', 'Testing', 30000),
(8, 'Anjali', 'Thane', 'Data', 38000);

create table departments (
  dept_id int, dept_name varchar(50), location varchar(50)
);
insert into departments values
(1, 'Testing', 'Mumbai'),
(2, 'Support', 'Pune'),
(3, 'Data', 'Thane'),
(4, 'HR', 'Nashik');

create table staff (
  id int, name varchar(50), dept_id int, salary int
);
insert into staff values
(1, 'Amit', 1, 35000),
(2, 'Neha', 2, 28000),
(3, 'Rohan', 3, 40000),
(4, 'Sneha', 1, 32000),
(5, 'Karan', 3, 45000),
(6, 'Pooja', 2, 26000),
(7, 'Vikas', NULL, 30000);

-- =====================================================
-- SECTION 2: BASIC QUERIES (SELECT, WHERE, ORDER BY)
-- =====================================================

-- Q1: Mumbai employees earning more than 30000
select * from employees
where city = 'Mumbai' and salary > 30000;

-- Q2: Top 3 highest paid employees
select * from employees
order by salary desc
limit 3;

-- Q3: Employees from Mumbai or Pune, highest salary first
select name, city, salary from employees
where city in ('Mumbai', 'Pune')
order by salary desc;

-- Q4: Names ending with 'a' (case-insensitive)
select * from employees
where name ilike '%a';

-- Q5: Salary between 28000 and 35000
select * from employees
where salary between 28000 and 35000;

-- =====================================================
-- SECTION 3: GROUP BY AND HAVING
-- =====================================================

-- Q6: Number of employees in each city
select city, count(*) as total_employees
from employees
group by city;

-- Q7: Average salary of each department (2 decimals)
select department, round(avg(salary), 2) as avg_salary
from employees
group by department;

-- Q8: Departments with more than 2 employees
select department, count(*)
from employees
group by department
having count(*) > 2;

-- Q9: City with the highest total salary
select city, sum(salary) as total_salary
from employees
group by city
order by sum(salary) desc
limit 1;

-- Q10: Employees earning 30000 or more, counted per department
select department, count(*)
from employees
where salary >= 30000
group by department;

-- =====================================================
-- SECTION 4: JOINS
-- =====================================================

-- Q11: Staff name with department name (INNER JOIN)
select s.name, d.dept_name
from staff s
inner join departments d on s.dept_id = d.dept_id;

-- Q12: Staff of the Data department with salary (INNER JOIN + WHERE)
select s.name, s.salary
from staff s
inner join departments d on s.dept_id = d.dept_id
where d.dept_name = 'Data';

-- Q13: All staff, even those without a department (LEFT JOIN)
select s.name, d.dept_name
from staff s
left join departments d on s.dept_id = d.dept_id;

-- Q14: Staff who have no department (LEFT JOIN + IS NULL)
select s.name
from staff s
left join departments d on s.dept_id = d.dept_id
where d.dept_id is null;

-- Q15: Staff count per department, HR shows 0 (count a column, not *)
select d.dept_name, count(s.id) as total_staff
from departments d
left join staff s on s.dept_id = d.dept_id
group by d.dept_name;

-- Q16: Departments with total salary above 60000, highest first
select d.dept_name, sum(s.salary) as total_salary
from staff s
inner join departments d on s.dept_id = d.dept_id
group by d.dept_name
having sum(s.salary) > 60000
order by sum(s.salary) desc;

-- =====================================================
-- SECTION 5: INSERT, UPDATE, DELETE
-- (works on a separate copy so the main tables stay safe)
-- =====================================================

-- Q17: Create a practice table with a primary key (copy of employees)
drop table if exists emp_practice;
create table emp_practice (
  id int primary key, name varchar(50) not null,
  city varchar(50), department varchar(50), salary int
);
insert into emp_practice select * from employees;

-- Q18: INSERT one new employee
insert into emp_practice (id, name, city, department, salary)
values (9, 'Riya', 'Nashik', 'Support', 27000);

-- Q19: UPDATE one employee's salary (check with select first)
select * from emp_practice where name = 'Neha';
update emp_practice set salary = 33000 where name = 'Neha';

-- Q20: UPDATE many rows, +1000 for everyone in Testing
update emp_practice
set salary = salary + 1000
where department = 'Testing';

-- Q21: DELETE employees earning less than 28000 (check with select first)
select * from emp_practice where salary < 28000;
delete from emp_practice where salary < 28000;

-- Q22: Final check, employees per department
select department, count(*) from emp_practice group by department;

-- Q23: Check the final state of emp_practice
select * from emp_practice order by id;

-- =====================================================
-- SECTION 6: SUBQUERIES, DUPLICATES AND NULL HANDLING
-- =====================================================
drop table if exists dup_demo;
create table dup_demo (id int, name varchar(50), city varchar(50));
insert into dup_demo values
(1, 'Amit', 'Mumbai'),
(2, 'Neha', 'Pune'),
(3, 'Amit', 'Mumbai'),
(4, 'Rohan', 'Thane'),
(5, 'Neha', 'Pune'),
(6, 'Neha', 'Pune');

-- Q24: Employees earning more than the average salary (subquery)
select name, salary from employees
where salary > (select avg(salary) from employees);

-- Q25: Employee with the minimum salary (subquery)
select name, salary from employees
where salary = (select min(salary) from employees);

-- Q26: Second highest salary
select max(salary) from employees
where salary < (select max(salary) from employees);

-- Q27: Employees earning more than Sneha (value comes from the subquery)
select name, salary from employees
where salary > (select salary from employees where name = 'Sneha');

-- Q28: Staff whose department is located in Pune (IN with subquery)
select name from staff
where dept_id in (select dept_id from departments where location = 'Pune');

-- Q29: Find duplicate records (same name and city)
select name, city, count(*) as times
from dup_demo
group by name, city
having count(*) > 1;

-- Q30: Unique records only (DISTINCT)
select distinct name, city from dup_demo;

-- Q31: Delete duplicates, keep the smallest id of each group
-- (run only once. To practise again, re-run the dup_demo setup above)
delete from dup_demo
where id not in (select min(id) from dup_demo group by name, city);

-- Q32: Replace NULL department with a default value (COALESCE)
select s.name, coalesce(d.dept_name, 'No Department') as department
from staff s
left join departments d on s.dept_id = d.dept_id;

-- Q33: Total rows vs rows that have a department (COUNT(*) vs COUNT(column))
select count(*), count(dept_id) from staff;