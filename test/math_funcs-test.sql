.read test/_settings.sql
.load dist/math_funcs

select pi();
create table recs(id integer primary key, name text, price integer, year integer);
insert into recs(name, price, year) values ('car10', 100, 2015), ('car2', 200, 2016);
insert into recs(name, price, year) values ('car6', 300, 2018), ('car4', 150, 2014);

select * from recs;
select product(price) from recs;
select median(price) from recs;
SELECT COVAR_POP(price,year) FROM recs;
