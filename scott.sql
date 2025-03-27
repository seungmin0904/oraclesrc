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

-- 개발자 : (CRUD CREATE(insert) READ(read) UPDATE DELECT)
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

-- COMM NULL 인 경우 '해당사항없음'
-- COMM 0 인 경우 '수당없음'
-- COMM > 0 인 경우 '수당 : 800'

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		WHEN e.COMM IS NULL THEN '해당사항없음'
		WHEN e.COMM = 0 THEN '수당없음'
		WHEN e.COMM > 0 THEN '수당 : ' || e.COMM
	END AS comm_text
FROM
	EMP e;

-- [실습]
-- 1. empno 7369 => 73**, ename SMITH => S****
-- empno, 마스킹처리empno, ename, 마스킹처리ename

SELECT replace('7369',SUBSTR('7369',3),'**')
FROM dual;


SELECT
	e.empno,
	REPLACE(e.empno, SUBSTR(e.empno, 3), '**') AS masking_empno,
	e.ENAME,
	REPLACE(e.ENAME, SUBSTR(e.ENAME, 2), '****') AS masking_ename
FROM
	EMP e; 

-- RPAD(열이름,자릿수,채울문자)
SELECT
	e.empno,
	RPAD(SUBSTR(e.empno, 1,2), 4, '*') AS masking_empno,
	e.ENAME,
	RPAD(SUBSTR(e.ENAME, 1,1), 5, '*') AS masking_ename
FROM
	EMP e;


-- 2. emp 테이블에서 사원의 월 평균 근무일수는 21일이다.
-- 하루 근무시간을 8시간으로 보았을 때 사원의 하루급여(day_pay)와 시급(time_pay)를
-- 계산하여 출력한다.(단, 하루급여는 소수 셋째자리에서 버리고, 시급은 둘째자리에서 반올림)
-- 출력형태) EMPNO, ENAME, SAL, DAY_PAY, TIME_PAY

SELECT
	E.EMPNO,
	E.ENAME,
	E.SAL,
	TRUNC(E.SAL / 21, 2) AS day_pay,
	ROUND(E.SAL / 21 / 8, 1) AS time_pay
FROM
	EMP e;


-- 3. 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원이 정직원이 되는 날짜(R_JOB)을 YYYY-MM-DD 형식으로 출력한다.
-- 단, 추가수당이 없는 사원의 추가수당은 N/A 로 출력
-- 출력형태 ) EMPNO, ENAME, HIREDATE, R_JOB, COMM 
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	NEXT_DAY(ADD_MONTHS(e.HIREDATE, 3), '월요일') AS r_job,
	NVL(to_char(e.COMM), 'N/A')
FROM
	EMP e; 


-- 4. 직속상관의 사원번호가 없을 때 : 0000
-- 직속상관의 사원번호 앞 두자리가 75 일때 : 5555
-- 직속상관의 사원번호 앞 두자리가 76 일때 : 6666
-- 직속상관의 사원번호 앞 두자리가 77 일때 : 7777
-- 직속상관의 사원번호 앞 두자리가 78 일때 : 8888
-- 그 외 직속상관 사원 번호일때 : 본래 직속상관 사원번호 그대로 출력
-- 출력형태) EMPNO, ENAME, MGR, CHG_MGR

SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR ,
	CASE 
		WHEN e.mgr IS NULL THEN '0000'
		WHEN SUBSTR(TO_CHAR(e.mgr), 1, 2) = '75' THEN '5555'
		WHEN SUBSTR(TO_CHAR(e.mgr), 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(TO_CHAR(e.mgr), 1, 2) = '77' THEN '7777'
		WHEN SUBSTR(TO_CHAR(e.mgr), 1, 2) = '78' THEN '8888'
		ELSE TO_CHAR(e.mgr)
	END	AS chg_mgr
FROM
	EMP e; 


SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR ,
	CASE 
		WHEN e.mgr IS NULL THEN '0000'
		WHEN e.mgr LIKE '75%' THEN '5555'
		WHEN e.mgr LIKE '76%' THEN '6666'
		WHEN e.mgr LIKE '77%' THEN '7777'
		WHEN e.mgr LIKE '78%' THEN '8888'
		ELSE TO_CHAR(e.mgr)
	END	AS chg_mgr
FROM
	EMP e; 


SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR ,
	DECODE(SUBSTR(to_char(nvl(e.mgr,0)),1,2), 
		'0', '0000',
		'75', '5555',
		'76', '6666',
		'77', '7777',
		'78', '8888',
		SUBSTR(to_char(e.mgr),1))		
	AS chg_mgr
FROM
	EMP e; 


SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR ,
	DECODE(SUBSTR(to_char(e.mgr),1,2), 
		null, '0000',
		'75', '5555',
		'76', '6666',
		'77', '7777',
		'78', '8888',
		SUBSTR(to_char(e.mgr),1))		
	AS chg_mgr
FROM
	EMP e; 



-- 하나의 열에 출력결과를 담는 다중행 함수
-- null 행은 제외하고 연산
-- 1. sum() / 2. count() / 3. max() / 4. min() / 5. avg()

-- 전체사원 급여 합
SELECT sum(e.sal) FROM EMP e;

-- 중복된 급여는 제외한 합
SELECT sum(e.sal), sum(DISTINCT e.sal), sum(ALL e.sal) FROM EMP e;

-- 단일 그룹의 그룹 함수가 아닙니다(해결 : group by 절에 사용한 컬럼만 가능)
-- SELECT e.ENAME,sum(e.sal) FROM EMP e;

-- 사원 수
SELECT count(e.empno), count(e.COMM), count(ALL e.COMM)
FROM EMP e;

-- 급여의 최대값과 최소값
SELECT max(e.sal), min(e.sal)
FROM EMP e;

-- 10번부서 사원 중 급여 최대값
SELECT max(e.sal), min(e.sal)
FROM EMP e
WHERE e.deptno = 10;

-- 20번 부서의 입사일 중 최근 입사일 출력
SELECT max(e.HIREDATE), min(e.HIREDATE)
FROM EMP e
WHERE e.DEPTNO = 20

-- 부서번호가 30번인 사원의 평균 급여
SELECT avg(e.sal)
FROM emp e
WHERE e.DEPTNO = 30;

-- 결과값을 원하는 열로 묶어 출력 : GROUP BY

-- 부서별 평균 급여 조회
SELECT e.DEPTNO, AVG(e.SAL)
FROM EMP e 
GROUP BY e.DEPTNO;

-- 부서별, 직책별 평균 급여 조회
SELECT e.DEPTNO,e.job, AVG(e.SAL)
FROM EMP e 
GROUP BY e.DEPTNO, e.JOB
ORDER BY e.DEPTNO;

-- 결과값을 원하는 열로 묶어 출력할 때 조건 추가 : GROUP BY + HAVING

-- 부서별, 직책별 평균 급여 조회 + 평균급여 >= 2000
SELECT e.DEPTNO,e.job, AVG(e.SAL)
FROM EMP e 
GROUP BY e.DEPTNO, e.JOB HAVING AVG(e.SAL) >= 2000
ORDER BY e.DEPTNO;


-- SQL Error [934] [42000]: ORA-00934: 그룹 함수는 허가되지 않습니다
-- WHERE 절 그룹함수 안됨
--SELECT e.DEPTNO,e.job, AVG(e.SAL)
--FROM EMP e 
--WHERE AVG(e.SAL) >= 2000
--GROUP BY e.DEPTNO, e.JOB 
--ORDER BY e.DEPTNO;

-- 같은 직무에 종사는 사원이 3명 이상인 직책과 인원 수 출력
-- SALESMAN 4

SELECT e.JOB, COUNT(e.EMPNO)
FROM EMP e 
GROUP BY e.JOB HAVING COUNT(e.empno) >= 3;


-- 사원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력
-- 1987 20 2
-- 1987 30 1

SELECT TO_CHAR(e.HIREDATE, 'YYYY'), e.DEPTNO, COUNT(e.EMPNO)
FROM EMP e 
GROUP BY TO_CHAR(e.HIREDATE, 'YYYY'), e.DEPTNO;

-- 조인(join)
-- 여러 종류의 데이터를 다양한 테이블에 나누어 저장하기 때문에 여러 테이블의 데이터를 조합하여
-- 출력할 때가 많다. 이때 사용하는 방식이 조인
-- 종류

-- 내부조인(연결 안되는 데이터는 제외) - inner join
-- 1. 등가조인 : 각 테이블의 특정 열과 일치하는 데이터를 기준으로 추출
-- 2. 비등가조인 : 등가조인 외의 방식
-- 3. 자체(self)조인 : 같은 테이블끼리 조인

-- 외부조인 : 연결 안되는 데이터 보기 - outer join
-- 1. 왼쪽외부조인(left outer join) : 오른쪽 테이블의 데이터 존재 여부와 상관없이 왼쪽 테이블 기준으로 출력
-- 2. 오른쪽외부조인(right outer join) : 왼쪽 테이블의 데이터 존재 여부와 상관없이 오른쪽 테이블 기준으로 출력

-- 사원별 부서정보 조회
SELECT *
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO;

SELECT e.EMPNO, e.DEPTNO, d.DNAME, d.LOC
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO;

-- 나올수 있는 모든 조합 출력
SELECT e.EMPNO, e.DEPTNO, d.DNAME, d.LOC
FROM EMP e, DEPT d;

-- 사원별 부서정보 조회 + 사원별 급여 >= 3000

SELECT e.EMPNO, e.DEPTNO, e.SAL, d.DNAME, d.LOC
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.SAL >= 3000;

-- 사원별 부서정보 조회 + 사원별 급여 <= 2500 + 사원번호 9999 이하

SELECT e.EMPNO, e.DEPTNO, e.SAL, d.DNAME, d.LOC
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.SAL <= 2500 AND e.EMPNO <= 9999;

-- 비등가조인
-- 사원별 정보 + salgrade grade 
SELECT *
FROM EMP e, SALGRADE s 
WHERE e.SAL >= s.LOSAL AND e.SAL <= s.HISAL;

SELECT *
FROM EMP e, SALGRADE s 
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- 자체조인
-- 사원정보 + 직속상관 정보
SELECT e1.EMPNO, e1.ENAME, e1.MGR,e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO;

-- left outer join
SELECT e1.EMPNO, e1.ENAME, e1.MGR,e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO(+);

-- right outer join
SELECT e1.EMPNO, e1.ENAME, e1.MGR,e2.ENAME AS mgr_ename
FROM EMP e1, EMP e2
WHERE e1.MGR(+) = e2.EMPNO;

-- 표준 문법을 사용한 조인
-- join ~ on : inner join
-- join 테이블명 on 조인하는 조건

-- inner 생략 가능
SELECT
	*
FROM
	EMP e
JOIN SALGRADE s 
ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;

SELECT
	*
FROM
	EMP e
INNER JOIN SALGRADE s 
ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL;




-- left outer join 테이블명 on 조인조건 
SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS mgr_ename
FROM
	EMP e1
LEFT OUTER JOIN EMP e2
ON
	e1.MGR = e2.EMPNO;


SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.ENAME AS mgr_ename
FROM
	EMP e1
RIGHT OUTER JOIN EMP e2
ON
	e1.MGR = e2.EMPNO;



SELECT *
FROM EMP e1 JOIN EMP e2 ON e1.EMPNO  = e2.empno JOIN EMP e3 ON  e2.EMPNO = e3.EMPNO;  


-- 급여가 2000을 초과한 사원의 부서정보, 사원정보 출력
-- 출력) 부서번호,부서명,사원번호,사원명,급여

