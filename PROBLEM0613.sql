use empolyee_db;

select * from employee;

-- EMPLOYEE 테이블에서 각 직원의 이메일 주소에서 도메인 부분을 추출하여 출력하시오.

select EMAIL from employee;
# select EMAIL, field('@') from employee;

    select EMAIL,
        substring_index(EMAIL,'@',-1) '도메인'-- 골뱅이기준 오른쪽에서 첫번쨰가져와야해서-1
    from employee;

-- EMPLOYEE 테이블에서 각 직원의 급여에서 10%를 감한 후, 이를 소수점 둘째 자리에서 반올림하여 출력하시오

    select SALARY,
           ROUND(SALARY * 0.9,2)
    -- '(1-0.10)'과  '*0.9'는 동일하나 원금에서 얼마의 비율을 뺏는지 알기위해 1-0.10을 사용하기도함
    from employee;

-- EMPLOYEE 테이블에서 각 부서의 평균 급여를 계산하고,
-- 그 값을 '부서별 평균 급여는 X 원입니다' 형식의 문자열로 출력하시오.

    select DEPT_TITLE,
            concat('부서별 평균 급여는',round(avg(SALARY),2),'원 입니다')
    from employee a
    JOIN department b on a.DEPT_CODE= b.DEPT_ID
    -- on a.DEPT_CODE= b.DEPT_ID 연결하기 위해서 연결된 열을 기재해줌
    group by  DEPT_TITLE;

-- EMPLOYEE 테이블에서 각 직원의 입사 연도, 입사 월, 입사 일을 각각 조회하시오.
    select * from employee;

    select HIRE_DATE,
           year(HIRE_DATE) 입사년 ,
           month(HIRE_DATE) 입사월,
           day(HIRE_DATE) 입사일
           from employee;

-- EMPLOYEE 테이블에서 입사일이 2010년 1월 1일 이후인 직원들의 이름과 입사일을 조회하시오.

select HIRE_DATE
from employee
where HIRE_DATE > '2010-01-01' ;