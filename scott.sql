-- RDBMS 
-- 기본단위 : 테이블

-- EMP(사원정보 테이블)
-- empno(사번), ename(사원명), job(직책), mgr(직속상관사번), hiredate(입사일), sal(급여), comm(추가수당), deptno(부서번호)
-- NUMBER(4,0) : 전체 자릿수 4자리(소수점 자릿수 0)
-- VARCHAR2(10) : 문자열 10Byte (VAR : 가변 - 7byte 문자열 저장했다면 7byte 공간만 사용)
--                영어 10문자, 한글 2byte, utf-8 3byte 할당 
-- DATE : 날짜

-- DEPT(부서테이블)
-- deptno(부서번호), dname(부서명), loc(부서위치)

-- SALGRADE(급여테이블)
-- grade(급여등급), losal(최저급여), hisal(최대급여)

-- 개발자 : CR(Read)UD
-- SQL(Structured Query Language : 구조질의언어) : RDBMS 데이터를 다루는 언어

-- sql 구문 실행 순서
-- ③ SELECT 
-- ① FROM
-- ② WHERE 
-- ④ ORDER by

-- 1. 조회(SELECT) - Read
-- 사원정보조회(전체조회)
-- * (모든 열)
SELECT * FROM EMP e; 

-- 특정 열 조회
SELECT e.EMPNO, e.ENAME, e.JOB FROM EMP e; 

-- 사원번호, 부서번호만 조회
SELECT e.EMPNO, e.DEPTNO FROM EMP e;

-- 중복 데이터는 제외하고 조회
SELECT DISTINCT deptno FROM emp;

SELECT DISTINCT job, deptno FROM emp;

-- 별칭
SELECT ename, sal, sal * 12 + comm annsal, comm
FROM EMP; 

SELECT ename, sal, sal * 12 + comm AS "annsal", comm FROM EMP; 

SELECT ename, sal, sal * 12 + comm AS annsal, comm FROM EMP; 

SELECT ename, sal, sal * 12 + comm AS 연봉, comm FROM EMP;
-- 별칭에 공백이 들어가는 경우 ""로 반드시 묶어야 함
SELECT ename 사원명, sal 급여, sal * 12 + comm AS "연 봉", comm 수당 FROM EMP e;

-- 원하는 순서대로 출력 데이터를 정렬(오름,내림) 
-- 오름차순일 때 asc 생략 가능
-- emp 테이블의 모든 열을 급여 기준으로 오름차순 조회
SELECT
	*
FROM
	EMP e
ORDER BY
	e.SAL ASC; 

SELECT
	*
FROM
	EMP e
ORDER BY
	e.SAL; 
-- 내림차순
SELECT * FROM EMP e ORDER BY e.SAL DESC; 
-- 사번,이름,직무만 급여기준으로 내림차순 조회
SELECT e.EMPNO, e.ENAME,e.JOB FROM EMP e ORDER BY e.SAL DESC; 

-- 부서번호의 오름차순, 급여의 내림차순
SELECT * FROM EMP e ORDER BY e.DEPTNO ASC, e.SAL DESC;

-- 
SELECT
	e.EMPNO employee_no,
	e.ENAME employee_name,
	e.mgr manager,
	e.sal salary,
	e.comm commission,
	e.deptno department_no
FROM
	EMP e;

SELECT
	*
FROM
	EMP e
ORDER BY
	e.DEPTNO DESC,
	e.ename ASC;

-- where : 조회 시 조건 부여
-- 부서번호가 30번인 사원 조회
SELECT *
FROM EMP e 
WHERE e.DEPTNO = 30;

-- 사번이 7782인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7782;

-- 부서번호가 30이고 직책이 SALESMAN 사원 조회
-- 오라클에서 문자는 '' 만 허용, 대소문자 구분
SELECT
	*
FROM
	EMP e
WHERE
	e.deptno = 30 AND e.job = 'SALESMAN';

