use world;
-- show tables;
-- select * from city;
select * from country;
-- BASIC functions
-- string related function
-- case conversition
select Name,upper(Name),lower(Name)from country;
select name,code,concat(Name,'$',code)from country;
select * from country where Region like '%Europe';
select * from country where Region like concat('%',continent);
select Name, Region, continent from country
where Region like concat('%',continent);
select Name, Region from country where Name like Region;
-- country name,population where first character of the continent same as country
select Name ,Population from country where Name like'_%' = continent like '%';
-- first character from from left()function
select Name,Population,continent from country
where left(continent,1)=left(Name,1);
-- SUBSTRING substr 
select Name,substr(Name,1) from country;
select Name,substr(Name,1,4) from country;
select Name,substr(Name,-1) from country;
select Name,substr(Name,-4,2) from country;
select Name,continent from country 
where substr(Name,1,1)=substr(continent,1,1);
-- get country name and population where starting 3 character of country is alg
select Name , population from country 
where substr(Name,1,3)='alg';
-- searching the location in string
select name,instr(name,'e') from country;
select name,char_length(name) from country;
select char_length('         deen    ');
-- trim remove extra spaces in data
select char_length(trim('        deendd xx  '));
select trim(both 'x' from ' deen  xxx');
-- lpad and rpad when we want to define string with fix charcter
select name,population,rpad(population,9,'#') from country;
select name,population,lpad(population,9,'0') from country;
-- NUMERIC AND Date function
select lifeexpectancy , round(lifeexpectancy) from country;
select 60.27 , round(60.27,1); 
-- round => round of to the nearest 10th place
select 6.0012 , round(6.0012,-1);
select 127.0001 , round(127.0001,-2);
-- truncate value extract
select 2005.34,round(2005.36,1),truncate(2005.34,1);
select mod(10,3),ceil(4.0001),floor(4.99999),power(2,4);
-- date function
select now(),current_date(),current_time(),current_timestamp();
-- add date function => by default add date(month,year,time)
select now(),adddate(now(),2),adddate(now(),interval 2 month);
select now(),subdate(now(),2);
select now(),extract(year from now());
SELECT DAYOFYEAR(CURDATE());
select now(),extract(year from now()),date_format(now(),'year is %Y');
-- aggregate function (multiline function) will give some result
-- distinct gives you unique values
 select distinct continent from country;
 select distinct continent,region from country;
 -- aggregate function to apply calculation 
 select * from country;
 select indepyear from country;
 select count(indepyear) from country;
 select count(*)  from country;
select count(population),sum(population),min(population), max(population),avg(population) from country;
select count(indepyear),count(*) from country where continent='asia';
-- get the  total country name the total region along with avg life expectancy and total population for 
-- the country who got the independence after 1947 before 1998
select * from country;
select count(name),count(region),avg(lifeexpectancy),sum(population) from country
where indepyear between 1947 and 1998;
SELECT COUNT(name) AS country_count,COUNT(region) AS region_count,AVG(lifeexpectancy) AS avg_life_expectancy,
SUM(population) AS total_population FROM country
WHERE indepyear > 1947 AND indepyear < 1998;
-- total no of country unique regions along with total population and highest lifeexpetecncy rate the total
-- capital for the country starting with letter a and d 
select count(name), count(distinct region),sum(population),max(lifeexpectancy),count(capital) from country
where name like 'A%' or  name like 'D%';
-- groupby select similar values  from group
select continent ,count(name)from country group by continent;
select name from country group by name;
-- total countries and total population for each independent year
select indepyear,count(name), sum(population) from country group by indepyear  order by 1;
SELECT indepyear,COUNT(name) AS total_countries,SUM(population) AS total_population
FROM country WHERE indepyear IS NOT NULL GROUP BY indepyear ORDER BY indepyear;
-- WHERE IS APPLIED ON PHYSICAL COLUMN PRESENT IN TABLE 
-- having is used to find value of coluumn where physical data is not present
-- having is used by group by
 select continent,count(name) from country group by continent having count(name);
 select continent from country group by continent;
 select indepyear , count(name) from country group by indepyear;
 --  who got indepyaer after 1930
 select indepyear,count(name) from country where indepyear >1930 group by indepyear order by indepyear;
 select indepyear,count(name) from country where indepyear >1930 group by indepyear 
 having count(name)>2  order by indepyear;
 --  goverment form  where total number of country > 20
 -- goverment form where country should have capital greater then 30
 -- get no of country and region with total population where life expectancy should be grater then 38 and population in each continent shouls be grater then 3000000
 select GovernmentForm, count(name)  from country  group by GovernmentForm having count(name)>20 ;
 select GovernmentForm ,count(Capital) from country where capital >30 group by GovernmentForm;
 select continent,count(name),count(region) ,sum(population) from country where lifeexpectancy >38  group by continent having sum(population)>3000000; 


