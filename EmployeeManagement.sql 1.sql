CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
	Salary INT,
    HireDate DATE,
	Department NVARCHAR(50)
);

CREATE TABLE EmployeeBonus (
    Employee_ref_id INT,
    BonusAmount DECIMAL(10, 2),
    BonusDate DATE,
);

CREATE TABLE EmployeeTitle (
    Employee_ref_id INT,
    Employee_title NVARCHAR(100),
    Affective_date DATE,
);

ALTER TABLE EmployeeBonus
ADD CONSTRAINT FK_EmployeeBonus_Employee
FOREIGN KEY (Employee_ref_id) REFERENCES Employee(EmployeeID);


INSERT INTO Employee (EmployeeID, FirstName, LastName, Salary, HireDate, Department)
VALUES
(1, 'Anika', 'Arora', 100000, '2020-02-14', 'HR'),
(2, 'Veena', 'Verma', 80000, '2011-06-15', 'Admin'),
(3, 'Vishal', 'Singhal', 300000, '2020-02-16', 'HR'),
(4, 'Sushanth', 'Singh', 500000, '2020-02-17', 'Admin'),
(5, 'Bhupal', 'Bhati', 500000, '2011-06-18', 'Admin'),
(6, 'Dheeraj', 'Diwan', 200000, '2011-06-19', 'Account'),
(7, 'Karan', 'Kumar', 75000, '2020-01-14', 'Account'),
(8, 'Chandrika', 'Chauhan', 90000, '2011-04-15', 'Admin');

INSERT INTO EmployeeBonus (Employee_ref_id, BonusAmount, BonusDate)
VALUES
(1, 5000, '2020-02-16'),
(2, 3000, '2011-06-16'),
(3, 4000, '2020-02-16'),
(1, 4500, '2020-02-16'),
(2, 3500, '2011-06-16');

INSERT INTO EmployeeTitle (Employee_ref_id, Employee_title, Affective_date)
VALUES
(1, 'Manager', '2016-02-20'),
(2, 'Executive', '2016-06-11'),
(8, 'Executive', '2016-06-11'),
(5, 'Manager', '2016-06-11'),
(4, 'Asst.Manager', '2016-06-11'),
(7, 'Executive', '2016-06-11'),
(6, 'Lead', '2016-06-11'),
(3, 'Lead', '2016-06-11');

SELECT FirstName AS Employee_name
FROM Employee;

SELECT UPPER(LastName) AS Last_Name
FROM Employee;

SELECT DISTINCT Department
FROM Employee;

SELECT SUBSTRING(LastName,1,3) AS First_Three_Chars
FROM Employee;

SELECT DISTINCT Department , LEN(Department) AS Lenght_dep
FROM Employee;

SELECT CONCAT(FirstName,' ',LastName) AS Full_Name
FROM Employee;

SELECT * FROM Employee
ORDER BY FirstName ;

SELECT * FROM Employee
ORDER BY FirstName ASC , Department DESC;

SELECT * FROM Employee
WHERE FirstName IN ('Veena','Karan');

SELECT * FROM Employee
WHERE Department ='Admin';

SELECT * FROM Employee
WHERE FirstName LIKE '%V%';

SELECT * FROM Employee
WHERE Salary > 100000 AND Salary < 500000;

SELECT * FROM Employee
WHERE YEAR(HireDate) = 2020 AND MONTH(HireDate) = 02;

SELECT * FROM Employee
WHERE Salary >= 50000 AND Salary <= 100000;

SELECT Department , COUNT(*) AS Emp_count
FROM Employee
GROUP BY Department
ORDER BY Emp_count DESC;

SELECT *
FROM Employee E
INNER JOIN EmployeeTitle ET ON E.EmployeeID = ET.Employee_ref_id
WHERE ET.Employee_title = 'Manager';

SELECT *
FROM Employee E
WHERE EXISTS (
    SELECT 1
    FROM Employee
    WHERE FirstName = E.FirstName AND LastName = E.LastName
    GROUP BY FirstName, LastName
    HAVING COUNT(*) > 1);


WITH RowNumberedEmployees AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY EmployeeID) AS RowNum
    FROM Employee
)
SELECT *
FROM RowNumberedEmployees
WHERE RowNum % 2 = 1;

SELECT *
INTO EmployeeClone
FROM Employee;

SELECT TOP 2 Salary 
FROM Employee
ORDER BY Salary DESC;

SELECT Salary , COUNT(*)
FROM Employee
GROUP BY Salary
HAVING COUNT(*)>1;

SELECT MAX(Salary) 
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee);

SELECT TOP (SELECT COUNT(*) / 2 FROM Employee) *
FROM Employee;

SELECT Department
FROM Employee
GROUP BY Department
HAVING COUNT(*)<4;

SELECT Department , COUNT(*) AS People_Num
FROM Employee
GROUP BY Department;

SELECT FirstName, LastName, Department, Salary
FROM Employee E
WHERE Salary = (
    SELECT MAX(Salary)
    FROM Employee
    WHERE Department = E.Department);

SELECT FirstName, LastName 
FROM Employee
WHERE Salary = (
       SELECT MAX(Salary) 
	   FROM Employee);


SELECT Department, AVG(Salary) AS Avg_Dep
FROM Employee
GROUP BY Department;


SELECT e.FirstName, e.LastName, eb.BonusAmount
FROM Employee e
JOIN EmployeeBonus eb ON e.EmployeeID = eb.Employee_ref_id
WHERE eb.BonusAmount = (
    SELECT MAX(BonusAmount)
    FROM EmployeeBonus);


SELECT e.FirstName, et.Employee_title
FROM Employee e
JOIN EmployeeTitle et ON e.EmployeeID = et.Employee_ref_id;
