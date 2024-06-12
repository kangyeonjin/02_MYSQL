-- dml(data manopulation language
-- 데이터 조작어, 테이블에 값을 삽입, 수정 또는 삭제 하는 sql

-- insert
-- 새로운 행을 추가하는 코드
-- 테이브릐 행의수가 증가한다
-- null허용가능한 컬럼이나, auto-increment가 있는 컬럼을 제외하고
-- insert하고 싶은 데이터 컬럼을 지정해서 insert가능

select * from tbl_menu;

# INSERT INTO [테이블명] VALUES ([컬럼내용]...)
INSERT INTO tbl_menu VALUES (NULL, '바나나해장국', 8500,4,'Y');
INSERT INTO tbl_menu VALUES (25, '파인애플탕', 8500,4,'Y');

# delete from tbl_menu where menu_name ='바나나해장국';
# delete from tbl_menu where menu_name ='파인애플탕';

DESCRIBE tbl_menu; -- 열정보
insert into tbl_menu(orderable_status, menu_price, menu_name, category_code)
values ('Y', 550, '파인애플탕',4);

-- 여러컬럼을 한번에 insert
insert into
    tbl_menu
values
    (null, '참치맛아이스크림', 1700,12, 'Y'),
    (null, '멸치맛아이스크림', 1500,11, 'Y'),
    (null, '소시지맛커피', 2500,8 ,'Y');

-- update
-- 테이블에 기록된 컬럼의 값을 수정하는 구문
-- 테이브에 전체행 갯수는 변화가 없다

select *
from tbl_menu
where menu_name = '파인애플탕';

select * from tbl_menu;

update tbl_menu
set
category_code = 7
where  -- 바꿀행 조건
menu_code =25;

-- delete
-- 테이블의 행을 삭제하는 구문
-- 테이블의 행의 갯수 줄어든다

-- limit를 사용한 삭제
-- 20000원 이상인 데이터중, 가격이 높은 순으로 2개 삭제
delete
from tbl_menu
where -- 삭제할 행 조건
menu_price >= 20000;
order by menu_price desc; -- 내림차순
# limit 2;

-- 20000원 이상 가격 높은 순으로 조회
select
    menu_name,
    menu_price
from
    tbl_menu
where menu_price > 20000
order by menu_price desc;

-- 단일행 삭제
delete
from tbl_menu
where
    menu_code = '28';

select * from tbl_menu;

-- 테이블 전체 행 삭제
delete
from tbl_menu
where menu_code >0; -- 메뉴코드가 0보다 크면 삭제

/*
replace
-- replace를 통해 중복된 데이터를 덮어 쓸수있다
-- 해당 행을 삭제하고 새로운 값을 삽입한다

-- insert시 primary key(기본키) 또는 unique key가 출돌이 발생할수있다

-- update조건을 충족하는 모든 행을 수정할수있지만,
--replace는 무조건 한행에 대해 수행만 가능하다
*/

#primary key : 기본키, pk 유일성과 최소성을 충족한다.
#해당행을 식별할때 기준이되는 필수키
#unique key : 테이블내에서 유일성을 만족하는키, 해당행을 식별할떄 사용가능
#최소성 : 키를 구성하는 속성들중 가장 최소로 필요한속성들로만 키를 구성하는 성질
#유일성 : 여러개의 데이터가 존재할때 각각의 행의 유일하게 식별가능한 조건
select * from tbl_menu;

insert into tbl_menu
values (17, '참기름 소주', 5000, 10, 'Y');

REPLACE INTO tbl_menu VALUES (17,'참기름소주',5000,10,'Y');  -- 기존행 변경, into 생략가능
REPLACE tbl_menu VALUES (17,'참기름맥주',5000,10,'Y');

REPLACE tbl_menu VALUES (9,'민트마카롱',5000,10,'Y');

replace tbl_menu
set menu_code =2,
    menu_name ='우럭쥬스',
    menu_price = 2000,
    category_code =9,
    orderable_status ='N';