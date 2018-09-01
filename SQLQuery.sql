------------------------------------------------------------------------
--CREATE TABLES
------------------------------------------------------------------------
CREATE TABLE ADMIN_CREDENTIALS(
aLoginID varchar(50) PRIMARY KEY,
aPassword varchar(20));

select * from ADMIN_CREDENTIALS;

CREATE TABLE ADMIN(
adminID varchar(10) PRIMARY KEY, 
adminName varchar(40), 
aLoginID varchar(50) FOREIGN KEY REFERENCES ADMIN_CREDENTIALS (aLoginID));

select * from ADMIN;

CREATE TABLE NON_CIS_FACULTY(
empID varchar(10) PRIMARY KEY,
empName varchar(40),
department varchar(10), 
empEmail varchar(50),
adminID varchar(10) FOREIGN KEY REFERENCES ADMIN(adminID));

select * from NON_CIS_FACULTY;

CREATE TABLE MEMBER_CREDENTIALS (
mLoginID varchar(50) PRIMARY KEY,
mPassword varchar(20));

select * from MEMBER_CREDENTIALS;

CREATE TABLE MEMBER (
memberID varchar(10) PRIMARY KEY,
mName varchar(40),
membertype varchar(20) NOT NULL,
mLoginID varchar(50),
createdBy varchar(10)
foreign key (mLoginID) references MEMBER_CREDENTIALS(mLoginID),
foreign key (createdBy) references ADMIN(adminID));

ALTER TABLE MEMBER
ADD CHECK (membertype in ('cis_faculty','cis_student','other_dept'));

select * from MEMBER;

create table ROLE_TYPE (
roleID varchar(10) PRIMARY KEY,
roleDescription varchar(20));

select * from ROLE_TYPE;

create table SURVEY (
surveyID  int PRIMARY KEY,
sName  varchar(100), 
sDescription varchar(500),
url varchar(150),
creationDate date,
goBackOption char(3) CHECK(goBackOption = 'Yes' or goBackOption = 'No')); 

select * from SURVEY;    

create table SURVEY_ROLE (
memberID varchar(10) foreign key references MEMBER(memberID),
surveyID int foreign key references SURVEY(surveyID),
roleID varchar(10) foreign key references ROLE_TYPE(roleID));

select * from SURVEY_ROLE;

create table QUESTION_TYPE (
typeID tinyint primary key,
typeName varchar(20));

select * from QUESTION_TYPE;

create table QUESTION (
questionID smallint primary key,
surveyID int foreign key references SURVEY(surveyID),
qDescription varchar(500),
typeId tinyint foreign key references QUESTION_TYPE(typeID));

select * from QUESTION;

create table ANSWER_CHOICE (
answerID smallint primary key,
questionID smallint foreign key references QUESTION(questionID),
aDescription varchar(500));

select * from ANSWER_CHOICE;

create table RESPONDENT (
respEmail varchar(50) primary key,
fName varchar(20),
lName varchar(20),
gender varchar(1) CHECK (gender in ('M','F')),
occupation varchar(20));

select * from RESPONDENT;

create table EMAIL_LIST (
surveyID int, respEmail varchar(50),
pwd  varchar(20),  
addedBy varchar(10) 
primary key(surveyID,respEmail)
foreign key (surveyId) references SURVEY(surveyID),
foreign key (addedBy) references MEMBER(memberId),
foreign key(respEmail) references RESPONDENT(respEmail));

select * from EMAIL_LIST;

create table ANSWER (
rAnswerID int IDENTITY(1,1) primary key,
questionID smallint foreign key references QUESTION(questionID),
respEmail varchar(50) foreign key references RESPONDENT(respEmail),
startTime datetime,
endTime datetime,
totalTime time);

select * from ANSWER;

create table MULTI_SELECTION_ANSWER(
rAnswerID int,
choiceID smallint
primary key(rAnswerID,choiceID));

select * from MULTI_SELECTION_ANSWER;

create table SINGLE_SELECTION_ANSWER(
rAnswerID int,
choiceID smallint
primary key(rAnswerID));

select * from SINGLE_SELECTION_ANSWER;

create table TEXT_ANSWER(
rAnswerID int,
text varchar(500)
primary key(rAnswerID));

select * from TEXT_ANSWER;

------------------------------------------------------------------------
--ADD DATA TO THE TABLES
------------------------------------------------------------------------

