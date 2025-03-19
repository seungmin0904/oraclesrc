-- RDBMS
-- 기본 단위 : 테이블
-- EMP(사원정도테이블)
-- empno(사번), ename(사원명), job(직책), mgr(직속상관사번), hiredate(입사일), sal(급여), comm(추가수당), deptno(부서명)
-- NUMBER(4,0) : 전체 자리수 4자리(소수점 자릿수 0)
-- VARCHA2(10) : 문자열 10byte (VAR : 가변 - 대아터 넣는 만큼의 공간만 사용하겠다 최대 저장값 이상 허용X)
--               영어는 10문자, 한글은 2byte, utf-8은 3byte 할당   
-- DATE : 날짜

-- 구문 실행 순서 
--3 SELECT 
--1 FROM 
--2 WHERE  
--4 ORDER BY 

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

-- 9) 집합 연산자 : UNION, MINUS , INTERSECT






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

--집합 연산자 
-- UNION
-- 부서번호 10,20 사원조회(or in)
SELECT *
FROM EMP e 
WHERE e.DEPTNO =10 OR e.DEPTNO 20;

SELECT *
FROM EMP e 
WHERE e.DEPTNO in(10,20);

SELECT *
FROM EMP e 
WHERE e.DEPTNO =10
UNION 
SELECT *
FROM EMP e 
WHERE e.DEPTNO =20;

-- 타입 일치만 확인 => 타입이 맞는다면 연결
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO =10
UNION 
SELECT e.SAL , e.JOB, e.DEPTNO, e.EMPNO 
FROM EMP e 
WHERE e.DEPTNO =20;

-- UNION(중복 제외하고 출력), UNION ALL(중복 데이터 포함 출력)
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO =10
UNION 
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO =10;

SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO =10
UNION ALL 
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO =10;


-- MINUS


-- INTERSECT 교집합 
SELECT e.EMPNO,e.ENAME,e.SAL,e.DEPTNO
FROM EMP e
INTERSECT
SELECT e.EMPNO,e.ENAME,e.SAL,e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO 10;

-- 오라클 함수
-- 내장함수
-- 1) 문자함수 
-- 대소문자를 바꿔주는 함수  : upper(), lower(), initcap()
-- 문자의 길이를 구하는 함수 : LENGTH(), LENGTHB()
-- 문자열 일부 추출 : SUBSTR(문자열 데이터, 시작위치 , 추출 길이)
-- 문자열 데이터 안에서 특정 문자 위치 찾기 : (INSTR())
-- 특정문자를 다른문자로 변경 : REPLACE(원본 문자열, 찾을 문자열, 변경 문자열)
-- 두 문자열 데이터를 합치기 : CONCAT(문자열1,문자열2), ||
-- 특정 문자 제거 : TRIM() , LTRIM() , RTRIM()


-- 사원 이름을 대문자 , 소문자 , 첫문자만 대문자로 변경
SELECT e.ENAME, UPPER(e.ENAME), LOWER(e.ENAME), INITCAP(e.ENAME)
FROM EMP e ;

-- 제목 oracle 검색
-- LIKE '&oracle%' or LIKE '&ORACLE%' or LIKE '&Oracle%'
--SELECT*
--FROM board
--WHERE upper(title) = upper ('oracle') 

-- 사원명 길이 구하기
SELECT e.ENAME , LENGTH(e.ENAME)
FROM EMP e ;

-- 사원명이 5자 이상인 사람 조회 
SELECT *
FROM EMP e 
WHERE LENGTH (e.ENAME) >=5; 

--LENGTHB() 문자열 바이트 수를 반환
-- XE버전 : 한글에 3byte 사용
-- dual : sys 소유 테이블(임시 연산이나 함수의 결과값 확인용도로 사용)
SELECT LENGTH('한글'), LENGTHB('한글')
FROM DUAL;


-- 시작위치 지정 시 양수(왼쪽) 1, 음수(오른쪽) : 맨끝부터 -1
SELECT e.JOB, SUBSTR(e.JOB,1,2), SUBSTR(e.JOB, 5)
FROM EMP e ;


SELECT e.JOB, 
SUBSTR(e.JOB, -LENGTH(e.job)),
SUBSTR(e.JOB, -LENGTH(e.job),2),
SUBSTR(e.JOB,-3)
FROM EMP e ;

-- INSTR(대상 문자열,위치를 찾으려는 문자,시작위치,시작위치에서 찾으려는 문자가 몇번째인지 지정 가능)
SELECT
	INSTR('HELLO ORACLE', 'L') AS INSTR_1,
	INSTR('HELLO ORACLE', 'L', 5) AS INSTR_2,
	INSTR('HELLO ORACLE', 'L', 2, 2) AS INSTR_3
FROM DUAL;

-- 사원이름에 S가 있는 사원
SELECT *
FROM EMP e 
WHERE e.ENAME  LIKE '%S%';

SELECT *
FROM EMP e
WHERE INSTR ( e.ENAME,'S' ) > 0;