-- 사번 7499 이고 부서번호가 30 사원조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7499 AND e.DEPTNO = 30;

-- 사번 7499 이거나 부서번호가 30 사원조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7499 OR e.DEPTNO = 30;

-- 연산자
-- 1) 산술연산자 : +,-,*,/
-- 2) 비교연산자 : >,<,>=,<=
-- 3) 등가비교연산자 : =, 같지않다(!=, <>, ^= )
-- 4) 논리부정연산자 : NOT
-- 5)             : IN
-- 6) 범위 : BETWEEN A AND B
-- 7) 검색 : LIKE 연산자와 와일드카드(_, %)
-- 8) IS NULL : 널과 같다
-- 9) 집합 연산자 : UNION,MINUS,INTERSECT

-- 연봉이(SAL*12) 36000 인 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal*12 = 36000;

-- 급여가 3000이상인 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal >= 3000;

-- 급여가 2500이상이고 직업이 ANALYST 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal >= 2500 AND e.JOB = 'ANALYST';

-- 문자 대소비교
-- 사원명의 첫 문자가 F와 같거나 F보다 뒤에 있는 사원조회
SELECT *
FROM EMP e
WHERE e.ename >= 'F';


-- 급여가 3000이 아닌 사원 조회
SELECT *
FROM EMP e 
WHERE e.sal != 3000;

SELECT *
FROM EMP e 
WHERE e.sal <> 3000;

SELECT *
FROM EMP e 
WHERE e.sal ^= 3000;

SELECT *
FROM EMP e 
WHERE NOT e.sal = 3000;

-- job 이 MANAGER 이거나, SALESMAN 이거나, CLERK 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB = 'MANAGER'
	OR e.JOB = 'SALESMAN'
	OR e.JOB = 'CLERK';

-- in 연산자로 변경
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB IN ('MANAGER','SALESMAN','CLERK');


SELECT
	*
FROM
	EMP e
WHERE
	e.JOB NOT IN ('MANAGER','SALESMAN','CLERK');

-- BETWEEN A AND B
-- 급여 2000 이상 3000이하
SELECT * FROM EMP E WHERE E.SAL >= 2000 AND E.SAL <= 3000;

SELECT * FROM EMP E WHERE E.SAL BETWEEN 2000 AND 3000;

-- 급여 2000 이상 3000이하가 아닌 사원 조회
SELECT * FROM EMP E WHERE E.SAL NOT BETWEEN 2000 AND 3000;

-- LIKE : 검색
-- _ : 어떤 값이든 상관없이 한 개의 문자열 데이터를 의미
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자열 데이터를 의미

-- 사원명이 S 로 시작하는 사원 조회
SELECT * FROM EMP E WHERE E.ENAME LIKE 'S%';

-- 사원이름의 두번째 글자가 L 인 사원 조회
SELECT * FROM EMP E WHERE E.ENAME LIKE '_L%';

-- 사원명에 AM 이 포함된 사원 조회
SELECT * FROM EMP E WHERE E.ENAME LIKE '%AM%';

-- 사원명에 AM 이 포함되지 않은 사원 조회
SELECT * FROM EMP E WHERE E.ENAME NOT LIKE '%AM%';

-- IS NULL
-- COMM이 NULL 인 사원 조회
SELECT *
FROM EMP e 
WHERE e.COMM IS NULL;

-- MGR이 NULL 인 사원(= 직속상관이 없는) 조회
SELECT *
FROM EMP e 
WHERE e.MGR IS NULL;

-- 직속 상관이 있는 사원 조회
SELECT *
FROM EMP e 
WHERE e.MGR IS NOT NULL;

-- 집합연산자 
-- UNION(합집합)
-- 부서번호 10, 20 사원조회(OR, IN)
SELECT * FROM EMP e WHERE e.DEPTNO = 10 OR e.DEPTNO=20;
SELECT * FROM EMP e WHERE e.DEPTNO IN (10,20);

