 -- dcl : Data control Language
 -- Permission which user can accessibility 
 -- Authentication and authorization
create user  regex identified by 'regex';
 select * from mysql.user;
 create database ddc;
 use ddc;
create table a as select actor_id,first_name from sakila.actor where actor_id between 1 and 5;
create table ab as select actor_id,first_name from sakila.actor where actor_id between 3 and 7;
show grants for regex; -- check permission
-- grant permission on database to user name
grant select on ddc.ab to regex; -- giving permission
grant select on ddc.* to regex; -- for full acess
grant all privileges on ddc.a to regex;
show grants for regex;
select * from a;
______________________________
another database
use ddc;
select * from ddc.a;
delete from a;
delete from ab;
