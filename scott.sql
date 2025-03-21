-- RDBMS
-- 기본단위 : 테이블

-- EMP(사원 정보 테이블)
----------------------
-- empno(사원 번호)
-- ename(사원 명)
-- job(직책)
-- mgr(직속상관 사원번호)
-- hiredate(입사일)
-- sal(급여)
-- comm(추가수당)
-- deptno(부서번호)
-----------------------


-- DEPT(부서 테이블)
-------------------
-- deptno(부서번호)
-- dname(부서명)
-- loc(부서위치)
-------------------

-- SALGRADE(급여 테이블)
-------------------
-- grade(급여등급)
-- losal(최저급여)
-- hisal(최대급여)
-------------------
-- RDB 타입
-- NUMBER(4, 0) : 전체 자리수 4자리(소수점 자리수 0)
-- VARCHAR2(10) : 문자열 10byte / "VAR" : 가변 - 7byte 문자열 저장했다면 7byte 공간만 사용
--				  10byte-> 영어 10문자, 한글 2byte, utf-8 3byte 할당
-- DATE : 날짜
---------------------------

-- 개발자 : (CRUD CREATE READ UPDATE DELECT)
-- CRUD -> SQL(Structured Query Language : 구조질의언어) RDBMS 데이터를 다루는 언어
-- GUI : DBeaver / CUI : SQL PLUS
-- sql은 한문장씩??????

-- sql 실행 순서
-- select : 5
-- from : 1
--where : 2
-- group by : 3
-- having : 4
-- order by :6

-- 1. 조회(SELECT) - READ
-- 사원정보 조회
SELECT * FROM EMP e ; -- 전체 조회

-- 별칭사용 deptno(부서번호) 조회
SELECT e.DEPTNO FROM EMP e; -- e : 별칭, 있는게 편함
SELECT deptno FROM emp;

SELECT e.EMPNO, e.DEPTNO FROM emp e; -- 사원번호, 부서번호 조회

-- 중복 데이터 제외하고 조회 (DISTINCT)
SELECT DISTINCT deptno FROM emp;
SELECT DISTINCT job, deptno FROM emp; -- job, deptno 둘 다 중복되는것만 제외

-- 연산 후 조회(+ 별칭 짓시)
SELECT ename, sal, (sal*12 + comm) AS annsal, comm FROM EMP ; -- AS 생략가능
SELECT ename "사 원 명", sal "급 여", (sal*12 + comm) "aNnSaL", comm FROM EMP ; -- "" 강조가능 (쌍따옴표사용시 무조건 대문자 X, 공백 포함 가능)

-- 원하는 순서대로 출력 데이터를 정렬
SELECT e.*  FROM EMP e ORDER BY e.sal ASC; -- emp 테이블의 모든 열을 급여 기준(ORDER BY)으로 오름차순(ASC) 조회
SELECT e.*  FROM EMP e ORDER BY e.sal ASC; -- 오름차순 ASC는 생략 가능
SELECT e.*  FROM EMP e ORDER BY e.sal DESC; -- emp 테이블의 모든 열을 급여 기준(ORDER BY)으로 내림차순(DESC) 조회

-- 사번, 이름, 직무만 급여 기준으로 내림차순 조회
SELECT e.EMPNO, e.ENAME, e.JOB FROM EMP e ORDER BY e.sal DESC;

-- 정렬 기준 복수 지정 (부서번호의 오름차순 정렬 후 급여의 내림차순 정렬)
SELECT e.* FROM EMP e ORDER BY e.deptno ASC, e.sal DESC; -- 정렬 순서에 영향을 끼침

-- 실습 각 열의 별칭을 바꿔서 조회, 부서번호를 내림차순으로 정렬 후 이름을 오름차순으로 
SELECT // ctrl+f 로 정리가능
	e.EMPNO "EMPLOYEE_NO",
	e.ENAME "EMPLOYEE_NAME",
	e.MGR "MANAGER",
	e.SAL "SALARY",
	e.COMM "COMMISSION",
	e.DEPTNO "DEPARTMENT_NO"
FROM
	EMP e
ORDER BY
	e.DEPTNO DESC,
	e.ENAME ASC;

-- 필요한 데이터만 출력 (WHERE : 조회 시 조건 부여)
-- 부서번호가 30번인 사원들을 조회
SELECT
	e.ENAME,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 30;

-- 사번이 7782인 사원 조회
SELECT
	*
FROM
	emp e
WHERE
	e.empno = 7782;

-- 부서번호가 30, 직책이 salesman 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 30 AND e.JOB = 'SALESMAN'; -- 오라클에서 문자는 ''만 가능 / 문자는 대소문자 구분함
	
