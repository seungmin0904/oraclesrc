-- RDBMS
-- 기본 단위 : 테이블
-- EMP(사원정도테이블)
-- empno(사번), ename(사원명), job(직책), mgr(직속상관사번), hiredate(입사일), sal(급여), comm(추가수당), deptno(부서명)
-- NUMBER(4,0) : 전체 자리수 4자리(소수점 자릿수 0)
-- VARCHA2(10) : 문자열 10byte (VAR : 가변 - 대아터 넣는 만큼의 공간만 사용하겠다 최대 저장값 이상 허용X)
--               영어는 10문자, 한글은 2byte, utf-8은 3byte 할당   
-- DATE : 날짜

-- DEPT(부서테이블)
-- DEPTNO(부서번호), dname(부서명), loc(부서위치)

-- SALGRADE(급여)
-- grade(급여등급), losal(최저급여), hisal(최대급여)

-- 개발자 : CR(Read)UD 
-- SQL(Structured Query Language : 구조질의언어) : RDBMS 데이터를 다루는 언어

-- 1. 조회(SELECT) - Read
-- 사원 정보 조회(전체조회)

-- * : 모든 열을 의미함
SELECT * FROM EMP e;
-- e. :  테이블내 지정 접근 가능
SELECT e.ENAME,e.EMPNO,e.JOB FROM EMP e;

-- 사원번호, 부서번호만 조회
SELECT e.EMPNO , e.DEPTNO FROM EMP e;

-- 중복 데이터 제외하고 조회 = DISTINCT
SELECT DISTINCT deptno FROM emp;
-- 데이터가 완전히 일치해야 중복처리가 됨
SELECT DISTINCT job, deptno FROM emp;

-- 별칭
SELECT ename, sal, sal*12 + comm annsal, comm
FROM EMP;
-- 별칭
SELECT ename, sal, sal*12 + comm AS "annsal", comm
FROM EMP;
-- 한글가능
SELECT ename, sal, sal*12 + comm AS 연봉, comm
FROM EMP;
-- 공백 에러 : 공백이 있으면 "" 가 필수임
SELECT ename 사원명, sal 급여, sal*12 + comm AS "연 봉", comm 수당
FROM EMP;

-- 원하는 순서대로 출력데이터를 정렬해서 조회
-- 테이블의 모든 열을 급여 기준으로 오름차순 조회 asc(오름차)가 default라 생략 가능
SELECT * FROM EMP e ORDER BY e.sal ASC;
SELECT * FROM EMP e ORDER BY e.sal
-- 내림차순 조회
SELECT * FROM EMP e ORDER BY e.sal DESC;
-- 사번,이름,직무만 급여 기준으로 내림차순 조회
SELECT e.ENAME ,e.EMPNO ,e.JOB  FROM EMP e ORDER  BY e.sal DESC;
--부서번호의 오름차순, 급여의 내림차순
SELECT * FROM EMP e ORDER BY e.DEPTNO ASC, e.SAL DESC;

SELECT
	e.EMPNO EMPLOYEE_NO,
	e.ENAME EMPLOYEE_NAME,
	e.MGR MANAGER,
	e.SAL SALARY,
	e.COMM COMMISSION,
	e.DEPTNO DEPARTMENT_NO
FROM
	EMP e ;
SELECT * FROM emp e ORDER BY e.DEPTNO DESC, e.ename ASC;

--where : 조건부여 ex) 조회 시
-- 부서번호가 30번인 사원 조회
SELECT *
FROM EMP e 
WHERE e.DEPTNO =30;

-- 사원번호가 7782인 사원 조회
SELECT *
FROM EMP e 
WHERE e.EMPNO =7782;

-- 부서 번호가 30이고(AND) 직책이 세일즈맨인 사람을 조회
-- 오라클에서 문자는 ''만 허용 
-- 문자열은 대소문자 구분을 함
SELECT *
FROM EMP e 
WHERE e.DEPTNO = 30 AND e.JOB ='SALESMAN';

-- 사원번호가 7499 이고 부서번호가 30번인 사원을 조회
SELECT *
FROM EMP e 
WHERE e.EMPNO =7499 AND e.DEPTNO = 30;

-- 사원번호가 7499 이거나(or) 부서번호가 30인 사원을 조회
select
FROM EMP e
WHERE e.EMPNO =7499 or e.DEPTNO = 30;



-- 연산자
-- 1) 산술 연산자 : +,-,*,/
-- 연봉이(SAL*12) 36000 인 사원 조회
SELECT* 
FROM EMP e 
WHERE e.sal*12 =36000;



-- 2) 비교 연산자 : >,<,>=,<=,=
--급여가 2500이상이고 직업이 ANALYST 사원 조회
SELECT*
FROM EMP e
WHERE e.sal >= 2500 AND e.job = 'ANALYST';


-- 3) 등가 비교연산자 : =, 같지않다(!=, <> , ^=)
-- 급여가 3000이 아닌 사원 조회
SELECT*
FROM EMP e
WHERE e.sal != 3000 ;


