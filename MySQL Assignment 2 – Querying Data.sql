/* DDL Commands :
1. Table Creation (CREATE): Write the SQL statements to create a database named “employee” and the following tables based on the provided schema:
⦿ Departments
⦿ Location
⦿ Employees*/

CREATE DATABASE employee;
USE employee;
CREATE TABLE departments(
department_id INT,
department_name VARCHAR(100)
);
CREATE TABLE location(
location_id INT,
location VARCHAR(30)
);
CREATE TABLE employees(
employee_id INT,
employee_name VARCHAR(50),
gender ENUM('M','F'),
age INT,
hire_date DATE,
designation VARCHAR(100),
department_id INT,
location_id INT,
salary DECIMAL(10,2)
);
/* 2. Table Alteration (ALTER): Consider the following scenarios and write the SQL statements to alter the structure of the tables accordingly:
⦿ Add a new column named "email" to the Employees table to store employee email addresses.
⦿ Modify the data type of the "designation" column in the Employees table to support a wider range of values.
⦿ Drop the “age” column from the Employees table.
⦿ Rename the “hire_date” column to “date_of_joining”. */

ALTER TABLE employees ADD COLUMN email VARCHAR(100);
ALTER TABLE employees MODIFY COLUMN designation VARCHAR(200);
ALTER TABLE employees DROP COLUMN age;
ALTER TABLE employees RENAME COLUMN hire_date TO date_of_joining;

/* 3. Table Renaming (RENAME): Rewrite the SQL statements to rename the following tables:
⦿ Rename the "Departments" table to "Departments_Info".
⦿ Rename the "Location" table to "Locations". */

RENAME TABLE departments TO departments_info;
RENAME TABLE location TO locations;

/* 4. Table Truncation (TRUNCATE): Write an SQL statement to truncate the Employees table. */

TRUNCATE TABLE employees;

/* 5. Database & Table Dropping (DROP): Write the SQL statements to drop the Employees table and then the “employee” database.*/

DROP TABLE employees;
DROP DATABASE employee;

/* Constraints :
1. Database Recreation:
⦿ Drop the 'employee' database if it exists and recreate it using the provided schema, ensuring that all tables are created with the appropriate constraints as instructed. */

DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

/* 2. Departments Table:
⦿ Ensure that the "department_id" uniquely identifies each department.
⦿ Set up constraints on the "department_name" to avoid duplicate and null entries.*/

CREATE TABLE departments(
department_id int auto_increment PRIMARY KEY,
department_name VARCHAR(100) NOT NULL UNIQUE
);

/* 3. Location Table:
⦿ Establish a mechanism to automatically generate unique identifiers for each location, ensuring that they are incremented sequentially.
⦿ Implement constraints to prevent the insertion of null and duplicate locations.*/

CREATE TABLE location (
  location_id INT AUTO_INCREMENT PRIMARY KEY,
  location VARCHAR(30) NOT NULL UNIQUE
);

/* 4. Employees Table:
⦿ Guarantee that each employee has a distinct identifier.
⦿ Create a restriction to ensure that the employee's name is always provided.
⦿ Limit the acceptable values for the "gender" field to only 'M' or 'F'.
⦿ Enforce a condition to ensure that the employee's age is 18 or above.
⦿ Automatically assign the current date to the "hire_date" field if not specified.
⦿ Establish links between the "department_id" and "location_id" fields in the "employees" table and their respective tables. */

CREATE TABLE employees (
  employee_id   INT PRIMARY KEY,
  employee_name VARCHAR(50) NOT NULL,
  gender        ENUM('M','F'),
  age           INT,
  hire_date     DATE DEFAULT (CURRENT_DATE),
  designation   VARCHAR(200),
  department_id INT,
  location_id   INT,
  salary        DECIMAL(10,2),
  CONSTRAINT chk_gender CHECK (gender IN ('M','F')),
  CONSTRAINT chk_age    CHECK (age >= 18),
  CONSTRAINT fk_emp_dept FOREIGN KEY (department_id)
    REFERENCES departments(department_id),
  CONSTRAINT fk_emp_loc  FOREIGN KEY (location_id)
    REFERENCES location(location_id)
);