SELECT e.DEPTNO, d.DNAME, e.EMPNO, e.ENAME, e.SAL
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.SAL > 2000
ORDER BY e.DEPTNO;


-- 모든 부서정보와 사원정보를 부서번호, 사원번호 순서로 정렬하여 출력
-- 출력) 부서번호,부서명,사원번호,사원명,직무,급여

SELECT e.DEPTNO, d.DNAME, e.EMPNO, e.ENAME, e.JOB, e.SAL
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
ORDER BY e.DEPTNO, e.EMPNO;

-- 모든 부서정보, 사원정보, 급여등급정보, 각 사원의 직속상관 정보를
-- 부서번호, 사원번호 순서로 정렬하여 출력
-- 출력) 부서번호,부서명,사원번호,사원명,매니저번호,급여,losal,hisal,grade,매니저empno,매니저이름

SELECT
	e1.deptno,
	d.DNAME,
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e1.SAL,
	s.LOSAL,
	s.HISAL,
	s.GRADE,
	e2.empno AS mgr_empno,
	e2.ENAME AS mgr_ename
FROM
	EMP e1
LEFT OUTER JOIN EMP e2 ON
	e1.MGR = e2.EMPNO
JOIN DEPT d ON
	e1.DEPTNO = d.DEPTNO
JOIN SALGRADE s ON
	e1.sal BETWEEN s.LOSAL AND s.HISAL
ORDER BY e1.DEPTNO, e1.empno;

-- 부서별 평균급여,최대급여,최소급여,사원 수 출력
-- 부서번호, 부서명, avg_sal, min_sal, cnt
SELECT e.DEPTNO, d.DNAME,  avg(e.sal) AS avg_sal, max(e.sal) AS max_sal,min(e.sal) AS min_sal, count(e.empno) AS cnt
FROM emp e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
GROUP BY e.DEPTNO, d.DNAME;



-- 서브쿼리 : SQL 구문을 실행하는 데 필요한 데이터를 추가로 조회하고자 SQL 구문 내부에서 사용하는 SELECT 문
-- 연산자 등의 비교 또는 조회 대상 오른쪽에 놓이며 괄호로 묶어서 사용
-- 특수한 몇몇 경우를 제외한 대부분의 서브쿼리에서는 order by 절을 사용할 수 없다.
-- 서브쿼리의 select 절에 명시한 열은 메인쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정
-- 서브쿼리에 있는 select문의 결과 행 수는 함께 사용하는 메인 쿼리의 연산자 종류와 어울려야 한다
-- 1) 단일행 서브쿼리 : 실행결과가 행 하나인 서브쿼리
--      연산자 : >, >=, =, <, <=, <>,^=,!=

-- 2) 다중행 서브쿼리 : 실행결과가 여러개의 행인 서브쿼리
--      연산자 : in, any(some), all, exists

-- 3) 다중열 서브쿼리 : 서브쿼리의 SELECT 절에 비교할 데이터를 여러개 지정



-- 이름이 JONES 인 사원의 급여보다 높은 급여를 받는 사원 조회

-- JONES 의 급여 조회
SELECT SAL FROM EMP e WHERE e.ENAME = 'JONES';

-- JONES 보다 많이 받는 사원 조회
SELECT * FROM EMP e WHERE e.sal > 2975;

-- 서브쿼리로 변경
SELECT * FROM EMP e WHERE e.sal > (SELECT SAL FROM EMP e WHERE e.ENAME = 'JONES');

-- ALLEN 보다 빨리 입사한 사원 조회
SELECT * FROM EMP e WHERE e.HIREDATE < (SELECT E.HIREDATE FROM EMP e WHERE e.ENAME = 'ALLEN');

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받은 사원정보(사번,이름,직무,급여)
-- 소속부서정보(부서번호,부서명,부서위치) 조회

SELECT
	e.EMPNO,e.ENAME,e.JOB,d.DEPTNO,d.DNAME,d.LOC
FROM
	EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE
	e.deptno = 20
	AND e.SAL > (
	SELECT
		AVG(e.SAL)
	FROM
		EMP e);

-- 전체사원의 평균급여보다 적거나 같은 급여를 받는 20번부서의 정보 조회

SELECT
	e.EMPNO,e.ENAME,e.JOB,d.DEPTNO,d.DNAME,d.LOC
FROM
	EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE
	e.deptno = 20
	AND e.SAL <= (
	SELECT
		AVG(e.SAL)
	FROM
		EMP e);

-- 다중행 서브쿼리

-- 부서별 최고 급여와 같은 급여를 받는 사원 조회
-- 1) 부서별 최고 급여 
SELECT max(e.SAL)
FROM EMP e GROUP BY e.DEPTNO

SELECT * FROM emp e WHERE e.sal IN (3000,2850,5000);

-- 서브쿼리 사용
SELECT
	*
FROM
	emp e
WHERE
	e.sal IN (
	SELECT
		max(e.SAL)
	FROM
		EMP e
	GROUP BY
		e.DEPTNO);

-- ANY, SOME : 서브쿼리가 반환한 여러 결과값 중 메인 쿼리와 조건식을 사용한 결과가 하나라도 TRUE 라면
--             메인쿼리 조건식을 TRUE 로 반환

-- IN과 같은 효과를 =ANY(OR =SOME) 로 가능 (in 을 더 많이 사용)
SELECT
	*
