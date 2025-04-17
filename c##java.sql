-- board 테이블 작성

CREATE TABLE board(
	bno number(8) PRIMARY KEY,
	title varchar2(100) NOT NULL,
	content varchar2(2000) NOT NULL,
	writer varchar2(50) NOT NULL,
	regdate DATE DEFAULT sysdate
);

CREATE SEQUENCE board_seq;

INSERT INTO board(bno,title,content,writer)
values(board_seq.nextval,'title1','content','user1');

INSERT INTO STUDENTTBL (NAME) VALUES ('홍길동');
INSERT INTO STUDENTTBL (NAME) VALUES ('성춘향');