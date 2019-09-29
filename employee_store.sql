CREATE TABLE Departments (
   Code INTEGER PRIMARY KEY NOT NULL,
   Name TEXT NOT NULL ,
   Budget REAL NOT NULL
 );

 CREATE TABLE Employees (
   SSN INTEGER PRIMARY KEY NOT NULL,
   Name TEXT NOT NULL ,
   LastName TEXT NOT NULL ,
   Department INTEGER NOT NULL ,
   CONSTRAINT fk_Departments_Code FOREIGN KEY(Department)
   REFERENCES Departments(Code)
 );

INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','O''Donnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);


-- 1. Select the last name of all employees.

select LastName from Employees;

-- 2. Select the last name of all employees, without duplicates.

select distinct LastName from Employees;

-- 3. Select all the data of employees whose last name is "Smith".

select * from employees
where LastName = 'Smith';

-- 4. Select all the data of employees whose last name is "Smith" or "Doe".

select * from employees
where LastName in ('Smith', 'Doe');

-- 5. Select all the data of employees that work in department 14.

select * from employees
where department = 14;

-- 6. Select all the data of employees that work in department 37 or department 77.

select * from employees
where department in (37, 77);

-- 7. Select all the data of employees whose last name begins with an "S".

select * from Employees
where lastname like 'S%';

-- 8. Select the sum of all the departments' budgets.

select sum(budget)
from Departments;

-- 9. Select the number of employees in each department (you only need to show the department code and the number of employees).

select department, count(*)
from Employees
group by department;


select d.code, count(e.name) total_employees
from employees e
inner join departments d on e.department = e.code
group by 1;

-- 10. Select all the data of employees, including each employee's department's data.

select * from Employees e
inner join departments d on e.department = d.code;

-- 11. Select the name and last name of each employee, along with the name and budget of the employee's department.

select e.name, e.lastname, d.name department, d.budget
from Employees e
inner join Departments d on e.department = d.code;

-- 12. Select the name and last name of employees working for departments with a budget greater than $60,000.

select name, LastName from Employees
inner join departments d on e.department = d.code
  and d.budget > 60000;

-- 13. Select the departments with a budget larger than the average budget of all the departments.

select *
from departments where budget >
  ( select avg(budget) from departments);

-- 14. Select the names of departments with more than two employees.

select name from Departments
  where code in
    (
      select departments
      from Employees
      group by department
      having count(*) > 2
    );

--also applicable but may return duplicates
select d.name
from employees e
inner join departments d on e.department = c.code
group by d.name
having count(*) > 2;

-- 15. Select the name and last name of employees working for departments with second lowest budget.

select name, LastName
from employees
where e.department  = (
    select subquery.code from (
      select * from deparments d order by d.budget limit 2
    )
    order by budget desc
    limit 1
  ) ;

-- 16. Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.

insert into departments --(code, name, budget)
  values(11, 'Quality Assurance', 40000);

insert into employees --(SSN, Name, LastName, Department)
  values('847219811', 'Mary', 'Moore', 11);

-- 17. Reduce the budget of all departments by 10%.

update departments
  set budget = budget*0.9;

-- 18. Reassign all employees from the Research department (code 77) to the IT department (code 14).

update employees
  set department = 14
  where department = 77;

-- 19. Delete from the table all employees in the IT department (code 14).

delete from employees
where department = 14;

-- 20. Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.

delete from Employees
  where (select code from Departments where d.budget >= 60000);

-- 21. Delete from the table all employees.

delete from employees;
