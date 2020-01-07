CREATE TABLE Departments (
    dept_no varchar(30)   NOT NULL,
    dept_name varchar(30)   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (dept_no)
);

CREATE TABLE Employees (
    emp_no int   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar(35)   NOT NULL,
    last_name varchar(35)   NOT NULL,
    gender varchar(1)   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (emp_no)
);

CREATE TABLE Dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar(30)   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

CREATE TABLE Dept_manager (
    dept_no varchar(30)   NOT NULL,
    emp_no int   NOT NULL,
     from_date date   NOT NULL,
    to_date date   NOT NULL
);

CREATE TABLE Salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

CREATE TABLE Titles (
    emp_no int   NOT NULL,
    title varchar(35)   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

--List the following details of each employee: employee number, last name, first name, gender, and salary.
select Employees.emp_no, 
	Employees.last_name, 
	Employees.first_name, 
	Employees.gender, 
	Salaries.salary
from Employees
inner join Salaries on
Employees.emp_no = Salaries.emp_no;

--List employees who were hired in 1986.
select * from employees
where hire_date between '1986-01-01' and '1986-12-31'

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
select t1.dept_no,
	t3.dept_name,
	t1.emp_no,
	t2.first_name,
	t2.last_name,
	t1.from_date,
	t1.to_date
from dept_manager as t1
join employees as t2 on
t1.emp_no = t2.emp_no
join departments as t3
on t3.dept_no = t1.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
select t1.emp_no,
	t1.last_name,
	t1.first_name,
	t3.dept_name
from employees as t1
join dept_emp as t2
on t1.emp_no = t2.emp_no
join departments as t3
on t3.dept_no = t2.dept_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
select employees.first_name,
	employees.last_name
from employees
where first_name = 'Hercules' and last_name like 'B%'; 

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select t1.emp_no
	, t1.last_name
	, t1.first_name
	, t3.dept_name
from employees as t1
join dept_emp as t2
on t1.emp_no = t2.emp_no
join departments as t3
on t3.dept_no = t2.dept_no
where t3.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select t1.emp_no
	, t1.last_name
	, t1.first_name
	, t3.dept_name
from employees as t1
join dept_emp as t2
on t1.emp_no = t2.emp_no
join departments as t3
on t3.dept_no = t2.dept_no
where t3.dept_name = 'Sales' or t3.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name, count (last_name) as name_cnt
from employees
group by last_name
order by name_cnt desc;
