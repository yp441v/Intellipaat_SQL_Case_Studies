 CREATE DATABASE case_study2

 USE case_study2

 CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');


  CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);


INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

	   CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);



INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')


CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)

SELECT * FROM Employee
SELECT * FROM Department
SELECT * FROM Job
SELECT * FROM Location



--Simple Queries:
--1. List all the employee details. 
SELECT * FROM Employee;

--2. List all the department details. 
SELECT * FROM Department;

--3. List all job details. 
SELECT * FROM Job;

--4. List all the locations. 
SELECT * FROM Location;

--5. List out the First Name, Last Name, Salary, Commission for allEmployees. 
SELECT First_Name, Last_Name, Salary, Comm 
FROM Employee;

--6. List out the Employee ID, Last Name, Department ID for all employees and alias
--Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".

SELECT Employee_ID AS "ID of the Employee", Last_Name AS  "Name of the Employee" , Department_ID AS "Dep_id" 
FROM Employee;

--7. List out the annual salary of the employees with their names only. 

SELECT CONCAT(First_Name, ' ', Last_Name) AS EmployeeName, Salary  AS AnnualSalary
FROM EMPLOYEE;


--WHERE Condition:

--1. List the details about "Smith". 

SELECT * FROM Employee
WHERE LAST_NAME = 'smith';

--2. List out the employees who are working in department 20. 
SELECT * FROM EMPLOYEE 
WHERE Department_Id = 20;

--3. List out the employees who are earning salaries between 3000 and4500.
SELECT * FROM EMPLOYEE 
WHERE Salary BETWEEN 3000 AND 4500;

--4. List out the employees who are working in department 10 or 20. 
SELECT * FROM EMPLOYEE 
WHERE Department_Id IN (10, 20);

--5. Find out the employees who are not working in department 10 or 30. 
SELECT * FROM EMPLOYEE 
WHERE Department_Id NOT IN (10, 30);

--6. List out the employees whose name starts with 'S'.

SELECT * FROM EMPLOYEE
WHERE Last_Name LIKE 'S%';

--7. List out the employees whose name starts with 'S' and ends with 'H'. 
SELECT * FROM EMPLOYEE 
WHERE Last_Name LIKE 'S%H';

--8. List out the employees whose name length is 4 and start with 'S'. 

SELECT * FROM EMPLOYEE
WHERE Last_Name LIKE 'S____';

--9. List out employees who are working in department 10 and draw salaries morethan 3500. 

SELECT * FROM EMPLOYEE 
WHERE Department_Id = 10 AND Salary > 3500;

--10. List out the employees who are not receiving commission. 

SELECT * FROM EMPLOYEE
WHERE Comm IS NULL;

--ORDER BY Clause:

--1. List out the Employee ID and Last Name in ascending order based on the Employee ID. 

SELECT Employee_Id, Last_Name 
FROM EMPLOYEE 
ORDER BY Employee_Id ASC;

--2. List out the Employee ID and Name in descending order based onsalary.

SELECT Employee_Id, CONCAT(First_Name, ' ', Last_Name) AS 'Employee Name'
FROM EMPLOYEE 
ORDER BY Salary DESC;

--3. List out the employee details according to their Last Name in ascending-order.

SELECT * 
FROM EMPLOYEE 
ORDER BY Last_Name ASC;

--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order. 

SELECT * 
FROM EMPLOYEE 
ORDER BY Last_Name ASC, Department_Id DESC;

--GROUP BY and HAVING Clause: 
SELECT * FROM EMPLOYEE

--1. How many employees are in different departments in the Organization?
SELECT COUNT(*) AS NumberOfEmployees, DEPARTMENT_ID
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID;

--2. List out the department wise maximum salary, minimum salary and average salary of the employees. 
SELECT MIN(SALARY) AS MinSal, MAX(SALARY) AS MaxSal, AVG(Salary) AS AvgSalary,DEPARTMENT_ID
FROM EMPLOYEE
GROUP BY DEPARTMENT_ID;

--3. List out the job wise maximum salary, minimum salary and average salary of the employees. 

SELECT MIN(SALARY) AS MinSal, MAX(SALARY) AS MaxSal, AVG(Salary) AS AvgSalary,JOB_ID
FROM EMPLOYEE
GROUP BY JOB_ID;

--4. List out the number of employees who joined each month in ascendingorder. 
SELECT COUNT(*)AS NumberOfEmployees, DATEPART(MONTH, HIRE_DATE) AS Joining_Month
FROM EMPLOYEE
GROUP BY  DATEPART(MONTH, HIRE_DATE)
ORDER BY Joining_Month ASC;


