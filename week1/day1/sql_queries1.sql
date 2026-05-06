**Schema (MySQL v5.7)**

    -- Create Department table
    CREATE TABLE Department (
        department_id INT PRIMARY KEY,
        name VARCHAR(50) NOT NULL
    );
    
    -- Create Employee table
    CREATE TABLE Employee (
        emp_id INT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        age INT,
        salary DECIMAL(10, 2),
        department_id INT,
        hire_date DATE,
        FOREIGN KEY (department_id) REFERENCES Department(department_id)
    );
    
    -- Create Project table
    CREATE TABLE Project (
        project_id INT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        department_id INT,
        FOREIGN KEY (department_id) REFERENCES Department(department_id)
    );
    
    -- Insert data into Department table
    INSERT INTO Department (department_id, name) VALUES
    (1, 'IT'),
    (2, 'HR'),
    (3, 'Finance'),
    (4, 'Marketing');
    
    -- Insert data into Employee table
    INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
    (1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
    (2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
    (3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
    (4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
    (5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01'),
    (6, 'David Green', 38, 70000.00, 4, '2022-05-18'),
    (7, 'Eve Black', 40, 55000.00, 3, '2021-08-30');
    
    -- Insert data into Project table
    INSERT INTO Project (project_id, name, department_id) VALUES
    (1, 'Project Alpha', 1),
    (2, 'Project Beta', 2),
    (3, 'Project Gamma', 1),
    (4, 'Project Delta', 3),
    (5, 'Project Epsilon', 4),
    (6, 'Project Zeta', 4),
    (7, 'Project Eta', 3);
    
    
    -- Insert additional data into Department table (if needed)
    -- No additional departments needed for this data set
    
    -- Insert additional data into Employee table to test edge cases for joins and nested queries
    INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
    (8, 'Frank White', 32, 48000.00, NULL, '2021-07-10'),  -- Employee without a department
    (9, 'Grace Kelly', 27, 65000.00, 1, '2018-11-13'),
    (10, 'Hannah Lee', 30, 53000.00, 4, '2020-02-25');
    
    -- Insert additional data into Project table to test edge cases for joins
    INSERT INTO Project (project_id, name, department_id) VALUES
    (8, 'Project Theta', 1),
    (9, 'Project Iota', NULL);  -- Project without a department

---

**Query #1** : --1. Retrieve all columns from the Employee table.

    SELECT * FROM Employee;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |

---
**Query #2**--Retrieve only the name and salary columns from the Employee table.

    SELECT name, salary FROM Employee;

| name        | salary  |
| ----------- | ------- |
| John Doe    | 50000.0 |
| Jane Smith  | 60000.0 |
| Bob Brown   | 80000.0 |
| Alice Blue  | 45000.0 |
| Charlie P.  | 50000.0 |
| David Green | 70000.0 |
| Eve Black   | 55000.0 |
| Frank White | 48000.0 |
| Grace Kelly | 65000.0 |
| Hannah Lee  | 53000.0 |

---
**Query #3**--Retrieve employees who are older than 30.

    SELECT * FROM Employee WHERE age > 30;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |

---
**Query #4**--Retrieve the names of all departments.

    SELECT name FROM Department;

| name      |
| --------- |
| IT        |
| HR        |
| Finance   |
| Marketing |

---
**Query #5**--Retrieve employees who work in the IT department.

    SELECT * FROM Employee WHERE department_id = 1;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |

---
**Query #6**--Retrieve employees whose names start with 'J'.

    SELECT * FROM Employee WHERE name LIKE 'J%';

| emp_id | name       | age | salary  | department_id | hire_date  |
| ------ | ---------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe   | 28  | 50000.0 | 1             | 2020-01-15 |
| 2      | Jane Smith | 34  | 60000.0 | 2             | 2019-07-23 |

---
**Query #7**--Retrieve employees whose names end with 'e'.

    SELECT * FROM Employee WHERE name LIKE '%e';

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |

---
**Query #8**--Retrieve employees whose names contain 'a'.

    SELECT * FROM Employee WHERE name LIKE '%@%';

There are no results to be displayed.

---
**Query #9**--Retrieve employees whose names are exactly 9 characters long.

    SELECT * FROM Employee WHERE LENGTH(name) = 9;

| emp_id | name      | age | salary  | department_id | hire_date  |
| ------ | --------- | --- | ------- | ------------- | ---------- |
| 3      | Bob Brown | 45  | 80000.0 | 1             | 2018-02-12 |
| 7      | Eve Black | 40  | 55000.0 | 3             | 2021-08-30 |

---
**Query #10**--Retrieve employees whose names have 'o' as the second character.

    SELECT * FROM Employee WHERE name LIKE '__J%';

There are no results to be displayed.

---
**Query #11**--Retrieve employees hired in the year 2020.

    SELECT * FROM Employee WHERE YEAR(hire_date) = 2020;

| emp_id | name       | age | salary  | department_id | hire_date  |
| ------ | ---------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe   | 28  | 50000.0 | 1             | 2020-01-15 |
| 10     | Hannah Lee | 30  | 53000.0 | 4             | 2020-02-25 |

---
**Query #12**-- Retrieve employees hired in January of any year.

    SELECT *FROM Employee Where MONTH(hire_date)=01;

| emp_id | name     | age | salary  | department_id | hire_date  |
| ------ | -------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe | 28  | 50000.0 | 1             | 2020-01-15 |

---
**Query #13**--Retrieve employees hired before 2019.

    SELECT *FROM Employee Where YEAR(hire_date)<2019;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |

---
**Query #14**--Retrieve employees hired on or after March 1, 2021.

    SELECT *FROM Employee Where hire_date>='01-03-2021';

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |

---
**Query #15**--Retrieve employees hired in the last 2 years.

    SELECT *FROM Employee Where hire_date>=CURRENT_DATE-INTERVAL '2' year;

There are no results to be displayed.

---
**Query #16**--Retrieve the total salary of all employees.

    SELECT SUM(salary) AS total_salary FROM Employee;

| total_salary |
| ------------ |
| 576000.0     |

---
**Query #17**--Retrieve the average salary of employees.

    SELECT AVG(salary) AS avg_salary FROM Employee;

| avg_salary |
| ---------- |
| 57600.0    |

---
**Query #18**--Retrieve the minimum salary in the Employee table.

    SELECT MIN(salary) AS min_salary FROM Employee;

| min_salary |
| ---------- |
| 45000.0    |

---
**Query #19**--Retrieve the number of employees in each department.

    SELECT department_id,COUNT(*) as dept_count FROM Employee GROUP BY department_id;

| department_id | dept_count |
| ------------- | ---------- |
|               | 1          |
| 1             | 3          |
| 2             | 2          |
| 3             | 2          |
| 4             | 2          |

---
**Query #20**--Retrieve the average salary of employees in each department.

    SELECT department_id,AVG(salary) as dept_avg FROM Employee GROUP BY department_id;

| department_id | dept_avg |
| ------------- | -------- |
|               | 48000.0  |
| 1             | 65000.0  |
| 2             | 55000.0  |
| 3             | 50000.0  |
| 4             | 61500.0  |

---
**Query #21**--Retrieve the total salary for each department.

    SELECT department_id,SUM(salary) as dept_total FROM Employee GROUP BY department_id;

| department_id | dept_total |
| ------------- | ---------- |
|               | 48000.0    |
| 1             | 195000.0   |
| 2             | 110000.0   |
| 3             | 100000.0   |
| 4             | 123000.0   |

---
**Query #22**--Retrieve the average age of employees in each department.

    SELECT department_id,AVG(salary) as dept_avg FROM Employee GROUP BY department_id;

| department_id | dept_avg |
| ------------- | -------- |
|               | 48000.0  |
| 1             | 65000.0  |
| 2             | 55000.0  |
| 3             | 50000.0  |
| 4             | 61500.0  |

---
**Query #23**--Retrieve the number of employees hired in each year.

    SELECT YEAR(hire_date) as total_count FROM Employee GROUP BY Year(hire_date);

| total_count |
| ----------- |
| 2018        |
| 2019        |
| 2020        |
| 2021        |
| 2022        |

---
**Query #24**--Retrieve the highest salary in each department.

    SELECT department_id,MAX(salary) as dept_max FROM Employee GROUP BY department_id;

| department_id | dept_max |
| ------------- | -------- |
|               | 48000.0  |
| 1             | 80000.0  |
| 2             | 60000.0  |
| 3             | 55000.0  |
| 4             | 70000.0  |

---
**Query #25**--Retrieve the department with the highest average salary.

    SELECT MAX(dept_avg) AS high_avg
    FROM (
        SELECT department_id, AVG(salary) AS dept_avg
        FROM Employee
        GROUP BY department_id
    ) AS subquery;

| high_avg |
| -------- |
| 65000.0  |

---
**Query #26**--Retrieve departments with more than 2 employees.

    SELECT department_id,COUNT(*) as total_count FROM Employee GROUP BY department_id
    HAVING total_count>2;

| department_id | total_count |
| ------------- | ----------- |
| 1             | 3           |

---
**Query #27**--Retrieve departments with an average salary greater than 55000.

    SELECT department_id,AVG(salary) as avg_salary FROM Employee GROUP BY department_id
    HAVING avg_salary>55000;

| department_id | avg_salary |
| ------------- | ---------- |
| 1             | 65000.0    |
| 4             | 61500.0    |

---
**Query #28**--Retrieve years with more than 1 employee hired.

    SELECT YEAR(hire_date) as total_count FROM Employee GROUP BY Year(hire_date)
    HAVING total_count>1;

| total_count |
| ----------- |
| 2018        |
| 2019        |
| 2020        |
| 2021        |
| 2022        |

---
**Query #29**-- Retrieve departments with a total salary expense less than 100000.

    SELECT department_id,SUM(salary) as dept_total FROM Employee GROUP BY department_id
    HAVING dept_total<100000;

| department_id | dept_total |
| ------------- | ---------- |
|               | 48000.0    |

---
**Query #30**--Retrieve departments with the maximum salary above 75000.

    SELECT department_id,MAX(salary) as dept_max FROM Employee GROUP BY department_id
    HAVING dept_max<75000;

| department_id | dept_max |
| ------------- | -------- |
|               | 48000.0  |
| 2             | 60000.0  |
| 3             | 55000.0  |
| 4             | 70000.0  |

---
**Query #31**-- Retrieve all employees ordered by their salary in ascending order.

    SELECT *FROM Employee ORDER BY(salary);

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |

---
**Query #32**--Retrieve all employees ordered by their age in descending order.

    SELECT *FROM Employee ORDER BY(salary) DESC;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |

---
**Query #33**--Retrieve all employees ordered by their hire date in ascending order.

    SELECT *FROM Employee ORDER BY Year(hire_date);

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |

---
**Query #34**--Retrieve employees ordered by their department and then by their salary.

    SELECT *FROm Employee ORDER BY department_id, salary;

| emp_id | name        | age | salary  | department_id | hire_date  |
| ------ | ----------- | --- | ------- | ------------- | ---------- |
| 8      | Frank White | 32  | 48000.0 |               | 2021-07-10 |
| 1      | John Doe    | 28  | 50000.0 | 1             | 2020-01-15 |
| 9      | Grace Kelly | 27  | 65000.0 | 1             | 2018-11-13 |
| 3      | Bob Brown   | 45  | 80000.0 | 1             | 2018-02-12 |
| 5      | Charlie P.  | 29  | 50000.0 | 2             | 2019-12-01 |
| 2      | Jane Smith  | 34  | 60000.0 | 2             | 2019-07-23 |
| 4      | Alice Blue  | 25  | 45000.0 | 3             | 2021-03-22 |
| 7      | Eve Black   | 40  | 55000.0 | 3             | 2021-08-30 |
| 10     | Hannah Lee  | 30  | 53000.0 | 4             | 2020-02-25 |
| 6      | David Green | 38  | 70000.0 | 4             | 2022-05-18 |

---
**Query #35**-- Retrieve departments ordered by the total salary of their employees.

    SELECT department_id, SUM(salary) AS dept_total FROM Employee GROUP BY department_id ORDER BY dept_total;

| department_id | dept_total |
| ------------- | ---------- |
|               | 48000.0    |
| 3             | 100000.0   |
| 2             | 110000.0   |
| 4             | 123000.0   |
| 1             | 195000.0   |

---
**Query #36**--Retrieve employee names along with their department names.

    SELECT e.name AS emply_name , d.name AS dept_name FROM Employee e INNER JOIN Department d ON e.department_id=d.department_id;

| emply_name  | dept_name |
| ----------- | --------- |
| John Doe    | IT        |
| Bob Brown   | IT        |
| Grace Kelly | IT        |
| Jane Smith  | HR        |
| Charlie P.  | HR        |
| Alice Blue  | Finance   |
| Eve Black   | Finance   |
| David Green | Marketing |
| Hannah Lee  | Marketing |

---
**Query #37**--Retrieve project names along with the department names they belong to.

    SELECT p.name AS project_name, d.name AS dept_name FROM Project p INNER JOIN Department d ON p.department_id=d.department_id;

| project_name    | dept_name |
| --------------- | --------- |
| Project Alpha   | IT        |
| Project Gamma   | IT        |
| Project Theta   | IT        |
| Project Beta    | HR        |
| Project Delta   | Finance   |
| Project Eta     | Finance   |
| Project Epsilon | Marketing |
| Project Zeta    | Marketing |

---
**Query #38**--Retrieve employee names and their corresponding project names.

    SELECT e.name AS emp_name, p.name AS project_name FROM Employee e INNER JOIN Project p ON e.department_id=p.department_id;

| emp_name    | project_name    |
| ----------- | --------------- |
| John Doe    | Project Alpha   |
| Bob Brown   | Project Alpha   |
| Grace Kelly | Project Alpha   |
| Jane Smith  | Project Beta    |
| Charlie P.  | Project Beta    |
| John Doe    | Project Gamma   |
| Bob Brown   | Project Gamma   |
| Grace Kelly | Project Gamma   |
| Alice Blue  | Project Delta   |
| Eve Black   | Project Delta   |
| David Green | Project Epsilon |
| Hannah Lee  | Project Epsilon |
| David Green | Project Zeta    |
| Hannah Lee  | Project Zeta    |
| Alice Blue  | Project Eta     |
| Eve Black   | Project Eta     |
| John Doe    | Project Theta   |
| Bob Brown   | Project Theta   |
| Grace Kelly | Project Theta   |

---
**Query #39**--Retrieve all employees and their departments, including those without a department.

    SELECT e.name AS emp_name,d.name AS dept_name FROM Employee e LEFT JOIN Department d ON e.department_id=d.department_id;

| emp_name    | dept_name |
| ----------- | --------- |
| John Doe    | IT        |
| Bob Brown   | IT        |
| Grace Kelly | IT        |
| Jane Smith  | HR        |
| Charlie P.  | HR        |
| Alice Blue  | Finance   |
| Eve Black   | Finance   |
| David Green | Marketing |
| Hannah Lee  | Marketing |
| Frank White |           |

---
**Query #40**--Retrieve all departments and their employees, including departments without employees.

    SELECT e.name AS emp_name,d.name AS dept_name FROM Employee e RIGHT JOIN Department d ON e.department_id=d.department_id;

| emp_name    | dept_name |
| ----------- | --------- |
| John Doe    | IT        |
| Bob Brown   | IT        |
| Grace Kelly | IT        |
| Jane Smith  | HR        |
| Charlie P.  | HR        |
| Alice Blue  | Finance   |
| Eve Black   | Finance   |
| David Green | Marketing |
| Hannah Lee  | Marketing |

---
**Query #41**--Retrieve employees who are not assigned to any project.

    SELECT e.emp_id, e.name AS employee_name FROM 
    Employee e LEFT JOIN Project p ON
    e.department_id = p.department_id WHERE 
    p.project_id IS NULL;

| emp_id | employee_name |
| ------ | ------------- |
| 8      | Frank White   |

---
**Query #42**--Retrieve employees and the number of projects their department is working on.

    SELECT e.emp_id,
           e.name AS employee_name,
           COUNT(p.project_id) AS number_of_projects
    FROM Employee e
    LEFT JOIN Project p
    ON e.department_id = p.department_id
    GROUP BY e.emp_id, e.name;

| emp_id | employee_name | number_of_projects |
| ------ | ------------- | ------------------ |
| 1      | John Doe      | 3                  |
| 2      | Jane Smith    | 1                  |
| 3      | Bob Brown     | 3                  |
| 4      | Alice Blue    | 2                  |
| 5      | Charlie P.    | 1                  |
| 6      | David Green   | 2                  |
| 7      | Eve Black     | 2                  |
| 8      | Frank White   | 0                  |
| 9      | Grace Kelly   | 3                  |
| 10     | Hannah Lee    | 2                  |

---
**Query #43**--Retrieve departments that have no employees.

    SELECT e.name AS emp_name,d.department_id FROM Employee e LEFT JOIN Department d ON e.department_id =d.department_id WHERE d.department_id IS NULL;

| emp_name    | department_id |
| ----------- | ------------- |
| Frank White |               |

---
**Query #44**--Retrieve employee names who share the same department with 'John Doe'.

    SELECT e.name AS emp_name ,d.department_id FROM Employee e LEFT JOIN Department d ON d.department_id=d.department_id WHERE d.department_id=1;

| emp_name    | department_id |
| ----------- | ------------- |
| John Doe    | 1             |
| Jane Smith  | 1             |
| Bob Brown   | 1             |
| Alice Blue  | 1             |
| Charlie P.  | 1             |
| David Green | 1             |
| Eve Black   | 1             |
| Frank White | 1             |
| Grace Kelly | 1             |
| Hannah Lee  | 1             |

---
**Query #45**--Retrieve the department name with the highest average salary.

    SELECT d.name AS department_name
    FROM Department d JOIN Employee e ON d.department_id = e.department_id
    GROUP BY d.name ORDER BY AVG(e.salary) DESC LIMIT 1;

| department_name |
| --------------- |
| IT              |

---
**Query #46**--Retrieve the employee with the highest salary.

    SELECT name,salary FROM Employee WHERE salary=(SELECT MAX(salary) FROM Employee);

| name      | salary  |
| --------- | ------- |
| Bob Brown | 80000.0 |

---
**Query #47**--Retrieve employees whose salary is above the average salary.

    SELECT name,salary FROM Employee WHERE salary>(SELECT AVG(salary) FROM Employee);

| name        | salary  |
| ----------- | ------- |
| Jane Smith  | 60000.0 |
| Bob Brown   | 80000.0 |
| David Green | 70000.0 |
| Grace Kelly | 65000.0 |

---
**Query #48**--Retrieve the second highest salary from the Employee table.

    SELECT MAX(salary) AS second_highest_salary FROM Employee WHERE salary < (SELECT MAX(salary) FROM Employee);

| second_highest_salary |
| --------------------- |
| 70000.0               |

---
**Query #49**--Retrieve the department with the most employees.

    SELECT d.name AS department_name
    FROM Department d
    WHERE d.department_id = (SELECT department_id FROM Employee GROUP BY department_id ORDER BY COUNT(*) DESC LIMIT 1);

| department_name |
| --------------- |
| IT              |

---
**Query #50**--Retrieve employees who earn more than the average salary of their department.

    SELECT e.name, e.salary, e.department_id
    FROM Employee e
    WHERE e.salary > (SELECT AVG(e2.salary) FROM Employee e2 WHERE e2.department_id = e.department_id);

| name        | salary  | department_id |
| ----------- | ------- | ------------- |
| Jane Smith  | 60000.0 | 2             |
| Bob Brown   | 80000.0 | 1             |
| David Green | 70000.0 | 4             |
| Eve Black   | 55000.0 | 3             |

---
**Query #51**--Retrieve the nth highest salary (for example, 3rd highest).

    SELECT MAX(salary) AS third_highest_salary
    FROM Employee
    WHERE salary < (
        SELECT MAX(salary)
        FROM Employee
        WHERE salary < (
            SELECT MAX(salary)
            FROM Employee
        )
    );

| third_highest_salary |
| -------------------- |
| 65000.0              |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/nGqnBYU4WKFiMXT8h5Fek6/4)