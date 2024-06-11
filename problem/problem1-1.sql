-- DEPARTMENT 테이블에서 모든 컬럼을 조회하시오.

    select *
    from department;

-- EMPLOYEE 테이블에서 EMP_NAME과 SALARY 컬럼을 조회하시오.

    select
        EMP_NAME,
        SALARY
    from
        employee;

-- JOB 테이블에서 JOB_CODE와 JOB_NAME을 조회하시오.

    select
        JOB_CODE,
        JOB_NAME
    from
        job;

-- LOCATION 테이블에서 LOCAL_CODE와 LOCAL_NAME을 조회하시오.

    select
        LOCAL_CODE,
        LOCAL_NAME
    from
        location

-- NATION 테이블에서 NATIONAL_NAME의 별칭을 '국가명'으로 하여 조회하시오
    select
        concat('국가명');

select NATIONAL_NAME as '국가명' from nation;