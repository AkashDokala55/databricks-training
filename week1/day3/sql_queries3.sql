**Schema (MySQL v5.7)**

    CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT,
    dept_id INT
    );
    INSERT INTO employees (emp_id, emp_name, manager_id, dept_id) VALUES
    (1, 'Karthik', NULL, 1),
    (2, 'Ajay', 1, 1),
    (3, 'Vijay', 1, 2),
    (4, 'Vinay', 2, 2),
    (5, 'Meena', 3, 3),
    (6, 'Veer', NULL, 4),
    (7, 'Keerthi', 4, 5),
    (8, 'Priya', 4, 5);
    
    
    CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
    );
    
    INSERT INTO departments (dept_id, dept_name) VALUES
    (1, 'HR'),
    (2, 'IT'),
    (3, 'Finance'),
    (4, 'Marketing'),
    (5, 'Sales');
    
    
    CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
    );
    
    INSERT INTO projects (project_id, project_name, emp_id) VALUES
    (1, 'Project A', 1),
    (2, 'Project B', 2),
    (3, 'Project C', 3),
    (4, 'Project D', 4),
    (5, 'Project E', 5);
    

---

**Query #1**--. Retrieve the names of employees and their corresponding managers from the "employees"
--table, ensuring that even employees without managers are included.

    SELECT e.emp_name,m.emp_name FROM employees e LEFT JOIN employees m ON e.manager_id=m.emp_id;

| emp_name | emp_name |
| -------- | -------- |
| Karthik  |          |
| Ajay     | Karthik  |
| Vijay    | Karthik  |
| Vinay    | Ajay     |
| Meena    | Vijay    |
| Veer     |          |
| Keerthi  | Vinay    |
| Priya    | Vinay    |

---
**Query #2**--. Display all employees and their corresponding departments from the "employees" and "departments" tables, showing employees even if they don't belong to any department.

    SELECT e.emp_name as employee,d.dept_name as department FROM employees e LEFT JOIN departments d ON e.dept_id=d.dept_id;

| employee | department |
| -------- | ---------- |
| Karthik  | HR         |
| Ajay     | HR         |
| Vijay    | IT         |
| Vinay    | IT         |
| Meena    | Finance    |
| Veer     | Marketing  |
| Keerthi  | Sales      |
| Priya    | Sales      |

---
**Query #3**--List the names of employees who report to a manager, along with their manager's name, from the "employees" table.


    SELECT e.emp_name,m.emp_name FROM employees e INNER JOIN employees m ON e.manager_id=m.emp_id;

| emp_name | emp_name |
| -------- | -------- |
| Ajay     | Karthik  |
| Vijay    | Karthik  |
| Vinay    | Ajay     |
| Meena    | Vijay    |
| Keerthi  | Vinay    |
| Priya    | Vinay    |

---
**Query #4**--Display a list of employees who do not belong to any department, even if the department data is missing.

    SELECT e.emp_name FROM employees e LEFT JOIN departments d ON e.dept_id = d.dept_id WHERE d.dept_id IS NULL;

There are no results to be displayed.

---
**Query #5**--Fetch the names of employees and the projects they are assigned to. For employees who are not assigned any projects, show NULL for the project.

    SELECT e.emp_name as employee,p.project_name as project FROM employees e LEFT JOIN projects p ON e.emp_id=p.emp_id;

| employee | project   |
| -------- | --------- |
| Karthik  | Project A |
| Ajay     | Project B |
| Vijay    | Project C |
| Vinay    | Project D |
| Meena    | Project E |
| Veer     |           |
| Keerthi  |           |
| Priya    |           |

---
**Query #6**--List all employees who have completed at least one project, showing their names and the project names.

    SELECT DISTINCT e.emp_name AS employee,
           p.project_name AS project
    FROM employees e
    INNER JOIN projects p ON e.emp_id = p.emp_id;

| employee | project   |
| -------- | --------- |
| Karthik  | Project A |
| Ajay     | Project B |
| Vijay    | Project C |
| Vinay    | Project D |
| Meena    | Project E |