-- 사원번호 7499 이고 부서번호가 30인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7499
	AND e.DEPTNO = 30;

-- 사원번호 7499 이거나 부서번호가 30인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.EMPNO = 7499
	OR e.DEPTNO = 30;

-- WHERE 에서도 쓸 수 있는 산술 연산자
-- 1. 산술연산자 +, -, *, /
-- 2. 비교연산자 >, <, >=, <=
-- 3. 등가비교연산자 =, 같지않다 (!= or <> or ^=)
-- 4. 논리부정연산자 NOT
-- 5. 			 IN
-- 6. 범위 연산자 BETWEEN A AND B
-- 7. 검색 LIKE 연산자와 와일드카드(_, %)
-- 8. IS NULL NULL과 같다
-- 9. 집합연산자 UNION, MINUS, INTERSECT
-- 연봉이 36000인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL * 12 = 36000;

-- 급여가 3000 이상인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.sal > 3000;

-- 급여가 2500 이상, 직원이 ANALYST인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.sal >= 2500 AND e.job = 'ANALYST';

-- 문자 대소비교

-- 급여가 3000이 아닌 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.sal ^= 3000; -- ^= != <>, NOT e.sal = 3000
	
-- 사원이름의 시작이 F보다 뒤에 있는 사원만 조회


SELECT
	*
FROM
	EMP e
WHERE
	e.ENAME >= 'F'
ORDER BY
	e.ENAME ASC;

-- JOB이 MANAGER 이거나, SALESMAN이거나, CLERK 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB = 'MANAGER'
	OR e.JOB = 'SALESMAN'
	OR e.JOB = 'CLERK';

-- -- JOB이 MANAGER 이거나, SALESMAN이거나, CLERK 사원 조회 (IN 사용)
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- JOB이 (MANAGER, SALESMAN, CLERK)가 아닌 사원 조회 (IN 사용)
SELECT
	*
FROM
	EMP e
WHERE
	e.JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- BETWEEN A AND B : A와 B 사이
-- 급여가 2000~3000 사이인 사원을 조회
SELECT * FROM EMP e WHERE e.SAL BETWEEN 2000 AND 3000;

-- 급여가 2000~3000 사이가 아닌 사원 조회
SELECT * FROM EMP e WHERE e.SAL NOT BETWEEN  2000 AND 3000;

-- 검색(LIKE) 연산자와 와일드카드(_, %)
-- _ : 어떤 값이든 상관없이 한 개의 문자열 데이터를 의미
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자열 데이터를 의미

-- 사원명이 S로 시작하는 사원을 조회
SELECT * FROM EMP e WHERE e.ename LIKE 'S%' ;

-- 사원 이름의 두번째 글자가 L인 사원 조회
SELECT * FROM EMP e WHERE e.ename LIKE '_L%' ;

-- 사원명에 AM이 포함된 사원 조회
SELECT * FROM EMP e WHERE e.ename LIKE '%AM%' ;
-- 사원명에 AM이 포함되지 않은 사원 조회

-- NULL 확인
SELECT * FROM EMP e WHERE e.ename NOT LIKE '%AM%' ;

-- MANAGER_ID가 NULL 인 사원 조회
SELECT * FROM EMP e WHERE e.MGR IS NULL;

-- MANAGER_ID가 NULL이 아닌 사원 조회
SELECT * FROM EMP e WHERE e.MGR IS NOT NULL;

-- 부서번호 10, 20 사원을 조회
SELECT * FROM EMP e WHERE e.deptno IN (10, 20);
SELECT * FROM EMP e WHERE e.deptno = 10 OR e.DEPTNO = 20;

-- 집합연산자 (UNION : 합집합) 
-- UNION(A와 C 그리고 A,C의 집합인 B를 출력 = A, B, C 출력)
-- UNION(A와 C를 출력, A와C의 집합은 B) = A, B, B, C 출력) 
-- 타입 일치 만 확인 => 타입이 맞는다면 연결

SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.deptno = 10
UNION
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.deptno = 20;

SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.deptno = 10
UNION ALL
SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO FROM EMP e WHERE e.deptno = 10;

SELECT e.ENAME, e.EMPNO, e.SAL FROM EMP e WHERE e.deptno = 10
UNION
SELECT e.ENAME, e.SAL, e.EMPNO FROM EMP e WHERE e.deptno = 20;

SELECT e.EMPNO, e.ENAME, e.SAL FROM EMP e WHERE e.deptno = 10
UNION
SELECT e.EMPNO, e.ENAME, e.SAL FROM EMP e WHERE e.deptno = 10;

SELECT e.EMPNO, e.ENAME, e.SAL FROM EMP e WHERE e.deptno = 10
UNION ALL
SELECT e.EMPNO, e.ENAME, e.SAL FROM EMP e WHERE e.deptno = 10;

