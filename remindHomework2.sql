use ogclass1;

-- favorite-subject테이블 생성
create table favorite_subject
(
    subject_no int primary key auto_increment,
    subject_name varchar(255) not null unique
);

-- class테이블 생성
create table class(
    student_no int primary key auto_increment,
    student_name varchar(255) not null,
    gender varchar(5) not null check ( gender in ('남','여') ),
    github_id varchar(255) not null unique ,
    email varchar(255) not null unique ,
    mbit varchar(10), -- null 허용
    subject_no int,
    foreign key (subject_no) references favoirte_subject (subject_no)
                  );

describe class; -- 테이블 구성확인

-- favorite_subject 데이터 삽입
insert into favoirte_subject (subject_name)
values ('spring'),
       ('jdbc'),
       ('java'),
       ('mysql'),
       ('mybatis'),
       ('react');

describe favoirte_subject;

select * from favoirte_subject
order by subject_no;

insert into class (student_name, gender, github_id, email,mbit,subject_no)
values ( '박태근','남','Ohgiraffers-bear','bear.ohfiraffers@gmail.com','ENFJ',1),
         ('지동현','남','Bring2it2on','yjkl0516@gmail.com','eeee',2),
         ('김강현','남','kimkinghyeon','modan8189@gmail.com','eeee',4),
         ( '이득규','남','MANTISKYU','asdaron44@gmail.com','eeee',3),
         ('홍주연','남','juyeon99','juyeon0806@gmail.com','eeee',4),
         ( '양혜연','여','yanghyeyeon','yhy4058@gmail.com','eeee',1),
         ( '이규섭','남','LKS9616','lks609591@gmail.com','eeee',3),
         ( '전유안','남','euuuuuuan','euan.may24@gmail.com','ENFP',5),
         ( '박성은','여','seongeun223','jklun080921@gmail.com','ISTJ',3),
         ('박하얀','여','parkhayarn','s0224y92@gmail.com','INFP',1),
         ( '위성민','남','wdh970616','wdh970616@gmail.com','eeee',1),
         ( '박효찬','남','qwes5674','qwes5674@gmail.com','eeee',3),
         ('이의정','여','himisterlee','lejlej100418@gmail.com','eeee',3),
         ('권은혜','여','dmsgpk237','a01027947353@gmail.com','ENFP',3),
         ( '배하은','여','Heun0420','usialeta@gmail.com','eeee',3),
         ('강연진','여','kangyeonjin','yeonjin917n.n@gmail.com','eeee',1),
         ('강진영','남','weed97','weed9935@gmail.com','eeee',3);

select * from class
order by student_no;

update class set mbti = '' where mbti ='eeee';
update class set mbti = null where mbti ='eeee';
