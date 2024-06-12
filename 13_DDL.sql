-- DDL(data definition language)
-- 데이터 정의어, 데이터베이스를 정의하는 언어
-- 데이터를 생성, 수정, 삭제 하는 등의 데이터 전처리

# drop table if exists tbl_country, user_check, user_foreignkey1, user_grade, user_notnull, user_primarykey, user_unique;
 -- create : 데이터베이스 ,테이블 등을 생성
-- alter : 테이블 수정
-- drop : 데이터베이스, 테이블 삭제
-- truncate : 테이블을 초기화

-- create
-- 테이블을 생성하는 구문(데이터베이스도 가능)
-- if not exist : 존재하지 않으면 수행하기
-- 기존에 존재하는 테이블이 있더라도 에러가 발생하지는 않는다.

create table if not exists tb1(
    pk int primary key ,
    fk int,
    col1 varchar(255) default 'MYSQL',
    check ( col1 in('Y','N')) -- col1 열의 값이 반드시 'Y' 또는 'N' 중 하나여야 한다는 조건
);

-- 테이블구조확인
describe tb1;

insert into tb1 values (1,10,'Y');
select * from tb1;

-- auto increment
-- insert시 primary키에 해당하는 컬럼에 자동으로 번호를 발생(중복되지 않게)

create table if not exists tb2
(
    pk int auto_increment primary key ,
    fk int,
    col1 varchar(255) default 'MYSQL',
    check ( col1 in('Y','N'))
);
describe tb2;

insert into tb2 values (null,10,'Y');
select * from tb2;

-- alter
-- 테이블에 추가/변경/수정/삭제를 할수있다.

describe tb2;
-- 열추가
alter table tb2 add col2 int not null;

-- 컬럼삭제
alter table  tb2 drop column col2;

-- 컬럼명 및 형식 변경
alter table  tb2 change fk change_fk int not null;

-- 열제약 조건 추가, 삭제
alter table  tb2 drop primary key;  -- 안됨, 프라이머리키는 해당테이블에 하나는 있어야함

-- 컬럼의 정의를 바꾸는것
alter table  tb2 modify pk int;

alter table  tb2 add primary key (pk);

select * from tb2;

-- 기존 데이터가 있는 경우, not null 옵션의 컬럼이 생기면
-- 기본값으로 들어가게 됨

alter table tb2
      add col3 date not null;
#add col4 tinyint not null ;
-- mysql자체에서 전역적인 유혀성 검사 모드를 사용한다
-- NO_ZERO_INDATE

select @@globla.sql_mode;
set global sql_mode = '';  -- date에 000넣어야 할일있을때 씀

-- drop
-- 테이블을 삭제하기 위한 구문
-- if exists를 적용하면 존재하지 않는 테이블이라도 에러가 발생하지 않는다
create table  if not exists tb3
(
   pk int auto_increment primary key ,
   fk int,
   col1 varchar(255) default 'MYSQL',
   check ( col1 in('Y','N'))
);

-- 테이블 여러개 삭제
drop table if exists tb1,tb2,tb3,tb4,tb5,tb6;

-- truncate
-- 삭제할때 사용된다
-- delete -> 데이터를 삭제할때 행마다하나씩 지워진다
-- truncate -> 테이블 drop, 테이블 생성진행
-- auto-interement컬럼이 있는경우 시작값도 0으로 초기화된다
create table if not exists  tb6
(
  pk int auto_increment primary key ,
  fk int,
  col1 varchar(255) default 'MYSQL',
  check ( col1 in('Y','N'))
);

insert into tb6 values (null,10,'y');
insert into tb6 values (null,10,'y');
insert into tb6 values (null,10,'y');
insert into tb6 values (null,10,'y');

select *from tb6;

truncate tb6;
