.load dist/math_funcs

select pi();
[{"pi()":3.1415926535897931159}]
create table recs(id integer primary key, name text, price integer, year integer);
insert into recs(name, price, year) values ('car10', 100, 2015), ('car2', 200, 2016);
insert into recs(name, price, year) values ('car6', 300, 2018), ('car4', 150, 2014);

select * from recs;
[{"id":1,"name":"car10","price":100,"year":2015},
{"id":2,"name":"car2","price":200,"year":2016},
{"id":3,"name":"car6","price":300,"year":2018},
{"id":4,"name":"car4","price":150,"year":2014}]
select product(price) from recs;
[{"product(price)":900000000.0}]
select median(price) from recs;
[{"median(price)":175.0}]
SELECT COVAR_POP(price,year) FROM recs;
[{"COVAR_POP(price,year)":96.875}]
