
\conninfo
\encoding

\dt

create table menu (
id int,
item varchar(10),
price numeric);

\dt

insert into menu values (1, 'GBJD',10);
select * from menu;
insert into menu values (2, 'GBRD',15), (3, 'GBNRD', 20);
select * from menu;
insert into menu(id, item) values (4, 'XHSCJD');
select * from menu;

select * 
from menu
where price > 15;

select * 
from menu
where price >= 15;

select * 
from menu
where price = null;

delete from menu where price = 15;
select * from menu;

delete from menu where price = null;
select * from menu;

delete from menu where price is null;

\c - wen
create database restaurant;
\c - wayne

\d pg_catalog.pg_authid
select * from pg_catalog.pg_authid;
drop user wen;
create user wen PASSWORD 'doudoudou';
select * from pg_catalog.pg_authid;

select rolname, rolpassword from pg_catalog.pg_authid;
select rolname, rolpassword from pg_catalog.pg_authid where rolname like 'w%';
alter user wen password 'doudou';
select rolname, rolpassword from pg_catalog.pg_authid where rolname like 'w%';

alter user wen createdb;
\c - wen
\conninfo
create database wen;

create table dish (id serial, code varchar(10) primary key, name varchar(20));
\copy dish from 'dish.csv' with csv header;
