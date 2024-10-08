# 데이터베이스 확인하기
show databases;

# 우리만의 데이터베이스 만들기 # 데이터베이스도 순서가 없다
create database kdt;

# table (저장소)
/*
[테이블]
데이터를 행 (로우, 레코드)과 열(컬럼, 필드)로 스키마에 따라 저장할 수 있는 구조 - 데이터를 가로로 본 것
       가로              세로
스키마: 데이터베이스의 구조와 제약조건에 관한 명세를 기술한 집합(테이블을 만들기 위한 구조)

create table 테이블명(첫 필드명 데이터타입 제약조건, 필드명2 데이터타입 제약조건, ...)

✔ 데이터타입
1. 숫자형
TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT: 정수  - INT 쓰자
FLOAT, DOUBLE, DECIMAL: 실수 - DOUBLE 쓰자

2. 문자형
CHAR, VARCHAR(최대 65535 byte), BINARY, VARBINARY, TEXT(최대한 많이) - VARCHAR 쓰자 , 이진파일은 잘 안 쓴다

3. 날짜형 
DATE, TIME, DATETIME, TIMESTAMP, YEAR - DATETIME 쓰자
TIMESTAMP: 시간의 흐름만 알고 싶을 때 덧셈 뺄셈

✔ 제약조건 (데이터의 무결성을 지키기 위해 데이터를 입력받을 때 실행되는 검사 규칙)
1. not null: null 값을 허용하지 않음
2. unique: 중복값 허용하지 않음, null값 허용
3. default: null값을 삽입할 때 기본이 되는 값을 설정함
4. primary key: null값을 허용하지 않음, 중복값을 허용하지 않음, 인덱싱을 설정함. 
				테이블에 단 하나만 설정 가능
                참조키와 쌍으로 연결한다.
5. foreign key: 참조키
				기본키와 쌍으로 연결
검색, 삽입, 수정, 삭제 등등이 주된 일
*/

# 데이터 베이스 선택하기
use kdt;

#테이블 만들기
create table member(
userid varchar(20) primary key,
userpw varchar(20) not null,
name varchar(20) not null,
hp varchar(20) unique not null,
email varchar(50) not null,
gender varchar(10) not null,
ssn1 char(6) not null, #주민번호앞자리 6글자
ssn2 char(7) not null,
zipcode varchar(5), #우편번호 5자리
address1 varchar(100),
address2 varchar(100),
address3 varchar(100),
regdate datetime default now(), #날짜와 시간, 가입하면 자동으로 저장된다
point int default 100
);

# 테이블 확인하기
desc member;

# 테이블 삭제하기
drop table member;

# 필드 추가하기
alter table member add mbti varchar(10);

# 필드 수정하기
alter table member modify column mbti varchar(20);

# 필드 삭제하기
alter table member drop mbti;

/* 
	CRUD(Create Read Update Delete) - 외워야 함
	테이블 생성, 데이터 삽입, 데이터 변경, 데이터 삭제
*/

/* 
데이터 삽입 (insert)
1. insert into 테이블명 values (값1, 값2, 값3 ...)  #데이터를 다 넣어야 한다 
2. insert into 테이블명 (필드명1, 필드명2, ...) values (값1, 값2, ...)
*/

# 연습용 테이블
create table words(
	eng varchar(50) primary key, 
    kor varchar(50) not null,
    lev int default 1);
    
desc words;

insert into words values('apple', '사과', 1); 
#insert into words values('apple', '사과', 1); # 중복 데이터 에러 #Duplicate entry 'apple' for key 'words.PRIMARY'


#테이블 확인하기
select * from words; #모든 컬럼
#select eng from words;

#insert into words values('banana', '바나나') #컬럼 개수가 일치하지 않음 #첫 번째 문법은 개수가 무조건 맞아야 한다
insert into words values('banana', '바나나', null);  #null이 들어간다. default가 작동해 주지 않는다
#insert into words values('orange', null, null); # 제약에 걸린다. #null 넣을 수 없다

insert into words (eng, kor, lev) values ('orange','오렌지',1);
insert into words (eng, kor) values ('melon','메론'); #lev에 default가 들어간 것 확인

insert into words(lev, eng, kor) values (2, 'avocado', '아보카도'); # 짝만 맞으면 순서가 바뀌어도 괜찮다
#insert into words(eng) values ('cherry'); # null을 넣을 수 없음
select * from words;
select * from member;
# 문제
# member테이블에 위 테이블에 삽입된 다섯 개의 단어로 5명의 유저를 삽입
insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2, zipcode, address1, address2, address3)
values('apple', 'aaaa', '김사과', '010-0000-0000', 'apple@apple.com', '여자', '981113','2222222', '00000','사과시','사과구','사과동');

insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2, zipcode, address1, address2, address3, point)
values('banana', 'bbb', '바나나', '010-1111-1111', 'banana@banana.com', '여자', '991010','2222222', '11111','바나시','바나구','바나동',200);

insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2, zipcode, address1, address2, address3)
values('orange', 'OOOO', '오렌지', '010-5555-5555', 'orange@orange.com', '남자', '781113','1111111', '22222','오렌시','오레구','오레동');

insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2, zipcode, address1, address2, address3, point)
values('melon', 'mmmm', '김메론', '010-6666-6666', 'melon@melon.com', '여자', '971010','2222222', '33333','메론시','메론구','메론동',300);

insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2, zipcode, address1, address2, address3)
values('cherry', 'cccc', '김체리', '010-7777-7777', 'cherry@cherry.com', '남자', '991111','1111111', '4444','체리시','체리구','체리동');

/* 
# 데이터 수정하기 (update)
1. update 테이블명 set 필드명1 = 값1, 필드명2 = 값2 ...
name = '김사과' 이러면 모든 값이 김사과로 바뀌어 버리는데.......
2. update 테이블명 set 필드명1 = 값1, 필드명2 = 값2 ... where 조건 
일시적인 safe 모드 해제
set sql_safe_updates = 0;
영구적인 safe 모드 해제
Edit -> Preferences -> SQL Editor -> Safe Updates 체크 해제 -> workbench 재시작
*/
use kdt;
select * from words;
update words set lev=1; #safe update 모드가 걸려 있어 where 조건을 이용하라는 뜻
# safe 모드를 풀어주자

# 오렌지 --> 어륀지 로 바꿔보자
update words set kor = '어륀지' where eng = 'orange';
# 더블클릭후 셀 값 변경, apply
# 모든 유저에게 50 포인트를 더해 주기
select * from member;
update member set point = point + 50;

# 멤버 테이블의 아이디가 'apple'인 유저의 우편번호를 '12345' 주소1을 '서울시 서초구' 주소2를 '양재동'으로 수정하기
update member set zipcode='12345', address1='서울시 서초구', address2='양재동' where userid='apple';
update member set zipcode='54321', address1='서울시 서초구', address2='반포동' where name='바나나';

/*
데이터 삭제하기 (delete)
1. delete from 테이블명 
2. delete from 테이블명 where 조건
*/
select * from words;
delete from words where eng='orange'; # 한 번 더 실행 시 데이터가 없어서 삭제x
delete from words; # 전체 테이블 삭제
 
/* */

insert into words values('apple', '사과', 1); 
insert into words values('banana', '바나나', null);
insert into words (eng, kor, lev) values ('orange','오렌지',1);
insert into words (eng, kor) values ('melon','메론'); #lev에 default가 들어간 것 확인
insert into words(lev, eng, kor) values (2, 'avocado', '아보카도');

/* 검색하기 (select) 
select
select 필드명 1, 필드명 2 ...from 테이블 명
select 필드명 1, 필드명 2 ...from 테이블 명 where 조건
select 필드명 1, 필드명 2 ...from 테이블 명 [where 조건] order by 필드명 [asc, desc] #안 쓰면 오름차순
select 필드명 1, 필드명 2 ...from 테이블 명 [where 조건] [order by 필드명 [asc, desc]] limit [숫자,] 숫자
select 필드명 1, 필드명 2 ...from 테이블 명 [where 조건] [group by 필드명] [having 조건] [order by 필드명 [asc, desc]] limit [숫자,] 숫자

/* 데이터베이스의 데이터는 정렬되지 않음
정렬하기 (order by)
*/


select 100;
select 100+50;
select 100+50 as 덧셈;
select 100+50 as '덧셈 연산'; # 띄어쓰기 할 때엔 꼭 작은따옴표('') 사용
select null; # 데이터가 없다
select ''; # 빈 데이터가 있다
select 100+null; #null과는 연산 불가
select 100+''; # 빈 데이터와는 연산 가능
select eng from words;
select eng, kor from words;
select * from words;

/*
연산자
1. 산술 연산자 : +, -, *, /, mod(나머지), div(몫)
2. 비교 연산자, =, <, >, >=, <=, <>(다르다)
3. 대입 연산자: =
4. 논리 연산자: and, or, not, xor
5. 기타 연산자: 
	is: 양쪽의 피연산자가 모두 같으면 true(결과가 나온다), 아니면 false(결과가 나오지 않는다)
    between A and B: A보다는 크거나 같고, B보다 작거나 같으면 true 아니면 false
    in: 매개변수로 전달된 리스트에 값이 존재하면 true 아니면 false
    like: 패턴으로 문자열을 검색하여, 값이 존재하면 true 아니면 false

*/

# member 테이블에서 아이디가 'apple'인 유저의 아이디, 이름, 성별을 출력해 보자
select userid, name, gender from member where userid='apple';

