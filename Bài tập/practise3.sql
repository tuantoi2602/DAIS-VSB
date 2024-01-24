-- Task 6: Task 5 + second way of declaration of the variables
-- change the declaration of all variables
SET SERVEROUTPUT ON;
DECLARE
  v_login Student.login%type;
  v_fname Student.fname%type;
  v_lname Student.lname%type;
  v_tallness Student.tallness%type;
BEGIN
  v_login := 'abc126';
  v_fname := 'John';
  v_lname := 'Smith';
  v_tallness := 175;
  insert into student (login, fname, lname, tallness) values (v_login, v_fname, v_lname, v_tallness);
  DBMS_OUTPUT.PUT_LINE('Student with login ' || v_login || ' was successfully inserted');
EXCEPTION
  WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('Student was not successfully inserted');
END;

-- stored methods. three types of stored methods:
-- 1, Stored procedure - executed by user, procedure does not have return value
-- 2, Stored function - executed by user, function has return value
-- 3, Stored trigger - executed by system

-- 10, Change task 7 to stored procedure
CREATE OR REPLACE PROCEDURE InsertStudent
AS
-- DECLARE - we do not write declare in stored methods
  v_login Student.login%type;
  v_fname Student.fname%type;
  v_lname Student.lname%type;
  v_tallness Student.tallness%type;
BEGIN
  v_login := 'abc126';
  v_fname := 'John';
  v_lname := 'Smith';
  v_tallness := 175;
  insert into student (login, fname, lname, tallness) values (v_login, v_fname, v_lname, v_tallness);
  DBMS_OUTPUT.PUT_LINE('Student with login ' || v_login || ' was successfully inserted');
EXCEPTION
  WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('Student was not successfully inserted');
END;

SET SERVEROUTPUT ON;
EXECUTE InsertStudent;

BEGIN
  InsertStudent;
END;

-- TASK 11, Change task 10 to parametrical stored procedure
CREATE OR REPLACE PROCEDURE InsertStudent2
(
  p_login Student.login%type,
  p_fname Student.fname%type,
  p_lname Student.lname%type,
  p_tallness Student.tallness%type)
AS
BEGIN
  insert into student (login, fname, lname, tallness) values (p_login, p_fname, p_lname, p_tallness);
  DBMS_OUTPUT.PUT_LINE('Student with login ' || v_login || ' was successfully inserted');
EXCEPTION
  WHEN OTHERS THEN
     PRINTOUT('Student was not successfully inserted');
END;

EXECUTE InsertStudent2('kjk123', 'Jon', 'Smith', 175);

-- TASK 12, Create procedure PRINTOUT with the parameter p_text, that will replace function DBMS_OUTPUT.PUT_LINE
-- Use procedure PRINTOUT in task 11
CREATE OR REPLACE PROCEDURE PRINTOUT
(
  p_text  VARCHAR2 -- in the case of parameters and return values, we do not declare the length
)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE(p_text);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR!');
END;

-- TASK 13, Rewrite task 11 to function
-- instead of printing messages, it will return 'ok'/'error'
CREATE OR REPLACE FUNCTION FInsertStudent
(
  p_login Student.login%type,
  p_fname Student.fname%type,
  p_lname Student.lname%type,
  p_tallness Student.tallness%type)
RETURN VARCHAR2  
AS
BEGIN
  insert into student (login, fname, lname, tallness) values (p_login, p_fname, p_lname, p_tallness);
  RETURN 'ok';
EXCEPTION
  WHEN OTHERS THEN
     RETURN 'error';
END;

EXECUTE FInsertStudent('kjk123', 'Jon', 'Smith', 175); -- it will not work, because we do not use return value
EXECUTE PRINTOUT(FInsertStudent('kjk123', 'Jon', 'Smith', 175));

DECLARE
  v_result varchar2(10);
BEGIN
  v_result := FInsertStudent('kjk123', 'Jon', 'Smith', 175);
  PRINTOUT(v_result);
END;

-- TASK 14, If the function returns 'ok', print out message 'Student was inserted', otherwise
-- print out message 'Student was not inserted'
DECLARE 
    v_result varchar2(10);
BEGIN
    v_result := FInsertStudent('kjk123', 'Jon', 'Smith', 175);
    PRINTOUT(v_result);
    IF v_result = 'ok' THEN
        PRINTOUT('Student was inserted');
    ELSE
        PRINTOUT('Student was not inserted');
    END IF;
END;

-- conditions
IF condition THEN
  ..
ELSIF condition THEN
  ..
ELSE
  ..
END IF;

-- TASK 15, Extend tasks 13&14 as follows:
-- function will return 3 values: 'ok', 'error', 'full' - if you have more than 5 students in table student
-- in the case, that function will return full, you will printout message 'Class is full !!!'
CREATE OR REPLACE FUNCTION F_InsertStudent2

-- Parameters in wich the user will assign values
(
  p_login       student.login%TYPE,
  p_fname       student.fname%TYPE,
  p_lname       student.lname%TYPE,
  p_tallness    student.tallness%TYPE
)  

-- What type of variable will return
RETURN VARCHAR2

AS 

  v_studentCount  INTEGER;

BEGIN
  
  SELECT COUNT(student.login) INTO v_studentCount FROM student;
  
  PRINTOUT(v_studentCount);
  
  IF v_studentCount < 5 THEN

    INSERT INTO student(login, fname, lname, tallness)
    VALUES (p_login, p_fname, p_lname, p_tallness);
    
    RETURN 'OK';
  
  ELSE
    
    RETURN 'FULL';
  
  END IF;

EXCEPTION 

  WHEN OTHERS THEN          
    RETURN 'ERROR!';

END;

-- TEST FUNCTION
DECLARE 
    v_result varchar2(10);
BEGIN
    v_result := F_InsertStudent2('kjk123', 'Jon', 'Smith', 175);
    PRINTOUT(v_result);
    IF v_result = 'OK' THEN
      PRINTOUT('Student was inserted');
    ELSIF v_result = 'FULL' THEN
      PRINTOUT('class is full');
    ELSE
      PRINTOUT('Student was not inserted');
    END IF;
END;

-- HOMEWORK
-- TASK 16, Create table Teacher (login, fname, lname, department varchar(50))
-- Create procedure StudentBecomeTeacher with parameters p_login, p_department
-- select fname, lname from student with login = p_login
-- insert student into the table teacher
-- delete student from table student
-- print out message, if student became teacher or not
-- procedure has to be solved as transaction