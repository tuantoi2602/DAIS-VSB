-- 1, Create function LoginExists with parameter p_login
-- Function will return true, if student with specified login exists
-- Otherwise, it will return false
create or replace FUNCTION LoginExists( p_login IN student.login%TYPE) 
RETURN boolean 
AS
  v_count integer;
BEGIN
  select count(*) into v_count from student where login = p_login;
  if (v_count = 1) THEN
    return true;
  else  
    return false;
  end if;  
END;

-- 2, Create procedure InsertStudent5 with parameters p_fname, p_lname, p_tallness
-- Procedure will insert student into table Student
-- Login will be created from first 3 letters of lname and '000'
-- SUBSTR(string, start index, length)
CREATE OR REPLACE PROCEDURE InsertStudent5
(
  p_fname         student.fname%TYPE,
  p_lname         student.lname%TYPE,
  p_tallness      student.tallness%TYPE
)
AS
  v_login         student.login%TYPE;
BEGIN
  v_login := SUBSTR(p_lname, 1, 3) || '000'; 
  INSERT INTO student(login, fname, lname, email, tallness)
  VALUES (v_login, p_fname, p_lname, NULL, p_tallness);
  PRINTOUT('Student with login ' ||v_login|| ' inserted successfully!');
EXCEPTION
  WHEN OTHERS THEN
    PRINTOUT('ERROR!');
END;

-- 3, Extend task 2 to increment number in login until it will find login that does not exist
loop                                                   for variable IN 1..100 loop
  exit when condition is satisfied;
end loop;                                              end loop;    

CREATE OR REPLACE PROCEDURE InsertStudent6
(
  p_fname         student.fname%TYPE,
  p_lname         student.lname%TYPE,
  p_tallness      student.tallness%TYPE
)
AS
  v_login         student.login%TYPE;
  v_number integer;
BEGIN
  v_number := 0;
  loop
    v_login := SUBSTR(p_lname, 1, 3) || TO_CHAR(v_number); 
    exit when not LoginExists(v_login);
    v_number := v_number + 1;
  end loop;

  INSERT INTO student(login, fname, lname, email, tallness)
  VALUES (v_login, p_fname, p_lname, NULL, p_tallness);
  PRINTOUT('Student with login ' || v_login || ' inserted successfully!');
EXCEPTION
  WHEN OTHERS THEN
    PRINTOUT('ERROR!');
END;

SET SERVEROUTPUT ON;
execute InsertStudent6('John', 'Smith', 175);

-- 4, Modify task 3 to use for cycle
CREATE OR REPLACE PROCEDURE InsertStudent6
(
  p_fname         student.fname%TYPE,
  p_lname         student.lname%TYPE,
  p_tallness      student.tallness%TYPE
)
AS
  v_login         student.login%TYPE;
  v_number integer;
BEGIN
  for v_number IN 0..999 loop
    v_login := SUBSTR(p_lname, 1, 3) || TO_CHAR(v_number); 
    exit when not LoginExists(v_login);
  end loop;

  INSERT INTO student(login, fname, lname, email, tallness)
  VALUES (v_login, p_fname, p_lname, NULL, p_tallness);
  PRINTOUT('Student with login ' || v_login || ' inserted successfully!');
EXCEPTION
  WHEN OTHERS THEN
    PRINTOUT('ERROR!');
END;

-- 5, Homework
-- logins have to have 6 characters (number has to have 3 digits)
-- if it will not find login that does not exists, print out the error

-- 6, Add attribute isTall into table Student, NULL, CHAR(1)
ALTER TABLE student
ADD IsTall CHAR(1) NULL;

-- 7, Create procedure IsStudentTall with parameter p_login
-- Procedure will set attribute isTall for student with p_login to '1', if his tallness > average tallness
-- Otherwise it will set it to '0'
CREATE OR REPLACE PROCEDURE IsStudentTall
(
  p_login       student.login%TYPE
)
AS 
  v_studentTallness       student.tallness%TYPE;
  v_AVGstudentTallness    student.tallness%TYPE;
BEGIN 
  SELECT AVG(student.tallness) INTO v_AVGstudentTallness FROM student;
  SELECT tallness INTO v_studentTallness FROM student WHERE p_login = login;
  
  IF v_studentTallness > v_AVGstudentTallness THEN
    UPDATE student SET istall = '1' WHERE p_login = login;
  ELSE
    UPDATE student SET istall = '0' WHERE p_login = login;
  END IF;
EXCEPTION
  WHEN OTHERS THEN 
    PRINTOUT('ERROR!');
END;

-- 8, Create procedure AreStudentsTall without parameters
-- Procedure will go through all students and it will set them attribute isTall
-- CURSOR - structure, that can store more records - the result of the select

CREATE OR REPLACE PROCEDURE AreStudentTall
(
  p_login       student.login%TYPE
)
AS
  CURSOR all_students is select * from student;
  v_studentTallness       student.tallness%TYPE;
  v_AVGstudentTallness    student.tallness%TYPE;
BEGIN 
  SELECT AVG(student.tallness) INTO v_AVGstudentTallness FROM student;
  
  for one_student in all_students loop
     IF one_student.tallness > v_AVGstudentTallness THEN
        UPDATE student SET istall = '1' WHERE one_student.login = login;
     ELSE
        UPDATE student SET istall = '0' WHERE one_student.login = login;
     END IF;
  end loop;
  
EXCEPTION
  WHEN OTHERS THEN 
    PRINTOUT('ERROR!');
END;

-- 9, Modify task 8 to use the cycle loop

CREATE OR REPLACE PROCEDURE AreStudentTall2
(
  p_login       student.login%TYPE
)
AS
  CURSOR all_students is select * from student;
  v_studentTallness       student.tallness%TYPE;
  v_AVGstudentTallness    student.tallness%TYPE;
  one_student student%rowtype;
BEGIN 
  SELECT AVG(student.tallness) INTO v_AVGstudentTallness FROM student;
  open all_students; -- execute select and put the result of the select into cursor
  loop
     FETCH all_students into one_student; -- set next student from cursor to one_student
     exit when all_students%NOTFOUND;    -- if there is not another student in cursor, exit loop
     IF one_student.tallness > v_AVGstudentTallness THEN
        UPDATE student SET istall = '1' WHERE one_student.login = login;
     ELSE
        UPDATE student SET istall = '0' WHERE one_student.login = login;
     END IF;
  end loop;
  close all_students;
EXCEPTION
  WHEN OTHERS THEN 
    PRINTOUT('ERROR!');
END;