-- employees(scott 의 emp동일개념인데 확장된 버전)

-- first name , last name, job id 만 조회
SELECT e.FIRST_NAME,e.LAST_NAME,e.JOB_ID
FROM EMPLOYEES e;

-- job_id 중복 제외 하고 확인
SELECT DISTINCT e.JOB_ID 
FROM EMPLOYEES e;

-- 사번이 176인 사원의 lastname과 부서번호를 조회 
SELECT e.LAST_NAME,e.DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE e.EMPLOYEE_ID = 176;
-- 연봉이 12000 이상인 사원의 lastname과 연봉 조회
SELECT e.LAST_NAME,e.SALARY
FROM EMPLOYEES e 
WHERE e.SALARY  >= 12000;
-- 연봉이 5000 ~ 12000 범위가 아닌 사원의 lastname과 급여를 조회
SELECT e.LAST_NAME,e.SALARY
FROM EMPLOYEES e 
WHERE NOT e.SALARY >= 5000 AND e.SALARY <=12000;
-- BETWEEN 사용 / 연봉이 5000 ~ 12000 범위가 아닌 사원의 lastname과 급여를 조회
SELECT e.LAST_NAME,e.SALARY
FROM EMPLOYEES e 
WHERE  e.SALARY NOT BETWEEN 5000 AND 12000;

--IN
-- 20,50번 부서에 근무하는 사원 조회(LAST_NAME, 부서번호), LAST_NAME 오름차순
SELECT e.LAST_NAME, e.DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE e.DEPARTMENT_ID IN (20,50) ORDER BY e.LAST_NAME ASC;
-- SALARY가 2500,3500,7000이 아니고, 직무가 SA_REP, ST_CLERK가 아닌 사원 조회
SELECT*
FROM EMPLOYEES e 
WHERE e.SALARY NOT IN (2500,3500,7000) AND e.JOB_ID NOT IN ('SA_REP','ST_CLERK');

-- 2014년 고용자 조회
-- 날짜 데이터도 ''붙임
SELECT*
FROM EMPLOYEES e 
WHERE e.HIRE_DATE BETWEEN '2014-01-01' AND '2014-12-31';

-- LAST_NAME u가 포함되는 사원들의 사번, LAST_NAME 조회
SELECT e.LAST_NAME, e.EMPLOYEE_ID
FROM EMPLOYEES e 
WHERE e.LAST_NAME LIKE '%u%';

-- LAST_NAME 의 4번째 글자가 a인 사원들의 사번, LAST_NAME조회
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e  
WHERE e.LAST_NAME  LIKE '___a%';

-- LAST_NAME 의 a혹은 e글자가 있는 사원들의 사번, LAST_NAME조회, LAST_NAME의 내림차순
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e  
WHERE e.LAST_NAME LIKE '%a%' OR e.LAST_NAME LIKE '%e%' ORDER BY e.LAST_NAME DESC;

-- LAST_NAME 의 a와 e글자가 있는 사원들의 사번, LAST_NAME조회, LAST_NAME의 내림차순
SELECT e.EMPLOYEE_ID, e.LAST_NAME
FROM EMPLOYEES e  
WHERE e.LAST_NAME LIKE '%a%e%' OR e.LAST_NAME LIKE '%e%a%' ORDER BY e.LAST_NAME DESC;

-- IS NULL
-- 매니저가 없는 사원들의 LAST_NAME, JOB_ID
SELECT e.LAST_NAME,e.JOB_ID
FROM EMPLOYEES e 
WHERE e.MANAGER_ID IS NULL;

-- ST_CLERK인 직업을 가진 사원이 없는 부서번호 조회(단, 부서번호가 null값인 부서 제외)
SELECT DISTINCT e.DEPARTMENT_ID
FROM EMPLOYEES e 
WHERE e.JOB_ID != 'ST_CLERK' AND e.DEPARTMENT_ID IS NOT NULL;
-- COMMISSION_PCT가 NULL 이 아닌 사원들 중 COMMISSTION=SALARY * COMMISSION_PCT 를 구한다
-- 계산 결과와 함께 사번, FIRST_NAME, JOB_ID 출력
SELECT e.EMPLOYEE_ID,e.FIRST_NAME,e.JOB_ID, e.SALARY * e.COMMISSION_PCT AS COMMISSTION
FROM EMPLOYEES e 
WHERE e.COMMISSION_PCT IS NOT NULL;

-- first name 이 'Curtis' 인 사람의 first name 과 last name, email ,phone number, job id조회
-- job id 결과는 소문자로 출력
SELECT e.FIRST_NAME, e.LAST_NAME, e.EMAIL, e.PHONE_NUMBER, LOWER(e.JOB_ID) AS job_id
FROM EMPLOYEES e 
WHERE e.FIRST_NAME = 'Curtis' ;

-- 부서번호가 60,70,80,90 인 사원들의 사번, firstname , last name,hiredate,job id 조회 
-- job id가 IT_PROG 인 사원의 경우 '프로그래머' 로 변경하여 출력
SELECT e.EMPLOYEE_ID ,e.FIRST_NAME , e.LAST_NAME , e.HIRE_DATE, REPLACE(e.JOB_ID, 'IT_PROG','프로그래머') job_id
FROM EMPLOYEES e 
WHERE e.DEPARTMENT_ID IN (60,70,80,90);

-- job id가 AD_PRES, PU_CLERK 인 사원들의 사번 , first name, lase name,부서번호, job id 조회
-- 사원명은 first name ,lastname 을 연결하여 출력한다  
SELECT e.EMPLOYEE_ID ,e.FIRST_NAME  || ' ' || e.LAST_NAME AS name,e.DEPARTMENT_ID,e.JOB_ID
FROM EMPLOYEES e 
WHERE e.JOB_ID IN ('AD_PRES', 'PU_CLERK');

-- 입사 10주년이 되는 날짜 출력
SELECT e.EMPLOYEE_ID , e.FIRST_NAME, e.HIRE_DATE, ADD_MONTHS(e.HIRE_DATE, 120)
FROM EMPLOYEES e ;
