--5. List out the number of employees for each month and year in ascending order based on the year and month.
SELECT YEAR(Hire_Date) AS join_year,
MONTH(Hire_Date) AS join_month,
COUNT(*) AS num_of_employees_joined
FROM EMPLOYEE
GROUP BY YEAR(Hire_Date), MONTH(Hire_Date)
ORDER BY join_year ASC, join_month ASC;


--6. List out the Department ID having at least four employees. 

SELECT Department_Id, COUNT(DEPARTMENT_ID) AS NumOfEmployees
FROM EMPLOYEE
GROUP BY Department_Id
HAVING COUNT(*) >= 4;


--7. How many employees joined in the month of January?

SELECT COUNT(*) AS 'num_of_employees_joined_In-January'
FROM EMPLOYEE
WHERE MONTH(Hire_Date) = 1;

--8. How many employees joined in the month of January orSeptember?
SELECT COUNT(*) AS 'num_of_employees_joined_In-January'
FROM EMPLOYEE
WHERE MONTH(Hire_Date) IN (1,9);

--9. How many employees joined in 1985?
SELECT COUNT(*) AS 'num_of_employees_joined_In-1985'
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = '1985';

--10. How many employees joined each month in 1985?

SELECT COUNT(*) AS 'num_of_employees_joined ', MONTH(HIRE_DATE) AS HIRE_MONTH,YEAR(Hire_Date)HIRE_YEAR
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = '1985'
GROUP BY MONTH(HIRE_DATE),YEAR(Hire_Date);

--11. How many employees joined in March 1985?

SELECT COUNT(*) AS 'num_of_employees_joined '
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = '1985' AND MONTH(Hire_Date) = 3;

--12. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?

SELECT DEPARTMENT_ID 
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985 AND MONTH(Hire_Date) = 4
GROUP BY  DEPARTMENT_ID
HAVING  COUNT(*) >=3;

--Joins:
--1. List out employees with their department names. 

SELECT E.*, D.Name AS Department_Name
FROM EMPLOYEE E
INNER JOIN Department D ON 
E.Department_Id = D.Department_Id;

--2. Display employees with their designations. 


SELECT E.*, J.Designation 
FROM EMPLOYEE AS E 
INNER JOIN JOB AS J ON 
E.Job_Id = J.Job_ID;

--3. Display the employees with their department names and regional groups. 
SELECT E.*, D.NAME,L.CITY FROM EMPLOYEE AS E
INNER JOIN DEPARTMENT AS D ON
E.Department_Id = D.Department_Id
INNER JOIN LOCATION AS L ON 
D.Location_Id = L.Location_ID


--4. How many employees are working in different departments? Display with department names. 

SELECT COUNT(*) AS No_of_Employees, D.DEPARTMENT_ID, D.NAME
FROM EMPLOYEE AS E
INNER JOIN DEPARTMENT  AS D ON 
E.Department_Id = D.Department_Id
GROUP BY D.DEPARTMENT_ID,D.NAME

--5. How many employees are working in the sales department?
SELECT COUNT(*) AS No_of_Employees
FROM EMPLOYEE AS E
INNER JOIN DEPARTMENT  AS D ON 
E.Department_Id = D.Department_Id
WHERE D.NAME = 'SALES'

--6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order.


SELECT COUNT(*) AS No_of_Employees ,  D.NAME AS DEPARTMENT_NAME
FROM EMPLOYEE AS E
INNER JOIN DEPARTMENT  AS D ON 
E.Department_Id = D.Department_Id
GROUP BY D.DEPARTMENT_ID, D.NAME 
HAVING COUNT(*) >= 5
ORDER BY  D.NAME ASC

--7. How many jobs are there in the organization? Display with designations. 

SELECT J.DESIGNATION, COUNT(*) AS NUMBER_OF_JOBS 
FROM EMPLOYEE AS E 
INNER JOIN JOB  AS J ON 
E.JOB_ID = J.JOB_ID
GROUP BY J.DESIGNATION,E.JOB_ID 

--8. How many employees are working in "New York"?

SELECT COUNT(*) as No_Of_Employees 
FROM EMPLOYEE AS E
INNER JOIN DEPARTMENT AS D ON
E.Department_Id = D.Department_Id
INNER JOIN LOCATION AS L ON 
D.Location_Id = L.Location_ID
WHERE CITY ='New York'

--9.Display the employee details with salary grades. Use conditional statement to create a grade column. 

SELECT *,
	CASE
		WHEN Salary < 1000 THEN 'Grade 1'
		WHEN Salary >= 1000 AND Salary < 3000 THEN 'Grade 2'
		ELSE 'Grade 3'
	END AS Salary_Grade
FROM EMPLOYEE;

--10. List out the number of employees grade wise. Use conditional statement to create a grade column. 

