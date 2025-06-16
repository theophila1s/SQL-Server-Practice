
----------------------------------------------------SQL SERVER QUERY -9         `                   

use Sample;

CREATE TABLE Employeestable (
    Emp_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department_ID INT,
    Manager_ID INT,
    Salary DECIMAL(10, 2)
);

SELECT * FROM Employeestable;

CREATE TABLE Departments (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL,
    Manager_ID INT
);

CREATE TABLE Projects (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(100) NOT NULL,
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Departments(Department_ID)
);

CREATE TABLE Employee_Projects (
    Emp_ID INT,
    Project_ID INT,
    Role VARCHAR(50),
    FOREIGN KEY (Emp_ID) REFERENCES Employees(Emp_ID),
    FOREIGN KEY (Project_ID) REFERENCES Projects(Project_ID),
    PRIMARY KEY (Emp_ID, Project_ID)
);


------------------- Inserting 
INSERT INTO Employeestable (Emp_ID, Name, Department_ID, Manager_ID, Salary)
VALUES 
        (1,'Ravina',100,200,28000),
         (2,'Shreya',101,201,70000),
          (3,'Monish',102,201,25000),
           (4,'Salman',103,202,10000),
            (5,'Seetha',102,202,45000),
             (6,'Ramya',102,203,33000);


INSERT INTO Departments (Department_ID, Department_Name, Manager_ID) 
VALUES 
        (100,'Saran',200),
        (101,'Priya',201),
        (102,'Diya',201),
        (104,'Zoya',201),
        (103,'Renu',202);

UPDATE Departments SET Department_Name = 'IT' WHERE Department_ID = 100;
UPDATE Departments SET Department_Name = 'IT' WHERE Department_ID = 103;
UPDATE Departments SET Department_Name = 'IT' WHERE Department_ID = 104;
UPDATE Departments SET Department_Name = 'BDE' WHERE Department_ID = 102;
UPDATE Departments SET Department_Name = 'Management' WHERE Department_ID = 101;

INSERT INTO Projects (Project_ID, Project_Name, Department_ID) 
VALUES 
        (301,'IT Support', 100),
        (302,'Product Mngmt', 101),
        (303,'Sales', 102),
        (304,'Development', 104),
        (305,'Agile Dev.', 103);

INSERT INTO Employee_Projects (Emp_ID, Project_ID, Role )
VALUES 
        (1,301,'Associate'),
        (2,302,'Technical Support'),
        (3,303,'Sales Executive'),
        (4,304,'Graduate Trainer'),
        (5,305,'Senior Developer');

SELECT* FROM Employeestable;
SELECT * FROM Departments;
SELECT * FROM Projects;
SELECT* FROM Employee_Projects;

-------------JOIN

SELECT  E.Emp_ID, E.Name, d.Department_Name
FROM Employeestable E
INNER JOIN Departments d ON
E.Department_ID = d.Department_ID;


------- MULTIPLE JOINS ON MULTIPLE TABLES

SELECT E.Name,d.Department_Name,p.Project_Name,ep.Role,E.Salary
FROM Employeestable E
JOIN Departments d ON E.Department_ID = d.Department_ID
LEFT JOIN Projects p ON d.Department_ID = P.Department_ID
RIGHT JOIN Employee_Projects ep ON p.Project_ID = ep.Project_ID ;

--------- LEFT JOINS
SELECT E.Name,d.Department_Name
FROM Departments d 
LEFT JOIN Employeestable E ON d.Department_ID = E.Department_ID;


----------------------------------------------------SQL SERVER QUERY -10
----Normalized Design Example

CREATE TABLE Students_Subjects (
    Student_ID INT,
    Subject VARCHAR(50),
    PRIMARY KEY (Student_ID, Subject)
);



--- 2NF 

CREATE TABLE Ordertables (
    Order_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100)
);

CREATE TABLE Order_Product (
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    FOREIGN KEY (Order_ID) REFERENCES Ordertables(Order_ID)
);



---3NF

CREATE TABLE Employees_Normalizedd (
    Emp_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Departments_Normalizedd(Dept_ID)
);

CREATE TABLE Departments_Normalizedd (
    Dept_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100),
    Manager_ID INT
);

CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100)
);



CREATE TABLE Enrollments (
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE NOT NULL,
    Grade VARCHAR(2),
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID),
    PRIMARY KEY (Student_ID, Course_ID)
);


INSERT INTO Students_Subjects (Student_ID, Subject)
VALUES 
(1, 'Math'),
(2, 'Science'),
(3, 'Math'),
(4, 'English'),
(5, 'Science');

INSERT INTO Ordertables (Order_ID, Customer_Name)
VALUES 
(101, 'Alice'),
(102, 'Bob'),
(103, 'Charlie'),
(104, 'David'),
(105, 'Eva');


INSERT INTO Order_Product (Order_ID, Product_ID, Quantity)
VALUES 
(101, 1, 2),
(102, 2, 1),
(103, 3, 5),
(104, 2, 3),
(105, 1, 1);

INSERT INTO Departments_Normalizedd (Dept_ID, Department_Name, Manager_ID)
VALUES 
(1, 'HR', 201),
(2, 'IT', 202),
(3, 'Sales', 203),
(4, 'Finance', 204),
(5, 'Marketing', 205);

INSERT INTO Employees_Normalizedd (Emp_ID, Name, Dept_ID)
VALUES 
(501, 'John', 1),
(502, 'Sara', 2),
(503, 'Mike', 2),
(504, 'Tina', 4),
(505, 'Alex', 5);

INSERT INTO Courses (Course_ID, Course_Name)
VALUES 
(101, 'Python'),
(102, 'Java'),
(103, 'Data Science'),
(104, 'SQL'),
(105, 'Cloud Computing');

CREATE TABLE Stud (
    Student_ID INT PRIMARY KEY,
    Stud_Name VARCHAR(100)
);

INSERT INTO Stud (Student_ID, Stud_Name)
VALUES 
(1, 'Anu'),
(2, 'Raj'),
(3, 'Priya'),
(4, 'Vikram'),
(5, 'Sneha');



INSERT INTO Enrollments (Student_ID, Course_ID, Enrollment_Date, Grade)
VALUES 
(1, 101, '2024-06-01', 'A'),
(2, 102, '2024-06-02', 'B'),
(3, 103, '2024-06-03', 'A'),
(4, 104, '2024-06-04', 'C'),
(5, 105, '2024-06-05', 'B');

SELECT s.Stud_Name, c.Course_Name
FROM Enrollments e
JOIN Stud s ON e.Student_ID = s.Student_ID
JOIN Courses c ON e.Course_ID = c.Course_ID;


SELECT * 
FROM Employees_Normalizedd
WHERE Name LIKE 'S%';

UPDATE Employees_Normalizedd
SET Dept_ID = 3
WHERE Name = 'Sara';