SELECT e.EMPNO, e.ename, e.sal FROM EMP e WHERE e.DEPTNO = 10
UNION 
SELECT e.EMPNO, e.ename, e.sal FROM EMP e WHERE e.DEPTNO = 20;

-- 타입 일치만 확인 => 타입이 맞는다면 연결
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10
UNION 
SELECT e.sal, e.job, e.DEPTNO, e.empno FROM EMP e WHERE e.DEPTNO = 20;

-- UNION(중복 제외하고 출력), UNION ALL(중복 데이터도 출력)
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10
UNION 
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10;

SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10
UNION ALL 
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.DEPTNO = 10;

-- MINUS(차집합)

SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e
MINUS 
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.deptno = 10;


-- INTERSECT(교집합)
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e
INTERSECT 
SELECT e.EMPNO, e.ename, e.sal, e.DEPTNO FROM EMP e WHERE e.deptno = 10;

-- 오라클 함수
-- 내장함수
-- 1) 문자함수
-- 대소문자를 바꿔주는 함수 : upper(), lower(), initcap()
-- 문자의 길이를 구하는 함수 : LENGTH(), LENGTHB()
-- 문자열 일부 추출 : SUBSTR(문자열데이터,시작위치,추출길이)
-- 문자열 데이터 안에서 특정 문자 위치 찾기 : INSTR()
-- 특정문자를 다른 문자로 변경 : REPLACE(원본문자열,찾을문자열,변경문자열)
-- 두 문자열 데이터를 합치기 : CONCAT(문자열1, 문자열2), ||
-- 특정 문자 제거 : TRIM(), LTRIM(), RTRIM()


-- 사원이름을 대문자, 소문자, 첫문자만 대문자로 변경
SELECT e.ENAME, UPPER(e.ENAME), LOWER(e.ENAME), INITCAP(e.ENAME)
FROM EMP e; 

-- 제목 oracle 검색
-- LIKE '%oracle%' OR LIKE '%ORACLE%' OR LIKE '%Oracle%'
--SELECT * 
--FROM board
--WHERE upper(title) = upper('oracle')

-- 사원명 길이 구하기
SELECT e.ENAME, LENGTH(e.ENAME)
FROM EMP e ;

-- 사원명이 5글자 이상인 사원 조회
SELECT *
FROM EMP e
WHERE LENGTH(e.ename) >= 5;

-- LENGTHB() : 문자열 바이트 수 반환
-- XE 버전 : 한글에 3BYTE 사용
-- dual : sys 소유 테이블(임시 연산이나 함수의 결과값 확인 용도로 사용)
SELECT LENGTH('한글'), LENGTHB('한글')
FROM DUAL;

-- 시작위치 지정 시 양수(왼쪽) 1, 음수(오른쪽부터) : 맨 끝부터 -1
SELECT E.JOB, SUBSTR(E.JOB,1,2), SUBSTR(E.JOB,5)
FROM EMP e; 

SELECT
	E.JOB,
	SUBSTR(E.JOB,-LENGTH(E.JOB)),
	SUBSTR(E.JOB,-LENGTH(E.JOB), 2),
	SUBSTR(E.JOB,-3)
FROM
	EMP e;

-- INSTR(대상문자열,위치를 찾으려는문자,시작위치,시작위치에서 찾으려는 문자가 몇 번째인지)
SELECT
	INSTR('HELLO, ORACLE!', 'L') AS INSTR_1,
	INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,
	INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3
FROM
	DUAL;

-- 사원 이름에 S 가 있는 사원 조회
SELECT *
FROM EMP e WHERE e.ENAME LIKE '%S%';

SELECT *
FROM EMP e WHERE INSTR(e.ename, 'S') > 0;

-- REPLACE(원본문자열,찾을문자열,변경문자열)
SELECT
	'010-1234-5678' AS REPLACE_BEFORE,
	REPLACE('010-1234-5678', '-', ' ') AS REPLACE1,
	REPLACE('010-1234-5678', '-') AS REPLACE2