---
**Query #7**--Employees and projects (include projects without employees):

    SELECT DISTINCT e.emp_name AS employee,
           p.project_name AS project
    FROM employees e
    INNER JOIN projects p ON e.emp_id = p.emp_id;

| employee | project   |
| -------- | --------- |
| Karthik  | Project A |
| Ajay     | Project B |
| Vijay    | Project C |
| Vinay    | Project D |
| Meena    | Project E |

---
**Query #8**--Employees and their departments (include employees without departments):

    SELECT e.emp_name AS employee,
           d.dept_name AS department
    FROM employees e
    LEFT JOIN departments d ON e.dept_id = d.dept_id;

| employee | department |
| -------- | ---------- |
| Karthik  | HR         |
| Ajay     | HR         |
| Vijay    | IT         |
| Vinay    | IT         |
| Meena    | Finance    |
| Veer     | Marketing  |
| Keerthi  | Sales      |
| Priya    | Sales      |

---
**Query #9**--Departments and employees (include departments with no employees):

    SELECT d.dept_name AS department,
           e.emp_name AS employee
    FROM departments d
    LEFT JOIN employees e ON d.dept_id = e.dept_id;

| department | employee |
| ---------- | -------- |
| HR         | Karthik  |
| HR         | Ajay     |
| IT         | Vijay    |
| IT         | Vinay    |
| Finance    | Meena    |
| Marketing  | Veer     |
| Sales      | Keerthi  |
| Sales      | Priya    |

---
**Query #10**--Employees without projects (show project details if applicable):

    SELECT e.emp_name AS employee,
           p.project_name AS project
    FROM employees e
    LEFT JOIN projects p ON e.emp_id = p.emp_id
    WHERE p.project_id IS NULL;

| employee | project |
| -------- | ------- |
| Veer     |         |
| Keerthi  |         |
| Priya    |         |

---
**Query #11**--Employees and projects (include employees without projects):

    SELECT e.emp_name AS employee,
           p.project_name AS project
    FROM employees e
    LEFT JOIN projects p ON e.emp_id = p.emp_id;

| employee | project   |
| -------- | --------- |
| Karthik  | Project A |
| Ajay     | Project B |
| Vijay    | Project C |
| Vinay    | Project D |
| Meena    | Project E |
| Veer     |           |
| Keerthi  |           |
| Priya    |           |

---
**Query #12**--Projects and employees (include projects without employees):

    SELECT p.project_name AS project,
           e.emp_name AS employee
    FROM projects p
    LEFT JOIN employees e ON p.emp_id = e.emp_id;

| project   | employee |
| --------- | -------- |
| Project A | Karthik  |
| Project B | Ajay     |
| Project C | Vijay    |
| Project D | Vinay    |
| Project E | Meena    |

---
**Query #13**--Employees with both a manager and at least one project:

    SELECT e.emp_name AS employee,
           m.emp_name AS manager,
           p.project_name AS project
    FROM employees e
    INNER JOIN employees m ON e.manager_id = m.emp_id
    INNER JOIN projects p ON e.emp_id = p.emp_id;

| employee | manager | project   |
| -------- | ------- | --------- |
| Ajay     | Karthik | Project B |
| Vijay    | Karthik | Project C |
| Vinay    | Ajay    | Project D |
| Meena    | Vijay   | Project E |

---
**Query #14**--Employees and departments (exclude employees without departments)

    SELECT e.emp_name AS employee,
           d.dept_name AS department
    FROM employees e
    INNER JOIN departments d ON e.dept_id = d.dept_id;

| employee | department |
| -------- | ---------- |
| Karthik  | HR         |
| Ajay     | HR         |
| Vijay    | IT         |
| Vinay    | IT         |
| Meena    | Finance    |
| Veer     | Marketing  |
| Keerthi  | Sales      |
| Priya    | Sales      |

---
**Query #15**--Departments and employees (include departments with no employees)

    SELECT d.dept_name AS department,
           e.emp_name AS employee
    FROM departments d
    LEFT JOIN employees e ON d.dept_id = e.dept_id;

| department | employee |
| ---------- | -------- |
| HR         | Karthik  |
| HR         | Ajay     |
| IT         | Vijay    |
| IT         | Vinay    |
| Finance    | Meena    |
| Marketing  | Veer     |
| Sales      | Keerthi  |
| Sales      | Priya    |

