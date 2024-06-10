-- EMPLOYEE 테이블에서 SALARY 컬럼을 기준으로 오름차순 정렬하여 조회하시오.

    select SALARY
    from employee
    order by SALARY asc ;

-- EMPLOYEE 테이블에서 SALARY 컬럼을 기준으로 내림차순 정렬하여 조회하시오.

select SALARY
from employee
order by SALARY desc ;

-- EMPLOYEE 테이블에서 SALARY 컬럼을 기준으로 내림차순 정렬하고,
-- 같은 값이 있을 경우 EMP_NAME을 기준으로 오름차순 정렬하여 조회하시오.

select SALARY,
       EMP_NAME
from employee
order by SALARY desc,
         EMP_NAME;

-- EMPLOYEE 테이블에서 EMP_ID와 SALARY, 그 둘의 곱을 계산하여 mult_salary 별칭으로 부여하고,
-- 해당 값으로 내림차순 정렬하여 조회하시오.

select EMP_ID,
       SALARY,
       EMP_ID * SALARY as multiple
from employee
order by multiple desc ;

-- EMPLOYEE 테이블에서 ENT_YN이 'N'인 항목을 먼저, 'Y'인 항목을 나중에 정렬하여 조회하시오.

select ENT_YN
    from employee
order by field(ENT_YN,'N','Y');