FROM
	DUAL;

-- 사번 : 사원명 
SELECT CONCAT(e.EMPNO, CONCAT(' : ',e.ENAME))
FROM EMP e; 

SELECT e.EMPNO || ' : ' || e.ENAME
FROM EMP e;


-- TRIM(삭제옵션(선택), 삭제할문자(선택) FROM 원본문자열(필수))
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS trim_leading,
	'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS trim_trailing,
	'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS trim_both
FROM
	DUAL;

-- LTRIM(), RTRIM()
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || LTRIM(' __Oracle__ ') || ']' AS Ltrim,
	'[' || RTRIM(' __Oracle__ ') || ']' AS Rtrim,
	'[' || RTRIM('<_Oracle_>','>_') || ']' AS RTRIM2
FROM
	DUAL;

-- 숫자함수
-- 반올림 : ROUND()
-- 버림 : TRUNC()
-- 가장 큰 정수 : CEIL()
-- 가장 작은 정수 : FLOOR()
-- 나머지 : MOD()

--    -2 -1 0 1 2
-- 1 2 3 4  . 5 6 7 8

SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND1,
	ROUND(1234.5678, 1) AS ROUND2,
	ROUND(1234.5678, 2) AS ROUND3,
	ROUND(1234.5678, -1) AS ROUND4,
	ROUND(1234.5678, -2) AS ROUND5
FROM
	DUAL;


SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC1,
	TRUNC(1234.5678, 1) AS TRUNC2,
	TRUNC(1234.5678, 2) AS TRUNC3,
	TRUNC(1234.5678, -1) AS TRUNC4,
	TRUNC(1234.5678, -2) AS TRUNC5
FROM
	DUAL;


SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;


SELECT MOD(15,6), MOD(10,2), MOD(11,2)
FROM DUAL;

-- 날짜함수
-- 오늘날짜/시간 : SYSDATE
-- 몇개월 이후 날짜 구하기 : ADD_MONTHS()
-- 두 날짜 간의 개월 수 차이 구하기 : MONTHS_BETWEEN()
-- 돌아오는 요일, 달의 마지막 날짜 구하기 : NEXT_DAY() / LAST_DAY()


SELECT
	SYSDATE AS NOW,
	SYSDATE-1 YESTERDAY,
	SYSDATE+1 AS TOMORROW,
	CURRENT_DATE AS CURRENT_DATE,
	CURRENT_TIMESTAMP AS CURRENT_TIMESTAMP
FROM
	DUAL;

-- 오늘날짜를 기준으로 3개월 이후 날짜 구하기
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- 입사한지 40년 넘은 사원 조회
SELECT *
FROM EMP e 
WHERE ADD_MONTHS(E.HIREDATE, 480) < SYSDATE;

-- 오늘날짜와 입사일자의 차이 구하기
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	sysdate,
	MONTHS_BETWEEN(e.HIREDATE, sysdate) AS month1,
		MONTHS_BETWEEN(sysdate, e.HIREDATE) AS month2,
			TRUNC(MONTHS_BETWEEN(e.HIREDATE, sysdate)) AS month3
FROM
	EMP e;


SELECT sysdate, NEXT_DAY(sysdate, '월요일'), LAST_DAY(sysdate)
FROM dual;

-- 자료형을 변환하는 형변환 함수
-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자열 데이터로 반환
-- TO_NUMBER() : 문자열 데이터를 숫자 데이터로 반환
-- TO_DATE() : 문자열 데이터를 날짜 데이터로 반환


-- number + '문자숫자' : 덧셈 가능(자동형변환)
SELECT e.EMPNO, e.ename, e.empno + '500'
FROM EMP e 
WHERE E.ENAME = 'SMITH';

--SELECT e.EMPNO, e.ename, e.empno + 'abcd'
--FROM EMP e 
--WHERE E.ENAME = 'SMITH';

