-- 오라클 관리자
-- system, sys(최고권한) 


-- 사용자 이름: sys as sysdba
-- 비밀번호 : 엔터


-- 오라클 12c버전부터 사용자 계정 생성 시 접두어(c##)를 요구함
-- c## 사용 하지 않으려면 (ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE; 선행)
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- 비밀번호 변경
-- 비밀번호는 대,소문자 구별함
ALTER USER hr IDENTIFIED BY hr;

-- 계정 잠금 해제
-- ALTER USER hr account unlock;