INSERT INTO ADMIN_CREDENTIALS VALUES('mary.kom@xyz.com','adf@345');
INSERT INTO ADMIN_CREDENTIALS VALUES('mark.gates@xyz.com','vkj$456');
INSERT INTO ADMIN_CREDENTIALS VALUES('phillip.rogers@xyz.com','dbv@086');
INSERT INTO ADMIN_CREDENTIALS VALUES('martha.stewart@xyz.com','890@nsc');
INSERT INTO ADMIN_CREDENTIALS VALUES('jake.gallen@xyz.com','jhghc%shv');
INSERT INTO ADMIN_CREDENTIALS VALUES('mini.brown@xyz.com','vblo@56437');

select * from ADMIN_CREDENTIALS;

INSERT INTO ADMIN VALUES('m.kom','mary kom','mary.kom@xyz.com');
INSERT INTO ADMIN VALUES('m.gates','mark gates','mark.gates@xyz.com');
INSERT INTO ADMIN VALUES('p.rogers','phillip rogers','phillip.rogers@xyz.com');
INSERT INTO ADMIN VALUES('m.stewart','martha stewart','martha.stewart@xyz.com');
INSERT INTO ADMIN VALUES('j.gallen','jake gallen','jake.gallen@xyz.com');
INSERT INTO ADMIN VALUES('m.brown','mini brown','mini.brown@xyz.com');

select * from ADMIN;

INSERT INTO NON_CIS_FACULTY VALUES('100001','jim corbett','LITERATURE','jim.corbett@xyz.com','m.kom');
INSERT INTO NON_CIS_FACULTY VALUES('100002','bill maher','ARTS','bill.maher@xyz.com','m.gates');
INSERT INTO NON_CIS_FACULTY VALUES('100003','rachel black','LITERATURE','rachel.black@xyz.com','m.brown');
INSERT INTO NON_CIS_FACULTY VALUES('100004','bill green','ACCOUNTS','bill.green@xyz.com','m.kom');
INSERT INTO NON_CIS_FACULTY VALUES('100005','minoca ed','BUSINESS','minoca.ed@xyz.com','m.gates');
INSERT INTO NON_CIS_FACULTY VALUES('100006','edward codd','BUSINESS','edward.codd@xyz.com','m.brown');

select * from NON_CIS_FACULTY;

INSERT INTO MEMBER_CREDENTIALS VALUES('martin.luther@abc.com','asd&431');
INSERT INTO MEMBER_CREDENTIALS VALUES('benny.dayal@abc.com','yut%766');
INSERT INTO MEMBER_CREDENTIALS VALUES('jeff.archer@xyz.com','hnj1234');
INSERT INTO MEMBER_CREDENTIALS VALUES('jim.corbett@abc.com','fghi@45');
INSERT INTO MEMBER_CREDENTIALS VALUES('bill.maher@xyz.com','hjkkl*167');
INSERT INTO MEMBER_CREDENTIALS VALUES('ayn.rand@abc.com','ghj*78909');

select * from MEMBER_CREDENTIALS;

INSERT INTO MEMBER VALUES('90000001','martin luther','cis_faculty','martin.luther@abc.com','m.kom');
INSERT INTO MEMBER VALUES('90000002','benny dayal','cis_faculty','benny.dayal@abc.com','m.gates');
INSERT INTO MEMBER VALUES('90000003','jeff archer','cis_student','jeff.archer@xyz.com','m.brown');
INSERT INTO MEMBER VALUES('90000004','jim corbett','other_dept','jim.corbett@abc.com','m.kom');
INSERT INTO MEMBER VALUES('90000005','bill maher','other_dept','bill.maher@xyz.com','m.gates');
INSERT INTO MEMBER VALUES('90000006','ayn rand','cis_student','ayn.rand@abc.com','m.brown');

select * from MEMBER;

INSERT INTO ROLE_TYPE VALUES('10001','create');
INSERT INTO ROLE_TYPE VALUES('10002','modify');
INSERT INTO ROLE_TYPE VALUES('10003','delete ');
INSERT INTO ROLE_TYPE VALUES('10004','review');

select * from ROLE_TYPE;

INSERT INTO SURVEY VALUES('500000001','Course Survey','Student satisfaction with course offered','https://course.survey','1/23/2017','Yes');
INSERT INTO SURVEY VALUES('500000002','Facilities Survey','To find facilities related student reponse','https://facilities.survey','1/23/2017','No');
INSERT INTO SURVEY VALUES('500000003','Gender Survey','To find gender profile of students','https://gender.survey','1/23/2017','No');
INSERT INTO SURVEY VALUES('500000004','Faculty Survey','Faculty Job Satisfaction Survey','https://faculty.survey','1/23/2017','Yes');
INSERT INTO SURVEY VALUES('500000005','Age Survey','To find age profile of students','https://age.survey','1/23/2017','Yes');

