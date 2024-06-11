-- distinct
-- 중복된 값을 제거하는데 사용된다
-- 중복을 제거해서 컬럼에 있는 컬럼값의 종류를 쉽게 파악할수있다
select
    category_code
from
    tbl_menu
order by
    category_code;

-- distinct select 뒤에 작성한다
select distinct category_code
from tbl_menu
order by category_code;

-- null값을 포함하고 있는 컬럼에 distinct 사용하면 널값도 중복제거됨
select distinct
    ref_category_code
from tbl_category;

-- 다중열 distinct사용
-- 다중열의 값들이 모두 동일하면 중복된것으로 판별한다
select distinct
        category_code,
       orderable_status
from
    tbl_menu;