-- 데이터베이스 생성 및 권한 부여
create database chundb;
grant all privileges on chundb.* to 'ohgiraffers'@'%';
show grants for 'ohgiraffers'@'%';
use chundb;

show databases;
show tables;

select * from TB_DEPARTMENT; --  학과테이블
select * from TB_STUDENT; -- 학생테이블
select * from TB_PROFESSOR; -- 교수테이블
select * from TB_CLASS; -- 수업테이블
select * from TB_CLASS_PROFESSOR; -- 수업교수테이블
select * from TB_GRADE; -- 학점테이블

# 춘 기술대학교의 학과 이름과 계열을 표시하시오.
# 단, 출력 헤더는 "학과 명", "계열"으로 표시하도록 한다.

    select department_name as '학과명',
           category as '계열'
        from tb_department;

# 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다

    select CAPACITY,
           DEPARTMENT_NAME,
           concat(DEPARTMENT_NAME,'학과의 정원은',CAPACITY,'명 입니다')
    from tb_department;

# 국어국문학과" 에 다니는 여학생 중
# 현재 휴학중인 여학생을 찾아달라는 요청이
# 들어왔다. 누구인가? (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서
# 찾아 내도록 하자)

describe tb_department;
describe tb_student;

    select a.DEPARTMENT_NO,
           a.STUDENT_NAME,
           a.ABSENCE_YN
    from tb_student a
    join tb_department b on a.DEPARTMENT_NO = b.DEPARTMENT_NO
    where DEPARTMENT_NAME = '국어국문학과'
    and ABSENCE_YN ='Y';

# 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다.
# 학번이 다음과 같을 때 대상자들을 찾는 적 SQL 구문을
# A513079, A513090, A513091, A513110, A513119

select STUDENT_NAME
from tb_student
where STUDENT_NO in ('A513079' 'A513090', 'A513091', 'A513110', 'A513119');

# 입학정원이 20 명 이상 30 명 이하인
# 학과들의 학과 이름과 계열을 출력

    select CAPACITY,
           DEPARTMENT_NAME,
           CATEGORY
    from tb_department
    where CAPACITY >=20 and CAPACITY <= 30;

# 춘기술대학교는총장을제외하고
# 모든교수들이소속학과를가지고있다.
# 그럼 춘기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성

 select PROFESSOR_NAME
 from tb_professor
 where DEPARTMENT_NO is null;

# 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다.

    select * from tb_student
    where DEPARTMENT_NO is null;

#     select a.DEPARTMENT_NAME,
#            student_name
#     from tb_department a
#     join tb_student b
#         on a.DEPARTMENT_NO = b.DEPARTMENT_NO
#     where DEPARTMENT_NO is null and DEPARTMENT_NAME is null;

# 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는
# 과목들은 어떤 과목인지 과목번호를 조회

    select distinct CLASS_TYPE,
           CLASS_NAME,
           DEPARTMENT_NO
    from tb_class
    where CLASS_TYPE = '전공필수';

# 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회

    select distinct CATEGORY
    from tb_department;

# 학번 전주 거주자들의 모임을 만들려고 한다. 휴학한 사람들은 제외하고,
# 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.

    select
           STUDENT_NO 학번,
           STUDENT_SSN 주민번호,
           STUDENT_NAME 이름
#             STUDENT_ADDRESS 주소
    from tb_student
    where ABSENCE_YN = 'N' and
          STUDENT_ADDRESS like '%전주%';

#     where student_address = (
#     #재학중인학생 & 전주거주자
#     select ABSENCE_YN,
#            STUDENT_ADDRESS
#     from tb_student
#     where ABSENCE_YN = 'N' and STUDENT_ADDRESS = (field '전주'));

# 영어영문학과(학과코드 `002`) 학생들의 학번과 이름,
# 입학 년도를 입학 년도가 빠른순으로 표시하는 SQL 문장을 작성하시오.
# ( 단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)

select * from tb_student;
select * from tb_department; -- student랑 department_no로

        select a.student_name 이름,
               a.student_no 학번,
               a.ENTRANCE_DATE 입학년도
        from tb_department b
        join tb_student a on(b.DEPARTMENT_NO=a.DEPARTMENT_NO)
            join tb_class c on(a.DEPARTMENT_NO=c.DEPARTMENT_NO)
        where DEPARTMENT_NAME = '영어영문학과' -- 영문학과인 사람
        order by ENTRANCE_DATE desc; -- 입학년도가 빠른순

