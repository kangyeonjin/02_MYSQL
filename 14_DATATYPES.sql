-- cast functions

-- 명시적 형변환
-- cast([표현형식] as 데이터 형식[(길이)])
-- convert([표현형식], [데이터형식]([길이])
-- 데이터 형식으로 가능한것
-- binary, char, date,datetime, decimal, json, signed integer(부호있는거)
-- time, unsigned integer(부호없는거)

-- tbl_menu전체 가격평균
select avg(menu_price)
from tbl_menu;

select cast(avg(menu_price)as signed integer )as '평균메뉴가격'
from tbl_menu;

select convert(avg(menu_price),signed integer )as '평균메뉴가격'
from tbl_menu;

-- date형 cast
select cast('2024$06$13'as date);
select cast('2024/05/30'as date);
select cast('2024%05%30'as date);
select cast('2024@05@30'as date);

-- 카테고리별 메뉴 가격 합계 구하기
-- 0000원
select concat(cast(menu_price as char(5)),'원') from tbl_menu;
select category_code,concat(cast(sum(menu_price) as char(5)),'원')
from tbl_menu group by category_code;

-- 암시적 형변환
select '1' + '2'; -- 형변환이되서 정수형의 덧셈으로 출력이됨
select concat(menu_price,'원') from tbl_menu; -- 문자로 변환이 됨

select 3 > 'MAY'; -- MAY는 숫자로 변환이 안되므로 0을 간주됨, 3>0으면 TRUE가됨
SELECT 5 >'6MAY'; -- 문자에서 첫번째로 나온숫자는 정수로 전환된다
SELECT 5 > 'M6AY'; -- 숫자가 뒤에나오면 문자로 인식됨
select '2024-6-13'; -- 날짜형으로 바뀔수있는 문자 -> date형으로 변환된다