select * from SURVEY;

INSERT INTO SURVEY_ROLE VALUES('90000001','500000001','10001');
INSERT INTO SURVEY_ROLE VALUES('90000002','500000002','10001');
INSERT INTO SURVEY_ROLE VALUES('90000001','500000002','10004');
INSERT INTO SURVEY_ROLE VALUES('90000004','500000001','10002');
INSERT INTO SURVEY_ROLE VALUES('90000002','500000001','10003');
INSERT INTO SURVEY_ROLE VALUES('90000002','500000002','10002');
INSERT INTO SURVEY_ROLE VALUES('90000003','500000002','10003');
INSERT INTO SURVEY_ROLE VALUES('90000003','500000001','10004');
INSERT INTO SURVEY_ROLE VALUES('90000004','500000001','10004');
INSERT INTO SURVEY_ROLE VALUES('90000003','500000002','10004');

select * from SURVEY_ROLE;

INSERT INTO QUESTION_TYPE VALUES('1','Text');
INSERT INTO QUESTION_TYPE VALUES('2','MultiSelection');
INSERT INTO QUESTION_TYPE VALUES('3','SingleSelection');

select * from QUESTION_TYPE;

INSERT INTO QUESTION VALUES('101','500000001','What is your age?','1');
INSERT INTO QUESTION VALUES('102','500000001','Which courses did you complete this semester?','2');
INSERT INTO QUESTION VALUES('103','500000001','Would you like to take more such courses?','3');
INSERT INTO QUESTION VALUES('104','500000001','Do you have any suggestions?','1');
INSERT INTO QUESTION VALUES('105','500000002','What facilities do you most commonly use at the college?','2');
INSERT INTO QUESTION VALUES('106','500000002','Do you think the facilitiea are adequate?','3');
INSERT INTO QUESTION VALUES('107','500000002','What more do you expect to be provided as facilities','1');

select * from  QUESTION;

INSERT INTO ANSWER_CHOICE VALUES(7001,'102','programming');
INSERT INTO ANSWER_CHOICE VALUES(7002,'102','statistics');
INSERT INTO ANSWER_CHOICE VALUES(7003,'102','dbms');
INSERT INTO ANSWER_CHOICE VALUES(7004,'102','IS strategy');
INSERT INTO ANSWER_CHOICE VALUES(7005,'103','yes');
INSERT INTO ANSWER_CHOICE VALUES(7006,'103','no');
INSERT INTO ANSWER_CHOICE VALUES(7007,'105','library');
INSERT INTO ANSWER_CHOICE VALUES(7008,'105','computer lab');
INSERT INTO ANSWER_CHOICE VALUES(7009,'105','printers and scanners');
INSERT INTO ANSWER_CHOICE VALUES(7010,'105','study rooms');
INSERT INTO ANSWER_CHOICE VALUES(7011,'105','conference rooms');
INSERT INTO ANSWER_CHOICE VALUES(7012,'106','yes');
INSERT INTO ANSWER_CHOICE VALUES(7013,'106','no');

select * from ANSWER_CHOICE;

INSERT INTO RESPONDENT VALUES('mark.job@abc.com','mark','job','M','student');
INSERT INTO RESPONDENT VALUES('steve.banon@abc.com','steve','banon','M','student');
INSERT INTO RESPONDENT VALUES('donald.duck@xyz.com','donald','duck','M','student');
INSERT INTO RESPONDENT VALUES('julia.missy@xyz.cof','julia ','missy','F','student');
INSERT INTO RESPONDENT VALUES('lisa.ray@xyz.cof','lisa','ray','F','student');
INSERT INTO RESPONDENT VALUES('jackie.fernandez@xyz.cof','jackie ','fernandez','F','student');

select * from RESPONDENT;

SET IDENTITY_INSERT Survey_CIS9340.dbo.ANSWER ON;

INSERT INTO ANSWER(respEmail,rAnswerID,questionID,startTime,endTime,totalTime) 
VALUES('mark.job@abc.com','1','101','2/20/2017  8:00:00','2/20/2017  8:01:27','01:27');
INSERT INTO ANSWER(respEmail,rAnswerID,questionID,startTime,endTime,totalTime)
 VALUES('mark.job@abc.com','2','102','2/20/2017  8:02:00','2/20/2017  8:02:45','0:00:45');
