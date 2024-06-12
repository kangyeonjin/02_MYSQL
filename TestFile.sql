create database test_db;
show databases ;
drop database test_db;
grant all privileges on ogclass_db.* to 'ohgiraffers'@'%';
show grants for 'ohgiraffers'@'%';
use test_db;

create table if not exists Test(
    test varchar(255) not null,
    test1 int not null unique
);

insert into Test (test, test1)
values ('value', 100);

describe Test;

alter table Test add test2 varchar(255) not null;
alter table Test drop column test2;