FROM
	emp e
WHERE
	e.sal = ANY (
	SELECT
		max(e.SAL)
	FROM
		EMP e
	GROUP BY
		e.DEPTNO);

-- < ANY, < SOME

-- 30 번 부서의 (최대)급여보다 적은 급여를 받는 사원조회(단일행)
SELECT
	*
FROM
	emp e
WHERE
	e.sal < (SELECT max(e.sal) FROM emp e WHERE e.DEPTNO = 30)
ORDER BY e.SAL, e.EMPNO;

-- 30 번 부서의 급여보다 적은 급여를 받는 사원조회(다중행)
SELECT
	*
FROM
	emp e
WHERE
	e.sal < ANY (SELECT e.sal FROM emp e WHERE e.DEPTNO = 30)
ORDER BY e.SAL, e.EMPNO;


-- ALL : 서브쿼리의 모든 결과가 조건식에 맞아 떨어져야만 메인쿼리의 조건식이 true


-- 30 번 부서의 최소급여보다 적은 급여를 받는 사원조회(단일행)
SELECT * FROM emp e WHERE e.sal < (SELECT min(e.sal) FROM emp e WHERE e.DEPTNO = 30);

-- 30 번 부서의 급여보다 적은 급여를 받는 사원조회(다중행)
SELECT * FROM emp e WHERE e.sal < ALL (SELECT e.sal FROM emp e WHERE e.DEPTNO = 30);


-- EXISTS : 서브쿼리에 결과값이 하나 이상 있으면 조건식이 모두 TRUE, 없으면 FALSE

SELECT * FROM EMP WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO=10);

SELECT * FROM EMP WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO=50);

-- 비교할 열이 여러개인 다중열 서브쿼리

-- 부서별 최고 급여와 같은 급여를 받는 사원 조회

SELECT
	*
FROM
	emp e
WHERE
	(e.DEPTNO, e.sal) IN (
	SELECT
		e.DEPTNO,max(e.SAL)
	FROM
		EMP e
	GROUP BY
		e.DEPTNO);

-- SELECT절에 사용하는 서브쿼리(결과가 반드시 하나만 반환)
-- 사원정보, 급여등급, 부서명 조회(조인)

SELECT
	e.EMPNO,
	e.JOB,
	e.SAL,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.sal BETWEEN s.LOSAL AND s.HISAL) AS salgrade,
	e.deptno,
	(SELECT d.DNAME FROM DEPT d WHERE e.DEPTNO = d.DEPTNO) AS dname
FROM
	EMP e; 


-- 10 번 부서에 근무하는 사원 중 30번 부서에 없는 직책인 사원의 사원정보(사번,이름,직무)
-- 부서정보(부서번호,부서명,위치) 조회

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	d.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e JOIN DEPT d ON e.DEPTNO = d.deptno
WHERE
	e.job
NOT IN (
	SELECT
		e.job
	FROM
		EMP e
	WHERE
		e.DEPTNO = 30) AND e.DEPTNO = 10;



-- 직책이 SALESMAN 인 사람의 최고급여보다 많이 받는 사람의 사원정보, 급여등급정보를 조회
-- 다중행 함수를 사용하는 방법과 사용하지 않는 방법 2가지로 작성(사번 기준으로 오름차순)
-- 출력 : 사번,이름,급여,등급

-- 다중행 함수를 사용하지 않는 방법

SELECT
	e.EMPNO,
	e.ENAME,
	e.sal,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.sal BETWEEN s.LOSAL AND s.HISAL) AS salgrade
FROM
	emp e
WHERE
	e.sal
> (
	SELECT
		MAX(e.sal)
	FROM
		emp e
	WHERE
		e.JOB = 'SALESMAN')
ORDER BY
	e.EMPNO;


-- 다중행 함수 사용
SELECT
	e.EMPNO,
	e.ENAME,
	e.sal,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.sal BETWEEN s.LOSAL AND s.HISAL) AS salgrade
FROM
	emp e
WHERE
	e.sal
> ALL (
	SELECT
		e.sal
	FROM
		emp e
	WHERE
		e.JOB = 'SALESMAN')
ORDER BY
	e.EMPNO;

-- C(Insert) : 삽입
--INSERT INTO 테이블명(필드명,필드명....)
--VALUES(값1,값2...)
-- 필드명 지정시 필드명개수와 벨류값개수는 동일해야 함
-- 필드명 생략시 값을 넣는 테이블의 현재 열 순서대로 나열되었다고 가정하고
-- 데이터를 처리하도록 되어있음 


-- 기존테이블 복사 후 새 테이블로 생성
CREATE TABLE dept_temp AS SELECT * FROM dept;

 INSERT INTO DEPT_TEMP(deptno,dname,loc)
VALUES(50,'DATABASE','SEOUL');

INSERT INTO DEPT_TEMP	
VALUES(60,'NETWORK','BUSAN');

INSERT INTO DEPT_TEMP	
VALUES('70','NETWORK','BUSAN');

--값의 수가 충분하지 않다 - 오류 
INSERT INTO DEPT_TEMP	(deptno,dname,loc)
VALUES('NETWORK','BUSAN');
-- 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
INSERT INTO DEPT_TEMP	
VALUES(600,'NETWORK','BUSAN');

-- null 
INSERT INTO DEPT_TEMP	
VALUES(80,'NETWORK',null);

INSERT INTO DEPT_TEMP	(deptno,dname)
VALUES(90,'NETWORK');

-- 열 구조만 복사 후 새 테이블 생성
CREATE TABLE emp_temp AS SELECT * FROM emp WHERE 1<>1;

