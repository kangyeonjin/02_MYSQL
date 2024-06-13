create database test_db;
show databases ;
drop database test_db;
grant all privileges on ogclass_db.* to 'ohgiraffers'@'%';
show grants for 'ohgiraffers'@'%';
use test_db;

create table if not exists Test(  -- 생성
    test varchar(255) not null, -- test 열의 공간값 255 null없음
    test1 int not null unique -- test1은 중복값 없음,null도 없음
);

insert into Test (test, test1) -- 열값에 데이터 삽입
values ('value', 100);

describe Test;  -- 테이블 정보 확인

alter table Test add test2 varchar(255) not null; -- 열정보추가
alter table Test add test_no int not null;
alter table Test drop column test2; -- 열 삭제

alter table Test drop primary key; -- 자동설정된 기본키 제거
alter table Test add primary key(test_no);  -- 새로 기본키 설정

-- null값을 포함하고 있는 경우는 기본키로 설정 할 수 없음 & 고유 해야함

create table if not exists Sample(
    sample int not null auto_increment unique,
    sample1 varchar(255) not null,
    sample2 int not null
);

select * from Sample;

insert into Sample (SAMPLE, SAMPLE1, SAMPLE2) VALUES (1,'new',11);

select
    sample,
    test
from
    test
join sample;