INSERT INTO ANSWER(respEmail,rAnswerID,questionID,startTime,endTime,totalTime)
 VALUES('mark.job@abc.com','4','103','2/20/2017  8:04:00','2/20/2017  8:04:40','0:00:40');
INSERT INTO ANSWER(respEmail,rAnswerID,questionID,startTime,endTime,totalTime)
 VALUES('mark.job@abc.com','5','104','2/20/2017  8:05:00','2/20/2017  8:06:00','0:01:00');
INSERT INTO ANSWER(respEmail,rAnswerID,questionID,startTime,endTime,totalTime)
 VALUES('steve.banon@abc.com','6','105','2/20/2017  9:15:00','2/20/2017  9:16:45','0:01:45');
INSERT INTO ANSWER(respEmail,rAnswerID,questionID,startTime,endTime,totalTime)
 VALUES('steve.banon@abc.com','7','106','2/20/2017  9:17:00','2/20/2017  9:18:00','0:01:00');
INSERT INTO ANSWER(respEmail,rAnswerID,questionID,startTime,endTime,totalTime)
 VALUES('steve.banon@abc.com','8','107','2/20/2017  9:18:02','2/20/2017  9:19:00','0:00:58');

 select * from ANSWER;

INSERT INTO MULTI_SELECTION_ANSWER VALUES('2','7001');
INSERT INTO MULTI_SELECTION_ANSWER VALUES('2','7002');
INSERT INTO MULTI_SELECTION_ANSWER VALUES('2','7003');

INSERT INTO MULTI_SELECTION_ANSWER VALUES('6','7007');
INSERT INTO MULTI_SELECTION_ANSWER VALUES('6','7008');
INSERT INTO MULTI_SELECTION_ANSWER VALUES('6','7009');
INSERT INTO MULTI_SELECTION_ANSWER VALUES('6','7010');

select * from MULTI_SELECTION_ANSWER;

INSERT INTO SINGLE_SELECTION_ANSWER VALUES('4','7005');
INSERT INTO SINGLE_SELECTION_ANSWER VALUES('7','7013');

select * from SINGLE_SELECTION_ANSWER;

INSERT INTO TEXT_ANSWER VALUES('1','25');
INSERT INTO TEXT_ANSWER VALUES('5',NULL);
INSERT INTO TEXT_ANSWER VALUES('8','More food options in the canteen');

select * from TEXT_ANSWER;

INSERT INTO EMAIL_LIST VALUES('500000001','mark.job@abc.com','lol@123','90000001');
INSERT INTO EMAIL_LIST VALUES('500000002','steve.banon@abc.com','lol@234','90000003');
INSERT INTO EMAIL_LIST VALUES('500000001','donald.duck@xyz.com','lol@345','90000001');
INSERT INTO EMAIL_LIST VALUES('500000001','julia.missy@xyz.cof','lol@456','90000001');
INSERT INTO EMAIL_LIST VALUES('500000002','lisa.ray@xyz.cof','lol@567','90000003');
INSERT INTO EMAIL_LIST VALUES('500000002','jackie.fernandez@xyz.cof','lol@678','90000003');

select * from EMAIL_LIST;

------------------------------------------------------------------------
--QUERIES ON THE TABLES
------------------------------------------------------------------------
-- 1. Search the email list for survey: 500000001
select * from EMAIL_LIST where surveyID = '500000001';

-- 2. Find the number of question for each survey
select surveyID, count(*) as Question_Count
from QUESTION
group by surveyID;

-- 3. Search for non-CIS Faculty who do not have access to the system
select ncf.empID, ncf.empName, empEmail, mem.memberID
from NON_CIS_FACULTY as ncf left join MEMBER as mem
on ncf.empEmail = mem.mLoginID
where memberID is NULL;

-- 4. Search the types of question for survey: 500000002
select surveyId, qDescription, typeName
from QUESTION as Ques join QUESTION_TYPE as Ques_Type
on Ques.typeID = Ques_Type.typeID
where surveyID = '500000002';

-- 5. Find members who created the survey list for each survey

select distinct surveyID, m.mName as Email_List_Creator 
from EMAIL_LIST join MEMBER as m
on EMAIL_LIST.addedBy = m.memberID;