---
**Query #16**--Employees with projects but no department

    SELECT e.emp_name AS employee,
           p.project_name AS project
    FROM employees e
    INNER JOIN projects p ON e.emp_id = p.emp_id
    LEFT JOIN departments d ON e.dept_id = d.dept_id
    WHERE d.dept_id IS NULL;

There are no results to be displayed.

---
**Query #17**--Number of employees per department (include departments with no employees)

    SELECT d.dept_name AS department,
           COUNT(e.emp_id) AS employee_count
    FROM departments d
    LEFT JOIN employees e ON d.dept_id = e.dept_id
    GROUP BY d.dept_name;

| department | employee_count |
| ---------- | -------------- |
| Finance    | 1              |
| HR         | 2              |
| IT         | 2              |
| Marketing  | 1              |
| Sales      | 2              |

---
**Query #18**--Employees and managers (only those with managers)

    SELECT e.emp_name AS employee,
           m.emp_name AS manager
    FROM employees e
    INNER JOIN employees m ON e.manager_id = m.emp_id;

| employee | manager |
| -------- | ------- |
| Ajay     | Karthik |
| Vijay    | Karthik |
| Vinay    | Ajay    |
| Meena    | Vijay   |
| Keerthi  | Vinay   |
| Priya    | Vinay   |

---
**Query #19**--Employees and managers (include employees without managers)

    SELECT e.emp_name AS employee,
           m.emp_name AS manager
    FROM employees e
    LEFT JOIN employees m ON e.manager_id = m.emp_id;

| employee | manager |
| -------- | ------- |
| Karthik  |         |
| Ajay     | Karthik |
| Vijay    | Karthik |
| Vinay    | Ajay    |
| Meena    | Vijay   |
| Veer     |         |
| Keerthi  | Vinay   |
| Priya    | Vinay   |

---
**Query #20**--Employees and departments (include departments with no employees)

    SELECT d.dept_name AS department,
           COUNT(e.emp_id) AS employee_count
    FROM departments d
    LEFT JOIN employees e ON d.dept_id = e.dept_id
    GROUP BY d.dept_name;

| department | employee_count |
| ---------- | -------------- |
| Finance    | 1              |
| HR         | 2              |
| IT         | 2              |
| Marketing  | 1              |
| Sales      | 2              |

---
**Query #21**--Employees and projects (include employees without projects)

    SELECT e.emp_name AS employee,
           p.project_name AS project
    FROM employees e
    LEFT JOIN projects p ON e.emp_id = p.emp_id;

| employee | project   |
| -------- | --------- |
| Karthik  | Project A |
| Ajay     | Project B |
| Vijay    | Project C |
| Vinay    | Project D |
| Meena    | Project E |
| Veer     |           |
| Keerthi  |           |
| Priya    |           |

---
**Query #22**--Employees with department and project (include missing ones)

    SELECT e.emp_name AS employee,
           d.dept_name AS department,
           p.project_name AS project
    FROM employees e
    LEFT JOIN departments d ON e.dept_id = d.dept_id
    LEFT JOIN projects p ON e.emp_id = p.emp_id;

| employee | department | project   |
| -------- | ---------- | --------- |
| Karthik  | HR         | Project A |
| Ajay     | HR         | Project B |
| Vijay    | IT         | Project C |
| Vinay    | IT         | Project D |
| Meena    | Finance    | Project E |
| Veer     | Marketing  |           |
| Keerthi  | Sales      |           |
| Priya    | Sales      |           |

---
**Query #23**--Employees and departments (include employees without departments)

    SELECT e.emp_name AS employee,
           d.dept_name AS department
    FROM employees e
    LEFT JOIN departments d ON e.dept_id = d.dept_id;

| employee | department |
| -------- | ---------- |
| Karthik  | HR         |
| Ajay     | HR         |
| Vijay    | IT         |
| Vinay    | IT         |
| Meena    | Finance    |
| Veer     | Marketing  |
| Keerthi  | Sales      |
| Priya    | Sales      |

---

