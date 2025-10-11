-- create database and use it
create database try;
use try;

-- create employees table
create table employees (
    employee_id int auto_increment primary key,
    name varchar(100),
    position varchar(100),
    salary decimal(10,2),
    hire_date date
);

-- create employee_audit table
create table employee_audit (
    audit_id int auto_increment primary key,
    employee_id int,
    name varchar(100),
    position varchar(100),
    salary decimal(10,2),
    hire_date date,
    action_date timestamp default current_timestamp
);

-- insert sample data
insert into employees (name, position, salary, hire_date) values
('john doe', 'software engineer', 80000.00, '2022-01-15'),
('jane smith', 'project manager', 90000.00, '2021-05-22'),
('alice johnson', 'ux designer', 75000.00, '2023-03-01');

-- create trigger to log insert into employee_audit

delimiter $$
create trigger after_employee_insert
after insert on employees
for each row
begin
    insert into employee_audit (employee_id, name, position, salary, hire_date)
    values (new.employee_id, new.name, new.position, new.salary, new.hire_date);

end;
$$
delimiter ;

-- create stored procedure to add employee and auto log via trigger
delimiter $$
create  procedure add_employee(
    in p_name varchar(100),
    in p_position varchar(100),
    in p_salary decimal(10,2),
    in p_hire_date date
)
begin
    insert into employees (name, position, salary, hire_date)
    values (p_name, p_position, p_salary, p_hire_date);
end;
$$
delimiter ;

-- example: call procedure to add new employee
call add_employee('bob brown', 'qa engineer', 70000.00, '2025-10-10');

select * from employees;
select * from employee_audit;