-- 6. Displaying Members and names of Admins who created those members. Also displaying the surveys created by those members
select MEMBER.memberID, MEMBER.mName as Member_Name, SURVEY.sName as Survey_Name, ADMIN.adminName as Mem_Created_By
from MEMBER join ADMIN
on MEMBER.createdBy = ADMIN.adminID
left join SURVEY_ROLE
on MEMBER.memberID = SURVEY_ROLE.memberID and roleID = '10001'
left join SURVEY 
on SURVEY.surveyID = SURVEY_ROLE.surveyID;

-- 7. Creating a view for Survey with the description for member roles

create view SURVEY_MEMBER_ROLE as (
select s.surveyId as Survey_Id, s.sName as Survey_Name, s.sDescription as Survey_Description, 
m.memberID as Member_ID, m.mName as Member_Name, r.roleDescription as Role_Description
from SURVEY as s join SURVEY_ROLE as sr
on s.surveyID = sr.surveyID
join MEMBER as m
on m.memberID = sr.memberID
join ROLE_TYPE as r
on r.roleID = sr.roleID);

select * from SURVEY_MEMBER_ROLE order by survey_id,role_description;

-- 8. Creating a view for Members who are creators and the members who review them

create view MEMBER_REVIEWER as (
select CREATOR.surveyid, CREATOR.Creator, REVIEWER.Reviewer from
(select distinct surveyid, mName as Creator
from MEMBER, SURVEY_ROLE, ROLE_TYPE
where MEMBER.memberID = SURVEY_ROLE.memberID
and SURVEY_ROLE.roleID = '10001') as CREATOR,

(select distinct surveyid, mName as Reviewer
from MEMBER, SURVEY_ROLE, ROLE_TYPE
where MEMBER.memberID = SURVEY_ROLE.memberID
and SURVEY_ROLE.roleID = '10004') as REVIEWER
where CREATOR.surveyId = REVIEWER. surveyId
);

select * from MEMBER_REVIEWER order by surveyid;

-- 9. a sub query of 3 tables showing SurveyName, Question description, Respondent's email and what were the respondent's answers.
select T2.respEmail, s.sName, T2.qDescription, T2.aDescription from Survey as s,
	(select q.surveyID, q.qDescription, T1.aDescription, T1.respEmail from Question as q,
		(select msa.choiceId, msa.rAnswerID, a.questionID, a.respEmail, ac.aDescription from MULTI_SELECTION_ANSWER as msa, ANSWER as a, 
		ANSWER_CHOICE as ac
		where msa.rAnswerID = a.rAnswerID and msa.choiceId = ac.answerId and a.questionId = ac.questionId
		UNION
		select ssa.choiceId, ssa.rAnswerID, a.questionID, a.respEmail, ac.aDescription from SINGLE_SELECTION_ANSWER as ssa, ANSWER as a,
		ANSWER_CHOICE as ac
		where ssa.rAnswerID = a.rAnswerID and ssa.choiceId = ac.answerId and a.questionId = ac.questionId) T1
	where q.questionID = T1.questionID) T2
where s.surveyID = T2.surveyID;

-- 10. A join and subquery of 4 tables giving the total time required to complete a survey for each repondent 
-----with survey and respondent names.

select T3.Survey_Name, m.mName as Survey_Created_By, T3.Respondent_Name, T3.Respondent_Email, T3.Required_Time
from SURVEY_ROLE as sr, MEMBER as m,
	(select T2.surveyID, T2.sName as Survey_Name,  r.fName + '' + r.lName as Respondent_Name, T2.respEmail as Respondent_Email,
	 T2.Required_Time from Respondent as r,
		(select T1.surveyID, s.sName, T1.respEmail, T1.Required_Time from Survey as s,
			(select Ques.surveyID, Resp.respEmail,
				RIGHT('0' + CAST(SUM(DATEDIFF(SECOND, StartTime, EndTime)) / 3600 AS VARCHAR),2) + ':' +
				RIGHT('0' + CAST((SUM(DATEDIFF(SECOND, StartTime, EndTime)) / 60) % 60 AS VARCHAR),2) + ':' +
				RIGHT('0' + CAST(SUM(DATEDIFF(SECOND, StartTime, EndTime)) % 60 AS VARCHAR),2) as Required_Time
				from Question as Ques join Answer as Ans
				on Ques.questionID = Ans.questionID
				join Respondent as Resp
				on Resp.respEmail = Ans.respEmail
				group by Ques.surveyID, Resp.respEmail) as T1
		where s. surveyID = T1.surveyID) as T2
	where r.respEmail = T2.respEmail) as T3
where sr.surveyID = T3.surveyID and m.memberID = sr.memberID;

