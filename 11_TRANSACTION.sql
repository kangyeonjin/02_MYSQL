-- transaction
-- 데이터베이스에서 한번에 수행되는 작업의 단위
-- 시작, 진행, 종료 단계를 가지며, 중간에 오류가 발생하면 롤백
-- 롤백 : 시작이전 단계로 되돌리는 작업
-- mysql은 기본적으로 자동 커밋설정이 되어있음(롤백이 안됨)

-- autocommit비활성화
set autocommit =0;
set autocommit = off;

-- autocommit활성화
set autocommit =1;
set autocommit = on;

select * from tbl_menu;
start transaction ;
insert into tbl_menu values(null, '바나나깐풍기', 8500,4,'Y');
UPDATE tbl_menu SET menu_name ='수정된메뉴' WHERE menu_code =5;
DELETE FROM tbl_menu WHERE menu_code =22;
commit;

# REPLACE tbl_menu VALUES (22,'바나나해장국',8500,4,'Y');

# rollback;