-- MINUS(차집합)
SELECT e.EMPNO, e.ENAME, e.SAL, e.deptno FROM EMP e
MINUS
SELECT e.EMPNO, e.ENAME, e.SAL, e.deptno FROM EMP e WHERE e.deptno = 10;
-- INTERSECT(교집합)
SELECT e.EMPNO, e.ENAME, e.SAL, e.deptno FROM EMP e
INTERSECT 
SELECT e.EMPNO, e.ENAME, e.SAL, e.deptno FROM EMP e WHERE e.deptno = 10;

-- 오라클 함수
--  내장함수
--   문자함수
-- 문자의 길이를 구하는 함수 : LENGTH()
-- 대소문자를 바꿔주는 함수 :upper(), lower(), initcap()
-- 사원이름을 대문자, 소문자, 첫문자만 대문자로변경
SELECT
	e.ENAME,
	upper(e.ename),
	lower(e.ename),
	initcap(e.ENAME)
FROM
	EMP e;
-- 제목 oracle 검색
SELECT *
FROM board
WHERE upper(title) = upper('oracle');

SELECT e.ENAME, LENGTH(e.ename) FROM EMP e ;

-- 사원명이 5글자 이상인 사원 조회
SELECT * FROM EMP e WHERE LENGTH(e.ename) >= 5;

-- sql 구문 실행 순서 from - where - select - order by
SELECT * FROM EMP e WHERE LENGTHB(e.ename) >= 5;

-- lengthb() : 문자열 바이트 수 반환
-- XE 버전 : 한글에 3byte 적용
-- dual이란 : sys 소유 테이블(임시 연산이나 함수의 결과값 확인 용도로 사용)
-- 문자열 일부 추출 : substr(문자열데이터, 시작위치, 추출길이)


SELECT length('한글'), LENGTHB('한글')
FROM dual;


SELECT e.JOB, SubStr(e.job, 1, 2), substr(E.JOB, 5) FROM EMP e;
-- 시작위치 지정  시 양수(왼쪽), 음수(오른쪽부터) : 맨 끝부터 -1
SELECT
	e.JOB
    , SubStr(e.job, -length(e.job))
	, SubStr(e.job, -length(e.job), 2)
	, SubStr(e.job, -3)
FROM 
	EMP e;

-- 문자열 데이터 내에서 특정 문자 위치 찾기 : INSTR(대상 문자열, 위치를 찾으려는 문자, 시작위치에서 찾으려는 문자가 몇 번째인지)
SELECT 
INSTR('HELLO ORACLE!', 'L') AS INSTR_1, -- 1번부터 탐색 시작
INSTR('HELLO ORACLE!', 'L', 5) AS INSTR_2, -- 5번부터 탐색 시작
INSTR('HELLO ORACLE!', 'L', 2, 2) AS INSTR_3 -- 2번부터 탐색 시작, 2번째로 찾는 걸 리턴
FROM DUAL;

SELECT e.ENAME, INSTR(lower(e.ENAME), 'a') AS "a_name"
FROM EMP e;

-- 사원 이름에 S가 있는 사원 조회
SELECT *
FROM EMP e 
WHERE e.ENAME LIKE '%S%';

-- INSTR 사용
SELECT *
FROM EMP e 
WHERE INSTR(e.ENAME, 'S') > 0;


-- REPLACE(원본문자열, 찾을문자열, 변경문자열) - 특정문자를 다른 문자로 변경
-- 날짜양식을 00-00-00에서 00/00/00로 기호를 변경하여 조회
SELECT e.HIREDATE , REPLACE(E.HIREDATE , '-', '/') 
FROM EMP e

-- 전화번호에서 '-'를 찾아 공백으로 변경
SELECT
'010-1234-5678' AS REPLACE_BEFORE,
REPLACE('010-1234-5678', '-', ' ') AS REPLACE1, -- 변경
REPLACE('010-1234-5678', '-') AS REPLACE2 -- 제거
FROM DUAL;

-- 두 문자열을 합치기 
-- 1. CONCAT(문자열1, 문자열2) - 2개씩밖에 못 합침
-- 2. 문자열1||문자열2||문자열a|| - 2개 이상의 문자열도 합칠 수 있음
-- 사번 : 사원명 조회
SELECT
CONCAT(e.EMPNO, CONCAT(' : ', e.ENAME))
FROM EMP e ;

SELECT
e.EMPNO || ' : ' || e.ENAME
FROM EMP e ;

-- 특정 문자 제거 
	-- 	1.TRIM(삭제옵션(선택), 삭제할 문자(선택)) FROM 원본문자열(필수) : 
	-- 	2.LTRIM(): 
	-- 	3.RTRIM(): 
