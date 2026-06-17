/* =========================
   1. DATABASE SETUP
========================= */
CREATE DATABASE EmployeeManagement;
USE EmployeeManagement;

/* =========================
   2. TABLE CREATION
========================= */

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Attendance Table
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT,
    AttendanceDate DATE,
    Status VARCHAR(10),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

/* =========================
   3. INSERT DATA
========================= */

INSERT INTO Departments VALUES
(1,'HR'), (2,'IT'), (3,'Finance'), (4,'Sales');

INSERT INTO Employees VALUES
(101,'Arun','arun@gmail.com',30000,2),
(102,'Vijay','vijay@gmail.com',35000,1),
(103,'Kumar','kumar@gmail.com',40000,2),
(104,'Priya','priya@gmail.com',45000,3),
(105,'Divya','divya@gmail.com',50000,4),
(106,'Rahul','rahul@gmail.com',32000,2),
(107,'Sneha','sneha@gmail.com',38000,1),
(108,'Karthik','karthik@gmail.com',42000,2),
(109,'Meena','meena@gmail.com',47000,3),
(110,'Ajith','ajith@gmail.com',55000,4),
(111,'Ramesh','ramesh@gmail.com',29000,1),
(112,'Suresh','suresh@gmail.com',36000,2),
(113,'Anitha','anitha@gmail.com',41000,3),
(114,'Lavanya','lavanya@gmail.com',48000,4),
(115,'Manoj','manoj@gmail.com',52000,2),
(116,'Keerthi','keerthi@gmail.com',34000,1),
(117,'Prakash','prakash@gmail.com',39000,2),
(118,'Nisha','nisha@gmail.com',46000,3),
(119,'Harish','harish@gmail.com',51000,4),
(120,'Deepa','deepa@gmail.com',58000,2),
(121,'Vignesh','vignesh@gmail.com',33000,1),
(122,'Aarthi','aarthi@gmail.com',37000,2),
(123,'Bala','bala@gmail.com',43000,3),
(124,'Gayathri','gayathri@gmail.com',49000,4),
(125,'Dinesh','dinesh@gmail.com',54000,2),
(126,'Shalini','shalini@gmail.com',31000,1),
(127,'Saravanan','saravanan@gmail.com',40000,2),
(128,'Pooja','pooja@gmail.com',45000,3),
(129,'Naveen','naveen@gmail.com',53000,4),
(130,'Reshma','reshma@gmail.com',60000,2);

INSERT INTO Attendance VALUES
(1,101,'2026-06-16','Present'),
(2,102,'2026-06-16','Absent'),
(3,103,'2026-06-16','Present'),
(4,104,'2026-06-16','Present'),
(5,105,'2026-06-16','Absent'),
(6,106,'2026-06-16','Present'),
(7,107,'2026-06-16','Present'),
(8,108,'2026-06-16','Absent'),
(9,109,'2026-06-16','Present'),
(10,110,'2026-06-16','Present'),
(11,111,'2026-06-16','Absent'),
(12,112,'2026-06-16','Present'),
(13,113,'2026-06-16','Present'),
(14,114,'2026-06-16','Absent'),
(15,115,'2026-06-16','Present'),
(16,116,'2026-06-16','Present'),
(17,117,'2026-06-16','Present'),
(18,118,'2026-06-16','Absent'),
(19,119,'2026-06-16','Present'),
(20,120,'2026-06-16','Present'),
(21,121,'2026-06-16','Absent'),
(22,122,'2026-06-16','Present'),
(23,123,'2026-06-16','Present'),
(24,124,'2026-06-16','Absent'),
(25,125,'2026-06-16','Present'),
(26,126,'2026-06-16','Present'),
(27,127,'2026-06-16','Absent'),
(28,128,'2026-06-16','Present'),
(29,129,'2026-06-16','Present'),
(30,130,'2026-06-16','Present');

/* =========================
   4. BASIC QUERIES
========================= */

SELECT * FROM Employees;

SELECT E.EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D
ON E.DepartmentID = D.DepartmentID;

SELECT * FROM Employees
WHERE Salary > 40000;

SELECT *
FROM Employees
ORDER BY Salary DESC
LIMIT 1;

SELECT *
FROM Employees
ORDER BY Salary ASC
LIMIT 1;

/* =========================
   5. AGGREGATE QUERIES
========================= */

SELECT COUNT(*) AS TotalEmployees FROM Employees;

SELECT AVG(Salary) AS AverageSalary FROM Employees;

SELECT D.DepartmentName,
       SUM(E.Salary) AS TotalSalary
FROM Employees E
JOIN Departments D
ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName;

SELECT D.DepartmentName,
       COUNT(*) AS EmployeeCount
FROM Employees E
JOIN Departments D
ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName;

SELECT D.DepartmentName,
       MAX(E.Salary) AS HighestSalary
FROM Employees E
JOIN Departments D
ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName;

/* =========================
   6. ATTENDANCE QUERIES
==========================*/

SELECT * FROM Attendance WHERE Status='Present';

SELECT * FROM Attendance WHERE Status='Absent';

SELECT E.EmployeeName, A.AttendanceDate, A.Status
FROM Employees E
JOIN Attendance A
ON E.EmployeeID = A.EmployeeID;

/* =========================
   7. VIEW
========================= */

CREATE VIEW EmployeeDepartmentView AS
SELECT
    E.EmployeeID,
    E.EmployeeName,
    D.DepartmentName,
    E.Salary
FROM Employees E
JOIN Departments D
ON E.DepartmentID = D.DepartmentID;

SELECT * FROM EmployeeDepartmentView;

/* =========================
   8. STORED PROCEDURE
========================= */

DELIMITER $$

CREATE PROCEDURE GetEmployeesByDepartment(IN DeptID INT)
BEGIN
    SELECT *
    FROM Employees
    WHERE DepartmentID = DeptID;
END $$

DELIMITER ;

CALL GetEmployeesByDepartment(2);

/* =========================
   9. TRIGGER + AUDIT
========================= */

CREATE TABLE SalaryAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER SalaryUpdateTrigger
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN
    IF OLD.Salary <> NEW.Salary THEN
        INSERT INTO SalaryAudit(EmployeeID, OldSalary, NewSalary)
        VALUES (OLD.EmployeeID, OLD.Salary, NEW.Salary);
    END IF;
END $$

DELIMITER ;

-- Test trigger
UPDATE Employees
SET Salary = 65000
WHERE EmployeeID = 101;

SELECT * FROM SalaryAudit;
