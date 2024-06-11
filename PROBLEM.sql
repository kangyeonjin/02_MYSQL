-- EMPLOYEE 테이블에서 SAL_LEVEL의 중복을 제거하고
 -- 고유한 급여 등급을 조회하시오.

    select distinct sal_level
    from employee;

-- EMPLOYEE 테이블에서 MANAGER_ID의 중복을 제거하고
-- 고유한 관리자 사번을 조회하시오. (NULL 값 포함)

   select distinct manager_id
   from employee;

-- EMPLOYEE 테이블에서 DEPT_CODE와 JOB_CODE의 조합을
-- 중복없이 조회하시오. (NULL 값 포함)

    select distinct DEPT_CODE,
           JOB_CODE
    from employee;

-- EMPLOYEE 테이블에서 SALARY가 높은 순서대로
-- EMP_NAME과 SALARY를 포함하여 상위 5명의 데이터를 조회하시오.

    select SALARY,
        EMP_NAME
    from
        employee
    order by SALARY
    LIMIT 5;

-- EMPLOYEE 테이블에서 HIRE_DATE가 가장 최근인 순서대로
-- EMP_NAME과 HIRE_DATE를 포함하여 상위 10명의 데이터를 조회하시오.

    SELECT HIRE_DATE, EMP_NAME
    FROM employee
    ORDER BY  HIRE_DATE
    LIMIT 10;

-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여,
-- 각 직원의 이름과 그 직원이 속한 부서명을 조회하시오.

    SELECT EMP_NAME,
           dept_title
    FROM
        employee a
    inner join department b
    on(a.DEPT_CODE = b.DEPT_ID);

-- EMPLOYEE 테이블과 JOB 테이블을 조인하여,
-- 각 직원의 이름과 그 직원의 직급명을 조회하시오.

    select JOB_NAME,
           EMP_NAME
    from employee a
    inner join job b
    using (JOB_CODE);

-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 LEFT JOIN하여,
-- 모든 직원과 그 직원이 속한 부서명을 조회하되, 부서가 없는 직원도 포함하여 조회하시오.

SELECT EMP_NAME,
       dept_title
FROM
    employee a
        LEFT join department b
        on(a.DEPT_CODE = b.DEPT_ID);

-- EMPLOYEE 테이블을 자기 자신과 조인하여,
-- 각 직원과 그 직원의 관리자의 이름을 조회하시오.
-- (자기 자신을 조인하는 SELF JOIN을 사용)

SELECT
    a.EMP_NAME,
    b.EMP_NAME
FROM
    employee a
join employee b on (a.EMP_ID = b.MANAGER_ID);

-- EMPLOYEE 테이블에서 JOB_CODE별 평균 급여를 조회하시오.

    SELECT JOB_CODE,AVG(SALARY) FROM employee GROUP BY JOB_CODE;

-- EMPLOYEE 테이블에서 SAL_LEVEL별 최소 급여를 조회하시오.

SELECT SAL_LEVEL, MIN(SALARY)
FROM employee
GROUP BY SAL_LEVEL;

-- EMPLOYEE 테이블에서 DEPT_CODE별 직원 수를 조회하되, 직원 수가 3명 이상인 부서만 조회하시오.

SELECT DEPT_CODE,
       COUNT(*)
FROM employee
GROUP BY DEPT_CODE
HAVING  COUNT(DEPT_CODE) >= 3;

-- EMPLOYEE 테이블에서 JOB_CODE별 평균 급여를 조회하되, 평균 급여가 4000000 이상인 직급만 조회하시오.

    SELECT JOB_CODE,
    AVG(SALARY)
    FROM employee
    GROUP BY JOB_CODE
    HAVING AVG(SALARY) >=4000000;

-- EMPLOYEE 테이블에서 DEPT_CODE와 JOB_CODE별 총 급여와 각 DEPT_CODE별
-- 총 급여를 ROLLUP을 사용하여 조회하시오.

    SELECT DEPT_CODE,
           JOB_CODE,
            SUM(SALARY)
        FROM employee
    GROUP BY DEPT_CODE,JOB_CODE
    WITH ROLLUP ;

