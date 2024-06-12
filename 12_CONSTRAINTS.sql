create database user_db;  -- db생성
show databases;  -- 전체 db목록조회
grant all privileges on user_db.* to 'ohgiraffers'@'%';  -- 권한부여
show grants for 'ohgiraffers'@'%'; -- 권한 조회
use user_db; -- user_db사용

-- constraints
-- 제약조건, 테이블에 데이터가 입력되거나 수정될때의 규칙을 정의한다
-- 데이터 무결성을 보장하는데 도움이 된다

-- not null
-- null값을 허용하지 않는 조건
drop table if exists user_notnull;
create table if not exists user_notnull
(
    user_no int not null,
    user_id varchar(255) not null,
    user_pwd varchar(255) not null,
    user_name varchar(255) not null,
    gender varchar(3),
    phone varchar(255) not null,
    email varchar(255)

);

insert into user_notnull
    (user_no, user_id, user_pwd, user_name,gender,phone,email)
values (1, 'user01','pass01','홍길동','남','010-1234-5678','hon123@gmail.com'),
       (2, 'user02','pass02','유관순','여','010-7777-7777','yo77@gmail.com');

-- unique
-- 중복값을 허용하지 않는 제약조건
create table if not exists user_unique
(
    user_no int not null unique,  -- 기본키
    user_id varchar(255) not null,
    user_pwd varchar(255) not null,
    user_name varchar(255) not null,
    gender varchar(3),
    phone varchar(255) not null,
    email varchar(255)

);

-- 같은 내용 두번 insert 했을때,
-- user_no의 unique 키가 중복되게 되면서
-- [23000][1062]deplicate entry '1' for key 'user_unique.user_no;발생

insert into user_unique
(user_no, user_id, user_pwd, user_name,gender,phone,email)
values (1, 'user01','pass01','홍길동','남','010-1234-5678','hon123@gmail.com'),
       (2, 'user02','pass02','유관순','여','010-7777-7777','yo77@gmail.com');

select * from user_unique;

-- primary key
-- 테이블에서 한행의 정보를 찾기위해 사용할 컬럼을 의미
-- notnull +unique제약조건을 의미
-- 한테이블당 한개만 설정할수있다
-- 한개의 컬럼에 설정할수도 있고, 여러개의 컬럼을 묶어서 설정할수도 있다(복합키)

select * from user_primarykey;

drop table if exists user_primarykey;

create table if not exists user_primarykey
(
    user_no int not null unique,  -- 기본키
#     user_no int primary key,
    user_id varchar(255) not null,
    user_pwd varchar(255) not null,
    user_name varchar(255) not null,
    gender varchar(3),
    phone varchar(255) not null,
    email varchar(255),
    primary key (user_no)
);

insert into user_primarykey
(user_no, user_id, user_pwd, user_name,gender,phone,email)
values (1, 'user01','pass01','홍길동','남','010-1234-5678','hon123@gmail.com'),
       (2, 'user02','pass02','유관순','여','010-7777-7777','yo77@gmail.com');

-- 중복값 체크
insert into user_primarykey
(user_no, user_id, user_pwd, user_name,gender,phone,email)
values (1, 'user01','pass01','홍길동','남','010-1234-5678','hon123@gmail.com');

-- foreign key
-- 참조된 다른 테이블에서 제공하는 값만 사용할수있다
-- 참조 무결성을 위배하지 않기 위해사용
-- foreign key 제약조건에 의해 테이블간의 관계 형성됨
-- 제공되는 값(참조하는 테이블의 값)이외에는 null사용가능

#참조무결성
#기본키와 외래키간의 관계가 항상 유지되도록 보장하는것을 의미한다

create table if not exists user_grade
(
    grade_code int not null unique ,
    grade_name varchar(255) not null
);

INSERT INTO  user_grade
values (10, '일반회원'),
       (20, '우수회원'),
       (30, '특별회원');

select * from user_grade;

create table if not exists user_foreignkey1 (
    user_no int primary key,
    user_id varchar(255) not null,
    user_pwd varchar(255) not null,
    user_name varchar(255) not null,
    gender varchar(3),
    phone varchar(255) not null,
    email varchar(255),
    grade_code int,
    foreign key (grade_code)
            references user_grade(grade_code)

);

insert into user_foreignkey1
(user_no, user_id, user_pwd, user_name,gender,phone,email,grade_code)
values (1, 'user01','pass01','홍길동','남','010-1234-5678','hon123@gmail.com',10),
       (2, 'user02','pass02','유관순','여','010-7777-7777','yo77@gmail.com',20);

-- 외래키 제약조건
-- 참조 컬럼에 없는값 적용

insert into user_foreignkey1
(user_no, user_id, user_pwd, user_name,gender,phone,email,grade_code)
values (1, 'user01','pass03','이순신','남','010-4321-5678','hon123@gmail.com',10);

select * from user_foreignkey1;
-- 참조무결성에 의해 일반적으로는 관계가 맺어진 컬럼을 변경할수없다
update user_foreignkey1
set grade_code = 5
where user_no =2;

-- check
-- check제약조건위반시 허용하지 않음
create table if not exists user_check
(
    user_no int auto_increment primary key ,
    user_name varchar(255) not null ,
    gender varchar(255) check(gender in('남','여')),  -- 조건
    age int check( age >= 19) -- 조건
);

insert into user_check
values (null, '홍길동','남',25),
       (null, '이순신','남',35);

select * from user_check;

-- gender check제약 조건확인
insert into user_check
values (null, '안중근','남자',27);

-- age check 제약조건확인
insert into user_check
values (null, '유관순', '여', 17);

-- default
-- 컬럼에 null대신 기본값 적용
-- 컬럼타입이 data일시, current_date만가능
-- datetime일 시 -> current_time, current_timestamp, now()모두 사용가능

create table if not exists tbl_country
(
    country_code int auto_increment primary key ,
    country_name varchar(255) default '한국',
    population varchar(255) default '0명',
    add_day date default (current_date),
    add_time datetime default(current_time)
);

insert into tbl_country
values (null, default,default,default,default);

select * from tbl_country;
