-- where
-- 특정 조건에 맞는 레코드(데이터)만을 선택하는데 사용된다
--  방법이 다양하다

-- 같음(=) 연산자를 활용한 where
select
    menu_name,
    menu_price,
    orderable_status
from
    tbl_menu
where
    orderable_status ='y';

/*tbl_meny에 있는 테이블에 있는 컬럼
  menu_name, menu_price, orderable_status를 조회할건데
  단, menu_price가 13000인 데이터만 조회*/


  select
      menu_name,
      menu_price,
      orderable_status
  from
    tbl_menu
  where
      menu_price = 13000;

-- select 담지 않아도, 다른 컬럼의 속성으로 제한할수있다
select
    menu_name,
    menu_price
from
    tbl_menu
where
    orderable_status = 'Y';

-- 같지 않음(!=,<>) 연산자를 사용하는 where
-- columnA !=B 컬럼에 있는 내용 중 B와 같지 않은 데이터만 보여주기
-- columnA <>B 컬럼에 있는 내용 중 B와 같지 않은 데이터만 보여주기
select menu_code,
       menu_name,
       orderable_status

from tbl_menu
# where orderable_status != 'Y';
where orderable_status <> 'Y';

-- 대소비교 연산자(>,>=,<,<=)를 사용하는 where
select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
where
    menu_price <=20000;

-- AND 연산자와 함께 where절 사용
-- 둘중에 하나라도 false면 false
-- 둘다 true여야 true
/*
true =1;
//false =0
null :값이 없다
*/

-- true가 되는 조건
select 1 and 1;

-- false가 되는 조건
select  1 and 0,0 and 0, 0 and null;

-- null이 되는조건
select 1 and null, null and null;

-- where에서 and조건은 두 조건을 모두 충족시키는 것을 조회한다.
select
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
    tbl_menu
where orderable_status = 'Y' and -- 주문가능여부가 'Y'이고
      category_code=10; -- 카테고리코드가 10인 데이터만 출력

/*tbl-menu테이블에 있는 menu_name, menu_price, category_code,
  orderable_status를 조회하는데
  주문가능여부가 y 이고, 가격이 1000원 이하인데이터 조회*/
select
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
    tbl_menu
where
    orderable_status = 'Y' and -- 주문가능여부가 'Y'이고
    menu_price <= 10000; -- 카테

-- or연산자와 함께 where절 사용
-- true가 되는 조건
select 1 or 1, 0 or 1, 1 or null;

-- false가 되는조건
select 0 or 0;

-- null이 될 조건
select 0 or null, null or null;

-- where에서의 or조거
-- 두조건 중 하나라도 충족하면 조회한다

select
    menu_name,
    menu_price,
    category_code
    orderable_status
from
    tbl_menu
where
    orderable_status ='y' or
    category_code = 12;

/*
and와 or연산의 우선순위
and가 or보다 우선순위가 높다
or의 우선순위를 높이고 싶으면 ()소괄호를 이용한다
*/

select 1 or 0 and 0; -- 0 and 0이 먼저 진행되므로 두번쨰 연산은 1or0이된다 =>1
select (1 or 0) and 0;

select
    *
from tbl_menu
where
    category_code =4 or menu_price = 9000 and menu_code > 10;

-- between연산자를 사용한 where
select
    menu_name,
    menu_price,
    category_code
from
    tbl_menu
where
    menu_price >= 10000 and
    menu_price <= 25000

/*between연산자
  경계값을 포함하고, 사이의 값을 포함한다
  beetween사용법
  [column_name] between[a] and [b]*/

 select
     menu_name,
     menu_price,
     category_code
     from
         tbl_menu
         where
             menu_price between 10000 and 25000;
/*
beetween의 부정표현*/
-- 경계값을 포함하지 않는다
select
    menu_name,
    menu_price,
    category_code
from
    tbl_menu
where
    menu_price not between 10000 and 25000;

/*
like연산자
특정 패턴과 일치하는 행을 검색해준다
패턴
% : 0개이상의 문자를 의미한다
ex) %apple%는 apple이 포함된 모든 문자열을 의미한다
_ : 1개의 문자를 나타낸다
ex) a_k는 a로 시작하고 k로 끝나는 세글자 문자열을 의미한다
*/
select *
from
    tbl_menu
# where menu_name like '민트%'
where menu_name like '민트___%';

/*menu '갈치'라는 단어가 들어간 메뉴를 찾아 보세요*/
select *
from
    tbl_menu
 where menu_name like '%갈치%';

-- like부정표현
select *
from tbl_menu
where menu_name not like '%갈치%';

/*in 연산자
  특정열의 값이 지정된 목록중 하나와 일치하는지 확인하는데 사용된다
  in 사용법
  [column_name]in(4,5,6...)
  */

select
    menu_name,
    category_code
from
    tbl_menu
where
    category_code in (4,5,6); -- category code가 4,5,6목록데이터만 조회

-- in연산자의 부정표현
select
    menu_name,
    category_code
from
    tbl_menu
where
    category_code not in (4,5,6);

/*
is null연산자
-- 값이 null인지 아닌지를 확인하여 조회한다
*/
select
    category_name,
    category_code,
    ref_category_code
from
    tbl_category
where
    ref_category_code is null;

-- is null 연산자의 부정표현
select
    category_name,
    category_code,
    ref_category_code
from
    tbl_category
where
    ref_category_code is not null;

