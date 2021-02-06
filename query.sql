/* EMPLOYEES TABLE QUERIES */

*DB: Employees
-- basic statement
select a.emp_no,
concat(a.first_name, a.last_name) as "name",
b.salary
from employees as a, salaries as b
where a.emp_no = b.emp_no
order by a.emp_no;

-- first inner join, not working properly
select a.emp_no,
concat(a.first_name, a.last_name) as "name",
b.salary, c.title
from employees as a
inner join salaries as b on b.emp_no = a.emp_no
inner join titles as c on c.emp_no = a.emp_no
order by a.emp_no;


-- final inner join, filtering by titles + date
select a.emp_no,
concat(a.first_name, a.last_name) as "name",
b.salary, c.title
from employees as a
inner join salaries as b on a.emp_no = b.emp_no
inner join titles as c 
on 	c.emp_no = a.emp_no and (
	c.from_date = (b.from_date + interval '2 days') or 
	c.from_date = b.from_date
)
order by a.emp_no;

-- see salary raises, that were both promotion and no promotion (left join)
select a.emp_no,
concat(a.first_name, a.last_name) as "name",
b.salary, coalesce(c.title, 'no title change'), coalesce(c.from_date::text, '-')
from employees as a
inner join  salaries as b on a.emp_no = b.emp_no
left join titles as c 
	on a.emp_no = c.emp_no and (
	c.from_date = (b.from_date + interval '2 days') or
	c.from_date = b.from_date
	)

--show department name of each employee
select concat(a.last_name, ' ', a.first_name),a.emp_no, b.dept_no, c.dept_name
from employees as a
inner join dept_emp as b on a.emp_no = b.emp_no
inner join departments as c on b.dept_no = c.dept_no


/* STORE TABLE QUERIES */

*DB: store
-- get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
select a.orderid, a.customerid, a.totalamount, b.state
from orders as a
inner join customers as b on a.customerid = b.customerid and
	b.state IN ('OH','NY','OR')
order by a.orderid;

*DB: store
-- show inventory for each product
select a.prod_id, a.quan_in_stock, b.title
from inventory as a
inner join products as b on a.prod_id = b.prod_id