--날짜 데이터 삽입 : 'YYYY-MM-DD' or 'YYYY/MM/DD'
INSERT INTO EMP_TEMP(empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
VALUES(9997,'최길동' , 'PRESIDENT',NULL,'2020-12-13', 5000 ,1000,10);

INSERT INTO EMP_TEMP(empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
VALUES(3113,'이춘향' , 'MANAGER',9999,sysdate, 4000 ,NULL,30);

-- * emp,salgrade 급여등급이 1인 사원들만 emp_temp에 추가하기
INSERT INTO EMP_TEMP(empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
SELECT e.*
FROM EMP e JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL
AND s.GRADE =1;


-- U(update)
-- update 테이블명
-- set 변경할 열= 값, 변경할 열= 값.....
-- where(선택) 데이터를 변경할 대상 행을 선별하는 조건 나열 
-- 90번 부서의 loc를 SEOUL로 변경
UPDATE DEPT_TEMP
SET LOC= 'SEOUL'
WHERE DEPTNO = 90;

-- where 조건이 없으면 loc 전체를 SEOUL로 바꿈
UPDATE DEPT_TEMP
SET LOC= 'SEOUL';

--COMMIT;
--ROLLBACK:

-- 40번 부서의 부서명을 위치 변경
-- dept 테이블 40번 부서랑 동일하게
UPDATE DEPT_TEMP
SET (dname,LOC) =   (SELECT dname, loc FROM DEPT WHERE DEPTNO = 40)
WHERE DEPTNO = 40;
-- 50번 부서의 dname과 loc 변경
UPDATE DEPT_TEMP
SET LOC= 'BOSTON' , DNAME= 'SALES'
WHERE DEPTNO = 50;

--Delete : 삭제
--DELETE FROM(선택) 테이블명
--WHERE(선택) 삭제할 조건 
DELETE FROM DEPT_TEMP
WHERE deptno = 70;

-- loc가 SEOUL 데이터 삭제
DELETE FROM DEPT_TEMP 
WHERE LOC = 'SEOUL';

--emp_temp sal 3000 이상인 사람 삭제 
DELETE EMP_TEMP
WHERE SAL >= 3000;
-- 테이블 전체삭제
DELETE EMP_TEMP;

CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;

-- DEPT 테이블에 다음 데이터를 삽입하기
-- 50 , ORACLE, BUSAN
INSERT INTO EXAM_DEPT(deptno,dname,loc)
VALUES(50,'ORACLE','BUSAN');
-- 60, SQL , ILSAN
INSERT INTO EXAM_DEPT(deptno,dname,loc)
VALUES(60,'SQL','ILSAN');
-- 70, SELECT, INCHEON
INSERT INTO EXAM_DEPT(deptno,dname,loc)
VALUES(70,'SELECT','INCHEON');
-- 80, DML, BUNDANG
INSERT INTO EXAM_DEPT(deptno,dname,loc)
VALUES(80,'DML','BUNDANG');


-- EXAM_EMP 테이블에 다음 데이터 삽입하기
-- 7201, USER1,MANAGER,7788,2016-02-01,4500,NULL,50
INSERT INTO EXAM_EMP (empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
VALUES(7201,'USER1' , 'MANAGER',7788,'2016-02-01', 4500 ,NULL,50);

-- 7202, USER2,CLERK,7201,2016-02-16,1800,NULL,50
INSERT INTO EXAM_EMP (empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
VALUES(7202,'USER2' , 'CLERK',7201,'2016-02-16', 1800 ,NULL,50);

-- 7203, USER3,ANALYST,7201,2016-04-11,3400,NULL,60
INSERT INTO EXAM_EMP (empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
VALUES(7203,'USER3' , 'ANALYST',7201,'2016-04-11', 3400 ,NULL,60);

-- 7204, USER4,SALESMAN,7201,2016-05-31,2700,NULL,60
INSERT INTO EXAM_EMP (empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
VALUES(7204,'USER4' , 'SALESMAN',7201,'2016-05-31', 2700 ,NULL,60);

-- 7205, USER5,CLERK,7201,2016-07-20,2600,NULL,70
INSERT INTO EXAM_EMP (empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
VALUES(7205,'USER5' , 'CLERK',7201,'2016-07-20', 2600 ,NULL,70);

-- 7206, USER6,CLERK,7201,2016-09-08,2600,NULL,70
INSERT INTO EXAM_EMP (empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
VALUES(7206,'USER6' , 'CLERK',7201,'2016-09-08', 2600 ,NULL,70);

-- 7207, USER7,LECTURER,7201,2016-10-28,2300,NULL,80
INSERT INTO EXAM_EMP (empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
VALUES(7207,'USER7' , 'LECTURER',7201,'2016-10-28', 2300 ,NULL,80);

-- 7208, USER8,STUDENT,7201,2018-03-09,1200,NULL,80
INSERT INTO EXAM_EMP (empno,ENAME,job,mgr,HIREDATE,sal,COMM,DEPTNO)
VALUES(7208,'USER8' , 'STUDENT',7201,'2018-03-09', 1200 ,NULL,80);

-- EXAM_EMP 에서 50번 부서에서 근무하는 사원의 평균 급여보다 많이 받는 사원을 
-- 70번 부서로 옮기는 sql구문 작성
UPDATE EXAM_EMP
SET DEPTNO = 70
WHERE EXAM_EMP.SAL  > 
(SELECT AVG(exam_emp.SAL) 
FROM EXAM_EMP WHERE EXAM_EMP.DEPTNO  = 50)
AND EXAM_EMP.DEPTNO  != 70;

-- EXAM_EMP 에서 입사일이 가장 빠른 60번 부서 사원보다 늦게 입사한 사원의 
-- 급여를 10% 인상하고 80번 부서로 옮기는 sql 구문 작성
UPDATE EXAM_EMP
SET SAL = SAL*1.1, DEPTNO = 80 
WHERE EXAM_EMP.HIREDATE > 
(SELECT MIN(EXAM_EMP.HIREDATE) 
FROM EXAM_EMP WHERE EXAM_EMP.DEPTNO = 60);

--EXAM_EMP 에서 급여등급이 5인 사원을 삭제하는 sql 구문 작성

DELETE FROM EXAM_EMP 
WHERE SAL BETWEEN (SELECT LOSAL FROM EXAM_SALGRADE WHERE GRADE = 5)
              AND (SELECT HISAL FROM EXAM_SALGRADE WHERE GRADE = 5);

-- 트랜잭션 : ALL or NOTHING (전부 실행 or 전부 취소)
-- DML(데이터 조작어) - insert , update , delete 
-- commit(전부실행)  / rollback(전부취소)
INSERT INTO DEPT_TEMP VALUES (30,'DATABASE','SEOUL');
UPDATE DEPT_TEMP SET  LOC='BUSAN' WHERE deptno =30;
DELETE FROM DEPT_TEMP WHERE DNAME = 'asd';

COMMIT;

ROLLBACK;


-- 세션 : 데이터베이스 접속 후 작업을 수행한 뒤 접속을 종료하기까지 전체 기간
-- 조회는 영향 없음
SELECT * FROM EMP e ;
-- DML 영향 있음
DELETE FROM DEPT_TEMP WHERE deptno =30;
COMMIT;
ROLLBACK;


-- DDL(데이터 정의어) : 객체를 생성,변경,삭제 
-- 1. 테이블 생성 : CREATE
-- 2.          변경 : ALTER
-- 3.          삭제 : DROP
-- 4. 테이블 전체 데이터 삭제  : TRUNCATE
-- 5. 테이블 이름변경 : RENAME

-- CREATE TABLE 테이블명(
-- 컬럼명1 , 자료형,
-- 컬럼명2 , 자료형,
-- 컬럼명3 , 자료형
-- )

-- 테이블명 규칙
-- 문자로 시작
-- 테이블 이름 길이 30byte 이하
-- 같은 사용자 안에서는 테이블명 중복 불가 
-- SQL 예약어는 테이블 이름으로 사용할 수 없음

-- NUMBER(7,2) : 전체 자리수 7 소수점 2자리 포함
-- VARCHAR(14) : 영어 14자 한글 4자 

CREATE TABLE DEPT_DDL (
DEPTNO NUMBER(2.0),
DNAME VARCHAR2(14),
LOC VARCHAR2(13)
);

CREATE TABLE EMP_DDL (
EMPNO NUMBER(4.0),
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR NUMBER(4,0),
HIREDATE DATE ,
SAL NUMBER(7,2),
COMM NUMBER(7,2),
DEPTNO NUMBER(2,0)
);

-- 기존 테이블 구조와 데이터를 복사해 새 테이블 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;

-- 기존 테이블 구조만 복사해 새 테이블 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP WHERE 1<>1;

-- ALTER : 테이블 변경(열에 대한것만)
-- 1) 열 추가
-- 2) 열 이름 변경
-- 3) 열 자료형을 변경
-- 4) 특정 열 삭제

-- HP 열 추가 
ALTER TABLE EMP_DDL ADD HP VARCHAR2(20);

-- HP => TEL 변경
ALTER TABLE  EMP_DDL RENAME COLUMN HP TO TEL;

-- 열 자료형을 변경  empno 자리수 4=>5로 변경 : 변경할 타입을 줘야함
-- 내부 데이터가 없는 상태여야 변경가능
ALTER TABLE  EMP_DDL MODIFY EMPNO NUMBER(5);

ALTER TABLE  EMP_DDL MODIFY ENAME VARCHAR2(8);

ALTER TABLE  EMP_DDL MODIFY EMPNO NUMBER(3);

ALTER TABLE  EMP_TEMP  MODIFY EMPNO NUMBER(3);

-- 특정 열 삭제
ALTER TABLE  EMP_DDL DROP COLUMN TEL;

-- 테이블 이름변경
RENAME EMP_DDL TO EMP_RENAME;

-- 테이블 데이터 삭제
-- delete from emp_rename;
-- rollback 안됨
TRUNCATE TABLE EMP_RENAME;

-- 테이블 제거
DROP TABLE EMP_RENAME;


-- MEMBER 테이블 생성
-- id , varchar2(8) /name 10/ addr 50 /email 30/ age number(4)
CREATE TABLE MEMBER (
ID VARCHAR2(8),
NAME VARCHAR2(10),
ADDR VARCHAR2(50),
email VARCHAR(30),
age NUMBER(4)
);

-- insert(remark X)
INSERT INTO member(id,name,addr,email,age)
VALUES('hong123','성춘향','서울시 종로구','hong123@naver.com',24);


-- member 테이블 열 추가 
-- bigo 열추가(문자열, 20)
ALTER TABLE MEMBER ADD bigo VARCHAR2(20);
--bigo 열 크기 30으로 변경
ALTER TABLE  MEMBER MODIFY bigo VARCHAR2(30);
-- bigo 열 이름을 remark로 변경
ALTER TABLE  MEMBER RENAME COLUMN bigo TO REMARK;


-- 오라클 객체
-- 1. 오라클 데이터베이스 테이블 
--    1) 사용자 테이블
--    2) 데이터 사전 : 중요한 데이터(사용자,권한,메모리,성능..) - 일반 사용자가 접근하는 곳은 아님
--                           user_ ,all_ ,dba_ , v$
-- 2. 인덱스 : 검색을 빠르게 처리 하기 위해 사용
--    1) FULL SCAN
--    2) INDEX SCAN
-- 3. view : 가상 테이블 
--     물리적으로 저장 된 테이블 아님
-- 4. 시퀀스 :  규칙에따라 순번을 생성




SELECT * FROM dict;

SELECT table_name
FROM user_tables;

-- 인덱스 조회
SELECT * FROM USER_INDEXES;

--인덱스 생성
-- CREATE INDEX 인덱스명 ON 테이블명(열 이름 ASC OR DESC, 열 이름...)
CREATE INDEX IDX_EMP_TEMP_SAL ON EMP_TEMP(SAL);

-- 인덱스 삭제 
DROP INDEX IDX_EMP_TEMP_SAL;

SELECT * FROM EMP e ;

-- view - 권한을 가진 사용자만 생성이 가능함
-- 보안성 : 특정 정보만 노출, 특정 정보를 노출하지 않음
-- 편리성 : select 문의 복잡도 완화
-- CREATE VIEW 뷰이름(열이름1,열이름2,...) AS (저장할 SELECT 구문)
--20번 부서 정보를 view 로 생성
CREATE VIEW vw_emp20 AS 
(SELECT e.EMPNO,e.ENAME,e.JOB,e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO =20);

-- 20번 부서 정보 확인 
SELECT e.EMPNO,e.ENAME,e.JOB,e.DEPTNO
FROM EMP e 
WHERE e.DEPTNO =20;

-- 뷰 삭제
DROP VIEW VW_EMP20;

-- 시퀀스 : 오라클 데이터 베이스에서 특정 규칙에 따른 연속 숫자를 생성하는 객체
-- 게시판 번호, 멤버 번호

-- CREATE SEQUENCE 시퀀스명;
CREATE SEQUENCE board_seq;
-- 
--CREATE SEQUENCE SCOTT.BOARD_SEQ 
--INCREMENT BY 1 : 시퀀스에서 생성할 번호의 증가값 , 값이 없으면 기본값이 1
--MINVALUE 1  : 시퀀스에서 생성할 번호의 최소값 , 값이 없으면 기본값이 NOMINVALUE (오름차순일때 1)
--MAXVALUE 9999999999999999999999999999 : 시퀀스에서 생성할 번호의 최대값
--NOCYCLE : 최소값에서 최대값까지 번호가 다 생성 되었을 경우 새로운 번호를 요청하면 error 발생 CYCLE: 돌아감
--CACHE 20 NOORDER  : 시퀀스가 생성할 번호 개수를 미리 메모리에 할당 or NOCACHE
-- NOORDER

-- member 테이블에 NO컬럼(number) 추가
ALTER TABLE member ADD NO NUMBER(20);


-- member no 값은 시퀀스 값으로 입력하기
-- 사용할 시퀀스 생성
CREATE SEQUENCE member_seq;

INSERT INTO member(NO, id,name,addr,email,age)
VALUES(member_seq.nextval,'hong123','성춘향','서울시 종로구','hong123@naver.com',24);

-- 시퀀스명.currval : 가장 마지막으로 생성된 시퀀스 확인
-- 시퀀스명.nextval : 시퀀스 발행
SELECT member_seq.currval
FROM dual;

CREATE SEQUENCE seq_dept_sequence
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
nocycle cache 2;

CREATE TABLE dept_sequence AS SELECT * FROM dept WHERE 1<>1;

INSERT INTO dept_sequence VALUES (seq_dept_sequence.nextval,'DATABASE', 'SEOUL');
SELECT *FROM DEPT_SEQUENCE;

-- 마지막 발생 시퀀스 확인
SELECT seq_dept_sequence.currval
FROM dual;

-- 시퀀스 수정 
ALTER SEQUENCE seq_dept_sequence
INCREMENT BY 3
MAXVALUE 99
CYCLE;

-- 시퀀스 삭제
DROP SEQUENCE board_seq;
DROP SEQUENCE seq_dept_sequence;

-- 제약조건(*****아주중요함******) : 테이블에 저장할 데이터를 제약하는 특수한 규칙
-- 1) NOT NULL : 빈값을 허용하지 않음
-- 2) UNIQUE : 중복불가
-- 3) PRIMARY KEY(PK) : 유일하게 하나만 존재
-- 4) FOREIGN KEY(FK) : 다른테이블과 관계맺기
-- 5) CHECK : 데이터 형태와 범위를 지정
-- 6) DEFAULT : 기본값 설정

