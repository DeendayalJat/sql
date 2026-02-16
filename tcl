-- TCL transaction control language
-- transaction -> set of logical statement (not permanent)
use dd;
create table actor_cp as select actor_id,first_name from sakila.actor
where actor_id between 1 and 5;
select * from actor_cp;
select * from actor_cp2;
-- select @@autocommit;
set autocommit=0;
insert into actor_cp2 value(6,'srk');
rollback; -- will disable and move to last saved values
insert into actor_cp2 value(8,'hysww');
set autocommit=1;
-- transaction start when:
-- DML is execute starting of tansaction with:
--   ___ start keyword
-- when transaction automtic close 
-- when use commit rollback in tcl our transactin will close
-- or ddl operation will also close transaction
commit;
rollback;
start transaction;
insert into actor_cp2 value(102,'sid');
select * from actor_cp2;
commit;
start transaction;
insert into actor_cp2 value(123,'sfe');
savepoint _db_actor_cp2_savepoint1;-- till u want to save -- savepoint savepoint_name
delete from actor_cp2 where actor_id=2;
-- rollback;
-- rollback till spacific point -- rollback to savepoint_name
rollback to _db_actor_cp2_savepoint1;
select * from actor_cp2;
commit;
USE dd;
-- cte -> common table expression
-- tempory name for sql
-- store data temporary and make querry readable
-- ; is the termination point
with copy_cte as (select * from sakila.actor)
select * from copy_cte;
select * from copy_cte;
with cte as (select * from sakila.payment)
-- select * from cte
-- select month(payment_date),count(*) from cte group by month(payment_date)
 select *,dense_rank() over(order by amount desc) as ranking from cte;
 with cte1 as (select *,dense_rank() over(order by amount desc) as ranking from sakila.payment)
 select * from cte1 where ranking = 2;
 with cte1 as (select *,dense_rank() over( partition by customer_id order by amount desc) as ranking from sakila.payment)
select * from cte1 where ranking = 2; -- second highest amount for each customer
-- with cte as ( select department as dept, avg(salary) as deptsalary from employee group by department)
-- select emo_id,emp_name,department,salary,dept,deptsalary from employee as execute 
-- join cte cte where e.department=cte.dept
-- and salary > deptsalary;
-- RECURSIVE CTE
 select actor_id,first_name from sakila.actor where actor_id between 1 and 4
 union
 select actor_id,first_name from sakila.actor where actor_id between 3 and 5;
 select actor_id,first_name from sakila.actor where actor_id between 1 and 4
 union all
 select actor_id,first_name from sakila.actor where actor_id between 3 and 5;
 with  recursive cte as 
 (select 10 as n-- assigning
 union all
 select n+1 from cte -- cte call
 where n <16 -- termininating
 )
 select * from cte;
 -- employee hierarchy
 
create table employees ( employee_id int primary key,
name varchar(50), manager_id int);
insert into  employees (employee_id,name,manager_id) values
(1,'alice',null),-- ceo
(2,'bob',1),-- report to alice
(3,'deb',2),-- bob
(4,'mob',2),-- bob
(5,'eve',3);-- deb
select * from employees;
with recursive cte as (
select employee_id,name,name  as hierarchy_path from employees where manager_id is null 
union all
select e.employee_id,e.name as hierarchy_path,concat(name ,'->',hierarchy_path ) from employees as e
join cte where e.manager_id= cte.employee_id and e.manger_id <5)
select * from cte;
WITH RECURSIVE cte AS (
    -- Anchor query (root)
    SELECT employee_id, name,cast(name AS CHAR(100)) AS hierarchy_path
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    -- Recursive query
    SELECT e.employee_id,e.name,CONCAT(c.hierarchy_path, ' -> ', e.name) AS hierarchy_path
    FROM employees e
    JOIN cte c
        ON e.manager_id = c.employee_id
    WHERE e.manager_id < 5
)
SELECT * FROM cte;
WITH RECURSIVE cte AS (SELECT employee_id, name, manager_id, 1 AS level FROM employees WHERE manager_id IS NULL
UNION ALL
SELECT e.employee_id, e.name, e.manager_id, c.level + 1 FROM employees e JOIN cte c ON e.manager_id = c.employee_id)
SELECT * FROM cte;

with recursive xyz as (
select employee_id,name,name as hierarchy_path from employees where manager_id is null
union all
select e.employee_id,e.name,concat(name ,'->',hierarchy_path ) from employees as e
join xyz where e.manager_id = xyz.employee_id and e.employee_id < 3
 )
select * from xyz;
with recursive cte as(
select employee_id ,name ,name as level_of_job from employees where manager_id  is null
union all 
select e.employee_id,e.name,concat(name,'->',level_of_job))
 
