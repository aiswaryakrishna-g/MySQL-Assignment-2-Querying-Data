# MySQL Assignments: Employee Database

**Author:** Aiswarya Krishna G
**Tools:** MySQL 8.0, MySQL Workbench

This repository contains my solutions for two MySQL assignments built on one `employee` database:

- **Part 1 (Assignment 1):** DDL Commands & Constraints
- **Part 2 (Assignment 2):** Querying Data

---

## Table of Contents

1. [Database Schema](#database-schema)
2. [Repository Structure](#repository-structure)
3. [How to Run](#how-to-run)
4. [Part 1: DDL Commands & Constraints](#part-1-ddl-commands--constraints)
5. [Part 2: Querying Data](#part-2-querying-data)
6. [Key Learnings](#key-learnings)

---

## Database Schema

The `employee` database has three tables:

| Table | Columns |
|---|---|
| `departments` | `department_id` (PK), `department_name` |
| `location` | `location_id` (PK, auto-increment), `location` |
| `employees` | `employee_id` (PK), `employee_name`, `gender`, `age`, `hire_date`, `designation`, `department_id` (FK), `location_id` (FK), `salary` |

**Relationships:** one department has many employees, and one location has many employees.

> 📷 *Add your schema / EER diagram screenshot here:* `![Schema](screenshots/schema.png)`

---

## Repository Structure

```
.
├── README.md
├── assignment1_2_employee.sql      # Full script: DDL, constraints, data, queries
└── screenshots/                    # Query and output screenshots
```

---

## How to Run

1. Open **MySQL Workbench** and connect to your local MySQL 8.0 server.
2. Open `assignment1_2_employee.sql` (File → Open SQL Script).
3. Run it in sections (select a block and press `Ctrl + Enter`), or run the whole script with the lightning-bolt button.
4. If Workbench shows error 1175 on the `UPDATE`, run `SET SQL_SAFE_UPDATES = 0;` first (already included in the script).

> **Note:** `CHECK` constraints are only enforced from MySQL 8.0.16 onwards.

---

# Part 1: DDL Commands & Constraints

## 1. Table Creation (CREATE)

Created the `employee` database and the `departments`, `location` and `employees` tables.

```sql
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
```

## 2. Table Alteration (ALTER)

```sql
ALTER TABLE employees ADD COLUMN email VARCHAR(100);
ALTER TABLE employees MODIFY COLUMN designation VARCHAR(200);
ALTER TABLE employees DROP COLUMN age;
ALTER TABLE employees RENAME COLUMN hire_date TO date_of_joining;
```

| Change | Command used |
|---|---|
| Add `email` column | `ADD COLUMN` |
| Widen `designation` | `MODIFY COLUMN` |
| Remove `age` | `DROP COLUMN` |
| Rename `hire_date` | `RENAME COLUMN` |

## 3. Table Renaming (RENAME)

```sql
RENAME TABLE departments TO departments_info;
RENAME TABLE location TO locations;
```

## 4. Table Truncation (TRUNCATE)

```sql
TRUNCATE TABLE employees;
```

Removes all rows from `employees` but keeps the table structure.

## 5. Dropping (DROP)

```sql
DROP TABLE employees;
DROP DATABASE employee;
```

## 6. Constraints: Database Recreation

```sql
DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;
```

### Departments table

```sql
CREATE TABLE departments(
  department_id INT AUTO_INCREMENT PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL UNIQUE
);
```

- `PRIMARY KEY` makes `department_id` uniquely identify each department.
- `NOT NULL UNIQUE` on `department_name` prevents null and duplicate names.

### Location table

```sql
CREATE TABLE location (
  location_id INT AUTO_INCREMENT PRIMARY KEY,
  location VARCHAR(30) NOT NULL UNIQUE
);
```

- `AUTO_INCREMENT` generates sequential unique IDs.
- `NOT NULL UNIQUE` prevents null and duplicate locations.

### Employees table

```sql
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
```

| Requirement | How it is enforced |
|---|---|
| Distinct employee identifier | `PRIMARY KEY` on `employee_id` |
| Name always provided | `NOT NULL` on `employee_name` |
| Gender only `M` or `F` | `ENUM('M','F')` + `CHECK` |
| Age 18 or above | `CHECK (age >= 18)` |
| Default hire date | `DEFAULT (CURRENT_DATE)` |
| Links to other tables | `FOREIGN KEY` on `department_id` and `location_id` |

---

# Part 2: Querying Data

## Data Loading

Tables are populated in this order so the foreign keys are satisfied: `departments` (13 rows), then `location` (4 rows), then `employees` (30 rows).

```sql
SELECT COUNT(*) FROM departments;  -- 13
SELECT COUNT(*) FROM location;     -- 4
SELECT COUNT(*) FROM employees;    -- 30
```

## Basic Queries

### 1. Distinct values

```sql
SELECT DISTINCT salary FROM employees;
```

Returns 11 distinct salaries, from 45000 to 100000.

### 2. Alias (AS)

```sql
SELECT age AS Employee_Age, salary AS Employee_Salary FROM employees;
```

### 3. WHERE clause & operators

Salary above ₹50000 and hired before 2016-01-01:

```sql
SELECT * FROM employees
WHERE salary > 50000 AND hire_date < '2016-01-01';
```

Returns 5 employees (IDs 5001, 5002, 5004, 5005, 5006).

Find the employee with a missing designation and fill it in:

```sql
SELECT * FROM employees WHERE designation IS NULL;

SET SQL_SAFE_UPDATES = 0;

UPDATE employees
SET designation = 'Data Scientist'
WHERE designation IS NULL;

SELECT * FROM employees WHERE employee_id = 5004;
```

Employee 5004 (Kiara Malhotra) now has the designation "Data Scientist".

## Sorting and Grouping Data

### 4. ORDER BY

```sql
SELECT * FROM employees
ORDER BY department_id ASC, salary DESC;
```

### 5. LIMIT

First 5 employees hired in 2018:

```sql
SELECT * FROM employees
WHERE YEAR(hire_date) = 2018
ORDER BY hire_date
LIMIT 5;
```

Returns employees 5019 to 5023.

### 6. Aggregate functions

Total salary in the Finance department:

```sql
SELECT SUM(e.salary) AS total_finance_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';
```

**Result:** 170000

Minimum age:

```sql
SELECT MIN(age) AS min_age FROM employees;
```

**Result:** 25

### 7. GROUP BY

Maximum salary for each location:

```sql
SELECT l.location, MAX(e.salary) AS max_salary
FROM employees e
JOIN location l ON e.location_id = l.location_id
GROUP BY l.location;
```

| location | max_salary |
|---|---|
| Chennai | 95000 |
| Bangalore | 95000 |
| Hyderabad | 90000 |
| Pune | 100000 |

Average salary for designations containing "Analyst":

```sql
SELECT designation, AVG(salary) AS avg_salary
FROM employees
WHERE designation LIKE '%Analyst%'
GROUP BY designation;
```

### 8. HAVING

Departments with fewer than 3 employees:

```sql
SELECT d.department_name, COUNT(e.employee_id) AS emp_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3;
```

| department_name | emp_count |
|---|---|
| Software Development | 1 |
| Product Management | 2 |
| Content Creation | 2 |
| Finance | 2 |
| Research and Development | 1 |
| Business Development | 2 |
| Operations | 1 |

Locations where female employees' average age is below 30:

```sql
SELECT l.location, AVG(e.age) AS avg_age
FROM employees e
JOIN location l ON e.location_id = l.location_id
WHERE e.gender = 'F'
GROUP BY l.location
HAVING AVG(e.age) < 30;
```

| location | avg_age |
|---|---|
| Chennai | 26.75 |
| Bangalore | 27.33 |
| Pune | 29.20 |

Hyderabad is excluded because its female average age is 31.00.

## Joins

### 9. Inner join

Employee names, designations and department names:

```sql
SELECT e.employee_name, e.designation, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;
```

Returns all 30 employees, since each one belongs to a department.

### 10. Left join

All departments with their employee counts, including departments with none:

```sql
SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;
```

Returns all 13 departments. `COUNT(e.employee_id)` is used instead of `COUNT(*)` so that a department with no employees shows 0 rather than 1.

### 11. Right join

All locations with the employees assigned to each:

```sql
SELECT l.location, e.employee_name
FROM employees e
RIGHT JOIN location l ON e.location_id = l.location_id;
```

A location with no employees would show `NULL` for `employee_name`. In this dataset every location has employees, so no NULLs appear.

---

## Key Learnings

- The difference between `CREATE`, `ALTER`, `RENAME`, `TRUNCATE` and `DROP`.
- How `PRIMARY KEY`, `UNIQUE`, `NOT NULL`, `CHECK`, `DEFAULT` and `FOREIGN KEY` protect data quality.
- `WHERE` filters rows before grouping, while `HAVING` filters groups after aggregation.
- Table aliases (`e`, `d`, `l`) make joins shorter and avoid ambiguous column names.
- Inner, left and right joins differ in which rows are kept when there is no match.
- Use `IS NULL` (not `= NULL`) to find missing values.

---

## Screenshots

> Add your Workbench screenshots in the `screenshots/` folder and link them here, for example:
>
> `![Distinct salaries](screenshots/q1_distinct_salary.png)`
