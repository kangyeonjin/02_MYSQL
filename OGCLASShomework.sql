create database ogclass_db;  -- db생성
show databases;  -- 전체 db목록조회
grant all privileges on ogclass_db.* to 'ohgiraffers'@'%';  -- 권한부여
show grants for 'ohgiraffers'@'%'; -- 권한 조회
use ogclass_db; -- user_db사용

create table if not exists favorite_subject_table  -- 생성
(
    subject_no int auto_increment primary key,
    subject_name varchar(255) not null unique
);

# alter table favorite_subject_table add subject_name varchar(255) not null;

create table if not exists class_table  -- 생성
(
    student_no int auto_increment primary key,
    student_name varchar(255) not null,
    gender varchar(5) not null check (gender IN ('남','여')), -- 남, 여 중 하나만 선택 되도록함
    github_id varchar(255) not null unique,
    email varchar(255) not null unique,
    mbti varchar(10),
    subject_no int,
    foreign key (subject_no)
        references favorite_subject_table (subject_no)
);

show tables;
describe class_table;

select * from favorite_subject_table;

# insert into favorite_subject_table(subject_name)
# values ('spring'),('jdbc'),('mysql'),('java'),('mybatis');

# insert into favorite_subject_table(subject_no, subject_name) VALUES (1,'spring');

insert into class_table
(student_no, student_name, gender, github_id, email, mbti, subject_no)
values (1, '박태근','남','Ohgiraffers-bear','bear.ohfiraffers@gmail.com','ENFJ',1),
       (2, '지동현','남','Bring2it2on','yjkl0516@gmail.com','eeee',2),
       (3, '김강현','남','kimkinghyeon','modan8189@gmail.com','eeee',4),
       (4, '이득규','남','MANTISKYU','asdaron44@gmail.com','eeee',3),
       (5, '홍주연','남','juyeon99','juyeon0806@gmail.com','eeee',4),
       (6, '양혜연','여','yanghyeyeon','yhy4058@gmail.com','eeee',1),
       (7, '이규섭','남','LKS9616','lks609591@gmail.com','eeee',3),
       (8, '전유안','남','euuuuuuan','euan.may24@gmail.com','ENFP',5),
       (9, '박성은','여','seongeun223','jklun080921@gmail.com','ISTJ',3),
       (10, '박하얀','여','parkhayarn','s0224y92@gmail.com','INFP',1),
       (11, '위성민','남','wdh970616','wdh970616@gmail.com','eeee',1),
       (12, '박효찬','남','qwes5674','qwes5674@gmail.com','eeee',3),
       (13, '이의정','여','himisterlee','lejlej100418@gmail.com','eeee',3),
       (14, '권은혜','여','dmsgpk237','a01027947353@gmail.com','ENFP',3),
       (15, '배하은','여','Heun0420','usialeta@gmail.com','eeee',3),
       (16, '강연진','여','kangyeonjin','yeonjin917n.n@gmail.com','eeee',1),
       (17, '강진영','남','weed97','weed9935@gmail.com','eeee',3);

select * from class_table;