USE employee;

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Software Development'),
(2, 'Marketing'),
(3, 'Data Science'),
(4, 'Human Resources'),
(5, 'Product Management'),
(6, 'Content Creation'),
(7, 'Finance'),
(8, 'Design'),
(9, 'Research and Development'),
(10, 'Customer Support'),
(11, 'Business Development'),
(12, 'IT'),
(13, 'Operations');

SELECT * FROM DEPARTMENTS;

INSERT INTO location (location) VALUES
('Chennai'),
('Bangalore'),
('Hyderabad'),
('Pune');
SELECT * FROM LOCATION;

INSERT INTO employees (employee_id, employee_name, gender, age, hire_date, designation, department_id, location_id, salary) VALUES
(5001, 'Vihaan Singh', 'M', 27, '2015-01-20', 'Data Analyst', 3, 4, 60000),
(5002, 'Reyansh Singh', 'M', 31, '2015-03-10', 'Network Engineer', 12, 1, 80000),
(5003, 'Aaradhya Iyer', 'F', 26, '2015-05-20', 'Customer Support Executive', 10, 2, 45000),
(5004, 'Kiara Malhotra', 'F', 29, '2015-07-05', NULL, 8, 3, 70000),
(5005, 'Anvi Chaudhary', 'F', 25, '2015-09-11', 'Business Development Executive', 11, 1, 55000),
(5006, 'Dhruv Shetty', 'M', 28, '2015-11-20', 'UI Developer', 8, 2, 65000),
(5007, 'Anushka Singh', 'F', 32, '2016-01-15', 'Marketing Manager', 2, 3, 90000),
(5008, 'Diya Jha', 'F', 27, '2016-03-05', 'Graphic Designer', 8, 4, 70000),
(5009, 'Kiaan Desai', 'M', 30, '2016-05-20', 'Sales Executive', 11, 3, 55000),
(5010, 'Atharv Yadav', 'M', 29, '2016-07-10', 'Systems Administrator', 12, 4, 80000),
(5011, 'Saanvi Patel', 'F', 28, '2016-09-20', 'Marketing Analyst', 2, 1, 60000),
(5012, 'Myra Verma', 'F', 26, '2016-11-05', 'Operations Manager', 13, 2, 95000),
(5013, 'Arnav Rao', 'M', 33, '2017-01-20', 'Customer Success Manager', 10, 3, 75000),
(5014, 'Vihaan Mohan', 'M', 30, '2017-03-10', 'Supply Chain Analyst', 10, 2, 60000),
(5015, 'Ishaan Kumar', 'M', 27, '2017-05-20', 'Financial Analyst', 7, 1, 85000),
(5016, 'Zoya Khan', 'F', 31, '2017-07-05', 'Legal Counsel', 4, 4, 100000),
(5017, 'Kabir Nair', 'M', 28, '2017-09-11', 'IT Support Specialist', 12, 2, 80000),
(5018, 'Ishan Mishra', 'M', 25, '2017-11-20', 'Research Scientist', 9, 3, 75000),
(5019, 'Ishika Patel', 'F', 29, '2018-01-15', 'Talent Acquisition Specialist', 4, 4, 55000),
(5020, 'Aarav Nair', 'M', 32, '2018-03-05', 'Software Engineer', 1, 1, 90000),
(5021, 'Advik Kapoor', 'M', 26, '2018-05-20', 'Finance Analyst', 7, 3, 85000),
(5022, 'Aadhya Iyengar', 'F', 28, '2018-07-10', 'HR Specialist', 4, 4, 60000),
(5023, 'Anika Paul', 'F', 30, '2018-09-20', 'Public Relations Specialist', 2, 2, 70000),
(5024, 'Aryan Shetty', 'M', 27, '2018-11-05', 'Product Manager', 5, 1, 95000),
(5025, 'Avni Iyengar', 'F', 31, '2019-01-20', 'Data Scientist', 3, 4, 100000),
(5026, 'Vivaan Singh', 'M', 29, '2019-03-10', 'Business Analyst', 3, 2, 75000),
(5027, 'Ananya Paul', 'F', 32, '2019-05-20', 'Content Writer', 6, 3, 60000),
(5028, 'Anaya Kapoor', 'F', 26, '2019-07-05', 'Event Coordinator', 6, 1, 60000),
(5029, 'Arjun Kumar', 'M', 33, '2019-09-11', 'Quality Assurance Analyst', 12, 2, 80000),
(5030, 'Sara Iyer', 'F', 28, '2019-11-20', 'Project Manager', 5, 1, 90000);