SELECT sysdate, to_char(sysdate, 'YYYY/MM/DD')
FROM dual;


SELECT
	sysdate,
	to_char(sysdate, 'MM'),
	to_char(sysdate, 'MON'),
	to_char(sysdate, 'MONTH'),
	to_char(sysdate, 'DD'),
	to_char(sysdate, 'DY'),
	to_char(sysdate, 'DAY'),
	to_char(sysdate, 'HH24:MI:SS'),
	to_char(sysdate, 'HH12:MI:SS AM'),
	to_char(sysdate, 'HH:MI:SS PM')
FROM
	dual;

-- 9 : 숫자 한자리를 의미
-- 0 : 숫자 한자리를 의미(빈자리를 0으로 채움)
SELECT e.SAL, TO_CHAR(e.sal, '$999,999'), TO_CHAR(e.sal, '$000,999,999')
FROM EMP e; 


-- 문자열 데이터와 숫자 데이터 연산
SELECT 1300-'1500', 1300 + '1500'
FROM dual;

SELECT '1300'-'1500'
FROM dual;

-- ORA-01722: 수치가 부적합합니다
SELECT '1,300'-'1,500'
FROM dual;


-- TO_NUMBER('문자열데이터','인식할숫자형태')
SELECT TO_NUMBER('1,300','999,999') - TO_NUMBER('1,500','999,999')
FROM dual;

-- TO_DATE() : 문자열데이터 => 날짜형식으로 변경
SELECT
	TO_DATE('2025-03-20', 'YYYY-MM-DD') AS DATE1,
	TO_DATE('2025-03-20', 'YYYY/MM/DD') AS DATE2
FROM
	DUAL;


-- NULL
-- 산술연산이나 비교연산자(IS NULL OR IS NOT NULL)가 제대로 수행되지 않음
-- 1) NVL(널여부를 검사할 데이터,널일때 반환할데이터)
-- 2) NVL2(널여부를 검사할 데이터,널이아닐때 반환할 데이터,널일때 반환할데이터)

SELECT e.EMPNO, e.ENAME, e.sal, e.comm, e.sal+e.comm,  NVL(e.comm, 0), e.sal + nvl(e.comm,0)
FROM EMP e;


SELECT
	e.EMPNO,
	e.ENAME,
	e.sal,
	e.comm,
	e.sal + e.comm,
	NVL2(e.comm, 'O', 'X'),
	NVL2(e.comm, e.sal * 12 + e.COMM, e.SAL*12) AS 연봉
FROM
	EMP e;

-- 자바의 if, switch 구문과 유사
-- DECODE
-- DECODE(검사대상이 될 데이터, 
--        조건1, 조건1 만족시 반환할 결과,
--        조건2, 조건2 만족시 반환할 결과,
--        조건1~조건n 일치하지 않을때 반환할 결과
-- )
-- CASE
-- CASE 검사대상이 될 데이터 
--     WHEN  조건1 THEN 조건1 만족시 반환할 결과
--     WHEN  조건2 THEN 조건2 만족시 반환할 결과
--     ELSE  조건1~조건n 일치하지 않을때 반환할 결과
-- END

-- 직책이 MANAGER 인 사원은 급여의 10% 인상
-- 직책이 SALESMAN 인 사원은 급여의 5% 인상
-- 직책이 ANALYST 인 사원은 동결
-- 나머지는 3% 인상

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	DECODE(e.job, 'MANAGER', e.SAL * 1.1,
	'SALESMAN', e.SAL * 1.05,
	'ANALYST', e.SAL,
	e.SAL * 1.03
	) AS upsal
FROM
	EMP e;


SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		e.job
	 WHEN 'MANAGER' THEN e.SAL * 1.1
		WHEN 'SALESMAN' THEN e.SAL * 1.05
		WHEN 'ANALYST' THEN e.SAL
		ELSE e.SAL * 1.03
	END AS upsal
FROM
	EMP e;