-- 특정문자를 다른문자로 변경 : REPLACE(원본 문자열, 찾을 문자열, 변경 문자열)
SELECT '010-1234-5678' AS REPLACE_BEFORE,
REPLACE('010-1234-5678', '-', ' ' )AS REPLACE1,
REPLACE('010-1234-5678', '-' )AS REPLACE2
FROM DUAL;

-- 사번 : 사원명
SELECT CONCAT(e.EMPNO, CONCAT( '  :  ' , e.ENAME ))
FROM EMP e ;
-- 이게 더 편함
SELECT e.EMPNO ||  '  :  '  || e.ENAME 
FROM EMP e ;

-- TRIM(삭제옵션(선택사항), 삭제할문자(선택사항) FROM 원본문자열(필수))
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS trim_leading,
	'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS trim_trailing,
	'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS trim_both
FROM
	DUAL;
-- LTRIM()
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || LTRIM( ' __Oracle__ ') || ']' AS Ltrim,
	'[' || RTRIM( ' __Oracle__ ') || ']' AS Rtrim,
	'[' || RTRIM( ' <__Oracle__> ' ,  '>__ ') || ']' AS Rtrim2
FROM
DUAL;

-- 숫자함수 
-- 반올림 : ROUND()
-- 버림 : TRUNC()
-- 가장 큰 정수 : CEIL()
-- 가장 작은 정수 : FLOOR()
-- 나머지 : MOD()

---4 -3-2-1 0123
-- 1 2 3 4 . 5678
SELECT ROUND(1234,5678) AS ROUND,
ROUND(1234.5678 , 0) AS ROUND1,
ROUND(1234.5678, 1) AS ROUND2,
ROUND(1234.5678, 2) AS ROUND3,
ROUND(1234.5678 , -1) AS ROUND4,
ROUND(1234.5678 , -2) AS ROUND5
FROM DUAL;

SELECT
	TRUNC(1234, 5678) AS TRUNC,
	TRUNC(1234.5678 , 0) AS TRUNC1,
	TRUNC(1234.5678, 1) AS TRUNC2,
	TRUNC(1234.5678, 2) AS TRUNC3,
	TRUNC(1234.5678 , -1) AS TRUNC4,
	TRUNC(1234.5678 , -2) AS TRUNC5
FROM
	DUAL;


SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;


SELECT MOD(15,6), MOD(10,2), MOD(11,2)
FROM DUAL;

-- 날짜함수
-- 오늘 날짜와 시간을 돌려주는 함수 : SYSDATE
-- 몇개월 이후 날짜구하기 : ADD_MONTHS()
-- 두 날짜간의 개월수 차이 구하기 : MONTHS_BETWEEN()
-- 돌아오는 요일, 달의 마지막 날짜 구하기 : NEXT_DAY() / LAST_DAY()
SELECT
	SYSDATE AS NOW,
	SYSDATE-1 YESTERDAY,
	SYSDATE + 1 AS TOMORROW,
	CURRENT_DATE AS current_date,
	CURRENT_TIMESTAMP AS CURRENT_TIMESTAMP
FROM
	DUAL;

-- 오늘 날짜를 기준으로 3개월 이후 날짜 구하기
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- 입사한지 40년이 넘은 사원 조회
SELECT *
FROM EMP e 
WHERE ADD_MONTHS(e.HIREDATE, 480) < SYSDATE; 

-- 오늘 날짜와 입사일자의 차이 구하기 
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	sysdate,
	MONTHS_BETWEEN(e.HIREDATE, sysdate)AS month1,
	MONTHS_BETWEEN(sysdate, e.HIREDATE )AS month2,
	TRUNC(MONTHS_BETWEEN(sysdate, e.HIREDATE))AS month3
FROM
	EMP e;

SELECT sysdate, NEXT_DAY(sysdate, '월요일'),LAST_DAY(sysdate)
FROM DUAL;

-- 자료형을 변환하는 형변환 함수
-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자열 데이터로 반환
-- TO_NUMBER() : 문자열 데이터를 숫자 데이터로 반환
-- TO_DATE() : 문자열 데이터를 날짜 데이터로 반환

--number + '문자숫자' : 덧셈 가능 (자동 형변환)
--SELECT e.EMPNO ,e.ENAME,e.EMPNO + '500'
--FROM EMP e 
--WHERE e.ENAME = 'SMITH';

SELECT sysdate, TO_CHAR(sysdate, 'YYYY-MM-DD')
FROM dual;

SELECT
	sysdate,
	TO_CHAR(sysdate, 'MM'),
	TO_CHAR(sysdate, 'MON'),
	TO_CHAR(sysdate, 'MONTH'),
	TO_CHAR(sysdate, 'DD'),
	TO_CHAR(sysdate, 'DY'),
	TO_CHAR(sysdate, 'DAY'),
	TO_CHAR(sysdate, 'HH24:MI:SS'),
	TO_CHAR(sysdate, 'HH12:MI:SS AM' ),
	TO_CHAR(sysdate, 'HH:MI:SS PM' )
FROM
	dual;

