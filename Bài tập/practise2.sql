-- 1, Connect to your database account
-- 2, Open the our website and open the second practise
-- 3, Drop all tables that you have created
-- 4, Create table presented on the slide 1
-- 5, Solve tasks 1 and 2 presented on the slide 2

-- PL/SQL - procedural extension of SQL language in ORACLE

-- blocks of commands
-- block of commands can contain:
-- 1, SQL commands
-- 2, Messages on the screen
-- 3, Exceptions
-- 4, Variables
-- 5, Transactions

-- Task 1: Insert one student into table student in block of commands
BEGIN
  insert into student (login, fname, lname, tallness) values ('abc123', 'John', 'Smith', 172);
END;

-- Task 2: Task 1 + message that student was successfully inserted
SET SERVEROUTPUT ON;
BEGIN
  insert into student (login, fname, lname, tallness) values ('abc124', 'John', 'Smith', 172);
  DBMS_OUTPUT.PUT_LINE('Student was successfully inserted');
END;

-- Task 3: Task 2 + message that student was not successfully inserted (in the case of error)
SET SERVEROUTPUT ON;
BEGIN
  insert into student (login, fname, lname, tallness) values ('abc124', 'John', 'Smith', 172);
  DBMS_OUTPUT.PUT_LINE('Student was successfully inserted');
EXCEPTION
  WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('Student was not successfully inserted');
END;

-- Task 4: Task 3 + usage of variables
-- add variables for fname, lname and tallness and use them in insert command
SET SERVEROUTPUT ON;
DECLARE
  v_login char(6);
BEGIN
  v_login := 'abc126';
  insert into student (login, fname, lname, tallness) values (v_login, 'John', 'Smith', 172);
  DBMS_OUTPUT.PUT_LINE('Student with login ' || v_login || ' was successfully inserted');
EXCEPTION
  WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('Student was not successfully inserted');
END;

-- Task 5: Task 4 + messages like
-- Student with login ABC and name CCC was successfully inserted
-- Student with login ABC and name CCC was not successfully inserted

-- Task 6: Task 5 + second way of declaration of the variables
-- change the declaration of all variables
SET SERVEROUTPUT ON;
DECLARE
  v_login Student.login%type;
BEGIN
  v_login := 'abc126';
  insert into student (login, fname, lname, tallness) values (v_login, 'John', 'Smith', 172);
  DBMS_OUTPUT.PUT_LINE('Student with login ' || v_login || ' was successfully inserted');
EXCEPTION
  WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('Student was not successfully inserted');
END;

-- Task 7: Task 6 + usage of rowtype
SET SERVEROUTPUT ON;
DECLARE
  v_student Student%rowtype;
BEGIN
  v_student.login := 'abc126';
  insert into student (login, fname, lname, tallness) values (v_login, 'John', 'Smith', 172);
  DBMS_OUTPUT.PUT_LINE('Student with login ' || v_login || ' was successfully inserted');
EXCEPTION
  WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('Student was not successfully inserted');
END;

e.g.
v_count integer;
v_count := select count(*) from student; -- it will not work, because select is not a function
select count(*) into v_count from student; -- it works

v_fname Student.fname%type;
v_lname Student.lname%type;
select fname into v_fname, lname into v_lname from student where login='abc123';

v_student Student%rowtype;
select * into v_student from student where login = 'abc123';

!! data types of variables have to same as data types of selected columns
!! select has to return ONLY 1 RECORD

-- Task 8: Task 5 or 6 or 7 + tallness will be set to tallness of the student with login abc123

-- Task 9: Insert 3 students, but all of them or none of them have to be inserted
SET SERVEROUTPUT ON;
BEGIN
  insert into student (login, fname, lname, tallness) values ('bbb111', 'John', 'Smith', 172);
  insert into student (login, fname, lname, tallness) values ('bbb222', 'John', 'Smith', 172);
  insert into student (login, fname, lname, tallness) values ('abc123', 'John', 'Smith', 172);
  DBMS_OUTPUT.PUT_LINE('Students were successfully inserted');
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('Students were not successfully inserted');
     ROLLBACK;
END;

-- TRANSACTION
-- COMMIT -- saves all changes into the database
-- ROLLBACK -- moves database to the state at the beginning