SELECT * FROM employees;
USE employee;
SELECT COUNT(*) FROM departments;  -- expect 13
SELECT COUNT(*) FROM location;      -- expect 4
SELECT COUNT(*) FROM employees;     -- expect 30

SELECT DISTINCT salary FROM employees; -- a query to retrieve distinct salaries from the Employees table.
SELECT age AS Employee_Age, salary AS Employee_Salary FROM employees; --  Provide aliases for the "age" and "salary" columns as "Employee_Age" and "Employee_Salary", respectively.

/* Where Clause & Operators: 
⦿  Retrieve employees with a salary greater than ₹50000 and hired before 
2016-01-01. */
SELECT * FROM employees
WHERE salary > 50000 AND hire_date < '2016-01-01';

/*Find the employee whose designation is missing and fill it with "Data 
Scientist".*/
SELECT * FROM employees WHERE designation IS NULL;

SET SQL_SAFE_UPDATES = 0;

UPDATE employees
SET designation = 'Data Scientist'
WHERE designation IS NULL;

SELECT * FROM employees WHERE employee_id = 5004;

/*Sorting and Grouping Data: 
1. ORDER BY: 
⦿  Find employees sorted by department ID in ascending order and salary in 
descending order. */
SELECT * FROM employees
ORDER BY department_id ASC, salary DESC;

/*LIMIT: 
⦿  Display the first 5 employees hired in the year 2018.*/
SELECT * FROM employees
WHERE YEAR(hire_date) = 2018
ORDER BY hire_date
LIMIT 5;

/* Aggregate Functions: 
⦿  Calculate the sum of all salaries in the Finance department. 
.*/
SELECT SUM(e.salary) AS total_finance_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

/*⦿  Find the minimum age among all employees*/
SELECT MIN(age) AS min_age FROM employees;

/* GROUP BY: 
⦿  List the maximum salary for each location. */
SELECT l.location, MAX(e.salary) AS max_salary
FROM employees e
JOIN location l ON e.location_id = l.location_id
GROUP BY l.location;

/*Calculate the average salary for each designation containing the word 
'Analyst'. */
SELECT designation, AVG(salary) AS avg_salary
FROM employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;

/*HAVING: 
⦿  Find departments with less than 3 employees.*/
SELECT d.department_name, COUNT(e.employee_id) AS emp_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3;

/*Find locations with female employees whose average age is below 30. */
SELECT l.location, AVG(e.age) AS avg_age
FROM employees e
JOIN location l ON e.location_id = l.location_id
WHERE e.gender = 'F'
GROUP BY l.location
HAVING AVG(e.age) < 30;

/*Inner Join: 
⦿  List employee names, their designations, and department names where 
employees are assigned to a department.*/
SELECT e.employee_name, e.designation, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

/* Left Join: 
⦿  List all departments along with the total number of employees in each 
department, including departments with no employees.*/
SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

/*Right Join: 
⦿  Display all locations along with the names of employees assigned to each 
location. If no employees are assigned to a location, display NULL for 
employee name.*/
SELECT l.location, e.employee_name
FROM employees e
RIGHT JOIN location l ON e.location_id = l.location_id;

