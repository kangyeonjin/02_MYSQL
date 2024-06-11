-- grouping
-- group by 절을 이용해서 결과 집합을 특정 열의 값에 따라 그룹화하는데 사용
-- having은 group by절과 함께 사용해야하며, 그룹에 대한 조건을 적용하는데 사용된다

-- menu table에서 카테고리 그룹을 조회
select
    category_code
    from tbl_menu
    group by category_code;

-- 카테고리 그룹에서 count를 사용해서 갯수를 조회
-- 카테고리별 갯수 조회하기
select category_code,
         count(*)  -- 매개변수와 위치에 따라 여러 사용방법이 있음
                  -- 전체행중 일치하는 행이 몇개인지 갯수를 반환하는 역할
from  tbl_menu
group by category_code;

-- sum으로 그룹화된 값의 총합을 구할수있다
-- 카테고리별 가격총합 계산하기
select
    category_code,
    sum(menu_price),
    count(*)
from
    tbl_menu
group by category_code;

-- avg로 그룹화된 값의 평균을 구할수있다
-- 카테고리별 평균 계산하기
select
    category_code,
        count(*) 총갯수,
        sum(menu_price) 총합,
        avg(menu_price) 평균
from tbl_menu
group by category_code;

-- 2개이상의 조건으로 그룹을 생성
-- menu_price, category_code
select
    menu_price,
    category_code,
    count(*)
from tbl_menu
group by
    menu_price,
    category_code;

-- category_code, orderable_status > 그룹을 만들기
-- 평균, 총합, 갯수
select
    category_code,
    orderable_status,
    count(*) 갯수,
    sum(menu_price) 총합,
    avg(menu_price) 평균
from
    tbl_menu
group by
    category_code, orderable_status;
# order by orderable_status;

/*having
  group by 와 함께 사용되며
  그룹화된 결과에 조건을 적용할때 사용된다.
  where는 개별 행에 조건을 적용하는것과 달리
  having절은 그룹화된 데이터에 조건을 적용한다.
  */

-- munu_price, category_code로 그루핑된 데이터에서
-- category_code가 5이상, 8이하만 조회
select menu_price,
       category_code
    from tbl_menu
group by menu_price,
         category_code
having category_code >= 5 and category_code <= 8
order by  menu_price;

-- where절로도 할수있다.
-- 그룹화전에 필터링을 할수없는 경우에는 having으로만 가능하다
select menu_price,
       category_code
from tbl_menu
where category_code >=5 and category_code <=8
group by
    menu_price, category_code
order by menu_price;

-- 카테고리 코드 그룹별 평균가격을 구하고, 평균가격이 8000원 이상인 경우만 조회
select category_code,
avg(menu_price)
from tbl_menu
group by  category_code
having  avg(menu_price) >= 8000;  -- where 불가능

/*
with rollup
group by 에서 사용되는 확장기능으로 다양한 수준의 집계데이터를 생성할수있다.
*/

-- 총합을 구할때
select
    category_code,
    sum(menu_price)
from
    tbl_menu
group by
    category_code
with rollup;

-- 컬럼두개를 활용한 rollup
-- 메뉴가격별 총합 및 해당메뉴 가격별 같은 카테고리의 총합
select
    menu_price,
    category_code,
    count(*),
    sum(menu_price)
from
    tbl_menu
group by
    menu_price, category_code
with rollup ;
