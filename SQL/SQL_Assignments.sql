create database marketcompany;

use marketcompany;

create table M_company(
companyid  int Primary key not null,
company_name varchar(45) not null,
street varchar(45) not null,
city varchar(45) not null,
state varchar(45) not null,
zip varchar(10) not null);

create table M_contact(
contact_id int  not null,
companyid int not null,
Firstname varchar(45) not null,
Lastname varchar(45),
street varchar(45) not null,
city varchar(45) not null,
state varchar(5) not null,
zip varchar(10) not null,
Ismain boolean,
Email varchar(45),
Phone varchar(12) not null,
PRIMARY KEY (contact_id),
FOREIGN KEY (companyid) REFERENCES M_company(companyid));

create table M_contactemployee(
ContactEmployee_id int not null,
contact_id int not null,
Employee_id int not null,
Contact_date date,
Descriptions varchar(100),
PRIMARY KEY (Employee_id),
FOREIGN KEY (contact_id) REFERENCES M_contact(contact_id));

create table M_employee(
Employee_id int not null,
Firstname varchar(45) not null,
Lastname varchar(45),
salary float ,
Hiredate date,
JobTitle varchar(45),
Email varchar(45),
Phone varchar(12) not null,
FOREIGN KEY (Employee_id) REFERENCES M_contactemployee(Employee_id));


INSERT INTO M_company (companyid, company_name, street, city, state, zip)
VALUES 
(1, 'Toll Brothers', '123 Main St', 'New York', 'NY', '10001'),
(2, 'Urban Outfitters, Inc.', '456 Fashion Ave', 'Los Angeles', 'CA', '90001'),
(3, 'Tech Innovators', '789 Silicon Blvd', 'San Francisco', 'CA', '94105'),
(4, 'Green Energy Solutions', '101 Renewable St', 'Austin', 'TX', '73301');

select * from M_company;

INSERT INTO M_contact (contact_id, companyid, Firstname, Lastname, street, city, state, zip, Ismain, Email, Phone)
VALUES 
(1, 1, 'Jack', 'Lee', '321 Elm St', 'New York', 'NY', '10001', TRUE, 'jack.lee@example.com', '123-456-7890'),
(2, 2, 'Sarah', 'Miller', '654 Maple Ave', 'Los Angeles', 'CA', '90001', TRUE, 'sarah.m@example.com', '987-654-3210'),
(3, 3, 'Tom', 'Johnson', '987 Pine St', 'San Francisco', 'CA', '94105', FALSE, 'tom.j@example.com', '111-222-3333'),
(4, 4, 'Dianne', 'Connor', '147 Cedar Rd', 'Austin', 'TX', '73301', FALSE, 'dianne.c@example.com', '444-555-6666');

select * from M_contact;

INSERT INTO M_employee (Employee_id, Firstname, Lastname, salary, Hiredate, JobTitle, Email, Phone)
VALUES 
(1, 'Lesley', 'Bland', 60000, '2020-03-15', 'Manager', 'lesley.b@example.com', '222-333-4444'),
(2, 'Michael', 'Adams', 55000, '2019-07-10', 'Supervisor', 'michael.a@example.com', '555-666-7777'),
(3, 'Sophia', 'Wright', 48000, '2021-06-05', 'Analyst', 'sophia.w@example.com', '888-999-0000'),
(4, 'David', 'Clark', 65000, '2018-02-20', 'Director', 'david.c@example.com', '111-222-3333');
select * from M_employee;


INSERT INTO M_contactemployee (ContactEmployee_id, contact_id, Employee_id, Contact_date, Descriptions)
VALUES 
(1, 1, 1, '2024-01-10', 'Meeting with Jack Lee'),
(2, 2, 2, '2024-02-15', 'Discussed contract with Sarah'),
(3, 3, 3, '2024-03-20', 'Tech consultation with Tom'),
(4, 4, 4, '2024-04-25', 'Strategy discussion with Dianne Connor');





--  Q.1) Statement to create the Contact table.
 /* create table M_contact(
contact_id int  not null,
companyid int not null,
Firstname varchar(45) not null,
Lastname varchar(45),
street varchar(45) not null,
city varchar(45) not null,
state varchar(5) not null,
zip varchar(10) not null,
Ismain boolean,
Email varchar(45),
Phone varchar(12) not null,
PRIMARY KEY (contact_id),
FOREIGN KEY (companyid) REFERENCES M_company(companyid)); */

-- Q.2) Statement to create the Employee table.
/* create table M_employee(
Employee_id int not null,
Firstname varchar(45) not null,
Lastname varchar(45),
salary float ,
Hiredate date,
JobTitle varchar(45),
Email varchar(45),
Phone varchar(12) not null,
FOREIGN KEY (Employee_id) REFERENCES M_contactemployee(Employee_id));*/

