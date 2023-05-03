insert into Teacher(TeacherId,TeacherName,Teachercontact)
Values (1,'Md Shumsul Alum','01711577545'),
       (2,'Md Shumsul Islam','01772675750'),
	   (3,'Md Mizanur Rahman','01716456854'),
	   (4,'Md Nurul Islam','01711257584'),
	   (5,'Mehidy Hassan','01711558754')
Go
Insert Into student(StudentId,StudentName,Studentcontact,DateofBirth)
 Values (1,'Md Tahomin','01739551429','2000/01/02'),
        (2,'Md Akter','01845797997','2001/01/01'),
		(3,'Md Nizum','01580816671','2002/05/02'),
		(4,'Md Alfaz','01799861494','1999/01/20'),
		(5,'Md Rafi','01755874987','2002/01/05'),
		(6,'Koli Akter','01739528751','1999/01/01'),
		(7,'Umma Kulsum','01739551447','2002/01/9'),
		(8,'Md Suzat','01739558741','1998/01/10'),
		(9,'Rahyan Akter','01739551584','1999/05/20'),
		(10,'Md Arafat','01739551489','1998/03/08'),
		(11,'Md Nahid','01739551009','1998/01/12'),
		(12,'Md Shamol','01739551489','2001/01/25'),
	    (13,'Md Taitanik','01739551487','2002/01/12')

Go
Insert into Semester (SemesterId,Semestername)
Values (1,'Summer'),
       (2,'winter'),
       (3,'Fall'),
       (4,'Spring')

Go
Insert into Subject(SubjectId,subjectname)
Values (1,'CSc'),
       (2,'EEE'),
	   (3,'Telecommunation'),
	   (4,'Teastial'),
	   (5,'Civil')
Go
Insert into studentData (TeacherId,StudentId,SemesterId,SubjectId)
Values (1,1,1,1),(1,2,1,1),(2,3,1,1),(2,4,2,2),(2,5,2,2),
        (3,6,2,2),(3,7,3,3),(3,8,3,3),(4,9,3,3),(4,10,4,4),
		(4,11,4,4),(4,12,1,5),(1,13,2,5)

Go
		------joining  Group by having--------
Select Se.semestername, Count(st.StudentName) as noofsubject, su.subjectname
From studentData SD
join Student st on SD.StudentId = st.studentId
join Semester Se on SD.SemesterId = Se.semesterId
join Subject Su on SD.SubjectId = Su.subjectId
group by Se.Semestername,Su.subjectname
having Subjectname = 'civil'

Go
     --------Joining where clouse-------
Select * from StudentData SD
join Teacher t on Sd.TeacherId = T.TeacherId
join Student S on Sd.StudentId = S.StudentId
join semester Sm on SD.SemesterId = Sm.SemesterId
Join Subject su on Sd.SubjectId = su.SubjectId
Where subjectname = 'Csc'

Go
     ---------Sub-Query----------
Select distinct st.studentname,squery.noofsubject
from student st,
(select count(SD.subjectId) as noofsubject
from studentData SD
join Student st on sd.StudentId = st.StudentId
Group by st.StudentName,SD.StudentId)as squery

Go
       ----------Case Function---------
Select su.subjectName,
case
when su.subjectname = 'CSC' Then 'Good subject'
When su.subjectname = 'EEE' Then 'Best Subject'
else 'Normal'
End as comands
from StudentData SD
join Subject su on SD.SubjectId = Su.SubjectId

Go
      ----------Cast convert-------
Select cast('18-january-2023' as date
select Datetime = CONVERT(Datetime,'18-January-2023 10:00:10.00')
Update StudentData set SubjectId = 5 where studentId = 1

Go
    ---------------CTE------------

With CTE_Student_Age (Name,DateofBirth,CurrentDate,Age) As
( 
   Select S.studentname,
          S.DateofBirth,
		  GETDATE(),
		  YEAR(GETDATE()) - YEAR( S.DateofBirth)
		  From Student S)
   Select Name DateofBirth,
   AGe
   From CTE_Student_Age
   Where
   AGe <= 30;
Go
--------select Top------
   SELECT TOP 5 StudentID, StudentName
FROM Student
ORDER BY StudentName DESC;

    --------select into statement---------
Select * Into Studentcopy from student

select * from Studentcopy
   go
   ---------Insert--------
Insert into studentcopy 
values(14,'Md Fahim','01728257316','1999/05/23')

Go
-----------Update statement--------
Update Studentcopy set studentname = 'Rohim' where studentId = 14
Go
    ---------delete Queary
Delete from Studentcopy where StudentName = 'Rohim'

go
       --------like Operator---------
SELECT studentname from Student
WHERE StudentName LIKE '%m';

SELECT studentname from Student
WHERE StudentName LIKE 'm%';

SELECT studentname from Student
WHERE StudentName LIKE '%m%';

---------Union join------

SELECT subjectname FROM subject
UNION
SELECT studentName FROM Student
order by subjectname;

go
------------Union All with where--------

SELECT subjectname FROM subject
where subjectName = 'Csc'
UNION all
SELECT studentName FROM Student
where studentName = 'Md Akter'
order by subjectname;

Go
    --------Between----------
SELECT StudentName FROM Student
WHERE studentid BETWEEN 1 AND 1;

