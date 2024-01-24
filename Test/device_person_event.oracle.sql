--======================================================
--
-- Author: Radim Baca
-- Create date: 10.9.2020
-- Description: Database script that is used in DS I tests in 2020
-- License: This code was writtend by Radim Baca and is the property of VSB - Technical university of Ostrava (VSB-TUO).
--          This code MAY NOT BE USED without the expressed written consent of VSB-TUO outside of VSB-TUO education
-- Change history:
--   2021-03-01: Oracle conversion: Michal Kratky 
--======================================================

DROP TABLE device_event;
DROP TABLE device;
DROP TABLE person;
DROP TABLE event_type;

create table device
(
	dID int GENERATED ALWAYS AS IDENTITY primary key,
	manufacturer varchar(15) not null,
	label varchar(15) not null,
	building varchar(1) not null,
	placement varchar(5),
	has_sensor int check(has_sensor = 0 or has_sensor = 1)
);

create table person 
(
	pID int primary key,
	name varchar(30) not null,
	is_extern int check(is_extern = 0 or is_extern = 1) not null,
	mother_language varchar(30) not null,
	bossID int references person(pID)
);

create table event_type
(
	tID int GENERATED ALWAYS AS IDENTITY primary key,
	event_description varchar(50) not null,
	importance int check(importance in (0,1,2)),
	is_recorded int check(is_recorded in (0,1))
);

create table device_event
(
	eID int primary key,
	dID int references device not null,
	pID int references person not null,
	tID int references event_type not null,
	startDate date,
	endDate date
);

insert into device(manufacturer, label, building, placement, has_sensor) values ('Bosh', 'S2XD-6', 'A', null, 1);
insert into device(manufacturer, label, building, placement, has_sensor) values ('Bosh', 'S3-8', 'B', '1001', 1);
insert into device(manufacturer, label, building, placement, has_sensor) values ('Bosh', 'Val-8X5', 'B', '203', 1);
insert into device(manufacturer, label, building, placement, has_sensor) values ('Bosh', 'Tr-21', 'C', null, 0);
insert into device(manufacturer, label, building, placement, has_sensor) values ('DeWalt', 'DC25', 'A', '1009', 0);
insert into device(manufacturer, label, building, placement, has_sensor) values ('DeWalt', 'CF X.5', 'B', '1001', 0);
insert into device(manufacturer, label, building, placement, has_sensor) values ('DeWalt', 'DB XS.6', 'B', '1001', 1);
insert into device(manufacturer, label, building, placement, has_sensor) values ('Ajax', 'OS 56', 'C', '301', 0);
insert into device(manufacturer, label, building, placement, has_sensor) values ('Ajax', 'OP 56 D', 'B', '203', 0);
insert into device(manufacturer, label, building, placement, has_sensor) values ('Hapatara', 'H1', 'C', '302', 0);
insert into device(manufacturer, label, building, placement, has_sensor) values ('Hapatara', 'H2-802.d', 'B', '1001', 0);


insert into person values(1, 'Petr', 0, 'Czech', null);
insert into person values(2, 'Ivana', 0, 'Czech', 1);
insert into person values(3, 'Olaf', 0, 'Norway', 1);
insert into person values(4, 'Mahdi', 0, 'Iran', null);
insert into person values(5, 'Michael', 1, 'USA', 4);
insert into person values(6, 'David', 1, 'Czech', 5);
insert into person values(7, 'Oumar', 0, 'Senegal', 3);
insert into person values(8, 'Moussa', 0, 'Senegal', 3);
insert into person values(9, 'Yuki', 0, 'Japan', 1);
insert into person values(10, 'Hiro', 0, 'Japan', 9);
insert into person values(11, 'Takumi', 0, 'Japan', 9);

insert into event_type(event_description, importance, is_recorded) values('electritity outage', 2, 1);
insert into event_type(event_description, importance, is_recorded) values('failure of machine part', 1, 0);
insert into event_type(event_description, importance, is_recorded) values('full machine failure', 2, 1);
insert into event_type(event_description, importance, is_recorded) values('planed maintenance', 0, 0);
insert into event_type(event_description, importance, is_recorded) values('planed machine update', 0, 0);
insert into event_type(event_description, importance, is_recorded) values('operator injury', 1, 0);