-- TRIM의 옵션
	-- LEADING : 왼쪽 = LTRIM
	-- TRAILING : 오른쪽 = RTRIM
	-- BOTH : 둘다

-- TRIM()
SELECT
'[' || TRIM(' __Oracle__ ') || ']'  AS trim,
'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']'  AS trim_Leading,
'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS trim_trailing,
'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS trim_both
FROM 
	DUAL;

SELECT
'[' || TRIM ('    __Oracle__    ') || ']'  AS TRIM,
'[' || LTRIM('     __Oracle__   ') || ']'  AS LTRIM,
'[' || RTRIM('     __Oracle__   ') || ']' AS RTRIM,
'[' || RTRIM('<__Oracle__>', '>_') || ']' AS TRIM_BOTH2
FROM 
	DUAL;

-- 숫자함수
-- 반올림 : ROUND()
-- 버림 : TRUNC()
-- 가장 큰 정수 : CEIL()
-- 가장 작은 정수 : FLOOR()
-- 나머지 : MOD()

-- ROUND 반올림
SELECT -- 소수에서 '.'기준 음수는 왼쪽, 양수는 오른쪽
ROUND(1234.5678) AS ROUND,
ROUND(1234.5678, 0) AS ROUND0,
ROUND(1234.5678, 1) AS ROUND1,
ROUND(1234.5678, 2) AS ROUND2,
ROUND(1234.5678, -1) AS "ROUND-1",
ROUND(1234.5678, -2) AS "ROUND-2"
FROM DUAL;

-- TRUNC 버림
SELECT
TRUNC(1234.5678) AS TRUNC1,
TRUNC(1234.5678, 0) AS TRUNC2,
TRUNC(1234.5678, 1) AS TRUNC3,
TRUNC(1234.5678, 2) AS TRUNC4,
TRUNC(1234.5678, -1) AS "TRUNC5",
TRUNC(1234.5678, -2) AS "TRUNC6"
FROM DUAL;

SELECT -- CEIL() 가장 큰 정수, FLOOR() 가장 작은 정수 , 올림과 내림하는 듯
CEIL(7.609), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

-- MOD() 나머지
SELECT 
MOD(15,6), 
MOD(10,2), 
MOD(11,2)
FROM DUAL;

-- 날짜함수
-- SYSDATE: 오늘 날짜/시간 조회 : 
-- ADD_MONTHS() : 몇개월 이후 날짜 구하기
-- MONTHS_BETWEEN() : 두 날짜 간의 개월 수 차이 구하기
-- NEXT_DAY() : 돌아오는 요일 구하기
-- LAST_DAY() : 달의 마지막 날짜 구하기
SELECT SYSDATE, SYSDATE - 1 YESTERDAY , SYSDATE - 2 YESTERYESTERDAY, SYSDATE - 3 YESTERYESTERYESTERDAY,
SYSDATE + 1 TOMARROW, SYSDATE + 2 TOMORRROW, SYSDATE +3 TOMORRRROW
FROM DUAL;

SELECT SYSDATE, CURRENT_DATE AS CURRENT_DATE, CURRENT_TIMESTAMP AS CURRENT_TIMESTAMP
FROM DUAL;

-- 오늘 날짜를 기준으로 3개월 이후의 날짜
SELECT ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- 입사한지 40년 넘은 사원 조회
SELECT *
FROM EMP e
WHERE SYSDATE > ADD_MONTHS(E.HIREDATE, 480);

-- 날짜 차이 MONTHS_BETWEEN()
-- 오늘날짜와 입사일자의 차이 구하기
SELECT
e.DEPTNO,
e.ENAME,
e.HIREDATE,
SYSDATE,
MONTHS_BETWEEN(SYSDATE, e.HIREDATE ) AS MONTH1,
MONTHS_BETWEEN(e.HIREDATE, SYSDATE ) AS MONTH2,
TRUNC(MONTHS_BETWEEN(SYSDATE, e.HIREDATE)) AS MONTH3
FROM EMP e ; 

-- NEXTDAY
SELECT sysdate, NEXT_DAY(SYSDATE, '월'), LAST_DAY(SYSDATE)
FROM DUAL;

-- 자료형을 변환하는 형변환 함수 
	-- TO_CHAR() : 문자열로 반환
	-- TO_NUMBER() : 숫자로 반환
	-- TO_DATE() : 날짜로 반환

SELECT 
E.EMPNO, E.ENAME, E.EMPNO + '500' -- number 타입 + '숫자' = 숫자 자동형변환
FROM EMP e
WHERE E.ENAME = 'SMITH';
 

