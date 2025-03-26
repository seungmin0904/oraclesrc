-- 오라클 관리자 접근방법
-- system, sys(최고권한)
-- 사용자 이름 : sys as sysdba 
-- 비밀번호 : 엔터

-- 오라클 12c 버전부터 사용자계정 생성시 접두어(c##)를 요구함
-- c##hr
-- c##을 사용하지 않을경우 아래 명령어 실행
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

-- 비밀번호 변경시
-- 비밀번호만 대소문자를 구별함
ALTER USER hr IDENTIFIED BY hr;

-- 계정 잠금 해제(hr)
ALTER USER hr account unlock;