CREATE TABLE tbl_notnull(
LOGIN_ID VARCHAR2(20) NOT NULL,
LOGIN_PWD VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20)
);

-- null을 허용하지 않음 LOGIN_PWD VARCHAR2(20) NOT NULL
INSERT INTO TBL_NOTNULL(LOGIN_ID,LOGIN_PWD,TEL)
VALUES('hong123',NULL,'010-1234-5678');

INSERT INTO TBL_NOTNULL(LOGIN_ID,LOGIN_PWD,TEL)
VALUES('hong123','','010-1234-5678');

INSERT INTO TBL_NOTNULL(LOGIN_ID,LOGIN_PWD)
VALUES('hong123','hong123');


-- 제약조건 이름짓기
CREATE TABLE tbl_notnull2(
LOGIN_ID VARCHAR2(20) CONSTRAINT 넌못지나간다_LOGID_NN NOT NULL,
LOGIN_PWD VARCHAR2(20) CONSTRAINT 넌못지나간다_LOGPWD_NN NOT NULL,
TEL VARCHAR2(20)
);

-- 기존 제약 조건에 제약조건 추가하기 - 기존 데이터도 새로 추가되는 제약조건을 만족해야 실행됨
ALTER TABLE TBL_PK MODIFY (TEL NOT NULL);
-- null 값 업데이트 하기
UPDATE TBL_UNIQUE  SET TEL = '010-1234-4568'
WHERE LOGIN_ID = 'hong123';
-- 제약조건 이름 설정
ALTER TABLE TBL_NOTNULL2 MODIFY (TEL CONSTRAINT 너도못지나간다 NOT NULL);
-- 제약조건 이름변경
ALTER TABLE TBL_NOTNULL2 RENAME CONSTRAINT 너도못지나간다 TO 그냥지나가라;
-- 제약조건 삭제
ALTER TABLE TBL_NOTNULL2  DROP  CONSTRAINT 그냥지나가라;


