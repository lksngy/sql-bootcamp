-- copy of queries from DBeaver

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
inner join titles as c on c.emp_no = a.emp_no
and c.from_date = (b.from_date + interval '2 days')
order by a.emp_no;