-- 3) Statement to create the ContactEmployee table.
/* create table M_contactemployee(
ContactEmployee_id int not null,
contact_id int not null,
Employee_id int not null,
Contact_date date,
Descriptions varchar(100),
PRIMARY KEY (Employee_id),
FOREIGN KEY (contact_id) REFERENCES M_contact(contact_id)); */

-- Q.4) In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800.
set sql_safe_updates = 0;

update M_employee
set Phone = 215-555-8800
where Firstname = "Lesley" ;

set sql_safe_updates = 1;

-- Q.5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” . 
update M_company
set company_name = "Urban Outfitters"
WHERE companyid = 1 ;

select * from M_ContactEmployee;
-- Q.6) In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement).
delete from M_Contactemployee
where Employee_id = 4 and Contact_id = 4;

DELETE FROM M_ContactEmployee 
WHERE contact_id = (SELECT contact_id FROM M_contact WHERE Firstname = 'Dianne' AND Lastname = 'Connor')
AND Employee_id = (SELECT Employee_id FROM M_employee WHERE Firstname = 'Jack' AND Lastname = 'Lee');

select * from M_ContactEmployee;

select * from M_contact;
select * from M_employee;

-- Q.7) Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement). Run the SQL SELECT query in MySQL Workbench. Copy the results below as well
SELECT DISTINCT M_employee.Firstname, M_employee.Lastname
FROM M_employee
JOIN M_contactemployee ON M_employee.Employee_id = M_contactemployee.Employee_id
JOIN M_contact ON M_contactemployee.contact_id = M_contact.contact_id
JOIN M_company ON M_contact.companyid = M_company.companyid
WHERE M_company.company_name = 'Toll Brothers';

-- Q.8) What is the significance of “%” and “_” operators in the LIKE statement?

SELECT * FROM M_employee WHERE Firstname LIKE 'S%';

-- Q.9) Explain normalization in the context of databases. 
/*Normalization in databases is the process of organizing data to:
Remove redundancy (duplicate data)
Ensure data integrity (no inconsistencies)
Reduce storage waste
Improve efficiency of queries
Common Normal Forms:

1NF (First Normal Form) → No duplicate rows & unique column values.
2NF (Second Normal Form) → No partial dependencies.
3NF (Third Normal Form) → No transitive dependencies. */

-- Q.10) What does a join in MySQL mean?
/* A JOIN in MySQL is used to combine records from multiple tables based on a related column.

Common Types of JOINs:

INNER JOIN → Returns matching records from both tables.
LEFT JOIN → Returns all records from the left table + matching from right.
RIGHT JOIN → Returns all records from the right table + matching from left.
FULL OUTER JOIN → Returns all records from both tables (not supported in MySQL directly). */

-- Q.11) 19.What do you understand about DDL, DCL, and DML in MySQL? 
/* DDL (Data Definition Language) → Defines structure (CREATE, ALTER, DROP)
DML (Data Manipulation Language) → Manages data (INSERT, UPDATE, DELETE)
DCL (Data Control Language) → Manages permissions (GRANT, REVOKE) */

-- Q.12) What is the role of the MySQL JOIN clause in a query, and what are some common types of joins? 
/* A JOIN is used to combine rows from two or more tables based on a related column between them. It allows you to retrieve data from multiple tables in a single query.

Common types of JOINs:

INNER JOIN: Returns only the rows that have matching values in both tables.
LEFT JOIN: Returns all rows from the left table, and the matched rows from the right table (if there’s no match, NULL values are returned).
RIGHT JOIN: Returns all rows from the right table, and the matched rows from the left table.
FULL OUTER JOIN: Returns rows when there’s a match in one of the tables (not supported in MySQL directly but can be simulated).*/

/*QUESTION :11:  DDL, DCL, and DML in MySQL:
DDL (Data Definition Language): Includes SQL statements like CREATE, ALTER, DROP that define or modify the structure of database objects like tables, indexes, etc.
DCL (Data Control Language): Includes SQL statements like GRANT and REVOKE to control access to data.
DML (Data Manipulation Language): Includes SQL statements like SELECT, INSERT, UPDATE, DELETE that manipulate data stored in the database.*/

/*QUESTION : 12: Role of the MySQL JOIN clause and common types of joins:
The JOIN clause is used to combine rows from two or more tables in a database based on a related column between them. It is essential for retrieving data from multiple tables in a single query.

Common types of JOINs:

INNER JOIN: Returns only rows that have matching values in both tables.
LEFT JOIN (LEFT OUTER JOIN): Returns all rows from the left table and matched rows from the right table.
RIGHT JOIN (RIGHT OUTER JOIN): Returns all rows from the right table and matched rows from the left table.
FULL OUTER JOIN: Returns all rows when there’s a match in one of the tables */






 




 