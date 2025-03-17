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
SELECT * FROM EMP e;