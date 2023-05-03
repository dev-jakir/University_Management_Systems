Drop Database UniversityDB

Go

Create database UniversityDB

on
(
    Name = 'UniversityDB_data_1',
	Filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.HRIDOYSQLSERVER\MSSQL\DATA
	            \UniversityDB_data_1.mdf',
    Size = 25mb,
	Maxsize = 100mb,
	filegrowth = 5%
)
Log on
(    
    Name = 'UniversityDB_Log_1',
	Filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.HRIDOYSQLSERVER\MSSQL\Log
	            \UniversityDB_Log_1.ldf',
    Size = 2mb,
	Maxsize = 50mb,
	filegrowth = 1%
)
Go

Use UniversityDB

go
Drop Table Teacher
Create table Teacher
(
  TeacherId int primary key not null,
  Teachername varchar(50),
  Teachercontact varchar(50)
);
Go
Create table Student
(  
    StudentId int primary key not null,
	StudentName varchar(50),
	Studentcontact varchar(50),
	DateofBirth date
)
Go
Drop table Semester
Create table Semester
(
   SemesterId int primary key not null,
   Semestername varchar(50),
)
Go
Create table Subject
(  
   SubjectId int primary key not null,
   subjectname varchar(50)
)
Go
Drop table studentData
Create Table StudentData
( 
    TeacherId int references Teacher(TeacherId),
	StudentId int references student(studentId),
	SemesterId int references semester(SemesterId),
    SubjectId int references subject(subjectId)
);
Go
--------------Clustered Index----------
Create Clustered Index Index_StudentData
on StudentData(StudentId)

Go
   -------Nonclusted Index---------
Create nonclustered index Index_Student
on Student(StudentName)

go
     -------Scular Value Funcation--------

create FUNCTION udf_SpringSemister_Student
()
Returns int
as Begin
Declare @SemesterStudent int;
Set @SemesterStudent = (select count (st.Semesterid) as [NoofSubject]
from StudentData st join semester se on St.SemesterId = se.SemesterId
where se.Semestername = 'Spring'group by st.SemesterId,se.Semestername)
    RETURN @semesterStudent;
	end;

	
	--------Table Value Fanction--------
Create Function FN_Tablevalue
()
Returns Table
Return
(   
    Select Se.semestername, Count(st.StudentName) as noofsubject, su.subjectname
From studentData SD
join Student st on SD.StudentId = st.studentId
join Semester Se on SD.SemesterId = Se.semesterId
join Subject Su on SD.SubjectId = Su.subjectId
group by Se.Semestername,Su.subjectname
having Subjectname = 'civil'
);
	-------View------
Create view vw_studentInfo as
Select distinct st.studentname,squery.noofsubject
from student st,
(select count(SD.subjectId) as noofsubject
from studentData SD
join Student st on sd.StudentId = st.StudentId
Group by st.StudentName,SD.StudentId)as squery

Go
   -------------Tigger--------
Create Trigger dbo. Tri_InsteadofUpdate_SUbject
On dbo.StudentData
Instead of Update
AS
Begin
Declare @TeacherId int, @studentId int,@SemesterId int,
@SubjectId int
Select @TeacherId = inserted.TeacherId,
       @StudentId = inserted.StudentId,
	   @SemesterId = inserted.SemesterId,
	   @SubjectId = inserted.SubjectId
From inserted
If UPDATE(SubjectId)
Begin
Raiserror('SubjectId cannot be ubdate.', 16,1)
Rollback
end
Else
Begin
Update[StudentData]
set SubjectId = @subjectId
Where StudentId = @studentId
End
Update studentdata set SubjectId = 5 where studentid = 1

Go
  ----------Store procedure---------

  Create proc SpSubject
  as
  select * from Subject
  Go
  select * from Subject
  execute Spstudent

Go
--------SpInsert-------
Create proc SpInsertSubject
@SubjectId int,
@subjectName varchar(50)
as
Insert into Subject(SubjectId,subjectname)
Values(@SubjectId,@subjectName)
go
execute SpInsertSubject
execute SpInsertSubject '6','Phython'

Go
---------SpUpdate------
Create proc SpUpdateSubject
@subjectId int,
@SubjectName varchar(50)
as
Update Subject set subjectname = @SubjectName
Where SubjectId = @subjectId
Go
Execute SpUpdateSubject '6','Bangla' 

Go

   --------SpDelet--------
Create Proc SpDeletSubject
@SubjectId int
as
Delete from Subject Where SubjectId = @SubjectId
Go
Execute SpDeletSubject '6'

Go

    ---------Sp without Parameters---------
Create proc Spwithoutprameters
as
select 1
go
execute Spwithoutprameters

Go
---------Sp with Parameters--------
create proc SpwithParameters
(
@inparameter int,
@result int out
)
As 
Begin
   Select @result =(@inparameter * @inparameter);
End;
Declare @res int;
exec SpwithParameters @inparameter = 5, @result = @res output;
select @res as 'Square value'

Go
-----------MERGE-------
create table Subjects_merge
(
SubjectID int primary key not null, 
SubjectName varchar (30)
)
PRINT('successfully created');
go
------- MERGE--------
MERGE INTO dbo.Subject as S
USING dbo.Subjects_merge as SUBJ
        ON S.SubjectID = SUBJ.SubjectID
WHEN MATCHED THEN
    UPDATE SET
      S.SubjectName = SUBJ.SubjectName
      WHEN NOT MATCHED THEN 
      INSERT (SubjectID, SubjectName)
      VALUES (SUBJ.SubjectID, SUBJ.SubjectName);