# 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다.
# 그 교수의 이름과 주민번호를 화면에 출력

    select  PROFESSOR_NAME,
            PROFESSOR_SSN
    from tb_professor   -- 문자열 길이 반환 함수 length(), char_length()
    where not char_length(PROFESSOR_NAME) = 3;

# 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오.
# 단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오.
# (단, 교수 중 2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름",
# "나이"로 한다. 나이는 ‘만’으로 계산한다.)

    select PROFESSOR_NAME 교수이름,
           YEAR(STR_TO_DATE(SUBSTRING(PROFESSOR_SSN,1,6), '%y%m%d')) 나이

#YEAR(curdate())- YEAR(STR_TO_DATE(SUBSTRING(PROFESSOR_SSN,1,6), '%y%m%d'))
# 실제나이를 알고자하면 YEAR(curdate())- 로 현재에서 생년월일을 빼서 나이를 계산한다
        from tb_professor
        where substring(PROFESSOR_SSN,8,1)in('1')  # in(1) 추출된게 1이 맞는지 확인
    order by PROFESSOR_SSN; # 뒤 8번째자리 수 추출함 주민번호 뒷자리 1번인사람 추출

# 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오.
# 출력 헤더는’이름’ 이 찍히도록 핚다.
# (성이 2 자인 경우는 교수는 없다고 가정하시오

    select substring(PROFESSOR_NAME,2)  이름
    # substring : 주어진 문자열에서 일부분을 추출함
    # substring_index :주어진 문자열에서 구분자를 기준으로 일부분을 추출함
    from tb_professor;

# 춘 기술대학교의 재수생 입학자를 구하려고 한다.
# 이때, 만 19살이 되는 해에 입학하면 재수를 하지 않은 것으로 간주한다.

# 학생나이주민번호 불러온뒤
# 19년이전 년도인 2005년 입학생인지 입학날짜와 함께 확인해야함

# 정상입학년도에 입학한 학생을 서브쿼리에 넣고
# 메인쿼리에서 정상입학년도에 입학하지 않은 학생의 이름과 입학년도를 출력하게함
# 정상입학년도 입학한 학생 - 입학년도(ENTRANCE_DATE) = 재수생

# 테이블을 하나 생성한다음 재수생 계산을 넣고나서 불러와서 읽히기.
# 변수생성으로 임시저장공간에 두고 출력을 간단히하던지.


select * from tb_student;
select YEAR(ENTRANCE_DATE) FROM tb_student;

select year(DATE_ADD(STR_TO_DATE(substring(STUDENT_SSN,1,6),'%y%m%d') , INTERVAL 19 YEAR))
from tb_student;

select year(ENTRANCE_DATE)-year(DATE_ADD(STR_TO_DATE(substring(STUDENT_SSN,1,6),'%y%m%d') , INTERVAL 19 YEAR))
from tb_student;  -- 입학년도 - 정상입학년도 = 재수

select STUDENT_NAME,
       year(ENTRANCE_DATE)입학년도,
       STR_TO_DATE(substring(STUDENT_SSN,1,6),'%y%m%d') 변환출생년도,
    year(ENTRANCE_DATE)-year(DATE_ADD(STR_TO_DATE(substring(STUDENT_SSN,1,6),'%y%m%d') , INTERVAL 19 YEAR))
from tb_student;

select
    STUDENT_NAME 학생이름,
    year(ENTRANCE_DATE)입학년도,
    substring(STUDENT_SSN,1,6) 출생년도,
    STR_TO_DATE(substring(STUDENT_SSN,1,6),'%y%m%d') 변환출생년도,
    DATE_ADD(STR_TO_DATE(substring(STUDENT_SSN,1,6),'%y%m%d') , INTERVAL 19 YEAR) 정상입학년도
from tb_student;

select
    STUDENT_NAME 학생이름,
    year(ENTRANCE_DATE)입학년도
