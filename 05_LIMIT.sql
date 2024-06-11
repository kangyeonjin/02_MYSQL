-- LIMIT
-- select 문의 결과 집합에서, 반환한ㄹ행의 수를 제한할때 사용된다

/*
LIMIT

SELECT [columnName]
FROM [tableName]
LIMIT [OFFSET],[ROWCOUNT]

OFFSET :시작할행의 번호(인덱스 체계)
ROW_COUNT :이후행부터 반환받을 행의갯수
*/

-- tbl_menu 테이블의 menu_code, menu_name, menu_price
-- menu_code 기준 내림차순정렬
select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_code desc;

-- 상위 다섯줄의 행만조회
select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_code desc
limit 5;
-- 2번행부터 5번행까지 조회
select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_code desc
limit 1, 4;

-- tbl_menu테이블에서
-- menu_name 과 menu_price
-- 가장 저렴한 순으로 3가지를 보여주세요

select
    menu_price,
    menu_name
from tbl_menu
order by menu_price asc  -- 오름차순(default)
limit 3;