-- EMPLOYEE 테이블에서 '해외영업1부'에 속한
-- 모든 직원의 이름, 직급, 급여를 조회하시오.

    SELECT EMP_NAME 이름,
           SALARY 급여,
           JOB_CODE 직급
    FROM employee
    JOIN department
    WHERE DEPT_ID IN ( SELECT DEPT_ID
                       FROM department
                       WHERE DEPT_TITLE = '해외영업1부');

-- EMPLOYEE 테이블에서 모든 직원의 평균 급여보다 높은 급여를 받는 직원의 이름과 급여를 조회하시오.

    select EMP_NAME,
         SALARY
    FROM employee
    WHERE SALARY > (SELECT AVG(SALARY) FROM employee);


-- EMPLOYEE 테이블에서 각 부서의 평균 급여보다 높은 급여를 받는
-- 직원의 이름, 부서명, 급여를 조회하시오.

    SELECT EMP_NAME 이름,
           SALARY 급여,
           DEPT_TITLE 부서명
    FROM
        employee
    JOIN department
    WHERE SALARY > (SELECT AVG(DEPT_CODE) FROM employee)
    ORDER BY SALARY DESC;

-- 상관서브쿼리문제
-- EMPLOYEE 테이블에서 각 부서별로
-- 가장 높은 급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.

SELECT EMP_NAME 이름,
       SALARY 급여,
       DEPT_TITLE 부서명
FROM
    employee
JOIN department
WHERE SALARY = (SELECT MAX(SALARY) FROM employee)
ORDER BY SALARY DESC;

-- EMPLOYEE 테이블에서 각 직급별 평균 급여보다 높은 급여를 받는 직원의 이름, 직급, 급여를 조회하시오.

SELECT EMP_NAME 이름,
       SALARY 급여,
        JOB_NAME 직급명
FROM
    employee
        JOIN job
WHERE SALARY > (SELECT AVG(SALARY) FROM employee)
ORDER BY SALARY DESC;

-- EXISTS 절 문제
-- DEPARTMENT 테이블에서
-- 직원이 있는 부서의 부서명을 조회하시오.

    SELECT DEPT_TITLE 부서명
        FROM department a
        JOIN employee b
    WHERE EXISTS( SELECT
                      count(*)  -- dept ip가 같은 사람 숫자를 센다
                  FROM department
           WHERE a.DEPT_ID = b.DEPT_CODE);

-- EMPLOYEE 테이블에서 급여가 가장 높은 직원의 이름과 급여를 조회하시오. (NOT EXISTS 사용)

    select SALARY,
           EMP_NAME
    from employee a
    where not exists(select SALARY
                     FROM employee b  -- 기존 급여정보에 계속 값을 비교해서 가장 큰 값을 출력
                     WHERE a.SALARY < b.SALARY);


-- CTE 문제
-- EMPLOYEE 테이블에서 각 부서별 평균 급여를 계산하고,
-- 평균 급여가 4000000 이상인 부서의 부서명과 평균 급여를 조회하시오.

    with ctemplyee as (
    select
       SALARY 급여,
       DEPT_TITLE 부서명
    from employee
    join department on SALARY >= 4000000
)

select *
from ctemplyee;



-- 부서코드가 'D6' 이거나 'D8'인 직원의
-- 이름, 부서, 급여를 조회하세요
-- IN 연산자 : 비교하려는 값 목록에 일치하는 값이 있는지 확인

-- 이씨성이 아닌 직원의 사번, 이름, 이메일주소 조회

-- J2직급의 급여 200만원 이상 받는 직원이거나
-- J7 직급인 직원의 이름, 급여, 직급코드 조회

-- J7 직급이거나 J2 직급인 직원들 중
-- 급여가 200만원 이상인 직원의
-- 이름, 급여, 직급코드를 조회하세요