-- 4) 논리 부정연산자 : NOT
-- job이 MANAGER 이거나, SALESMAN 이거나, CLERK 아닌 사원 조회
SELECT *
FROM EMP e 
WHERE 
e.JOB NOT IN ('MANAGER','SALESMAN','CLERK');


-- 5)             : IN
-- job이 MANAGER 이거나, SALESMAN 이거나, CLERK 사원 조회(IN 사용)
SELECT *
FROM EMP e 
WHERE 
e.JOB IN ('MANAGER','SALESMAN','CLERK');



-- 6) 범위 연산자 : BETWEEN A AND B
-- BETWEEN
-- 2000 ~ 3000 사이인 직원
SELECT*
FROM EMP e 
WHERE e.SAL BETWEEN 2000 AND 3000;

-- 2000 ~ 3000 사이가 아닌 사원
SELECT*
FROM EMP e 
WHERE e.SAL NOT BETWEEN 2000 AND 3000;



-- 7) 검색 연산자 : LIKE 연산자와 와일드카드( _ , % )
-- 사원명이 s로 시작하는 사원을 조회
SELECT*
FROM EMP e 
WHERE e.ename LIKE 'S%'

-- 사원 이름의 두번째 글자가 L인 사원을 조회
SELECT*
FROM EMP e 
WHERE e.ename LIKE '_L%'

-- 사원명에 AM이 포함된 사원조회
SELECT*
FROM EMP e 
WHERE e.ename LIKE '%AM%';

-- 사원명에 AM이 포함되지 않은 사원 조회
SELECT*
FROM EMP e 
WHERE e.ename NOT LIKE '%AM%';



-- 8) IS NULL : NULL과 같다
-- COMM 이 NULL인 사원 조회
SELECT * 
FROM EMP e  
WHERE e.COMM IS NULL;

-- MGR(직속상관) 이 NULL 인 사원 조회
SELECT * 
FROM EMP e  
WHERE e.MGR  IS NULL;

-- 직속상관이 있는 사람
SELECT * 
FROM EMP e  
WHERE e.MGR  IS NOT NULL;






-- 연봉이(SAL*12) 36000 인 사원 조회
SELECT* 
FROM EMP e 
WHERE e.sal*12 =36000;

-- 급여가 3000이상인 사원 조회
SELECT*
FROM EMP e
WHERE e.sal >= 3000 ;

--급여가 2500이상이고 직업이 ANALYST 사원 조회
SELECT*
FROM EMP e
WHERE e.sal >= 2500 AND e.job = 'ANALYST';

-- 문자 대,소 비교
-- 사원명의 첫 문자가 F와 같거나 F보다 뒤에있는 
SELECT*
FROM EMP e
WHERE e.ename >= 'F';
-- 급여가 3000이 아닌 사원 조회
SELECT*
FROM EMP e
WHERE e.sal != 3000 ;

SELECT*
FROM EMP e
WHERE e.sal <> 3000 ;

SELECT*
FROM EMP e
WHERE e.sal ^= 3000 ;

SELECT*
FROM EMP e
WHERE NOT e.sal = 3000 ;

-- job이 MANAGER 이거나, SALESMAN 이거나, CLERK 사원 조회(IN 사용)
SELECT *
FROM EMP e 
WHERE 
e.JOB IN ('MANAGER','SALESMAN','CLERK');
-- job이 MANAGER 이거나, SALESMAN 이거나, CLERK 아닌 사원 조회
SELECT *
FROM EMP e 
WHERE 
e.JOB NOT IN ('MANAGER','SALESMAN','CLERK');

-- BETWEEN A AND B
-- 급여가 2000 이상 3000 이하인 사원
SELECT*
FROM EMP e 
WHERE e.SAL >= 2000 AND e.sal <=3000;

-- BETWEEN
SELECT*
FROM EMP e 
WHERE e.SAL BETWEEN 2000 AND 3000;
-- 2000 이상 3000이하가 아닌 사원
SELECT*
FROM EMP e 
WHERE e.SAL NOT BETWEEN 2000 AND 3000;

-- LIKE: 검색
-- _ : 어떤 값이든 상관없이 한개의 문자열 데이터를 의믜
-- % : 길이와 상관없이(문자 없는 경우도 포함)모든 문자열 데이터를 의미

-- 사원명이 s로 시작하는 사원을 조회
SELECT*
FROM EMP e 
WHERE e.ename LIKE 'S%'

-- 사원 이름의 두번째 글자가 L인 사원을 조회
SELECT*
FROM EMP e 
WHERE e.ename LIKE '_L%'

-- 사원명에 AM이 포함된 사원조회
SELECT*
FROM EMP e 
WHERE e.ename LIKE '%AM%';

-- 사원명에 AM이 포함되지 않은 사원 조회
SELECT*
FROM EMP e 
WHERE e.ename NOT LIKE '%AM%';

--IS NULL
-- COMM 이 NULL인 사원 조회
SELECT * 
FROM EMP e  
WHERE e.COMM IS NULL;

-- MGR(직속상관) 이 NULL 인 사원 조회
SELECT * 
FROM EMP e  
WHERE e.MGR  IS NULL;

-- 직속상관이 있는 사람
SELECT * 
FROM EMP e  
WHERE e.MGR  IS NOT NULL;









