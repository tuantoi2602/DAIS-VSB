-- block of commands can contain:
-- 1, SQL commands
-- 2, Print outs
-- 3, Variables
-- 4, Transactions
-- 5, Exceptions
-- 6, Conditions
-- 7, Cycles
-- 8, Cursors
-- 9, Dynamic SQL

-- block of commands can be stored at database account as:
-- 1, Stored procedures
-- 2, Stored functions
-- 3, Stored triggers

CREATE OR REPLACE PROCEDURE InsertStudent10
(
  p_tablename varchar,
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


-- Dynamic SQL
-- we use in the case, when we want to call SQL command, but we do not know the name of the table/attributes 
-- in the time of compilation
-- we will create sql command as a string and we put it into some variable
-- consequently, we execute this variable by command EXECUTE IMMEDIATE

CREATE OR REPLACE PROCEDURE InsertStudent10
(
  p_tablename varchar,
  p_login Student.login%type,
  p_fname Student.fname%type,
  p_lname Student.lname%type,
  p_tallness Student.tallness%type)
AS
  v_command varchar(1000);
BEGIN
  v_command := 'insert into ' || p_tablename || '(login, fname, lname, tallness) values (''' || p_login || ''',''' || p_fname || ''',''' || p_lname || ''',' || p_tallness || ')';
--  DBMS_OUTPUT.PUT_LINE(v_command);
  EXECUTE IMMEDIATE v_command;
  DBMS_OUTPUT.PUT_LINE('Student with login ' || p_login || ' was successfully inserted');
EXCEPTION
  WHEN OTHERS THEN
     PRINTOUT('Student was not successfully inserted');
END;

SET SERVEROUTPUT ON;
EXECUTE InsertStudent10('Student', 'pop012', 'Jan', 'Popek', 175);

insert into Student(login, fname, lname, tallness) values ('pop011','Jan','Popek',175)

-- HOMEWORK
-- Create procedure CreateBackupTable with one parameter p_tablename.
-- Procedure will create the copy of the table. The name of the copy table will be p_tablename || _backup
-- The copy table will have same attributes (names and datatypes) as input table
-- Procedure will not copy data, only structure of the table

-- USE SYSTEM CATALOGUE
select * from USER_TAB_COLUMNS where table_name = 'STUDENT'

-- TRIGGERS
-- blocks of commands, that are not executed by user, but they are executed by system when some event on some object occur
-- usually, event is insert/update/delete and object is table
-- triggers are stored in the section Triggers
-- the structure of the triggers is as follows:
CREATE OR REPLACE TRIGGER trigger_name -- triggers can not have parameters neither return value
BEFORE/AFTER/INSTEAD OF event -- we define the event that will execute the triggers and also if trigger will be executed before, after of instead of this event
ON table_name -- we define object/table on which the event is executed
FOR EACH ROW -- says if the trigger will be executed once or for each affected record
DECLARE -- we have to write in the case of triggers, we can not write in the case of procedures and functions
  ... -- declaration of variables
BEGIN
  ... -- body of the trigger
  :NEW -- datatype is %ROWTYPE, we can use in the case of insert and update
  :OLD -- datatype is %ROWTYPE, we can use in the case of update and delete
END;



-- Create table Statistics with attributes operation (varchar(30), pk) and counter (integer)
-- Insert into this tables records:
-- insert/0
-- update/0
-- delete/0

Create table Statistics
(
  operation varchar(30) primary key,
  counter integer
);

insert into Statistics (operation, counter) values ('insert', 0);
insert into Statistics (operation, counter) values ('update', 0);
insert into Statistics (operation, counter) values ('delete', 0);

-- Create 3 triggers, that will count the operations over the table student
CREATE OR REPLACE TRIGGER InsertCounter
AFTER insert ON student
BEGIN
  update Statistics set counter = counter + 1 where operation = 'insert';
END;

CREATE OR REPLACE TRIGGER DeleteCounter
AFTER delete ON student
-- FOR EACH ROW
BEGIN
  update Statistics set counter = counter + 1 where operation = 'delete';
END;

insert into Student (login, fname, lname, tallness) values ('bou124', 'John', 'Bouman', 175);
select * from statistics

select * from student

delete from student where login in ('pop011','pop012','bou123');

-- Delete 3 students, when:
-- A, Trigger contains for each row
-- B, Trigger does not contain for each row

-- Replace triggers for insert, update and delete by one trigger
CREATE OR REPLACE TRIGGER OperationCounter
AFTER insert or update or delete ON student
BEGIN
  -- system variables inserting, updating and delete of the datatype boolean
  if (inserting) then
     update Statistics set counter = counter + 1 where operation = 'insert';
  end if;   
  
  if (updating) then
     update Statistics set counter = counter + 1 where operation = 'update';
  end if;   

  if (deleting) then
     update Statistics set counter = counter + 1 where operation = 'delete';
  end if;   
END;