SELECT Salary_Grade, COUNT(*) AS num_employees
FROM (
    SELECT *,
           CASE
               WHEN Salary < 1000 THEN 'Grade 1'
			   WHEN Salary >= 1000 AND Salary < 3000 THEN 'Grade 2'
			   ELSE 'Grade 3'
           END AS Salary_Grade
    FROM EMPLOYEE)
	AS SalaryGrades
GROUP BY Salary_Grade;

--11.Display the employee salary grades and the number of employees between 2000 to 5000 range of salary. 

SELECT Salary_Grade, COUNT(*) AS num_employees
FROM (
    SELECT *,
           CASE
               WHEN Salary < 1000 THEN 'Grade 1'
			   WHEN Salary >= 1000 AND Salary < 3000 THEN 'Grade 2'
			   ELSE 'Grade 3'
           END AS Salary_Grade
    FROM EMPLOYEE
) AS SalaryGrades
Where Salary between 2000 and 5000
GROUP BY Salary_Grade;

--12. Display all employees in sales or operation departments. 

SELECT E.*, D.NAME FROM EMPLOYEE AS E
JOIN DEPARTMENT AS D ON 
E.DEPARTMENT_ID = D.Department_Id
WHERE D.Name IN ('Sales', 'Operations');

--SET Operators:
--1. List out the distinct jobs in sales and accounting departments. 

SELECT  J.Designation
FROM JOB AS J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'SALES'
UNION 
SELECT  J.Designation
FROM JOB AS J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'ACCOUNTING'

--2. List out all the jobs in sales and accounting departments.


SELECT  J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales' 
UNION ALL
SELECT  J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Accounting';


--3. List out the common jobs in research and accounting departments in ascending order. 

SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Research'
INTERSECT
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Accounting'
ORDER BY Designation ASC;

--Subqueries:
--1. Display the employees list who got the maximum salary.



SELECT * FROM EMPLOYEE
WHERE Salary = ( SELECT MAX(Salary)     FROM EMPLOYEE);

--2. Display the employees who are working in the sales department. ++
SELECT * FROM EMPLOYEE AS E
JOIN DEPARTMENT D ON 
E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.NAME = 'SALES'

---3. Display the employees who are working as 'Clerk'. 
SELECT * FROM EMPLOYEE AS E
JOIN JOB AS J ON 
E.JOB_ID = J.JOB_ID
WHERE DESIGNATION =   'CLERK'

--4. Display the list of employees who are living in "New York". 

SELECT *
FROM EMPLOYEE AS E
INNER JOIN DEPARTMENT AS D ON
E.Department_Id = D.Department_Id
INNER JOIN LOCATION AS L ON 
D.Location_Id = L.Location_ID
WHERE CITY ='New York'

--5. Find out the number of employees working in the sales department.
 SELECT COUNT(*)  FROM EMPLOYEE AS E
 JOIN DEPARTMENT AS D ON 
 E.DEPARTMENT_ID = D.Department_Id
 WHERE D.NAME = 'SALES'


--6. Update the salaries of employees who are working as clerks on the basis of 10%. 
UPDATE EMPLOYEE
SET SALARY = SALARY+SALARY*.10
WHERE JOB_ID IN(
SELECT Job_ID
FROM JOB
WHERE Designation = 'Clerk')

--7. Delete the employees who are working in the accounting department. 

DELETE FROM EMPLOYEE
WHERE DEPARTMENT_ID IN
(SELECT  DEPARTMENT_ID
FROM DEPARTMENT
WHERE NAME = 'ACCOUNTING')

--8. Display the second highest salary drawing employee details.

SELECT *
FROM employee
ORDER BY salary DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

--9. Display the nth highest salary drawing employee details. 
DECLARE @N INT = 2; 

SELECT *
FROM (
SELECT *, ROW_NUMBER() OVER (ORDER BY Salary DESC) AS salary_rank
FROM EMPLOYEE)
AS RANK_TABLE
WHERE salary_rank = @N;

--10. List out the employees who earn more than every employee in department 30. 
SELECT *
FROM EMPLOYEE
WHERE Salary > ALL (
SELECT Salary
FROM EMPLOYEE
WHERE Department_Id = 30
)
--11. List out the employees who earn more than the lowest salary in department.Find out whose department has no employees. 

SELECT *
FROM EMPLOYEE E
WHERE Salary > (
    SELECT MIN(Salary)
    FROM EMPLOYEE
    WHERE Department_Id = E.Department_Id
);

--12. Find out which department has no employees.
SELECT D.*, E.EMPLOYEE_ID
FROM Department D
LEFT JOIN EMPLOYEE E ON D.Department_Id = E.Department_Id
WHERE E.Employee_Id IS NULL;

--13. Find out the employees who earn greater than the average salary for their department

SELECT * FROM EMPLOYEE AS E
WHERE SALARY >
(
SELECT AVG(SALARY)
FROM EMPLOYEE
WHERE Department_Id = E.Department_Id
);