SELECT SYSDATE, 
TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
TO_CHAR(SYSDATE, 'MON'),
TO_CHAR(SYSDATE, 'MONTH'),
TO_CHAR(SYSDATE, 'DD'),
TO_CHAR(SYSDATE, 'DY'),
TO_CHAR(SYSDATE, 'DAY'),
TO_CHAR(SYSDATE, 'DD-MM-DY')
FROM DUAL;

SELECT SYSDATE,
TO_CHAR(SYSDATE, 'HH24:MI:SS'),
TO_CHAR(SYSDATE, 'HH12:MI:SS AM'),
TO_CHAR(SYSDATE, 'HH:MI:SS PM'),
TO_CHAR(SYSDATE, 'HH:MI:SS')
FROM DUAL;

-- 돈 양식으로 변경 
-- 9 : 숫자 한 자리
-- 0 : 숫자 한자리, 빈자리는 0으로 채움
SELECT e.SAL, TO_CHAR(e.SAL, '$999,999')
FROM EMP e;

-- TO_NUMBER()
-- 문자열 데이터와 숫자 데이터 연산
SELECT 1300-'1500', 1300 + '1500'
FROM DUAL;
-- 문자열(숫자) 끼리의 연산
SELECT '1300' - '1500'
FROM DUAL;

-- TO_NUMBER('문자열 데이터', '인식할 숫자 형태')
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM DUAL;

SELECT 
TO_DATE('1988-02-25', 'YY-MM-DD') AS DATE1,
TO_DATE('1988-02-25', 'YY/MM/DD') AS DATE2,
TO_DATE('1988-02-25', 'YY/MM-DD') AS DATE3
FROM DUAL;

--NULL
-- NULL 포함시, 산술연산이나 비교연산자(IS NULL, IS NOT NULL)가 제대로 수행되지 않음

--1. NVL(널 여부를 검사할 데이터, 널일때 반환할 데이터)
--2. NVL2(널 여부를 검사할 데이터, 널이 아닐때 반환할 데이터 ,널일때 반환할 데이터)
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.COMM,
	e.SAL + e.COMM,
	NVL(e.COMM, 0),
	e.SAL + NVL(e.COMM, 0)
FROM
	EMP e; 

SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.COMM,
	e.SAL + e.COMM,
	NVL2(e.COMM, 'O', 'N/A'),
	NVL2(e.COMM, e.SAL * 12 + e.COMM,e.SAL*12) AS 연봉
FROM
	EMP e; 

-- 자바의 if, switch 구문과 유사
-- DECODE ( 조건식은 무조건 = 비교)
-- DECODE(검사대상이 될 데이터,
-- 조건1, 조건1 만족시 반환할 거, 
-- 조건2, 조건2 만족시 반환할 거,
-- 조건a, 조건a 만족시 반환할 거
-- 조건1~조건a 만족하지 않을 때 반환할 결과
-- )

-- CASE
-- DECODE검사대상이 될 데이터
-- WHEN 조건1 THEN 조건1 만족시 반환할 거 
-- WHEN 조건2 THEN 조건2 만족시 반환할 거
-- WHEN 조건a THEN 조건a 만족시 반환할 거
-- ELSE 조건1~조건a 만족하지 않을 때 반환할 결과
-- END

-- 직책이 MANAAGER 인 사원은 급여의 10% 인상
-- 직책이 SALESMAN 인 사원은 급여의 5% 인상
-- 직책이 ANALYST 인 사원은 급여의 동결
-- 나머지 직책의 사우너은 급여 3%인상

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	DECODE(
e.JOB, 
'MANAGER', e.SAL * 1.1,
'SALESMAN', e.SAL * 1.05,
'ANALYST', e.SAL,
e.SAL * 1.03
) AS UPSAL
FROM
	EMP e;
 

-- case
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		e.JOB
		WHEN 'MANAGER'
		THEN e.SAL * 1.1
		WHEN 'SALESMAN'
		THEN e.SAL * 1.05
		WHEN 'ANALYST'
		THEN e.SAL
		ELSE e.SAL * 1.03
	END AS UPSAL
FROM
	EMP e;

-- COMM NULL인 경우 '해당사항없음'
-- COMM 0인 경우 '수당없음'
-- COMM > 0 인 경우 '수당 : 800'

-- 조건식을 그때 그때 붙혀도 됨
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		WHEN e.COMM IS NULL
		THEN '해당사항 없음'
		WHEN e.COMM = 0
		THEN '수당 없음'
		WHEN e.COMM > 0
		THEN '수당 : ' || e.COMM
	END AS COMM_TEXT
FROM
	EMP e;

