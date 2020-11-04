use ProgressTracker_V6;

delimiter €€

drop procedure if exists NewStudent €€
drop procedure if exists SingleStudent €€
drop procedure if exists StudentList €€
drop procedure if exists UpdateStudent €€
drop procedure if exists DeleteStudent €€

drop procedure if exists NewSchool €€
drop procedure if exists SingleSchool €€
drop procedure if exists SchoolList €€
drop procedure if exists UpdateSchool €€
drop procedure if exists DeleteSchool €€

drop procedure if exists NewCourse €€
drop procedure if exists SingleCourse €€
drop procedure if exists CourseList €€
drop procedure if exists UpdateCourse €€
drop procedure if exists DeleteCourse €€

-- ======================================= - oo0oo - ======================================= --
create procedure NewStudent(first_name varchar(55), last_name varchar(55), date_of_birth date, starting_on int)
begin
		insert into Students (firstname,lastname,dob,startSemester)
    values (first_name,last_name,date_of_birth,starting_on);
end €€

create procedure SingleStudent(student_id int)
begin
	select * from Students where studentID = student_id;
end €€

create procedure StudentList()
begin
	select * from Students;
end €€

create procedure UpdateStudent(student_id int, first_name varchar(55), last_name varchar(55), date_of_birth date, starting_on int)
begin
		update Students
	set firstname = first_name, startSemester = starting_on
    where dob = date_of_birth;
end €€

create procedure DeleteStudents(student_id int)
begin
	delete from Students where studentID = student_id;
end €€

-- ======================================= - oo0oo - ======================================= --
create procedure NewSchool(school_name varchar(75))
begin
	insert into Schools(schoolName) values (school_name);
end €€

create procedure SingleSchool(school_id int)
begin
	select * from schools where schoolID = school_id;
end €€

create procedure SchoolList()
begin
	select * from schools;
end €€

create procedure UpdateSchool(school_id int, school_name varchar(75))
begin
		update Schools
	set schoolName = school_name
    where schoolID = school_id;
end €€

create procedure DeleteSchool(school_id int)
begin
	delete from Schools where schoolID = school_id;
end €€

-- ======================================= - oo0oo - ======================================= --
create procedure NewCourse(course_number char(15), course_name varchar(75), course_credits int)
begin
		insert into courses(courseNumber,courseName,courseCredits)
    values (course_number,course_name,course_credits);
end €€

create procedure SingleCourse(course_number char(15))
begin
	select * from courses where courseName = course_number;
end €€

create procedure CourseList()
begin
	select * from courses;
end €€

create procedure UpdateCourse(course_number char(15), course_name varchar(75), course_credits int)
begin
		update courses
	set courseName = course_name, courseCredits= course_credits
    where courseNumber = course_number;
end €€

create procedure DeleteCourse(course_number char(15))
begin
	delete from courses where courseNumber = couse_number;
end €€

delimiter ;