# 성별이 남자인 유저를 모두 출력(단, 컬럼도 모두 출력)
select name from member where gender='남자';
select * from member where gender='남자';

# point가 200이상인 유저의 아이디, 이름, 포인트 출력
select userid, name, point from member where point>=200;


# 로그인
select userid, name from member where userid='apple' and userpw='aaaa'; #로그인
select userid, name from member where userid='apple' and userpw='1234'; #로그인 실패

# point가 200이상인 유저의 아이디, 이름, 포인트 출력
select userid, name, point from member where point >=200;
select userid, name, point from member where point between 200 and 1000;
select userid, name, point from member where point >= 200 and point<=1000;

# 아이디가 apple, orange, melon 인 유저의 모든 컬럼 출력
select * from member where userid='apple' or userid='orange' or userid ='melon';
select * from member where userid in ('apple', 'orange', 'melon');

# 아이디가 a로 시작하는 유저의 모든 컬럼 출력
select * from member where userid like 'a%';

# 아이디가 a로 끝나는 유저의 모든 컬럼 출력
select * from member where userid like '%a';

# 아이디가 a를 포함하는 유저의 모든 컬럼 출력
select * from member where userid like '%a%';

select * from words;
# words 테이블에서 level이 null인 테이블을 출력
select * from words where lev = 'null'; #X
select * from words where lev = null; #X
select * from words where lev is null; #O 
select * from words where lev is not null; #O

/* 데이터베이스의 데이터는 정렬되지 않음
정렬하기 (order by)
*/

#유저 테이블에서 아이디로 오름차순해서 모든 컬럼 출력하기
select * from member order by userid;
select * from member order by userid asc; #똑같다 
select * from member order by userid desc; #내림차순

# 유저 테이블에서 포인트로 내림차순하여 아이디, 이름, 포인트, 가입날짜 순으로 출력
select userid, name, point, regdate from member order by point desc;
 
insert into member (userid, userpw, name, hp, email, gender, ssn1, ssn2, zipcode, address1, address2, address3)
values('avocado', 'vvvv', '김아보', '010-8888-8888', 'avocado@avocado.com', '남자', '991111','1111111', '6666','아보시','카도구','아카동');
select * from member;

# 유저 테이블에서 포인트순으로 오름차순하고 포인트가 같다면 userid로 내림차순
select * from member order by point asc, userid desc;

# 유저 테이블에서 여성 회원을 포인트 순으로 내림차순하고, 포인트가 같다면 userid로 내림차순
select * from member where gender='여자' order by point desc, userid desc;

#limit(일부 로우만 출력하고 싶을 때)
#limit 가져올 로우의 개수, limit 시작로우(인덱스), 가져올 로우의 개수

select * from member;
select * from member limit 3;
select * from member limit 2, 2; #시작로우 2, 가져올 로우 2개

#member 테이블의 회원을 포인트 순으로 내림차순하고, 포인트가 같다면 userid로 오름차순한 뒤, 탑 3 출력
select * from member order by point desc, userid asc limit 3;


# 그룹
# select 그룹을 맺은 컬럼 또는 집계함수 from 테이블 group by 필드명
# select 그룹을 맺은 컬럼 또는 집계함수 from 테이블 group by 필드명 having 조건
# 집게함수: count(), sum(), avg(), min(), max()
select * from member group by gender; #error
select gender from member group by gender;
select gender from member group by gender having gender='남자';
select count(*) from member; #데이터가 6개이므로
select * from member;
select count(userid) from member; #null이 없는 컬럼, primary key가 제약 조건으로 걸려 있는 컬럼을 선택하는 걸 추천
select count(zipcode) from member; #null이 있는 컬럼 - 빼고 세 주어서 원하는 값이 나오지 않을 수도 있다
select count(userid) as cnt from member; # 다른 언어간의 호환을 위해 as를 쓰는 것이 좋다

# 유저 테이블에서 성별로 그룹을 나누고, 각 그룹에 인원이 몇 명인지 출력해 보자...
select gender, count(userid) as '인원' from member group by gender;
select gender, count(userid) as '인원' from member group by gender having gender ='여자';

# 유저 테이블에서 포인트가 150인 유저 중에서 성별로 그룹을 나눠 각 그룹의 포인트 평균을 구하고, 평균의 포인트가 200이상인 성별을 알아보자
# 단 성별이 남여 모두 나온다면 포인트가 높은 성별을 우선으로 출력
#select 필드명 1, 필드명 2 ...from 테이블 명 [where 조건] [group by 필드명] [having 조건] [order by 필드명 [asc, desc]] limit [숫자,] 숫자

select gender, avg(point) as avg from member where point>=150 group by gender having avg>=200 order by avg desc;
select gender, avg(point) as mmm from member where point>=150 group by gender having mmm>=200 order by mmm desc;