-- [실습]
-- 1. empno : 9999 형태 => 9** 변환
--    ename : SMITH 형태 => S****(길이만큼)
-- 출력 : 원본 EMPNO, AFTER EMPNO, 원본 ENAME, AFTER ENAME
SELECT
	e.EMPNO,
	REPLACE(e.EMPNO , SUBSTR(e.EMPNO, 3) , '**') AS "AFTER EMPNO",
	e.ENAME,
	REPLACE(e.ENAME, SUBSTR(e.ENAME, 2), '****') AS "AFTER ENAME"
FROM
	EMP e;

-- 데이터의 공간을 특정 문자로 채우기 : LPAD(), RPAD()
-- (데이터, 데이터 자리수, 채울문자)

-- ORACLE -> 10 자리로 표현
SELECT
	'Oracle',
	LPAD('Oracle', 10, '#'),
	RPAD('Oracle', 10, '*'),
	LPAD('Oracle', 10),
	RPAD('Oracle', 10)
FROM DUAL;

SELECT
	e.EMPNO,
	RPAD(SUBSTR(e.EMPNO, 0, 2), 4, '*') AS "AFTER EMPNO",
	e.ENAME,
	RPAD(SUBSTR(e.ENAME, 1, 1), LENGTH(SUBSTR(e.ENAME,1)), '*') AS "AFTER ENAME"
FROM
	EMP e;


-- 2. EMP 테이블에서 사원의 월 평균 근무일수는 21일.
-- 하루 근무시간을 8시간으로 보았을때 사원의 하루 급여(DAY_PAY),
-- 시급(TIME_PAY) 를 계산하여 출력 ( 단 하루 급여는 소수 셋째자리에서 버리고,
-- 시급은 둘째자리에서 반올림)
-- 출력형태 empno,ename,sal,day_pay,time_pay
SELECT
e.EMPNO,
e.ENAME,
e.SAL,
TRUNC(e.SAL  / 21, 2) AS day_pay,
ROUND(e.SAL / 21 / 8, 1) AS time_pay
FROM EMP e;


-- 3. 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
--    사원이  정직원이 되는 날짜(R_JOB)을 'YYYY-MM-DD' 형식으로 출력
--    단 추가수당이 없는 사원의 추가수당은 N/A로 출력
--     출력형태 ) EMPNO,ENAME,HIREDAE,R_JOB,COMM

SELECT
e.EMPNO,
e.ENAME,
e.HIREDATE,
TO_CHAR(ADD_MONTHS(e.HIREDATE, 3), 'YYYY-MM-DD') AS r_job,
NVL(TO_CHAR(e.COMM), 'N/A') AS "COMM"
FROM EMP e;




-- 4. 직속상관의 사원번호가 없을 때 : 0000
--    직속상권의 사원번호 앞두자리가 75일 때 : 5555 
--    직속상권의 사원번호 앞두자리가 76일 때 : 6666
--    직속상권의 사원번호 앞두자리가 77일 때 : 7777
--    직속상권의 사원번호 앞두자리가 78일 때 : 8888
--    그 외 직속 상관의 사원번호일때 : 본래 직속상관 사원번호 출력
--    출력형태 EMPNO, ENAME, MGR, (CHG_MGR)
SELECT
e.EMPNO,
e.ENAME,
e.MGR,
CASE 
	WHEN TO_CHAR(e.MGR) IS NULL THEN '0000'
	WHEN SUBSTR(TO_CHAR(e.MGR), 1, 2) = '75' THEN '5555'
	WHEN SUBSTR(TO_CHAR(e.MGR), 1, 2) = '76' THEN '6666'
	WHEN SUBSTR(TO_CHAR(e.MGR), 1, 2) = '77' THEN '7777'
	WHEN SUBSTR(TO_CHAR(e.MGR), 1, 2) = '78' THEN '8888'
	ELSE TO_CHAR(e.MGR) 
END AS "CHG_MGR"
FROM EMP e;

SELECT
e.EMPNO,
e.ENAME,
e.MGR,
CASE 
	WHEN e.MGR IS NULL THEN 0000
	WHEN e.mgr LIKE '75%' THEN 5555
	WHEN e.mgr LIKE '76%' THEN 6666
	WHEN e.mgr LIKE '77%' THEN 7777
	WHEN e.mgr LIKE '78%' THEN 8888
	ELSE e.MGR 
END AS "CHG_MGR"
FROM EMP e;

-- 하나의 열에 출력 결과를 담는 다중행 함수 = null 제외
-- 1. SUM()
-- 2. COUNT()
-- 3. MAX()
-- 4. MIN()
-- 5. AVG()

-- 전체 사원의 급여의 합 구하는
SELECT
SUM(E.SAL)
FROM
	EMP e;

-- 전체 사원의 급여의 합 구하는데 중복된 급여는 제외한 합
SELECT
SUM(E.SAL), sum(DISTINCT E.SAL), sum(ALL e.sal)
FROM
	EMP e;
