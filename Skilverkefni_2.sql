-- 1:
drop trigger if exists restrictors_insert;
delimiter $$
create trigger restrictors_insert
before insert on Restrictors
for each row
begin
	if(new.courseNumber = new.restrictorID) then
		signal sqlstate '45000'
		set message_text = "Do not set a course that precedes or coincides with itself.";
	end if;
end $$
delimiter ;

insert into restrictors(courseNumber,restrictorID,restrictorType)values('GAGN2VG','GAGN2VG',1);
    
-- 2:
drop trigger if exists restrictors_update;
delimiter $$
create trigger restrictors_update
before update on Restrictors
for each row
begin
	if(new.courseNumber = new.restrictorID) then
		signal sqlstate '45000'
        set message_text = 'Ekki setja áfanga sem undanfara eða samfara af sjálfum sér.';
	end if;
end $$
delimiter ;

update restrictors set courseNumber = restrictorID where courseNumber='GAGN2VG';

-- 3:
delimiter $$
drop procedure if exists AStudentsCredit $$

create procedure AStudentsCredit(in varStudentID int)
begin
	select concat_ws(' ', students.firstName,student.lastName) as "Full Name",
	tracks.trackName as "Track Name", sum(courses.courseCredits) as "Total Credits"
	from courses join trackcourses join registration join students join tracks
	where courses.courseNumber = trackcourses.courseNumber
	and trackcourses.courseNumber = registration.courseNumber
	and students.studentID = registration.studentID
	and students.studentID = varStudentID
	and registration.passed = true;
end $$
delimiter ;

call AStudentsCredit(1);

-- 4:
delimiter $$
drop procedure if exists AddStudent $$
    
create procedure AddStudent(in varFirstName varchar(25), in varLastName varchar(25), in varDOB date, in varStartSemester int, in varTrackID int, in varDate date)
begin
	declare varStudentID int;
    insert into Students(firstName,lastName,dob,startSemester)values(varFirstName,varLastName,varDOB,varStartSemester);
    set varStudentID = (select studentID from Students order by studentID desc limit 1);
    call AddMandatoryCourses(varStudentID,varTrackID,varDate,varStartSemester);
end $$
delimiter ;

call AddStudent("Mateusz","Kuzniewski","2001-02-05",1,7,'2020-08-25'); select * from students; select * from registration;

delimiter $$
drop procedure if exists AddMandatoryCourses $$
    
create procedure AddMandatoryCourses(in varStudentID int, in varTrackID int, in varDate date, in varSemester int)
begin
	declare varCourseNumber char(20);
	declare done int default false;
	declare ACursor cursor
		for select courseNumber from trackcourses  where mandatory = 1 and trackID = varTrackID;
	declare continue handler for not found set done = true;
	open ACursor;
	read_loop: loop
		fetch ACursor into varCourseNumber;
		if done then
			leave read_loop;
		end if;
		insert into Registration(studentID,trackID,courseNumber,registrationDate,passed,semesterID)values(varStudentID,varTrackID,varCourseNumber,varDate,false,varSemester);
	end loop;
	close ACursor;
end $$
delimiter ;

call AddMandatoryCourses(1,7,'2020-08-25',6); select * from registration;
	
delimiter $$
drop procedure if exists StudentRegistration $$
    
create procedure StudentRegistration(in varStudentID int, in varTrackID int, in varCourseNumber char(10), in varDate date, in varPassed bool, in varSemester int)
begin
	insert into Registration(studentID,trackID,courseNumber,registrationDate,passed,semesterID)values(varStudentID,varTrackID,varCourseNumber,varDate,varPassed,varSemester);
end $$
delimiter ;

call StudentRegistration(1,7,'FORR202','2020-08-25',false,6);
