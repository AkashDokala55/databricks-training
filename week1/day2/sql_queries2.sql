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
**Query #52**--Retrieve employees who are older than all employees in the HR department.

    SELECT name, age
    FROM Employee
    WHERE age > ALL (
        SELECT age
        FROM Employee
        WHERE department_id = (
            SELECT department_id
            FROM Department
            WHERE name = 'HR'
        )
    );

| name        | age |
| ----------- | --- |
| Bob Brown   | 45  |
| David Green | 38  |
| Eve Black   | 40  |

---
**Query #53**--Retrieve departments where the average salary is greater than 55000.

    SELECT d.name AS department_name,
           AVG(e.salary) AS average_salary
    FROM Employee e
    JOIN Department d
    ON e.department_id = d.department_id
    GROUP BY d.name
    HAVING AVG(e.salary) > 55000;

| department_name | average_salary |
| --------------- | -------------- |
| IT              | 65000.0        |
| Marketing       | 61500.0        |

---
**Query #54**--Retrieve employees who work in a department with at least 2 projects.

    SELECT name
    FROM Employee
    WHERE department_id IN (
        SELECT department_id
        FROM Project
        GROUP BY department_id
        HAVING COUNT(project_id) >= 2
    );

| name        |
| ----------- |
| John Doe    |
| Bob Brown   |
| Alice Blue  |
| David Green |
| Eve Black   |
| Grace Kelly |
| Hannah Lee  |

---
**Query #55**--Retrieve employees who were hired on the same date as 'Jane Smith'.

    SELECT name, hire_date
    FROM Employee
    WHERE hire_date = (
        SELECT hire_date
        FROM Employee
        WHERE name = 'Jane Smith'
    );

| name       | hire_date  |
| ---------- | ---------- |
| Jane Smith | 2019-07-23 |

---
**Query #56**--Retrieve the total salary of employees hired in the year 2020.

    SELECT SUM(salary) AS total_salary
    FROM Employee
    WHERE YEAR(hire_date) = 2020;

| total_salary |
| ------------ |
| 103000.0     |

---
**Query #57**--Retrieve the average salary of employees in each department ordered by average salary in descending order.

    SELECT d.name AS department_name,
           AVG(e.salary) AS average_salary
    FROM Employee e
    JOIN Department d
    ON e.department_id = d.department_id
    GROUP BY d.name
    ORDER BY average_salary DESC;

| department_name | average_salary |
| --------------- | -------------- |
| IT              | 65000.0        |
| Marketing       | 61500.0        |
| HR              | 55000.0        |
| Finance         | 50000.0        |

---
**Query #58**--Retrieve departments with more than 1 employee and an average salary greater than 55000.

    SELECT d.name AS department_name,
           COUNT(e.emp_id) AS employee_count,
           AVG(e.salary) AS average_salary
    FROM Employee e
    JOIN Department d
    ON e.department_id = d.department_id
    GROUP BY d.name
    HAVING COUNT(e.emp_id) > 1
       AND AVG(e.salary) > 55000;

| department_name | employee_count | average_salary |
| --------------- | -------------- | -------------- |
| IT              | 3              | 65000.0        |
| Marketing       | 2              | 61500.0        |

---
**Query #60**--Retrieve the total number of employees and average salary for departments with more than 2 employees.

    SELECT d.name AS department_name,
           COUNT(e.emp_id) AS total_employees,
           AVG(e.salary) AS average_salary
    FROM Employee e
    JOIN Department d
    ON e.department_id = d.department_id
    GROUP BY d.name
    HAVING COUNT(e.emp_id) > 2;

| department_name | total_employees | average_salary |
| --------------- | --------------- | -------------- |
| IT              | 3               | 65000.0        |

---
**Query #61**--Retrieve the name and salary of employees whose salary is above the average salary of their department.

    SELECT e.name, e.salary
    FROM Employee e
    WHERE e.salary > (
        SELECT AVG(salary)
        FROM Employee
        WHERE department_id = e.department_id
    );

| name        | salary  |
| ----------- | ------- |
| Jane Smith  | 60000.0 |
| Bob Brown   | 80000.0 |
| David Green | 70000.0 |
| Eve Black   | 55000.0 |

---
**Query #62**--Retrieve the names of employees who were hired on the same date as the oldest employee in the company.

    SELECT name
    FROM Employee
    WHERE hire_date = (
        SELECT hire_date
        FROM Employee
        ORDER BY age DESC
        LIMIT 1
    );

| name      |
| --------- |
| Bob Brown |

---
**Query #63**--Retrieve department names along with the total number of projects they are working on ordered by the number of projects.

    SELECT d.name AS department_name,
           COUNT(p.project_id) AS total_projects
    FROM Department d
    LEFT JOIN Project p
    ON d.department_id = p.department_id
    GROUP BY d.name
    ORDER BY total_projects DESC;

| department_name | total_projects |
| --------------- | -------------- |
| IT              | 3              |
| Marketing       | 2              |
| Finance         | 2              |
| HR              | 1              |

---
**Query #64**--Retrieve the employee name with the highest salary in each department.

    SELECT d.name AS department_name,
           e.name AS employee_name,
           e.salary
    FROM Employee e
    JOIN Department d
    ON e.department_id = d.department_id
    WHERE e.salary = (
        SELECT MAX(salary)
        FROM Employee
        WHERE department_id = e.department_id
    );

| department_name | employee_name | salary  |
| --------------- | ------------- | ------- |
| HR              | Jane Smith    | 60000.0 |
| IT              | Bob Brown     | 80000.0 |
| Marketing       | David Green   | 70000.0 |
| Finance         | Eve Black     | 55000.0 |

---

[View on DB Fiddle](https://www.db-fiddle.com/f/nGqnBYU4WKFiMXT8h5Fek6/4)