-- 단일 그룹의 그룹함수가 아닙니다(해결: group by 절에 사용한 컬럼만 가능)
-- select e.ename,sum(e,sal) from emp e;
-- 총사원의 인원수 구하기

SELECT count(e.empno), count(e.ename), count(e.COMM), count(e.HIREDATE), count(DISTINCT(e.JOB)), COUNT(E.JOB)
FROM emp e;

SELECT DISTINCT(e.JOB)
FROM EMP e;

-- 급여의 최대값 최소값
SELECT MAX(e.SAL) max, MIN(e.SAL) min
FROM EMP e;

-- 10번 부서 인원들의 급여 최대값
SELECT MAX(e.SAL)
FROM EMP e
WHERE e.DEPTNO = 10;

-- 20번 부서 인원들의 입사일중 가장 최근과 오래된 입사일
SELECT MAX(TO_CHAR(e.HIREDATE, 'YYYY-MM-DD')) JUNIOR, 
MIN(TO_CHAR(e.HIREDATE, 'YYYY-MM-DD')) SENIOR
FROM EMP e;

-- 부서가 30번인 사원의 평균 급여
SELECT AVG(e.SAL) avgSAL
FROM EMP e
WHERE e.DEPTNO = 30;


-- 결과값을 원하는 열로 묶어 출력 : Group by

-- 부서별 평균 급여 조회
SELECT e.DEPTNO, avg(e.SAL)
FROM EMP e 
GROUP BY  e.DEPTNO;

-- 부서별 직책별 평균 급여 조회
SELECT e.DEPTNO,e.JOB, avg(e.SAL)
FROM EMP e 
GROUP BY  e.DEPTNO,e.JOB
ORDER BY e.DEPTNO;


-- 결과값을 원하는 열로 묶어 출력할때 조건 추가 : gruop by + having
-- 부서별, 직책별 평균 급여 조회 + 평균급여 >= 2000
SELECT e.DEPTNO,e.JOB, avg(e.SAL)
FROM EMP e 
GROUP BY  e.DEPTNO,e.JOB HAVING avg(e.SAL) >= 2000
ORDER BY e.DEPTNO;

-- 같은 직무에 종사하는 사원이 3명 이상인 직책과 인원수를 출력
-- SALESMAN 4
SELECT e.JOB, COUNT(e.EMPNO)
FROM EMP e 
GROUP BY e.JOB HAVING COUNT(e.EMPNO) >=3;

-- 사원들의 입사연도를 기준으로 부서별로 몇명이 입사했는지 출력 
-- 1987 20번 부서에 n명이 들어옴 
SELECT TO_CHAR(e.HIREDATE,'YYYY'), e.DEPTNO, count(e.EMPNO)
FROM EMP e 
GROUP BY TO_CHAR(e.HIREDATE,'YYYY'),e.DEPTNO;

-- 조인(join)
-- 여러종류의 데이터를 다양한 테이블에 나누어 저장하기 때문에 여러 테이블의 데이터를 조합하여
-- 출력할 때가 많다. 이때 사용하는 방식이 조인 
-- 종류
-- 내부조인(연결 안되는 데이터는 제외) - inner join
-- 1) 등가조인 : 각 테이블의 특정 열과 일치하는 데이터를 기준으로 추출
-- 2) 비등가조인 : 등가조인 외의 조인 
-- 3) 자체(self)조인 : 같은 테이블끼리 조인

-- 외부조인 : 연결 안되는 데이터 보기 - outer join 
--1) 왼쪽 외부 조인(left outer join) : 오른쪽 테이블의 존재 여부와 상관 없이 왼쪽 테이블 기준으로 출력
--2) 오른쪽 외부 조인(right outer join) : 왼쪽 테이블의 존재 여부와 상관없이 오른쪽 테이블 기준으로 출력

-- 사원별 부서 정보 조회
SELECT*
FROM EMP e ,DEPT d 
WHERE e.DEPTNO = d.DEPTNO;

SELECT e.EMPNO,e.DEPTNO,d.DNAME,d.LOC
FROM EMP e ,DEPT d 
WHERE e.DEPTNO = d.DEPTNO;

-- 나올 수 있는 모든 조합에 대해 출력
SELECT e.EMPNO,e.DEPTNO,d.DNAME,d.LOC
FROM EMP e ,DEPT d ;

-- 사원 별 부서 정보조회 + 사원별 급여 >=3000
SELECT e.EMPNO, e.DEPTNO,e.SAL,d.DNAME,d.LOC 
FROM EMP e , DEPT d 
WHERE e.DEPTNO  = d.DEPTNO AND e.SAL  >= 3000;

