-- subquery
-- 서브쿼리는 다른 쿼리에서 실행되는 쿼리
-- 존재하지 않는 조건에 근거한 값들을 검색하고자할때
-- 메인쿼리가 서브쿼리를 포함하는 종속적인 관계이다

-- 서브쿼리의 유형
-- 1. 일반 서브쿼리
-- 단일행 일반서브쿼리
-- 다중행 일반 서브쿼리
-- 2. 상관 서브쿼리
-- 스칼라 서브쿼리

-- 서브쿼리의 규칙
-- 서브쿼리느 반드시 소괄호()로 묶어야한다(select...) 형태
-- 서브쿼리느 연산자의 오른쪽에 위치해야한다
-- 서브쿼리내에서 order by문법은 지원되지 않는다

-- 단일행 서브쿼리
-- 민트미역국이랑 같은 카테고리의 메뉴 조회(메뉴코드, 메뉴명, 가격, 주문가능여부)

/*쿼리 2번 사용해서 원하는 결과 구하기*/
select category_code
from tbl_menu
where menu_name = ('민트미역국');

/*서브쿼리를 사용해 구하기*/
select menu_code        메뉴코드,
       menu_name        메뉴명,
       menu_price       메뉴가격,
       orderable_status 주문가능여부
from tbl_menu
where category_code = ( -- 괄호안에 쿼리문을넣어서 서브쿼리로 사용가능하다
    select category_code
    from tbl_menu
    where menu_name = '민트미역국');

-- 다중행 서브쿼리
-- 카테고리코드가 식사인 모든 카테고리코드를 조회
select category_code
from tbl_category
where ref_category_code = 1;

select *
from tbl_menu
where category_code in (select category_code
                        from tbl_category
                        where ref_category_code = 1);

-- all연산자
-- 서브쿼리의 결과 모두에 대해 연산결과가 참이면 참을반환
-- x > All(..) : 모든 값보다 크면 참, 최대값보다도 크면 참
-- x >= All(..) : 모든 값보다 크거나 같으면 참, 최대값보다 크거나 같으면 참
-- x < All(..) : 모든 값보다 작으면 참, 최소값보다도 작으면 참
-- x <= All(..) : 모든 값보다 작거나 같으면 참, 최소값보다 작거나 같으면 참
-- x = All(..) : 모든 값과 같으면 참
-- x != All(..) : 모든 값과 다르면 참(not in이랑 통일)

-- 가장 비싼메뉴 조회
select max(menu_price)
from tbl_menu;

select *
from tbl_menu
where menu_price >= all (select menu_price
                         from tbl_menu);

-- 한식보다 비싼 중식 or 일식을 찾아줘
select *
from tbl_menu
where category_code in (5, 6) -- 일식, 중식만 조회
  and menu_price > all ( -- 한식의 메뉴 가격들
    select menu_price
    from tbl_menu
    where category_code = 4);

-- 상관 서브쿼리
-- 메인쿼리가 서브쿼리의 결과에 영향을 주는 경우를 의미함
-- 메인쿼리의 값을 서브쿼리에 주고 서브쿼리를 수행한다음
-- 그 결과를 다시 메인쿼리로 반환하는 형식으로 수행되는 서브쿼리

-- 서브쿼리의 where절 수행을 위해
-- 메인쿼리가 먼저 수행되는 구조
-- 메인쿼리의 테이블의 행에 따라 서브쿼리의 결과값도 바뀐다.

-- 카테고리별 평균가격이 가장 비싼 메뉴 조회
select category_code,
        max(menu_price)
from tbl_category
group by category_code;

select *
from tbl_menu a -- 이테이블을
where menu_price = (select max(menu_price)
                    from tbl_menu
                    where category_code = a.category_code -- 여기서 가져다쓴다
);

-- exists
-- exists :서브쿼리 결과 집합에 행이 존재하면 참, 행이존재하지 않으면 거짓
-- not exists
-- 서브쿼리 결과 집합에 행이 존재하지 않으면 참, 행이 존재하면 거짓

-- tbl_menu에서 사용되는 카테고리만 조회하겠다
select a.category_code,
       a.category_name
from tbl_category a
where exists(select category_code
             from tbl_menu b
             where b.category_code = a.category_code);

-- 스칼라서브쿼리
-- 결과값이 1개인 서브쿼리,주로 select문에서 사용된다
-- 스칼라 = 단일값
-- 메뉴명, 카테고리명 조회

select a.menu_name,
       b.category_name
from tbl_menu a
         left join tbl_category b on a.category_code = b.category_code;

-- 스칼라서브쿼리
select a.menu_name,
       (select category_name
    from tbl_category b
    where b.category_code = a.category_code)
           category_name
from tbl_menu a;

-- 스칼라 서브쿼리의 반환행수가 1행보다 많을수는 없다
select
    menu_name,
(select category_name
        from tbl_category)category_name
from tbl_menu ;

/*cte(common table expressions)
  서브쿼리랑 비슷한개념
  코드의 가독성과 재사용성을 위해사용한다
  from 절에서만 사용함
  (join 일시 join구문에서도 가능)*/

  -- 메뉴명과 카테고리명을 함께 출력
with menucate as (
    select
       menu_name,
    category_name
    from tbl_menu a
    join tbl_category b on a.category_code = b.category_code

)

select *
from menucate
order by  menu_name;