-- UNIQUE : 데이터의 중복을 허용하지 않음
--                   null은 중복 대상에서 제외됨

CREATE TABLE TBL_UNIQUE(
LOGIN_ID VARCHAR2(20)  UNIQUE,
LOGIN_PWD VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20)
);

-- 데이터 무결성
-- 데이터베이스에 저장되는 데이터의 정확성과 일치성 보장
-- DML 과정에서 지켜야 하는 규칙

--  중복을 시도하면 무결성 제약조건 위배 오류
INSERT INTO TBL_UNIQUE(LOGIN_ID,LOGIN_PWD,TEL)
VALUES('hong123','hong123','010-1234-5678');

INSERT INTO TBL_UNIQUE(LOGIN_ID,LOGIN_PWD,TEL)
VALUES(NULL ,'hong123','010-1234-5678');

ALTER TABLE TBL_UNIQUE MODIFY (TEL UNIQUE);

UPDATE TBL_UNIQUE tu SET TEL = NULL;


-- 유일하게 하나만 있는 값 : PRIMARY KEY(PK)
-- PK : NOT NULL + UNIQUE
-- PK 생성 > 컬럼 하나만 지정가능함 
CREATE TABLE TBL_PK(
LOGIN_ID VARCHAR2(20)  PRIMARY KEY,
LOGIN_PWD VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20)
);