-- 사원별 부서 정보조회 + 사원별 급여 <= 2500+사원번호 9999 이하
SELECT e.EMPNO, e.DEPTNO,e.SAL,d.DNAME,d.LOC 
FROM EMP e , DEPT d 
WHERE e.DEPTNO  = d.DEPTNO AND e.SAL  <=2500 AND e.EMPNO <=9999;

-- 비등가조인
-- 사원별 정도 + salgrade greade
SELECT*
FROM EMP e ,SALGRADE s 
WHERE e.SAL >= s.LOSAL AND e.SAL <= s.HISAL;


SELECT*
FROM EMP e ,SALGRADE s 
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 자체 조인 
-- 사원정보 + 직속상관의정보
SELECT e1.EMPNO,e1.ENAME,e1.MGR,e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2  
WHERE e1.MGR = e2.EMPNO;

--left outer join : 오른쪽 테이블의 존재 여부와 상관 없이 왼쪽 테이블 기준으로 출력
SELECT e1.EMPNO,e1.ENAME,e1.MGR,e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2  
WHERE e1.MGR = e2.EMPNO(+);
-- right outer join : 왼쪽 테이블의 존재 여부와 상관없이 오른쪽 테이블 기준으로 출력
SELECT e1.EMPNO,e1.ENAME,e1.MGR,e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2  
WHERE e1.MGR(+) = e2.EMPNO;

-- 표준 문법을 사용한 조인
-- join ~on
-- join 테이블명 on 조인하는 조건
-- inner join
SELECT e.EMPNO,e.DEPTNO,d.DNAME,d.LOC
FROM EMP e  
JOIN DEPT d  
on e.DEPTNO = d.DEPTNO;

SELECT*
FROM EMP e 
JOIN SALGRADE s  
on e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- outer join
-- left outer join 테이블명 on 조인 조건
SELECT e1.EMPNO,e1.ENAME,e1.MGR,e2.ENAME AS mgr_ename
FROM EMP e1 LEFT OUTER JOIN EMP e2  
on e1.MGR = e2.EMPNO;
-- right outer join 테이블명 on 조인 조건
SELECT e1.EMPNO,e1.ENAME,e1.MGR,e2.ENAME AS mgr_ename
FROM EMP e1 RIGHT OUTER JOIN EMP e2  
on e1.MGR = e2.EMPNO;

--3개 연결
SELECT *
FROM EMP e1 JOIN EMP e2 ON e1.EMPNO = e2.EMPNO JOIN EMP e3 ON e2.EMPNO =e3.EMPNO;

-- 급여가 200을 초과한 사원의 부서정보, 사원정보 출력
-- 부서번호,부서명,사원번호,사원명,급여
SELECT e.DEPTNO,d.DNAME,e.EMPNO,e.ENAME,e.SAL
FROM EMP e JOIN DEPT d ON e.DEPTNO =d.DEPTNO
WHERE e.SAL > 2000
ORDER BY e.DEPTNO;



--모든 부서 정보와 사원정보를 부서번호, 사원번호 순서로 정렬하여 출력 
-- 부서번호,부서명,사원번호,사원명,직무,급여
SELECT e.DEPTNO,d.DNAME,e.EMPNO,e.ENAME,e.job,e.SAL
FROM EMP e JOIN DEPT d ON e.DEPTNO =d.DEPTNO
ORDER BY e.DEPTNO,e.EMPNO;

-- 모든 부서 정보 , 사원정보, 급여등급 정보, 각 사원의 직속 상관정보를 
-- 부서번호, 사원번호 순서로 정렬하여 출력 
-- 부서번호,부서명,사원번호,사원명,매니저번호,급여,losal,hisal,grede,매니저empno,매니저이름
SELECT 
e1.DEPTNO ,
d.DNAME ,
e1.EMPNO, 
e1.ENAME, 
e1.MGR, 
e1.SAL ,
s.LOSAL ,
s.HISAL ,
s.GRADE ,
e2.EMPNO  
AS mgr_ename, e2.ENAME  
AS mgr_ename
FROM EMP e1 
LEFT OUTER JOIN EMP e2  
on e1.MGR = e2.EMPNO 
JOIN DEPT d  
ON e1.DEPTNO =d.DEPTNO 
JOIN SALGRADE s 
ON e1.sal 
BETWEEN s.LOSAL AND s.HISAL
ORDER BY e1.DEPTNO,e1.EMPNO;

-- 부서별 평균 급여, 최대 급여, 최소급여, 사원수 출력 
SELECT e.DEPTNO , d.DNAME , avg(e.sal) AS avg_sal, max(e.sal) AS max_sal, min(e.sal) AS min_sal , count(e.empno) AS cnt
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
GROUP BY e.DEPTNO,d.DNAME;


