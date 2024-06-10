/*
SQL이란
Structured Query Language의 약자로 직역하면 구조화된 질의 언어이다
단순히 질의만 하는것이 아니라
DML,DDL,DCL, TCL이런 데이터베이스르 조작 및 조회 하기 위해 사용하는 표준언어이다
*/


-- SELECT
-- MYSQL의 가장 기본적인 명령어로 특정 테이블에서 원하는 데이터를 조회할수있다

select
    menu_name -- 어떤 칼럼을
from tbl_menu; -- 어느테이블에서

-- 여러컬럼을 한번에 조회할수있다
select
    menu_code,
    menu_name,
    menu_price
from tbl_menu;

-- 모든 컬럼을 직접써서 조회하기
select
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from tbl_menu;

-- *를 써서 전체를 조회할수있다
select
    *
from tbl_menu;

/*
select 단독 활용
- from 없이 단독으로 사용가능
- 단독으로 사용할때는 단순한 텍스트용도로 사용된다
*/

select (5+5);
select (5-5);
select (5*5);
select (5/5);
select (5%5);

-- mysql내장함수도 사용가능
select now();  -- 현재시간 출력
select concat('bear', '안녕', 'ohgiraffers');

-- 컬럼에 별칭을 사용 할 수 있다
select concat('박',' ','태근')as name;

-- 공백을 사용하고 싶으면 작은 따옴표로 묶어줘야함
select concat('박',' ','태근')as 'Full name';


