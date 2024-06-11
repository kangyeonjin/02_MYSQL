-- join
-- 여러개의분산된 표를 조합해서 하나의 표로 만드는기능
-- 관계형 데이터베이스에서 가장 중요한 파트이다

-- 두개이상 테이블을 관련있는 컬럼을 통해 결합하는데 사용된다
-- 두개이상 테이블은 반드시 연관있는 컬럼이 존재해야하며, 이를 통해
-- join된 테이블들의 컬럼을 모두 확인할수있다

/*
alias
- sql의 컬럼 또는 테이블에 별칠을 달수있다.
*/

select
    -- 별칭에 띄어쓰기나 특수 기호가 없다면
    -- 홀따움표와 as는 생략이 가능하다
    a.menu_code as 'code',  -- a에서 참조해서옴 code를 별칭으로함
    a.menu_name as name,
    a.menu_price as 'price'
from
    tbl_menu a
order by
    price;

-- inner join 교집합
-- left join 왼쪽집합
-- right join 오른쪽집합
-- full outer join 교집합제외 ?? 생각안남

/*
inner join(JOIN만있으면 INNER JOIN임)
두 테이블의 교집합을 반환하는 SQL JOIN유형
INNER JOIN에서 INNER키워드는 생략가능하다
컬럼명이 같거나, 다를경우 ON으로 서로 연관있는 컬럼에 대한
조건을 작성하여 JOIN 한다
*/

SELECT
    a.menu_name, -- tbl_menu를 a로 바꿈
    b.category_code -- tbl_category를 b로바꿈
FROM
    tbl_menu a
inner join tbl_category b
on a.category_code = b.category_code
order by b.category_name;

-- inner join은 교집합을 반환하므로 join순서를 바꾸어도 영향이없다
select
    a.menu_name,
    b.category_name,
    a.category_code ACode,
    b.category_code BCode
from
    tbl_category b
        inner join tbl_menu a
    on a.category_code = b.category_code
order by
    b.category_name;

-- using
-- 컬럼명이 같을 경우 using으로 서로 연관있는 컬럼에 대한
-- 조건을 작성하여 join 할 수 있다
select
    a.menu_name,
    b.category_name
from
    tbl_menu a
inner join tbl_category b using(category_code)
order by
    b.category_name;

/*left join
  첫번째 테이블 모두 조회하고,
  왼쪽과 일치하는 오른쪽 테이블을 join해준다*/

  select
      a.menu_name,
      b.category_name
  from
      tbl_menu a
  left join tbl_category b on a.category_code = b.category_code;

/*
right join
두번째 테이블을 모두 조회하고
오른쪽과 일치하는 외쪽 테이블을 join해준다
*/

select
    a.menu_name,
    b.category_name
from tbl_menu a
right join tbl_category b on a.category_code=b.category_code;

/*cross join
  두 테이블의 모든 가능한 조합을 반환하는 join(모든 경우의 수를 다 구함)
  카르테시안 곱이라고도 함*/

#   select
#       a.menu_name
#       b.category_name
#   from
#       tbl_menu a
#   cross join tbl_category b;  -- 모든 경우의수를 확인할때 사용함

  /*self join
    같은 테이블 내에서 행과 행사이의관계를 찾기 위해 사용되는 join
    */

select
    a.category_name 카테고리,
    b.category_name 대분류
from
    tbl_category a
join tbl_category b on a.ref_category_code = b.category_code;