CREATE TABLE TBL_PK2(
LOGIN_ID VARCHAR2(20) CONSTRAINT PK키지정 PRIMARY KEY,
LOGIN_PWD VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20)
);


INSERT INTO TBL_PK(LOGIN_ID,LOGIN_PWD,TEL)
VALUES('hong123','hong123','010-1234-5678');

INSERT INTO TBL_PK2(LOGIN_ID,LOGIN_PWD,TEL)
VALUES('hong123','hong123','010-1234-5678');

--FK(외래키) : 다른테이블과 관계를 맺는 키
-- join 구문 EMP(deptno) , DEPT(deptno) 연동 
-- emp 테이블에 deptno 는 dept테이블에 있는 dept 값을 참조해서 삽입

-- 부서 테이블 생성(참조 대상이 되는 테이블 먼저 작성)
--부모
CREATE TABLE DEPT_FK(
 DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
 DNAME VARCHAR2(14),
 LOC VARCHAR2(13)
);

--자식
CREATE TABLE EMP_FK(
EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
ENAME VARCHAR2(10) NOT NULL,
JOB VARCHAR2(9) NOT NULL,
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7,2) NOT NULL,
COMM NUMBER(7,2),
DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
);

--무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다-부모 키가 없습니다
-- 참조 대상이 되는(부모) 테이블의 데이터부터 삽입 후 참조하는(자식) 테이블의 데이터를 삽입해야함 

--부모 데이터 삽입
INSERT INTO DEPT_FK VALUES(10,'DATABASE','SEOUL');
--자식 데이터 삽입
INSERT INTO EMP_FK(EMPNO,ENAME,JOB,HIREDATE,SAl,DEPTNO)
VALUES(9999,'TEST1','PARTNER',SYSDATE,2500,10);

DELETE FROM EMP_FK WHERE EMPNO =9999;
DELETE FROM DEPT_FK WHERE DEPTNO = 10;

-- DELETE 시 주의점 : 부모와 관계된 자식이 데이터를 가지고 있으면 부모는 delete 를 수행할 수 없음
--1) 자식데이터 삭제,변경,null 선행 후
--2) 부모데이터 삭제 
DELETE FROM EMP_FK WHERE DEPTNO = 10;
DELETE FROM DEPT_FK WHERE DEPTNO = 20;

-- 옵션 설정
-- 1) on delete cascade : 부모 삭제 될때 자식도 같이 삭제(다같이 죽자)
-- 2) on delete set null : 부모 삭제 시 연결된 자식의 부모를 null로 변경(상속재산 없음)

-- cascade
CREATE TABLE EMP_FK2(
EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK2 PRIMARY KEY,
ENAME VARCHAR2(10) NOT NULL,
JOB VARCHAR2(9) NOT NULL,
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7,2) NOT NULL,
COMM NUMBER(7,2),
DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK2
REFERENCES DEPT_FK(DEPTNO) ON DELETE CASCADE 
);

-- set null
CREATE TABLE EMP_FK3(
EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK3 PRIMARY KEY,
ENAME VARCHAR2(10) NOT NULL,
JOB VARCHAR2(9) NOT NULL,
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7,2) NOT NULL,
COMM NUMBER(7,2),
DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK3
REFERENCES DEPT_FK(DEPTNO) ON DELETE SET NULL  
);

INSERT INTO DEPT_FK VALUES(20,'NETWORK','BUSAN');
--자식 데이터 삽입
INSERT INTO EMP_FK3(EMPNO,ENAME,JOB,HIREDATE,SAl,DEPTNO)
VALUES(9999,'TEST1','PARTNER',SYSDATE,2500,20);



