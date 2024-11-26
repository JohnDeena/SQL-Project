/*TASK 1 
    1) DATABASE CREATION - Creating 3 tables : StudentInfo, CoursesInfo, EnrollmentInfo. */

create table StudentInfo(
STU_ID int PRIMARY KEY,
STU_NAME varchar(25),
DOB date,
PHONE_NO varchar(15),
EMAIL_ID varchar(50),
ADDRESS varchar(100));

create table CoursesInfo(
Course_ID int PRIMARY KEY,
COURSE_NAME varchar(50),
COURSE_INSTRUCTOR_NAME varchar(50));

create table EnrollmentInfo(
ENROLLMENT_ID VARCHAR(15),
STU_ID INT,
COURSE_ID INT,
ENROLL_STATUS varchar(20) CHECK (ENROLL_STATUS IN ('Enrolled', 'NOT Enrolled')) NOT NULL,
FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(Course_ID));

-- 2) Data Creation: Insert sample data in 3 tables

INSERT INTO StudentInfo(STU_ID,STU_NAME,DOB,PHONE_NO,EMAIL_ID,ADDRESS)
Values
(1, 'Naveen', '1997-02-13', '9988776654', 'naveen25@csk.com', 'New street, Pallavaram'),
(2, 'Prajwel', '1994-08-20', '8787878787', 'prajwel25@csk.com', 'middle street, medavakkam'),
(3, 'Vishal', '1996-03-18', '1818181818', 'vishal18@rcb.com', 'old street, madhavaram'),
(4, 'Hari', '1990-12-12', '3456789012', 'hari90@police.com', 'high street, OMR'),
(5, 'Deena', '2000-01-01', '9020002000', 'johndeena@canadain.com', 'modern street, Guduvancherry'),
(6, 'Giji', '1999-08-09', '7654321123', 'Gjthemodel@llm.com', 'model street, mudichur');

INSERT INTO CoursesInfo(COURSE_ID,COURSE_NAME,COURSE_INSTRUCTOR_NAME)
VALUES
(101, 'SQL', 'Jayaselan'),
(102, 'PYTHON', 'Ramesh'),
(103, 'JAVA', 'Vinayagam');

INSERT INTO EnrollmentInfo(ENROLLMENT_ID,STU_ID,COURSE_ID,ENROLL_STATUS)
VALUES
('D51', 1, 101, 'Enrolled'),
('D51', 1, 102, 'Enrolled'),
('D52', 2, 101, 'Enrolled'),
('D53', 3, 102, 'Enrolled'),
('D54', 4, 102, 'Enrolled'),
('D55', 5, 103, 'Enrolled'),
('D56', 6, 103, 'Enrolled');


/* 3. Retrieve the Student Information :
       a) Query to retrive student details, such as student name, contact informations, Enrollment status. */

Select
s.STU_ID as Student_Name,
s.PHONE_NO as Phone_number,
S.EMAIL_ID as Email_id,
S.ADDRESS as Address,
E.ENROLL_STATUS as Enrollment_status,
C.course_name as course_name
From
StudentInfo s
JOIN
EnrollmentInfo e ON s.STU_ID = e.STU_ID
JOIN
CoursesINFO c ON e.course_id = c.course_id;

-- b) Query to retrive a list of courses in which a specific student is enrolled.

select s.stu_name, c.course_name
from
CoursesInfo c
join
EnrollmentInfo e ON c.Course_id = e.Course_id
join
StudentInfo s on s.STU_ID = e.STU_ID
WHERE
s.Stu_name = 'Naveen';

-- c) Query to retrive a list of course information, including course name, instructor information.

Select course_name, Course_instructor_name as instructors_name
from CoursesInfo;

-- d) Query to retrive a list of course information for specific course.

select Course_name, Course_id, Course_instructor_name as instructor_name from CoursesInfo
where course_name = 'JAVA';

-- e) Query to retrive a list of course information for multiple courses.

select Course_name, Course_id, Course_instructor_name as instructor_name from CoursesInfo;

/* f) Test the queries to ensure accurate retrieval of student information.
      (execute the queries and verify the results against the expected output.) */
      
select * from StudentInfo
where stu_name IN ('Prajwel', 'Giji');  -- Sample testing with IN operator.

select * from StudentInfo
where stu_name = 'prajwel' OR 'giji';   -- Sample testing with OR operator.

/* 4) Reporting and Analytics (Using joining queries)
     a) Write a query to retrieve the number of students enrolled in each course. */

Select c.COURSE_NAME, COUNT(s.STU_NAME) AS student_count
FROM
StudentInfo s
JOIN enrollmentInfo e on s.stu_id = e.stu_id
Join coursesinfo c on c.Course_ID = e.Course_ID
WHERE
e.ENROLL_STATUS = 'Enrolled'
Group by c.Course_name;

-- b) Query to retrieve list of students enrolled in a specific course.

Select s.STU_NAME as Students_enrolled_in_SQL
FROM
StudentInfo s
JOIN enrollmentInfo e on s.stu_id = e.stu_id
Join coursesinfo c on c.Course_ID = e.Course_ID
WHERE
e.ENROLL_STATUS = 'Enrolled' and e.course_id = '101';

-- c) Query to retrieve count of students enrolled for each instructor.

Select c.course_instructor_name, count(s.stu_name) as Students_enrolled
from
StudentInfo s
JOIN enrollmentInfo e on s.stu_id = e.stu_id
join coursesinfo c on e.Course_id = c.course_id
where
e.ENROLL_STATUS = 'Enrolled'
Group by c.course_instructor_name;

-- d) Query to retrieve the list of students who are enrolled in multiple courses.

select s.STU_Name as Students_enrolled_in_multiple_courses
from
CoursesInfo c
JOIN EnrollmentInfo e on c.Course_ID = e.Course_ID
JOIN StudentInfo s on s.STU_ID = e.STU_ID
where ENROLL_STATUS = 'Enrolled'
GROUP BY
s.STU_NAME
Having
count(*) > 1;

-- e) Query to retrieve the list of courses that have the highest no. of enrolled students(arrange from highest to lowest):

Select c.Course_name, Count(s.Stu_name) as Enrolled_students_Count
FROM
CoursesInfo c
Join EnrollmentInfo e on c.Course_ID = e.Course_ID
JOIN StudentInfo s on s.STU_ID = e.STU_ID
where ENROLL_STATUS = 'Enrolled'
group by
c.Course_name
order by
Enrolled_students_Count;




select * from StudentInfo;
select * from CoursesInfo;
select * from EnrollmentInfo;
