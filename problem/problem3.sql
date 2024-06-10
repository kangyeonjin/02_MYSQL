-- EMPLOYEE 테이블에서 DEPT_CODE가 'D1'인 데이터를 조회하시오.

    select
          DEPT_CODE
    from
        employee
    where DEPT_CODE ='D1';

-- EMPLOYEE 테이블에서 SALARY가 5000000 이상인 데이터를 조회하시오.
select
    SALARY
from
    employee
where SALARY >= 5000000;
-- EMPLOYEE 테이블에서 DEPT_CODE가 'D1'이면서 SALARY가 3000000 이상인 데이터를 조회하시오.
select
    DEPT_CODE,
    SALARY
from
    employee
where DEPT_CODE ='D1' and SALARY = 3000000;

-- EMPLOYEE 테이블에서 DEPT_CODE가 'D1'이거나 JOB_CODE가 'J4'인 데이터를 조회하시오.

select
    DEPT_CODE,
    JOB_CODE
from
    employee
where DEPT_CODE ='D1' or JOB_CODE ='J4';

-- EMPLOYEE 테이블에서 SALARY가 2000000 이상 4000000 이하인 데이터를 조회하시오.
select
    SALARY
from
    employee
where SALARY >= 2000000 and SALARY <= 4000000;
-- EMPLOYEE 테이블에서 EMP_NAME에 '김'이 포함된 데이터를 조회하시오.
select
    *
from
    employee
where EMP_NAME like '%김%';

-- EMPLOYEE 테이블에서 EMP_NAME이 '이'로 시작하는 데이터를 조회하시오.
select
    *
from
    employee
where EMP_NAME like '이%';
-- EMPLOYEE 테이블에서 EMAIL이 'greedy.com'으로 끝나는 데이터를 조회하시오.
select
    *
from
    employee
where EMAIL like '%greedy.com';

-- EMPLOYEE 테이블에서 EMP_NAME이 '송'으로 시작하고 '기'로 끝나는 데이터를 조회하시오.

select *
from employee
where EMP_NAME like '송%기';

-- EMPLOYEE 테이블에서 PHONE이 '010'으로 시작하지 않는 데이터를 조회하시오.

    select *
    from
        employee
    where PHONE not like '010%';

-- EMPLOYEE 테이블에서 DEPT_CODE가 'D1', 'D2', 'D3'인 데이터를 조회하시오.
select
    *
from
    employee
where DEPT_CODE in ('D1','D2','D3');

-- EMPLOYEE 테이블에서 JOB_CODE가 'J1', 'J2', 'J3'이 아닌 데이터를 조회하시오.
select
    *
from
    employee
where JOB_CODE in ('J1','J2','J3');
-- EMPLOYEE 테이블에서 SAL_LEVEL이 'S1', 'S2', 'S3'인 데이터를 조회하시오.
select
    *
from
    employee
where SAL_LEVEL in ('S1','S2','S3');
-- EMPLOYEE 테이블에서 DEPT_CODE가 NULL인 데이터를 조회하시오.
select
    *
from
    employee
where DEPT_CODE iS NULL;
-- EMPLOYEE 테이블에서 EMAIL이 NULL이 아닌 데이터를 조회하시오.
select
    *
from
    employee
where employee.EMAIL iS NOT NULL;