from tb_student
 where YEAR(ENTRANCE_DATE) =(
     select year(ENTRANCE_DATE)   # 정상 입학년도에 입학한 학생을 서브 쿼리에 넣고 반환하기
         from tb_student
            where  DATE_ADD(STR_TO_DATE(substring(STUDENT_SSN,1,6),'%y%m%d'), INTERVAL 19 YEAR);

#[인터넷 답안]
# select
#     STUDENT_NAME,
#     ENTRANCE_DATE
# from tb_student
# where extract(year from ENTRANCE_DATE) - lpad(substr(STUDENT_SSN,1,2),4,'19')>19;

    -- current_date 현재 날짜를 반환함, date_sub 날짜빼는 계산함수
    -- ENTRANCE_DATE <= date_sub~~ 날짜 연산결과가 entrance_date열의 날짜보다 작거나 같은지

# 2020년 크리스마스는 무슨 요일이었는가?

    select dayname('2020-12-25') 20년크리스마스;

# `*STR_TO_DATE*('99/10/11', '%y/%m/%d')`
# `*STR_TO_DATE*('49/10/11', '%y/%m/%d')`은 각각 몇 년 몇 월 몇 일을 의미할까?
#  또 `*STR_TO_DATE*('70/10/11', '%y/%m/%d')`
#  `*STR_TO_DATE*('69/10/11', '%y/%m/%d')` 은 각각 몇 년 몇 월 몇 일을 의미할까?

select STR_TO_DATE('99/10/11','%y/%m/%d');
select STR_TO_DATE('49/10/11','%y/%m/%d');
select STR_TO_DATE('70/10/11','%y/%m/%d');
select STR_TO_DATE('69/10/11','%y/%m/%d');

# 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오.
# 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고,
# 점수는 반올림하여 소수점 이하 한자리까지만 표시

    select * from tb_student;

    select STUDENT_NO 학생번호,
           STUDENT_NAME 학생이름,
           POINT 학점
    from tb_student a
    JOIN tb_grade b on (b.STUDENT_NO = a.STUDENT_NO)
    where STUDENT_NO = 'A517178';


# [인터넷 답안]
#     SELECT ROUND(AVG(POINT),1) 평점
#     FROM
#         tb_grade
#     WHERE STUDENT_NO ='A517178';


# 학과별 학생수를 구하여 "학과번호",
# "학생수(명)" 의 형태로 헤더를 만들어 결과값이 출력되도록 하시오.

    select CAPACITY 학생수명,
            department_name 학과이름,
            DEPARTMENT_NO 학과번호
    from
        tb_department;
#order by 1에서 1은 첫번째 선택된열에서 정렬하라는 것


# 지도 교수를 배정받지 못한 학생의 수는
# 몇 명 정도 되는 알아내는 SQL 문을 작성하시오

select count(*)
from tb_student
where COACH_PROFESSOR_NO is null;

# 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오.
# 단, 이때 출력 화면의 헤더는 "년도",
# "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.

select substring(TERM_NO,1,4) from tb_grade;

select * from tb_grade;

    select STUDENT_NAME 학생이름,
           round(avg(POINT),1) 년도별평점, -- 점수반올림하여 소수점이하 한자리까지만 표시
           substring(TERM_NO,1,4)  -- 년도만 뽑아서 보여줌(월단위 없앰)
    from tb_student a
    join tb_grade b on (a.student_no = b.student_no)
    where a.STUDENT_NO = 'A112113' -- 김고운학생을 검색
    group by TERM_NO
    order by TERM_NO desc ;

# 학과 별 휴학생 수를 파악하고자 한다.
# 학과 번호와 휴학생 수를 표시

select  * from tb_student;
select  * from tb_department;

select ABSENCE_YN,
       count(*)
from tb_student
group by  ABSENCE_YN;

    select DEPARTMENT_NO  as 학과번호,
           department_name 학과이름,
            sum(ABSENCE_YN = 'Y') as 휴학생수
    from tb_student a
    join tb_department b using (DEPARTMENT_NO)
    group by ABSENCE_YN , DEPARTMENT_NO;

# 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다.

select * from tb_student;

select STUDENT_NAME
from tb_student
group by STUDENT_NAME
having count(*)  > 1;
-- group by로 묶어준 그룹의 행수를 count하는데
-- 1보다 큰거는 특정열에서 중복된값이 있는 그룹만 선택하게됨??? 모르겠음

# 학생이름과 주소지를 표시하시오.
# 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.

select * from tb_student;

select STUDENT_NAME 학생이름,
       STUDENT_ADDRESS 주소지
from tb_student
order by STUDENT_NAME;

# 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.

select ABSENCE_YN,
       STUDENT_NAME,
        student_ssn
from tb_student
order by STUDENT_SSN;

# 주소지가 강원도나 경기도인 학생들 중 2020년대 학번을 가진 학생들의
# 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
# 단, 출력헤더에는 "학생이름","학번", "거주지 주소" 가 출력되도록 한다.
select * from tb_student;
select * from tb_grade;
#학기번호에 년도가 기재되있음, 학기번호는 GRADE에 있음

select STUDENT_ADDRESS 거주지주소,
       STUDENT_NAME 학생이름,
       STUDENT_NO 학번,
       TERM_NO 학기번호
from tb_student
join tb_grade using (STUDENT_NO)
where STUDENT_ADDRESS LIKE '%강원도%' OR STUDENT_ADDRESS LIKE '%경기도%'
      AND TERM_NO LIKE '2020%'
order by STUDENT_NAME;

# 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인핛 수 있는 SQL 문장을 작성하시오.
# (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)
SELECT * FROM tb_professor;
SELECT * FROM tb_department;

SELECT PROFESSOR_SSN 주민번호,
       PROFESSOR_NAME 교수이름
FROM tb_professor
JOIN tb_department USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '법학과'
ORDER BY PROFESSOR_SSN;

# 2022 년 2학기에 C3118100 과목을 수강한 학생들의 학점을 조회하려고 한다.
# 학점이 높은 학생부터 표시하고,
# 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오
select * from tb_class;

# SELECT distinct STUDENT_NAME,
#        POINT,
#        class_no
# from tb_student  join tb_grade using (student_no)
# join tb_class  using(class_no)
# where class_no = 'C3118100'
# order by POINT desc, STUDENT_NO asc;

# 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 문을 작성
SELECT * FROM tb_student;
select * from tb_department;
select * from tb_grade;

SELECT distinct tb_grade.STUDENT_NO 학생번호,
       tb_student.STUDENT_NAME 학생이름,
       tb_department.DEPARTMENT_NAME 학과이름
FROM tb_student
    JOIN tb_department using(department_no)
    join tb_grade using(student_no)
order by STUDENT_NAME;

# 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력

select distinct DEPARTMENT_NAME 학과이름,
       class_name 과목이름
from tb_department
join tb_class using (department_no);

# 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력
SELECT * FROM tb_class;
SELECT * FROM tb_professor;

SELECT PROFESSOR_NAME 교수이름,
       CLASS_NAME 과목이름
from tb_professor
join tb_class using (DEPARTMENT_NO);

# 8 번의 결과 중 ‘인문사회’ 계열에 속한 과목의 교수 이름을 찾으려고 한다.
# 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성

select * from tb_department;

select distinct PROFESSOR_NAME 교수이름,
       class_name 과목이름
from tb_professor
join tb_class using (department_no)
join tb_department using (department_no)
where category = '인문사회';


# ‘음악학과’ 학생들의 평점을 구하려고 한다.
# 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오.
# (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)

select
       STUDENT_NO 학번,
        STUDENT_NAME 학생이름,
        round(sum(point)/count(STUDENT_NO),1) 평점
from tb_student
join tb_department using(department_no)
join tb_grade using (student_no)
where DEPARTMENT_NAME = '음악학과'
group by STUDENT_NO;  #group by절로 묶어야 연산이 가능함


# 9. 학번이 `A313047` 인 학생이 학교에 나오고 있지 않다.
# 지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다.
# 이때 사용할 SQL 문을 작성하시오.
#      단, 출력헤더는 ‚’학과이름‛, ‚학생이름‛, ‚지도교수이름‛으로 출력되도록 한다.

select distinct
       department_name 학과이름,
       STUDENT_NAME 학생이름,
       professor_name 교수이름
from tb_student
join tb_department using(DEPARTMENT_NO)
join tb_professor using(department_no)
    where STUDENT_NO = 'A313047';



# 2022년도에 인간관계론 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오





# 예체능 계열 과목 중 과목 담당교수를 한명도 배정받지 못한 과목을 찾아 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성




# 12. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다.
# 학생이름과 지도교수 이름을 찾고 맡길 지도 교수가 없는 학생일 경우
# "지도교수 미지정”으로 표시하도록 하는 SQL 문을 작성하시오.
#     단, 출력헤더는 “학생이름”, “지도교수”로 표시하며 고학번 학생이 먼저 표시되도록 한다






# 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아
# 그 학생의 학번, 이름, 학과 이름, 평점을 출력하는 SQL 문을 작성



# 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.



# 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성




# 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을 작성하시




# 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의
# 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL 문을 찾아내시오. 단, 출력헤더는 "계열 학과명",
# "전공평점"으로 표시되도록 하고, 평점은 소수점 한 자리까지만 반올림하여 표시되도록 한다.





