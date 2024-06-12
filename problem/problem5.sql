#메뉴 테이블에서 카테고리 그룹 조회
select
    category_code
from
    tbl_menu
group by
    category_code;

#카테고리 그룹에서 count를 사용해서 갯수를 조회
select
    category_code,
    count(*)
from tbl_menu
group by category_code;

select
   category_code,
   sum(menu_price)
from tbl_menu
group by  category_code

select
    menu_price,
    category_code,
    count(*)
from tbl_menu
group by
    menu_price,
    category_code

select
    menu_price,
    category_code
from
    tbl_menu
group by
    menu_price,
    category_code
having
    category_code >= 5 and category_code <= 8
order by
    menu_price;

select
   category_code,
    sum(menu_price)
from
    tbl_menu
group by
    category_code
with rollup ;

select
    category_code
from
    tbl_menu
where
    menu_name = '민트미역국';