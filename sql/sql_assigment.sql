create database company;
use company;

create table company (
 company_id int primary key,
 company_name varchar(45),
 street varchar(45),
 city varchar(45),
 state varchar(2),
 zip varchar(10)
 );
 
insert into company(company_id,company_name,street, city, state, zip)
values
(1, 'Toll Brothers', '123 Elm Street', 'New York', 'NY', '10001'),
(2, 'Urban Outfitters, Inc.', '789 Pine Avenue', 'Los Angeles', 'CA', '90001'),
(3, 'Apple Inc.', '1 Infinite Loop', 'Cupertino', 'CA', '95014');

--  1) create table contact

create table contact ( 
      contact_id int primary key,
      company_id  int,
      first_name varchar(45),
      last_name varchar(45),
      stret varchar(45),
      city varchar(45),
      state varchar(10),
      zip varchar(10),
      ismain boolean,
      email varchar(45),
      phone varchar(12),
      foreign key (company_id) references company(company_id)
      );
      
insert into contact (contact_id, company_id, first_name, last_name, stret, city, state, zip, ismain, email, phone)
values
(1, 1, 'Dianne', 'Connor', '12 Maple Street', 'New York', 'NY', '10002', TRUE, 'dianne.connor@toll.com', '212-555-1111'),
(2, 2, 'Lesley', 'Bland', '45 Oak Road', 'Los Angeles', 'CA', '90002', FALSE, 'lesley.bland@urban.com', '213-555-2222'),
(3, 3, 'John', 'Smith', '56 Cherry Lane', 'Cupertino', 'CA', '95014', TRUE, 'john.smith@apple.com', '408-555-3333');
      
-- 2) create table employee      
      
create table employee (
	employee_id int primary key,
    first_name varchar(45),
    last_name varchar(45),
    salary decimal(10,2),
    hiredate date,
    jobtitle varchar(25),
    email varchar(45),
    phone varchar(12)
    );
    
insert into employee (employee_id, first_name, last_name, salary, hiredate, jobtitle, email, phone)
values
(1, 'Jack', 'Lee', 65000.00, '2018-05-15', 'Sales Rep', 'jack.lee@marketco.com', '215-555-4444'),
(2, 'Sarah', 'Brown', 72000.00, '2019-03-12', 'Manager', 'sarah.brown@marketco.com', '215-555-5555'),
(3, 'Lesley', 'Bland', 68000.00, '2020-01-20', 'Account Executive', 'lesley.bland@marketco.com', '215-555-6666');

select * from employee;

-- 3) create table contactemployee

create table contact_employee (
	contact_emp_id int primary key,
    contact_id int,
    employee_id int,
    contact_date date,
    description varchar(100),
    foreign key (employee_id) references employee(employee_id),
    foreign key (contact_id) references contact(contact_id)
    );
    
insert contact_employee (contact_emp_id, contact_id, employee_id, contact_date, description)
values
(1, 1, 1, '2024-03-12', 'Meeting with Dianne Connor regarding Toll Brothers project'),
(2, 2, 2, '2024-05-25', 'Discussion with Lesley Bland about Urban Outfitters'),
(3, 3, 3, '2024-06-10', 'Follow-up meeting with Apple Inc. contact');

-- 4) update lesley bland’s phone number

update employee
set phone = '215-555-8800'
where first_name = 'lesley' and last_name = 'bland';

-- 5) update company name

update company
set company_name = 'urban outfitters'
where company_name = 'urban outfitters, inc.';


-- 6) delete dianne connor’s contact event with jack lee

delete from contactemployee
where contact_id = (
  select contact_id from contact
  where first_name = 'dianne' and last_name = 'connor'
)
and employee_id = (
  select employee_id from employee
  where first_name = 'jack' and last_name = 'lee'
);

-- 7)select employees who contacted toll brothers

select * from company;
select * from contact;
select * from contact_employee;
select * from employee;


select e.first_name, e.last_name
from employee e
join contactemployee ce on e.employee_id = ce.employee_id
join contact c on ce.contact_id = c.contact_id
join company co on c.company_id = co.company_id
where co.company_name = 'toll brothers';


-- 8) meaning of % and _ in like statement

-- % means any number of characters (zero or more)
-- example: like 'a%' → names starting with a

-- _ means exactly one character
-- example: like '_a%' → names with 'a' as second letter



-- 9) what is normalization

-- normalization is the process of organizing data in a database to reduce redundancy and improve data integrity.

-- 1nf → remove repeating groups

-- 2nf → remove partial dependencies

-- 3nf → remove transitive dependencies



-- 10) what is join in mysql

-- join is used to combine rows from two or more tables based on a related column between them.



-- 11) ddl, dml, dcl in mysql

-- ddl (data definition language): create, alter, drop, truncate

-- dml (data manipulation language): insert, update, delete, select

-- dcl (data control language): grant, revoke

-- 1️. DDL – Data Definition Language
-- DDL is used to define or modify the structure of database objects such as tables, indexes, and schemas. It deals with schema-level changes.

-- Examples:
-- CREATE → Creates a new table, database, or index.

-- ALTER → Modifies the structure of an existing table.

-- DROP → Deletes a table, database, or index permanently.

-- TRUNCATE → Removes all records from a table but keeps the table structure.

-- 2️. DML – Data Manipulation Language
-- DML is used to manipulate the data stored in database objects. It deals with record-level operations.

-- Examples:
-- INSERT → Adds new records into a table.

-- UPDATE → Modifies existing records in a table.

-- DELETE → Removes records from a table.

-- SELECT → Retrieves data from one or more tables.



-- 3️. DCL – Data Control Language
-- 
-- DCL is used to control access and permissions on database objects. It defines who can do what in the database.

-- examples:
-- GRANT → Gives privileges to a user or role.

-- REVOKE → Removes previously granted privileges.



-- 12) types of join in mysql

-- inner join → returns matching rows from both tables

-- left join → all rows from left table and matching from right

-- right join → all rows from right table and matching from left

-- full join → all rows when there is match in either table

      