insert into device_event VALUES (1, 3, 8, 4, TO_DATE('2015-04-27 17:14:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-04-27 18:57:28', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (2, 3, 9, 6, TO_DATE('2015-05-03 18:35:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-05-03 18:49:38', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (3, 10, 6, 1, TO_DATE('2015-05-03 20:19:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-05-03 20:21:45', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (4, 7, 2, 3, TO_DATE('2015-05-20 21:44:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-05-20 23:44:15', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (5, 1, 10, 3, TO_DATE('2015-06-03 22:15:36', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-03 23:42:04', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (6, 4, 8, 5, TO_DATE('2015-06-18 00:27:44', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-06-18 01:06:45', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (7, 1, 2, 3, TO_DATE('2015-07-07 01:12:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-07 01:44:57', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (8, 4, 10, 3, TO_DATE('2015-07-21 03:19:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-21 03:46:13', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (9, 3, 2, 3, TO_DATE('2015-07-28 04:12:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-07-28 05:45:28', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (10, 9, 4, 4, TO_DATE('2015-08-13 04:54:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-13 06:51:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (11, 10, 1, 4, TO_DATE('2015-08-22 08:46:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-08-22 10:02:55', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (12, 5, 5, 3, TO_DATE('2015-09-02 10:13:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-02 11:54:45', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (13, 4, 3, 4, TO_DATE('2015-09-20 13:50:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-20 14:54:32', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (14, 4, 2, 2, TO_DATE('2015-09-27 14:14:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-09-27 16:04:13', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (15, 3, 2, 5, TO_DATE('2015-10-06 17:20:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-06 18:26:14', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (16, 5, 2, 3, TO_DATE('2015-10-16 18:26:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-16 20:16:22', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (17, 1, 6, 5, TO_DATE('2015-10-30 20:52:36', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-10-30 20:59:02', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (18, 6, 11, 4, TO_DATE('2015-11-12 21:06:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-12 22:59:07', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (19, 3, 1, 2, TO_DATE('2015-11-17 00:55:19', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-17 02:48:06', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (20, 3, 9, 2, TO_DATE('2015-11-23 01:19:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-23 03:00:55', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (21, 1, 9, 2, TO_DATE('2015-11-27 03:44:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-27 03:55:50', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (22, 11, 8, 2, TO_DATE('2015-11-30 06:01:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-11-30 07:53:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (23, 7, 11, 3, TO_DATE('2015-12-19 06:07:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-12-19 06:24:40', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (24, 11, 3, 2, TO_DATE('2015-12-19 06:34:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2015-12-19 07:50:39', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (25, 4, 11, 5, TO_DATE('2016-01-06 09:04:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-01-06 10:59:54', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (26, 11, 1, 4, TO_DATE('2016-01-21 12:09:56', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-01-21 13:54:04', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (27, 5, 6, 2, TO_DATE('2016-02-04 14:32:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-02-04 15:26:22', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (28, 9, 3, 5, TO_DATE('2016-02-14 17:28:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-02-14 18:00:22', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (29, 6, 1, 1, TO_DATE('2016-02-22 18:17:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-02-22 18:33:26', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (30, 11, 8, 1, TO_DATE('2016-03-08 19:04:44', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-03-08 20:07:51', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (31, 3, 4, 6, TO_DATE('2016-03-24 19:05:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-03-24 20:01:30', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (32, 7, 1, 6, TO_DATE('2016-04-12 21:52:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-04-12 22:45:43', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (33, 9, 10, 5, TO_DATE('2016-04-25 22:16:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-04-25 23:21:03', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (34, 10, 6, 5, TO_DATE('2016-05-12 01:18:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-05-12 02:58:01', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (35, 2, 8, 6, TO_DATE('2016-05-15 02:53:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-05-15 04:23:04', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (36, 4, 10, 6, TO_DATE('2016-05-28 04:30:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-05-28 06:29:11', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (37, 11, 8, 5, TO_DATE('2016-06-16 08:27:30', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-16 10:20:45', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (38, 5, 6, 3, TO_DATE('2016-06-16 11:20:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-16 11:45:23', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (39, 7, 2, 2, TO_DATE('2016-06-30 13:10:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-06-30 14:21:30', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (40, 4, 7, 4, TO_DATE('2016-07-19 14:11:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-07-19 14:27:24', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (41, 11, 7, 2, TO_DATE('2016-07-26 14:28:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-07-26 15:20:34', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (42, 11, 7, 3, TO_DATE('2016-08-02 18:09:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-08-02 19:33:56', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (43, 11, 10, 2, TO_DATE('2016-08-04 21:45:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-08-04 23:23:06', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (44, 3, 3, 4, TO_DATE('2016-08-14 22:29:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-08-15 00:28:04', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (45, 6, 10, 3, TO_DATE('2016-08-30 01:26:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-08-30 02:54:38', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (46, 6, 4, 4, TO_DATE('2016-08-31 01:57:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-08-31 02:25:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (47, 1, 11, 3, TO_DATE('2016-09-01 02:43:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-09-01 03:22:03', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (48, 8, 7, 5, TO_DATE('2016-09-05 06:33:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-09-05 07:57:30', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (49, 3, 2, 4, TO_DATE('2016-09-22 08:47:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-09-22 09:06:54', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (50, 11, 7, 3, TO_DATE('2016-10-01 10:41:14', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-10-01 12:06:27', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (51, 11, 10, 3, TO_DATE('2016-10-19 12:15:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-10-19 13:38:07', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (52, 2, 11, 5, TO_DATE('2016-10-28 12:20:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-10-28 12:58:27', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (53, 2, 4, 4, TO_DATE('2016-10-30 13:18:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-10-30 14:43:21', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (54, 7, 11, 3, TO_DATE('2016-11-14 16:20:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-11-14 16:23:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (55, 4, 6, 4, TO_DATE('2016-11-22 18:33:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-11-22 20:11:20', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (56, 2, 3, 3, TO_DATE('2016-11-24 20:39:23', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-11-24 20:52:25', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (57, 8, 11, 5, TO_DATE('2016-12-11 00:15:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-12-11 00:35:36', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (58, 10, 11, 4, TO_DATE('2016-12-11 00:58:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-12-11 02:09:23', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (59, 2, 10, 3, TO_DATE('2016-12-20 01:04:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-12-20 01:05:52', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (60, 3, 5, 1, TO_DATE('2017-01-05 03:31:52', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-01-05 04:23:09', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (61, 8, 8, 2, TO_DATE('2017-01-24 05:45:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-01-24 06:36:51', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (62, 2, 3, 6, TO_DATE('2017-02-12 06:40:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-02-12 08:10:48', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (63, 10, 11, 3, TO_DATE('2017-02-12 09:57:01', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-02-12 11:02:58', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (64, 5, 3, 5, TO_DATE('2017-02-23 12:45:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-02-23 13:52:11', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (65, 6, 5, 4, TO_DATE('2017-03-11 15:04:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-03-11 15:27:58', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (66, 7, 2, 3, TO_DATE('2017-03-27 18:07:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-03-27 19:02:58', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (67, 8, 9, 4, TO_DATE('2017-04-11 19:41:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-04-11 20:00:05', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (68, 11, 4, 2, TO_DATE('2017-04-16 21:08:27', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-04-16 22:02:26', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (69, 3, 10, 1, TO_DATE('2017-04-23 00:22:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-04-23 00:55:02', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (70, 2, 10, 2, TO_DATE('2017-05-05 03:49:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-05-05 04:02:41', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (71, 6, 10, 2, TO_DATE('2017-05-08 06:10:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-05-08 07:13:57', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (72, 7, 6, 6, TO_DATE('2017-05-24 08:57:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-05-24 10:32:07', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (73, 8, 2, 4, TO_DATE('2017-05-25 09:04:32', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-05-25 09:20:32', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (74, 3, 8, 4, TO_DATE('2017-06-05 09:11:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-06-05 09:49:37', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (75, 9, 6, 2, TO_DATE('2017-06-22 11:55:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-06-22 13:15:45', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (76, 5, 5, 5, TO_DATE('2017-06-26 15:10:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-06-26 16:39:07', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (77, 11, 5, 4, TO_DATE('2017-06-28 18:04:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-06-28 19:28:47', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (78, 7, 7, 1, TO_DATE('2017-07-08 18:12:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-07-08 19:49:22', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (79, 10, 2, 5, TO_DATE('2017-07-09 19:47:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-07-09 21:07:20', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (80, 7, 2, 6, TO_DATE('2017-07-09 20:36:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-07-09 21:16:49', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (81, 10, 10, 4, TO_DATE('2017-07-20 22:19:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-07-20 22:50:29', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (82, 1, 3, 6, TO_DATE('2017-07-28 00:04:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-07-28 01:07:08', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (83, 1, 5, 6, TO_DATE('2017-08-14 01:40:01', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-08-14 02:13:47', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (84, 6, 1, 6, TO_DATE('2017-08-29 03:30:36', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-08-29 04:04:57', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (85, 10, 7, 6, TO_DATE('2017-09-13 07:18:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-09-13 08:13:10', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (86, 8, 3, 1, TO_DATE('2017-09-16 11:08:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-09-16 11:46:54', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (87, 11, 5, 1, TO_DATE('2017-09-25 11:55:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-09-25 12:18:14', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (88, 2, 1, 5, TO_DATE('2017-09-30 15:47:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-09-30 17:08:11', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (89, 11, 6, 1, TO_DATE('2017-10-06 17:56:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-10-06 19:00:51', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (90, 3, 5, 3, TO_DATE('2017-10-15 20:08:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-10-15 21:55:50', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (91, 8, 9, 3, TO_DATE('2017-10-25 21:22:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-10-25 22:01:38', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (92, 6, 10, 6, TO_DATE('2017-11-05 00:35:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-11-05 00:36:56', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (93, 9, 4, 2, TO_DATE('2017-11-11 02:10:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-11-11 03:49:39', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (94, 8, 7, 4, TO_DATE('2017-11-22 05:54:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-11-22 07:27:55', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (95, 10, 11, 5, TO_DATE('2017-12-01 09:17:36', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-12-01 10:07:39', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (96, 6, 9, 6, TO_DATE('2017-12-11 11:05:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-12-11 12:58:22', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (97, 5, 8, 6, TO_DATE('2017-12-20 13:44:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2017-12-20 14:11:48', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (98, 5, 7, 4, TO_DATE('2018-01-04 16:12:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-01-04 16:50:54', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (99, 11, 8, 2, TO_DATE('2018-01-07 18:50:22', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-01-07 19:20:39', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (100, 10, 11, 1, TO_DATE('2018-01-21 21:01:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-01-21 21:52:55', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (101, 3, 3, 3, TO_DATE('2018-02-02 23:59:12', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-02-03 00:02:47', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (102, 8, 11, 3, TO_DATE('2018-02-15 00:34:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-02-15 00:44:20', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (103, 5, 3, 6, TO_DATE('2018-02-21 03:09:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-02-21 03:18:42', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (104, 2, 3, 1, TO_DATE('2018-03-05 04:07:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-03-05 04:50:26', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (105, 1, 6, 5, TO_DATE('2018-03-16 07:18:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-03-16 07:50:27', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (106, 6, 2, 5, TO_DATE('2018-03-21 08:35:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-03-21 09:54:55', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (107, 5, 9, 1, TO_DATE('2018-03-29 09:42:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-03-29 09:45:06', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (108, 3, 10, 3, TO_DATE('2018-04-12 11:08:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-04-12 12:36:45', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (109, 9, 1, 3, TO_DATE('2018-04-22 12:25:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-04-22 13:15:03', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (110, 1, 9, 5, TO_DATE('2018-04-30 15:30:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-04-30 16:41:04', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (111, 5, 6, 6, TO_DATE('2018-05-06 15:59:05', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-05-06 16:40:23', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (112, 8, 9, 5, TO_DATE('2018-05-14 16:53:06', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-05-14 17:11:19', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (113, 4, 10, 4, TO_DATE('2018-05-24 20:52:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-05-24 21:41:12', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (114, 1, 8, 6, TO_DATE('2018-06-03 23:28:04', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-06-04 00:21:42', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (115, 6, 5, 2, TO_DATE('2018-06-04 00:16:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-06-04 01:07:04', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (116, 5, 11, 4, TO_DATE('2018-06-23 03:52:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-06-23 04:29:01', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (117, 6, 2, 2, TO_DATE('2018-07-06 05:01:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-07-06 06:10:11', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (118, 2, 6, 1, TO_DATE('2018-07-11 05:43:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-07-11 06:20:56', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (119, 2, 8, 5, TO_DATE('2018-07-30 08:25:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-07-30 08:43:40', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (120, 11, 7, 5, TO_DATE('2018-08-18 09:09:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-08-18 09:14:45', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (121, 4, 3, 4, TO_DATE('2018-09-03 11:20:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-09-03 12:30:03', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (122, 8, 5, 1, TO_DATE('2018-09-09 14:11:51', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-09-09 14:16:53', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (123, 10, 8, 6, TO_DATE('2018-09-22 17:48:49', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-09-22 18:38:56', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (124, 6, 6, 1, TO_DATE('2018-09-23 18:02:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-09-23 19:37:23', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (125, 9, 9, 4, TO_DATE('2018-09-24 19:38:02', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-09-24 20:54:59', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (126, 6, 7, 6, TO_DATE('2018-10-03 19:58:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-10-03 20:35:41', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (127, 8, 1, 2, TO_DATE('2018-10-05 22:06:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-10-05 22:49:41', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (128, 4, 1, 5, TO_DATE('2018-10-18 23:44:19', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-10-19 00:43:03', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (129, 3, 9, 4, TO_DATE('2018-11-04 00:41:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-11-04 02:14:17', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (130, 10, 2, 5, TO_DATE('2018-11-08 04:35:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-11-08 06:29:20', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (131, 4, 7, 1, TO_DATE('2018-11-17 07:59:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-11-17 09:01:58', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (132, 8, 5, 3, TO_DATE('2018-11-26 10:40:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-11-26 11:20:59', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (133, 11, 10, 1, TO_DATE('2018-12-15 13:17:07', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-12-15 13:44:38', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (134, 11, 4, 1, TO_DATE('2018-12-19 14:54:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2018-12-19 16:09:05', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (135, 11, 11, 1, TO_DATE('2019-01-02 16:09:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-01-02 16:49:22', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (136, 7, 7, 6, TO_DATE('2019-01-16 17:21:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-01-16 19:04:35', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (137, 5, 8, 6, TO_DATE('2019-01-30 18:02:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-01-30 18:19:08', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (138, 4, 1, 4, TO_DATE('2019-02-03 21:15:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-02-03 22:44:32', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (139, 4, 9, 6, TO_DATE('2019-02-19 00:20:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-02-19 00:57:06', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (140, 9, 6, 3, TO_DATE('2019-02-25 00:51:39', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-02-25 01:48:50', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (141, 2, 8, 6, TO_DATE('2019-03-12 03:06:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-03-12 03:23:45', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (142, 4, 5, 4, TO_DATE('2019-03-27 07:03:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-03-27 08:36:21', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (143, 7, 11, 4, TO_DATE('2019-04-13 07:37:37', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-04-13 09:00:28', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (144, 6, 6, 1, TO_DATE('2019-05-01 10:07:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-05-01 12:06:23', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (145, 6, 2, 4, TO_DATE('2019-05-13 13:43:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-05-13 15:29:47', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (146, 8, 4, 2, TO_DATE('2019-05-17 15:54:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-05-17 17:17:23', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (147, 9, 8, 3, TO_DATE('2019-05-25 18:46:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-05-25 19:06:27', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (148, 7, 10, 2, TO_DATE('2019-06-07 20:29:52', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-06-07 21:26:30', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (149, 4, 5, 3, TO_DATE('2019-06-24 20:36:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-06-24 22:03:10', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (150, 6, 8, 5, TO_DATE('2019-06-28 23:59:25', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-06-29 01:19:16', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (151, 11, 10, 6, TO_DATE('2019-07-15 02:24:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-07-15 03:15:57', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (152, 7, 1, 5, TO_DATE('2019-07-21 04:30:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-07-21 06:30:15', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (153, 3, 8, 1, TO_DATE('2019-08-01 06:05:01', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-08-01 06:43:26', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (154, 6, 8, 3, TO_DATE('2019-08-02 06:44:33', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-08-02 06:50:05', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (155, 1, 1, 1, TO_DATE('2019-08-02 08:48:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-08-02 09:42:13', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (156, 1, 10, 2, TO_DATE('2019-08-02 09:43:54', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-08-02 10:01:58', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (157, 1, 7, 3, TO_DATE('2019-08-02 12:00:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-08-02 12:29:39', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (158, 10, 2, 3, TO_DATE('2019-08-12 15:29:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-08-12 16:05:34', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (159, 6, 7, 2, TO_DATE('2019-08-16 16:42:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-08-16 18:16:03', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (160, 9, 5, 1, TO_DATE('2019-08-25 18:19:36', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-08-25 18:29:27', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (161, 5, 5, 5, TO_DATE('2019-08-25 22:09:15', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-08-25 23:18:29', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (162, 8, 9, 1, TO_DATE('2019-09-02 00:41:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-09-02 01:22:51', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (163, 7, 3, 1, TO_DATE('2019-09-21 02:55:01', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-09-21 04:26:16', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (164, 5, 11, 2, TO_DATE('2019-09-30 03:06:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-09-30 04:43:17', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (165, 8, 2, 5, TO_DATE('2019-10-09 04:15:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-10-09 06:08:08', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (166, 9, 9, 3, TO_DATE('2019-10-21 05:03:27', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-10-21 05:13:07', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (167, 5, 4, 4, TO_DATE('2019-10-29 08:06:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-10-29 08:47:28', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (168, 7, 9, 5, TO_DATE('2019-10-31 09:29:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-10-31 11:01:30', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (169, 8, 7, 5, TO_DATE('2019-11-05 12:46:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-11-05 14:28:12', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (170, 3, 8, 4, TO_DATE('2019-11-23 15:41:46', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-11-23 16:22:22', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (171, 9, 7, 2, TO_DATE('2019-12-09 18:11:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-12-09 18:20:29', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (172, 7, 5, 3, TO_DATE('2019-12-12 20:19:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-12-12 20:44:09', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (173, 11, 6, 5, TO_DATE('2019-12-23 21:34:42', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-12-23 21:46:59', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (174, 5, 10, 4, TO_DATE('2020-01-07 22:37:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-01-08 00:13:54', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (175, 3, 8, 6, TO_DATE('2020-01-19 22:38:19', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-01-19 23:53:30', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (176, 9, 10, 1, TO_DATE('2020-02-03 00:15:06', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-02-03 02:14:28', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (177, 3, 4, 1, TO_DATE('2020-02-22 01:31:55', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-02-22 03:21:00', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (178, 11, 4, 1, TO_DATE('2020-03-05 04:23:34', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-03-05 05:41:07', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (179, 1, 8, 2, TO_DATE('2020-03-08 07:02:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-03-08 07:29:06', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (180, 2, 5, 2, TO_DATE('2020-03-25 09:50:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-03-25 10:16:08', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (181, 9, 1, 5, TO_DATE('2020-04-05 10:05:17', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-04-05 11:06:21', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (182, 11, 10, 5, TO_DATE('2020-04-21 10:40:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-04-21 12:09:41', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (183, 1, 4, 3, TO_DATE('2020-04-29 11:04:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-04-29 11:48:15', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (184, 10, 3, 3, TO_DATE('2020-05-18 13:32:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-05-18 14:35:59', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (185, 8, 9, 2, TO_DATE('2020-05-23 16:32:29', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-05-23 18:30:43', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (186, 9, 7, 1, TO_DATE('2020-06-08 19:35:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-06-08 21:00:31', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (187, 7, 2, 5, TO_DATE('2020-06-14 20:43:11', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-06-14 21:23:32', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (188, 6, 11, 4, TO_DATE('2020-06-14 21:30:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-06-14 22:44:09', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (189, 6, 2, 5, TO_DATE('2020-06-26 23:27:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-06-27 00:41:22', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (190, 6, 7, 3, TO_DATE('2020-07-03 23:35:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-07-04 00:19:50', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (191, 7, 7, 6, TO_DATE('2020-07-09 01:27:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-07-09 02:38:29', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (192, 1, 6, 1, TO_DATE('2020-07-22 02:10:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-07-22 03:41:09', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (193, 6, 7, 4, TO_DATE('2020-08-01 03:34:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-08-01 03:36:18', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (194, 7, 3, 6, TO_DATE('2020-08-17 05:23:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-08-17 06:42:29', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (195, 4, 11, 2, TO_DATE('2020-09-01 06:20:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-09-01 08:06:19', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (196, 9, 2, 4, TO_DATE('2020-09-09 07:22:44', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-09-09 07:24:30', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (197, 3, 10, 6, TO_DATE('2020-09-20 08:50:41', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-09-20 10:40:57', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (198, 3, 6, 3, TO_DATE('2020-09-24 11:16:16', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-09-24 13:14:10', 'YYYY-MM-DD HH24:MI:SS'));
insert into device_event VALUES (199, 11, 3, 1, TO_DATE('2020-10-09 13:32:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-10-09 14:15:37', 'YYYY-MM-DD HH24:MI:SS'));

COMMIT;

-- Select the count of records
SELECT COUNT(*) FROM device;
SELECT COUNT(*) FROM person;
SELECT COUNT(*) FROM event_type;	
SELECT COUNT(*) FROM device_event;