-------------------------- SET UP
drop table if exists orders
GO

create table orders (
  login char(6),
  item int,
  pieces int,
  otime date
)
GO 

INSERT INTO orders VALUES ('nor001', 1, 10, '2019-02-27')
INSERT INTO orders VALUES ('sta001', 1, 5, '2019-02-25')
INSERT INTO orders VALUES ('swa005', 10, 1, '2019-02-20')
INSERT INTO orders VALUES ('cha100', 1, 8, '2019-02-25')
GO



-------------------------- READ UNCOMMITTED

--T1
BEGIN TRAN
INSERT INTO orders VALUES ('lee040', 5, 50, '2019-02-24')
--T2 executes commands 1.0 and 1.1

--T1
ROLLBACK TRANSACTION

--T2 executes again select 1.1
--what we can see in transaction T2?

-------------------------- READ COMMITTED 1

--T1
BEGIN TRAN
INSERT INTO orders VALUES ('lee040', 5, 50, '2019-02-24')
--T2 executes commands 2.0 and 2.1

--T1
ROLLBACK TRANSACTION

--T2 executes again select 2.1
--what we can see in transaction T2?
--what is the reason of different behaviour?

-------------------------- READ COMMITTED 2

--T1
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRAN
SELECT AVG(pieces) FROM orders


--T2 execute commands 2.2


--T1 
SELECT AVG(pieces) FROM orders
--Is the result of the select correct?

--T1
ROLLBACK TRANSACTION

--Execute SET UP of table Orders (commands drop,create and insert mentioned at the top)

-------------------------- READ COMMITTED SNAPSHOT

--T1 is neccessary to close t2.sql before execution of following command
ALTER DATABASE bac027 SET READ_COMMITTED_SNAPSHOT ON

--T1
BEGIN TRAN
INSERT INTO orders VALUES ('lee040', 5, 50, '2019-02-24')

--T2 execute commands 3.0 and 3.1
--What is the difference between READ COMMITTED and READ COMMITTED SNAPSHOT?

--T1
ROLLBACK TRANSACTION

--T1 is neccessary to close t2.sql before execution of following command
ALTER DATABASE bac027 SET READ_COMMITTED_SNAPSHOT OFF

-------------------------- REPEATABLE READ 1

--T1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
SELECT AVG(pieces) FROM orders

--T2 executes command 4.0

--T1
SELECT AVG(pieces) FROM orders
--How is transaction T1 consistency assured at this isolation level?

--T1
ROLLBACK TRANSACTION

--Execute SET UP of table Orders (commands drop,create and insert mentioned at the top)

-------------------------- REPEATABLE READ 2

--T1
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
SELECT * FROM orders WHERE item BETWEEN 5 AND 10

--T2 executes command 4.1

--T1
SELECT * FROM orders WHERE item BETWEEN 5 AND 10
--How is the situation in this example different from REPEATABLE READ 1?
--What is the cause of the difference? How do we call this phenomenon?

--T1
ROLLBACK TRANSACTION

--Execute SET UP of table Orders (commands drop,create and insert mentioned at the top)


-------------------------- SERIALIZABLE

--Try example REPEATABLE READ 2 with isolation level SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

-------------------------- SNAPSHOT 1

--T1 is neccessary to close t2.sql before execution of following command
ALTER DATABASE bac027 SET READ_COMMITTED_SNAPSHOT ON
ALTER DATABASE bac027 SET ALLOW_SNAPSHOT_ISOLATION ON

--T2 execute commands 5.0 and 5.1

--T1
SET TRANSACTION ISOLATION LEVEL SNAPSHOT
BEGIN TRAN
SELECT * FROM orders

--T2 execute command 5.2

--T1
SELECT * FROM orders
--Why do we not see a confirmed T2 transaction now?

--T1
COMMIT TRAN

--T1
SELECT * FROM orders
--Why do we see it now?


-------------------------- SNAPSHOT

--Try example REPEATABLE READ 2 with isolation level SNAPSHOT
--Compare the behaviour of SQL Server with the previous two tests
