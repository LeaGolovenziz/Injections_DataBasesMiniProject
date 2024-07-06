prompt PL/SQL Developer import file
prompt Created on שבת 06 יולי 2024 by golol
set feedback off
set define off
prompt Creating APPOINTMENT...
create table APPOINTMENT
(
  appointment_id NUMBER not null,
  app_date       DATE,
  hour           VARCHAR2(10) not null,
  room           NUMBER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table APPOINTMENT
  add primary key (APPOINTMENT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table APPOINTMENT
  add constraint CHK_ROOM_NUMBER
  check (room = ROUND(room));

prompt Creating CHILD...
create table CHILD
(
  child_id   NUMBER not null,
  name       VARCHAR2(3) not null,
  birth_date DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CHILD
  add primary key (CHILD_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating GUARDIAN...
create table GUARDIAN
(
  guardian_id NUMBER not null,
  name        VARCHAR2(3) not null,
  birth_date  DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GUARDIAN
  add primary key (GUARDIAN_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating GUARDIAN_OF...
create table GUARDIAN_OF
(
  child_id    NUMBER not null,
  guardian_id NUMBER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GUARDIAN_OF
  add primary key (CHILD_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table GUARDIAN_OF
  add foreign key (CHILD_ID)
  references CHILD (CHILD_ID);
alter table GUARDIAN_OF
  add foreign key (GUARDIAN_ID)
  references GUARDIAN (GUARDIAN_ID);

prompt Creating STOCK...
create table STOCK
(
  stock_id NUMBER not null,
  shelf_id NUMBER not null,
  amount   NUMBER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STOCK
  add primary key (STOCK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STOCK
  add constraint CHK_STOCK_AMOUNT
  check (amount >= 0);

prompt Creating INJECTED...
create table INJECTED
(
  appointment_id NUMBER not null,
  stock_id       NUMBER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INJECTED
  add primary key (APPOINTMENT_ID, STOCK_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INJECTED
  add foreign key (APPOINTMENT_ID)
  references APPOINTMENT (APPOINTMENT_ID);
alter table INJECTED
  add foreign key (STOCK_ID)
  references STOCK (STOCK_ID);

prompt Creating NURSE...
create table NURSE
(
  nurse_id   NUMBER not null,
  name       VARCHAR2(3) not null,
  birth_date DATE
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table NURSE
  add primary key (NURSE_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating INJECTED_BY...
create table INJECTED_BY
(
  appointment_id NUMBER not null,
  nurse_id       NUMBER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INJECTED_BY
  add primary key (APPOINTMENT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INJECTED_BY
  add foreign key (APPOINTMENT_ID)
  references APPOINTMENT (APPOINTMENT_ID);
alter table INJECTED_BY
  add foreign key (NURSE_ID)
  references NURSE (NURSE_ID);

prompt Creating INJECTED_TO...
create table INJECTED_TO
(
  appointment_id NUMBER not null,
  child_id       NUMBER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INJECTED_TO
  add primary key (APPOINTMENT_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INJECTED_TO
  add foreign key (APPOINTMENT_ID)
  references APPOINTMENT (APPOINTMENT_ID);
alter table INJECTED_TO
  add foreign key (CHILD_ID)
  references CHILD (CHILD_ID);

prompt Creating INJECTION...
create table INJECTION
(
  injection_id  NUMBER not null,
  name          VARCHAR2(3) not null,
  disease       VARCHAR2(3) not null,
  dosage        NUMBER not null,
  age_injection NUMBER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INJECTION
  add primary key (INJECTION_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INJECTION
  add constraint CHK_DOSAGE_POSITIVE
  check (dosage > 0);

prompt Creating IN_STOCK...
create table IN_STOCK
(
  injection_id NUMBER not null,
  stock_id     NUMBER not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table IN_STOCK
  add primary key (INJECTION_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table IN_STOCK
  add foreign key (INJECTION_ID)
  references INJECTION (INJECTION_ID);
alter table IN_STOCK
  add foreign key (STOCK_ID)
  references STOCK (STOCK_ID);

prompt Disabling triggers for APPOINTMENT...
alter table APPOINTMENT disable all triggers;
prompt Disabling triggers for CHILD...
alter table CHILD disable all triggers;
prompt Disabling triggers for GUARDIAN...
alter table GUARDIAN disable all triggers;
prompt Disabling triggers for GUARDIAN_OF...
alter table GUARDIAN_OF disable all triggers;
prompt Disabling triggers for STOCK...
alter table STOCK disable all triggers;
prompt Disabling triggers for INJECTED...
alter table INJECTED disable all triggers;
prompt Disabling triggers for NURSE...
alter table NURSE disable all triggers;
prompt Disabling triggers for INJECTED_BY...
alter table INJECTED_BY disable all triggers;
prompt Disabling triggers for INJECTED_TO...
alter table INJECTED_TO disable all triggers;
prompt Disabling triggers for INJECTION...
alter table INJECTION disable all triggers;
prompt Disabling triggers for IN_STOCK...
alter table IN_STOCK disable all triggers;
prompt Disabling foreign key constraints for GUARDIAN_OF...
alter table GUARDIAN_OF disable constraint SYS_C007490;
alter table GUARDIAN_OF disable constraint SYS_C007491;
prompt Disabling foreign key constraints for INJECTED...
alter table INJECTED disable constraint SYS_C007520;
alter table INJECTED disable constraint SYS_C007521;
prompt Disabling foreign key constraints for INJECTED_BY...
alter table INJECTED_BY disable constraint SYS_C007498;
alter table INJECTED_BY disable constraint SYS_C007499;
prompt Disabling foreign key constraints for INJECTED_TO...
alter table INJECTED_TO disable constraint SYS_C007503;
alter table INJECTED_TO disable constraint SYS_C007504;
prompt Disabling foreign key constraints for IN_STOCK...
alter table IN_STOCK disable constraint SYS_C007517;
alter table IN_STOCK disable constraint SYS_C007518;
prompt Deleting IN_STOCK...
delete from IN_STOCK;
commit;
prompt Deleting INJECTION...
delete from INJECTION;
commit;
prompt Deleting INJECTED_TO...
delete from INJECTED_TO;
commit;
prompt Deleting INJECTED_BY...
delete from INJECTED_BY;
commit;
prompt Deleting NURSE...
delete from NURSE;
commit;
prompt Deleting INJECTED...
delete from INJECTED;
commit;
prompt Deleting STOCK...
delete from STOCK;
commit;
prompt Deleting GUARDIAN_OF...
delete from GUARDIAN_OF;
commit;
prompt Deleting GUARDIAN...
delete from GUARDIAN;
commit;
prompt Deleting CHILD...
delete from CHILD;
commit;
prompt Deleting APPOINTMENT...
delete from APPOINTMENT;
commit;
prompt Loading APPOINTMENT...
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (1, to_date('06-04-2024', 'dd-mm-yyyy'), '3:15 AM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (2, to_date('20-03-2024', 'dd-mm-yyyy'), '4:52 PM', 24);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (3, to_date('08-10-2024', 'dd-mm-yyyy'), '9:25 AM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (4, to_date('28-05-2024', 'dd-mm-yyyy'), '1:48 AM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (5, to_date('19-09-2024', 'dd-mm-yyyy'), '8:45 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (6, to_date('23-02-2024', 'dd-mm-yyyy'), '4:35 AM', 5);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (7, to_date('24-05-2024', 'dd-mm-yyyy'), '10:26 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (8, to_date('12-09-2024', 'dd-mm-yyyy'), '1:27 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (9, to_date('04-10-2024', 'dd-mm-yyyy'), '8:59 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (10, to_date('18-07-2024', 'dd-mm-yyyy'), '8:37 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (11, to_date('20-08-2024', 'dd-mm-yyyy'), '4:09 AM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (12, to_date('03-10-2024', 'dd-mm-yyyy'), '10:57 PM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (13, to_date('12-03-2024', 'dd-mm-yyyy'), '3:11 PM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (14, to_date('05-07-2024', 'dd-mm-yyyy'), '12:46 AM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (15, to_date('30-11-2023', 'dd-mm-yyyy'), '8:09 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (16, to_date('27-09-2024', 'dd-mm-yyyy'), '1:19 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (17, to_date('03-08-2024', 'dd-mm-yyyy'), '9:25 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (18, to_date('16-04-2024', 'dd-mm-yyyy'), '9:11 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (19, to_date('03-06-2024', 'dd-mm-yyyy'), '3:11 AM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (20, to_date('17-09-2024', 'dd-mm-yyyy'), '11:16 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (21, to_date('21-12-2023', 'dd-mm-yyyy'), '1:43 PM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (22, to_date('03-02-2024', 'dd-mm-yyyy'), '9:09 AM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (23, to_date('26-11-2023', 'dd-mm-yyyy'), '11:37 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (24, to_date('13-01-2024', 'dd-mm-yyyy'), '12:51 PM', 0);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (25, to_date('11-10-2024', 'dd-mm-yyyy'), '6:29 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (26, to_date('29-05-2024', 'dd-mm-yyyy'), '2:44 PM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (27, to_date('29-12-2023', 'dd-mm-yyyy'), '9:30 AM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (28, to_date('20-01-2024', 'dd-mm-yyyy'), '10:22 PM', 24);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (29, to_date('16-02-2024', 'dd-mm-yyyy'), '2:16 AM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (30, to_date('23-04-2024', 'dd-mm-yyyy'), '4:32 AM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (31, to_date('01-07-2024', 'dd-mm-yyyy'), '7:19 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (32, to_date('29-06-2024', 'dd-mm-yyyy'), '9:10 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (33, to_date('26-03-2024', 'dd-mm-yyyy'), '1:01 AM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (34, to_date('09-08-2024', 'dd-mm-yyyy'), '2:30 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (35, to_date('06-01-2024', 'dd-mm-yyyy'), '11:40 PM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (36, to_date('29-07-2024', 'dd-mm-yyyy'), '9:53 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (37, to_date('25-09-2024', 'dd-mm-yyyy'), '10:01 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (38, to_date('18-10-2024', 'dd-mm-yyyy'), '4:57 AM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (39, to_date('09-05-2024', 'dd-mm-yyyy'), '8:29 PM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (40, to_date('27-09-2024', 'dd-mm-yyyy'), '1:26 AM', 9);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (41, to_date('07-09-2024', 'dd-mm-yyyy'), '5:43 PM', 9);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (42, to_date('15-06-2024', 'dd-mm-yyyy'), '9:59 AM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (43, to_date('30-04-2024', 'dd-mm-yyyy'), '7:58 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (44, to_date('08-03-2024', 'dd-mm-yyyy'), '8:39 PM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (45, to_date('14-05-2024', 'dd-mm-yyyy'), '10:47 AM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (46, to_date('14-08-2024', 'dd-mm-yyyy'), '3:30 PM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (47, to_date('22-07-2024', 'dd-mm-yyyy'), '7:11 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (48, to_date('15-12-2023', 'dd-mm-yyyy'), '12:12 PM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (49, to_date('08-10-2024', 'dd-mm-yyyy'), '4:23 AM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (50, to_date('29-02-2024', 'dd-mm-yyyy'), '6:47 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (51, to_date('18-01-2024', 'dd-mm-yyyy'), '2:19 AM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (52, to_date('01-06-2024', 'dd-mm-yyyy'), '4:08 PM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (53, to_date('17-04-2024', 'dd-mm-yyyy'), '8:37 AM', 5);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (54, to_date('15-03-2024', 'dd-mm-yyyy'), '10:49 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (55, to_date('21-08-2024', 'dd-mm-yyyy'), '2:13 PM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (56, to_date('09-02-2024', 'dd-mm-yyyy'), '6:05 AM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (57, to_date('14-09-2024', 'dd-mm-yyyy'), '10:22 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (58, to_date('19-05-2024', 'dd-mm-yyyy'), '1:17 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (59, to_date('04-10-2024', 'dd-mm-yyyy'), '2:41 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (60, to_date('18-06-2024', 'dd-mm-yyyy'), '8:56 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (61, to_date('25-01-2024', 'dd-mm-yyyy'), '9:30 AM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (62, to_date('09-07-2024', 'dd-mm-yyyy'), '3:45 PM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (63, to_date('03-03-2024', 'dd-mm-yyyy'), '11:18 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (64, to_date('30-04-2024', 'dd-mm-yyyy'), '1:54 AM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (65, to_date('07-08-2024', 'dd-mm-yyyy'), '6:29 PM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (66, to_date('23-02-2024', 'dd-mm-yyyy'), '8:01 AM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (67, to_date('28-09-2024', 'dd-mm-yyyy'), '11:48 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (68, to_date('25-06-2024', 'dd-mm-yyyy'), '2:36 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (69, to_date('10-10-2024', 'dd-mm-yyyy'), '3:52 PM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (70, to_date('30-06-2024', 'dd-mm-yyyy'), '9:09 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (71, to_date('14-03-2024', 'dd-mm-yyyy'), '11:15 AM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (72, to_date('18-04-2024', 'dd-mm-yyyy'), '2:30 PM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (73, to_date('03-08-2024', 'dd-mm-yyyy'), '4:45 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (74, to_date('28-02-2024', 'dd-mm-yyyy'), '9:00 PM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (75, to_date('31-10-2024', 'dd-mm-yyyy'), '1:15 PM', 9);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (76, to_date('19-01-2024', 'dd-mm-yyyy'), '5:30 AM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (77, to_date('27-05-2024', 'dd-mm-yyyy'), '7:45 PM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (78, to_date('08-06-2024', 'dd-mm-yyyy'), '10:00 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (79, to_date('19-09-2024', 'dd-mm-yyyy'), '3:15 PM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (80, to_date('25-03-2024', 'dd-mm-yyyy'), '1:30 AM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (81, to_date('25-01-2024', 'dd-mm-yyyy'), '9:30 AM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (82, to_date('09-07-2024', 'dd-mm-yyyy'), '3:45 PM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (83, to_date('03-03-2024', 'dd-mm-yyyy'), '11:18 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (84, to_date('30-04-2024', 'dd-mm-yyyy'), '1:54 AM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (85, to_date('07-08-2024', 'dd-mm-yyyy'), '6:29 PM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (86, to_date('23-02-2024', 'dd-mm-yyyy'), '8:01 AM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (87, to_date('28-09-2024', 'dd-mm-yyyy'), '11:48 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (88, to_date('25-06-2024', 'dd-mm-yyyy'), '2:36 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (89, to_date('10-10-2024', 'dd-mm-yyyy'), '3:52 PM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (90, to_date('30-06-2024', 'dd-mm-yyyy'), '9:09 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (91, to_date('29-06-2024', 'dd-mm-yyyy'), '5:04 PM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (92, to_date('03-08-2024', 'dd-mm-yyyy'), '4:40 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (93, to_date('14-07-2024', 'dd-mm-yyyy'), '12:57 AM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (94, to_date('16-07-2024', 'dd-mm-yyyy'), '3:39 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (95, to_date('20-10-2024', 'dd-mm-yyyy'), '6:18 PM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (96, to_date('28-11-2023', 'dd-mm-yyyy'), '11:30 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (97, to_date('14-06-2024', 'dd-mm-yyyy'), '12:54 AM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (98, to_date('24-04-2024', 'dd-mm-yyyy'), '1:41 AM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (99, to_date('19-09-2024', 'dd-mm-yyyy'), '7:34 PM', 5);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (100, to_date('03-09-2024', 'dd-mm-yyyy'), '2:03 PM', 13);
commit;
prompt 100 records committed...
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (101, to_date('22-08-2024', 'dd-mm-yyyy'), '4:25 AM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (102, to_date('03-04-2024', 'dd-mm-yyyy'), '1:56 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (103, to_date('30-09-2024', 'dd-mm-yyyy'), '1:42 AM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (104, to_date('19-06-2024', 'dd-mm-yyyy'), '7:49 AM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (105, to_date('26-07-2024', 'dd-mm-yyyy'), '11:07 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (106, to_date('30-11-2023', 'dd-mm-yyyy'), '12:45 AM', 9);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (107, to_date('25-08-2024', 'dd-mm-yyyy'), '2:13 AM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (108, to_date('04-05-2024', 'dd-mm-yyyy'), '9:14 PM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (109, to_date('10-02-2024', 'dd-mm-yyyy'), '10:56 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (110, to_date('24-07-2024', 'dd-mm-yyyy'), '2:06 PM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (111, to_date('01-07-2024', 'dd-mm-yyyy'), '1:30 PM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (112, to_date('07-10-2024', 'dd-mm-yyyy'), '12:18 AM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (113, to_date('23-08-2024', 'dd-mm-yyyy'), '1:26 PM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (114, to_date('28-10-2024', 'dd-mm-yyyy'), '8:02 PM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (115, to_date('13-06-2024', 'dd-mm-yyyy'), '2:57 PM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (116, to_date('03-08-2024', 'dd-mm-yyyy'), '4:24 PM', 9);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (117, to_date('07-11-2024', 'dd-mm-yyyy'), '2:10 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (118, to_date('16-05-2024', 'dd-mm-yyyy'), '8:28 AM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (119, to_date('21-11-2024', 'dd-mm-yyyy'), '9:14 AM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (120, to_date('01-09-2024', 'dd-mm-yyyy'), '8:45 AM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (121, to_date('06-03-2024', 'dd-mm-yyyy'), '4:41 AM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (122, to_date('11-04-2024', 'dd-mm-yyyy'), '4:36 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (123, to_date('30-06-2024', 'dd-mm-yyyy'), '6:08 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (124, to_date('29-02-2024', 'dd-mm-yyyy'), '12:21 PM', 24);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (125, to_date('18-11-2024', 'dd-mm-yyyy'), '9:07 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (126, to_date('20-04-2024', 'dd-mm-yyyy'), '4:53 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (127, to_date('27-05-2024', 'dd-mm-yyyy'), '10:31 AM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (128, to_date('29-02-2024', 'dd-mm-yyyy'), '5:30 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (129, to_date('27-01-2024', 'dd-mm-yyyy'), '8:10 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (130, to_date('09-04-2024', 'dd-mm-yyyy'), '9:56 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (131, to_date('28-01-2024', 'dd-mm-yyyy'), '2:15 PM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (132, to_date('25-09-2024', 'dd-mm-yyyy'), '7:52 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (133, to_date('25-05-2024', 'dd-mm-yyyy'), '5:36 AM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (134, to_date('23-09-2024', 'dd-mm-yyyy'), '10:10 PM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (135, to_date('04-12-2023', 'dd-mm-yyyy'), '11:43 AM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (136, to_date('25-10-2024', 'dd-mm-yyyy'), '3:35 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (137, to_date('05-12-2023', 'dd-mm-yyyy'), '7:42 PM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (138, to_date('25-04-2024', 'dd-mm-yyyy'), '11:03 PM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (139, to_date('28-06-2024', 'dd-mm-yyyy'), '7:15 PM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (140, to_date('07-05-2024', 'dd-mm-yyyy'), '8:14 PM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (141, to_date('04-06-2024', 'dd-mm-yyyy'), '8:45 AM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (142, to_date('09-01-2024', 'dd-mm-yyyy'), '11:44 AM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (143, to_date('22-06-2024', 'dd-mm-yyyy'), '5:24 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (144, to_date('05-12-2023', 'dd-mm-yyyy'), '1:41 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (145, to_date('15-02-2024', 'dd-mm-yyyy'), '2:37 PM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (146, to_date('08-05-2024', 'dd-mm-yyyy'), '4:26 PM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (147, to_date('26-08-2024', 'dd-mm-yyyy'), '3:00 PM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (148, to_date('01-02-2024', 'dd-mm-yyyy'), '6:19 AM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (149, to_date('16-06-2024', 'dd-mm-yyyy'), '6:01 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (150, to_date('18-05-2024', 'dd-mm-yyyy'), '11:33 PM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (151, to_date('19-08-2024', 'dd-mm-yyyy'), '3:31 AM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (152, to_date('21-06-2024', 'dd-mm-yyyy'), '9:00 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (153, to_date('21-08-2024', 'dd-mm-yyyy'), '3:44 PM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (154, to_date('04-07-2024', 'dd-mm-yyyy'), '5:34 AM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (155, to_date('21-07-2024', 'dd-mm-yyyy'), '7:10 PM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (156, to_date('18-08-2024', 'dd-mm-yyyy'), '8:11 AM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (157, to_date('28-08-2024', 'dd-mm-yyyy'), '1:49 PM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (158, to_date('20-06-2024', 'dd-mm-yyyy'), '1:34 AM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (159, to_date('08-07-2024', 'dd-mm-yyyy'), '1:53 AM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (160, to_date('11-02-2024', 'dd-mm-yyyy'), '8:42 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (161, to_date('11-04-2024', 'dd-mm-yyyy'), '5:49 PM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (162, to_date('23-09-2024', 'dd-mm-yyyy'), '5:51 AM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (163, to_date('06-08-2024', 'dd-mm-yyyy'), '6:23 PM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (164, to_date('02-08-2024', 'dd-mm-yyyy'), '12:39 PM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (165, to_date('12-11-2024', 'dd-mm-yyyy'), '4:43 AM', 24);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (166, to_date('25-03-2024', 'dd-mm-yyyy'), '9:23 PM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (167, to_date('19-01-2024', 'dd-mm-yyyy'), '10:02 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (168, to_date('31-12-2023', 'dd-mm-yyyy'), '3:55 AM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (169, to_date('21-11-2024', 'dd-mm-yyyy'), '11:16 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (170, to_date('24-10-2024', 'dd-mm-yyyy'), '10:00 AM', 24);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (171, to_date('09-04-2024', 'dd-mm-yyyy'), '3:00 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (172, to_date('26-12-2023', 'dd-mm-yyyy'), '1:30 AM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (173, to_date('24-12-2023', 'dd-mm-yyyy'), '1:52 PM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (174, to_date('21-09-2024', 'dd-mm-yyyy'), '5:02 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (175, to_date('25-02-2024', 'dd-mm-yyyy'), '5:37 AM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (176, to_date('19-03-2024', 'dd-mm-yyyy'), '2:38 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (177, to_date('14-03-2024', 'dd-mm-yyyy'), '11:12 PM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (178, to_date('18-11-2024', 'dd-mm-yyyy'), '10:37 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (179, to_date('11-07-2024', 'dd-mm-yyyy'), '10:19 AM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (180, to_date('09-10-2024', 'dd-mm-yyyy'), '7:37 AM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (181, to_date('31-08-2024', 'dd-mm-yyyy'), '11:38 AM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (182, to_date('23-09-2024', 'dd-mm-yyyy'), '10:58 AM', 0);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (183, to_date('18-07-2024', 'dd-mm-yyyy'), '1:53 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (184, to_date('10-12-2023', 'dd-mm-yyyy'), '4:50 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (185, to_date('20-01-2024', 'dd-mm-yyyy'), '4:34 PM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (186, to_date('10-12-2023', 'dd-mm-yyyy'), '11:54 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (187, to_date('18-05-2024', 'dd-mm-yyyy'), '10:53 PM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (188, to_date('21-12-2023', 'dd-mm-yyyy'), '3:11 AM', 24);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (189, to_date('22-08-2024', 'dd-mm-yyyy'), '8:49 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (190, to_date('28-10-2024', 'dd-mm-yyyy'), '9:45 PM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (191, to_date('19-12-2023', 'dd-mm-yyyy'), '3:34 PM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (192, to_date('20-11-2024', 'dd-mm-yyyy'), '3:09 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (193, to_date('24-07-2024', 'dd-mm-yyyy'), '11:58 PM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (194, to_date('19-10-2024', 'dd-mm-yyyy'), '4:49 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (195, to_date('25-03-2024', 'dd-mm-yyyy'), '7:02 PM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (196, to_date('11-09-2024', 'dd-mm-yyyy'), '3:18 AM', 5);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (197, to_date('11-09-2024', 'dd-mm-yyyy'), '2:54 PM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (198, to_date('12-06-2024', 'dd-mm-yyyy'), '1:39 AM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (199, to_date('13-09-2024', 'dd-mm-yyyy'), '12:30 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (200, to_date('24-05-2024', 'dd-mm-yyyy'), '11:02 AM', 18);
commit;
prompt 200 records committed...
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (201, to_date('07-02-2024', 'dd-mm-yyyy'), '7:21 PM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (202, to_date('13-12-2023', 'dd-mm-yyyy'), '4:19 AM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (203, to_date('01-08-2024', 'dd-mm-yyyy'), '3:32 AM', 0);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (204, to_date('20-12-2023', 'dd-mm-yyyy'), '11:31 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (205, to_date('23-09-2024', 'dd-mm-yyyy'), '11:01 AM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (206, to_date('27-07-2024', 'dd-mm-yyyy'), '2:05 PM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (207, to_date('30-09-2024', 'dd-mm-yyyy'), '5:52 PM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (208, to_date('29-09-2024', 'dd-mm-yyyy'), '7:49 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (209, to_date('06-08-2024', 'dd-mm-yyyy'), '2:35 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (210, to_date('05-03-2024', 'dd-mm-yyyy'), '1:44 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (211, to_date('23-06-2024', 'dd-mm-yyyy'), '9:48 PM', 0);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (212, to_date('01-09-2024', 'dd-mm-yyyy'), '7:39 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (213, to_date('18-03-2024', 'dd-mm-yyyy'), '2:34 PM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (214, to_date('15-04-2024', 'dd-mm-yyyy'), '6:22 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (215, to_date('10-10-2024', 'dd-mm-yyyy'), '4:23 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (216, to_date('23-06-2024', 'dd-mm-yyyy'), '8:59 PM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (217, to_date('29-06-2024', 'dd-mm-yyyy'), '9:25 PM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (218, to_date('29-02-2024', 'dd-mm-yyyy'), '9:19 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (219, to_date('03-11-2024', 'dd-mm-yyyy'), '2:35 AM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (220, to_date('02-04-2024', 'dd-mm-yyyy'), '8:11 AM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (221, to_date('03-07-2024', 'dd-mm-yyyy'), '1:47 PM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (222, to_date('07-03-2024', 'dd-mm-yyyy'), '9:12 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (223, to_date('02-01-2024', 'dd-mm-yyyy'), '12:38 AM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (224, to_date('27-11-2023', 'dd-mm-yyyy'), '10:59 AM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (226, to_date('27-09-2024', 'dd-mm-yyyy'), '11:27 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (227, to_date('02-04-2024', 'dd-mm-yyyy'), '7:43 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (228, to_date('23-01-2024', 'dd-mm-yyyy'), '1:46 AM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (229, to_date('22-09-2024', 'dd-mm-yyyy'), '6:05 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (230, to_date('11-12-2023', 'dd-mm-yyyy'), '12:44 AM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (231, to_date('01-04-2024', 'dd-mm-yyyy'), '5:40 AM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (232, to_date('01-03-2024', 'dd-mm-yyyy'), '1:37 PM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (233, to_date('18-08-2024', 'dd-mm-yyyy'), '12:08 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (234, to_date('15-10-2024', 'dd-mm-yyyy'), '11:17 PM', 9);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (235, to_date('10-06-2024', 'dd-mm-yyyy'), '8:01 AM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (236, to_date('21-01-2024', 'dd-mm-yyyy'), '3:00 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (237, to_date('01-12-2023', 'dd-mm-yyyy'), '8:41 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (238, to_date('13-01-2024', 'dd-mm-yyyy'), '10:39 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (239, to_date('11-12-2023', 'dd-mm-yyyy'), '11:49 PM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (240, to_date('11-02-2024', 'dd-mm-yyyy'), '9:28 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (241, to_date('24-08-2024', 'dd-mm-yyyy'), '9:31 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (242, to_date('13-06-2024', 'dd-mm-yyyy'), '7:16 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (243, to_date('11-12-2023', 'dd-mm-yyyy'), '5:11 PM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (244, to_date('27-04-2024', 'dd-mm-yyyy'), '11:19 AM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (245, to_date('26-05-2024', 'dd-mm-yyyy'), '6:33 AM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (246, to_date('11-11-2024', 'dd-mm-yyyy'), '3:49 AM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (247, to_date('08-09-2024', 'dd-mm-yyyy'), '4:12 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (248, to_date('09-07-2024', 'dd-mm-yyyy'), '7:07 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (249, to_date('13-02-2024', 'dd-mm-yyyy'), '4:20 PM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (250, to_date('29-09-2024', 'dd-mm-yyyy'), '7:12 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (251, to_date('11-02-2024', 'dd-mm-yyyy'), '10:52 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (252, to_date('10-12-2023', 'dd-mm-yyyy'), '8:56 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (253, to_date('13-02-2024', 'dd-mm-yyyy'), '11:08 PM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (254, to_date('04-11-2024', 'dd-mm-yyyy'), '11:54 AM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (255, to_date('17-03-2024', 'dd-mm-yyyy'), '4:34 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (256, to_date('06-02-2024', 'dd-mm-yyyy'), '9:41 PM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (257, to_date('02-04-2024', 'dd-mm-yyyy'), '4:39 AM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (258, to_date('11-04-2024', 'dd-mm-yyyy'), '12:49 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (259, to_date('05-10-2024', 'dd-mm-yyyy'), '12:04 AM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (260, to_date('27-11-2023', 'dd-mm-yyyy'), '8:56 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (261, to_date('05-07-2024', 'dd-mm-yyyy'), '6:11 AM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (262, to_date('28-06-2024', 'dd-mm-yyyy'), '6:24 AM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (263, to_date('30-11-2023', 'dd-mm-yyyy'), '1:24 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (264, to_date('29-09-2024', 'dd-mm-yyyy'), '6:30 AM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (265, to_date('08-05-2024', 'dd-mm-yyyy'), '10:37 AM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (266, to_date('03-02-2024', 'dd-mm-yyyy'), '2:13 PM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (267, to_date('15-09-2024', 'dd-mm-yyyy'), '7:28 PM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (268, to_date('06-03-2024', 'dd-mm-yyyy'), '12:45 PM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (269, to_date('11-11-2024', 'dd-mm-yyyy'), '9:45 PM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (270, to_date('25-12-2023', 'dd-mm-yyyy'), '4:53 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (271, to_date('08-11-2024', 'dd-mm-yyyy'), '9:41 PM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (272, to_date('28-07-2024', 'dd-mm-yyyy'), '7:30 PM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (273, to_date('08-04-2024', 'dd-mm-yyyy'), '6:48 PM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (274, to_date('17-03-2024', 'dd-mm-yyyy'), '2:39 AM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (275, to_date('23-02-2024', 'dd-mm-yyyy'), '4:00 PM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (276, to_date('29-11-2023', 'dd-mm-yyyy'), '6:49 PM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (277, to_date('15-11-2024', 'dd-mm-yyyy'), '11:47 PM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (278, to_date('02-02-2024', 'dd-mm-yyyy'), '1:06 PM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (279, to_date('21-11-2024', 'dd-mm-yyyy'), '11:48 AM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (280, to_date('12-12-2023', 'dd-mm-yyyy'), '7:11 PM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (281, to_date('10-08-2024', 'dd-mm-yyyy'), '7:42 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (282, to_date('31-07-2024', 'dd-mm-yyyy'), '12:30 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (283, to_date('29-12-2023', 'dd-mm-yyyy'), '8:07 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (284, to_date('14-07-2024', 'dd-mm-yyyy'), '1:42 AM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (285, to_date('31-03-2024', 'dd-mm-yyyy'), '9:12 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (286, to_date('01-12-2023', 'dd-mm-yyyy'), '4:20 AM', 24);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (287, to_date('26-12-2023', 'dd-mm-yyyy'), '9:11 AM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (288, to_date('02-06-2024', 'dd-mm-yyyy'), '2:06 AM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (289, to_date('25-12-2023', 'dd-mm-yyyy'), '4:10 PM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (290, to_date('21-03-2024', 'dd-mm-yyyy'), '1:16 AM', 9);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (291, to_date('25-06-2024', 'dd-mm-yyyy'), '5:56 PM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (292, to_date('17-03-2024', 'dd-mm-yyyy'), '2:35 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (293, to_date('24-11-2024', 'dd-mm-yyyy'), '6:17 PM', 24);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (294, to_date('01-12-2023', 'dd-mm-yyyy'), '2:21 AM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (295, to_date('01-04-2024', 'dd-mm-yyyy'), '8:43 PM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (296, to_date('15-02-2024', 'dd-mm-yyyy'), '1:27 PM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (297, to_date('10-09-2024', 'dd-mm-yyyy'), '8:23 AM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (298, to_date('30-06-2024', 'dd-mm-yyyy'), '7:58 PM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (299, to_date('23-12-2023', 'dd-mm-yyyy'), '11:32 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (300, to_date('04-09-2024', 'dd-mm-yyyy'), '10:24 PM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (301, to_date('29-02-2024', 'dd-mm-yyyy'), '1:19 PM', 14);
commit;
prompt 300 records committed...
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (302, to_date('20-07-2024', 'dd-mm-yyyy'), '1:46 AM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (303, to_date('08-06-2024', 'dd-mm-yyyy'), '6:23 AM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (304, to_date('16-09-2024', 'dd-mm-yyyy'), '12:57 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (305, to_date('01-09-2024', 'dd-mm-yyyy'), '9:37 PM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (306, to_date('30-04-2024', 'dd-mm-yyyy'), '8:16 PM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (307, to_date('09-04-2024', 'dd-mm-yyyy'), '12:39 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (308, to_date('15-12-2023', 'dd-mm-yyyy'), '10:19 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (309, to_date('04-09-2024', 'dd-mm-yyyy'), '5:52 PM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (310, to_date('28-05-2024', 'dd-mm-yyyy'), '1:47 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (311, to_date('02-06-2024', 'dd-mm-yyyy'), '6:26 AM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (312, to_date('23-06-2024', 'dd-mm-yyyy'), '3:39 AM', 5);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (313, to_date('01-05-2024', 'dd-mm-yyyy'), '11:46 PM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (314, to_date('28-03-2024', 'dd-mm-yyyy'), '4:09 PM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (315, to_date('26-08-2024', 'dd-mm-yyyy'), '12:20 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (316, to_date('14-04-2024', 'dd-mm-yyyy'), '8:06 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (317, to_date('22-07-2024', 'dd-mm-yyyy'), '8:38 PM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (318, to_date('25-01-2024', 'dd-mm-yyyy'), '12:07 PM', 5);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (319, to_date('20-12-2023', 'dd-mm-yyyy'), '7:39 PM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (320, to_date('02-11-2024', 'dd-mm-yyyy'), '7:35 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (321, to_date('08-12-2023', 'dd-mm-yyyy'), '2:12 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (322, to_date('02-02-2024', 'dd-mm-yyyy'), '8:05 PM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (323, to_date('11-02-2024', 'dd-mm-yyyy'), '1:39 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (324, to_date('20-10-2024', 'dd-mm-yyyy'), '4:37 AM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (325, to_date('09-10-2024', 'dd-mm-yyyy'), '4:36 AM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (326, to_date('15-10-2024', 'dd-mm-yyyy'), '8:07 PM', 5);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (327, to_date('26-10-2024', 'dd-mm-yyyy'), '7:04 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (328, to_date('10-04-2024', 'dd-mm-yyyy'), '4:03 AM', 9);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (329, to_date('23-04-2024', 'dd-mm-yyyy'), '11:19 AM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (330, to_date('17-06-2024', 'dd-mm-yyyy'), '7:48 AM', 9);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (331, to_date('28-07-2024', 'dd-mm-yyyy'), '10:24 AM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (332, to_date('13-09-2024', 'dd-mm-yyyy'), '5:06 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (333, to_date('29-01-2024', 'dd-mm-yyyy'), '6:37 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (334, to_date('16-03-2024', 'dd-mm-yyyy'), '10:19 PM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (335, to_date('12-06-2024', 'dd-mm-yyyy'), '2:58 PM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (336, to_date('23-11-2024', 'dd-mm-yyyy'), '3:12 PM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (337, to_date('01-01-2024', 'dd-mm-yyyy'), '3:31 AM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (338, to_date('09-12-2023', 'dd-mm-yyyy'), '7:09 PM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (339, to_date('24-03-2024', 'dd-mm-yyyy'), '7:30 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (340, to_date('16-09-2024', 'dd-mm-yyyy'), '6:26 PM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (341, to_date('10-12-2023', 'dd-mm-yyyy'), '3:18 PM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (342, to_date('22-11-2024', 'dd-mm-yyyy'), '10:39 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (343, to_date('31-01-2024', 'dd-mm-yyyy'), '2:41 PM', 5);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (344, to_date('16-10-2024', 'dd-mm-yyyy'), '10:42 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (345, to_date('03-01-2024', 'dd-mm-yyyy'), '10:31 AM', 2);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (346, to_date('21-08-2024', 'dd-mm-yyyy'), '6:12 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (347, to_date('23-03-2024', 'dd-mm-yyyy'), '12:06 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (348, to_date('13-03-2024', 'dd-mm-yyyy'), '2:56 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (349, to_date('27-06-2024', 'dd-mm-yyyy'), '12:46 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (350, to_date('02-12-2023', 'dd-mm-yyyy'), '3:56 PM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (351, to_date('01-05-2024', 'dd-mm-yyyy'), '8:55 AM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (352, to_date('28-01-2024', 'dd-mm-yyyy'), '4:10 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (353, to_date('01-03-2024', 'dd-mm-yyyy'), '3:57 PM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (354, to_date('18-06-2024', 'dd-mm-yyyy'), '8:11 AM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (355, to_date('10-04-2024', 'dd-mm-yyyy'), '5:28 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (356, to_date('21-03-2024', 'dd-mm-yyyy'), '11:29 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (357, to_date('02-08-2024', 'dd-mm-yyyy'), '1:00 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (358, to_date('25-10-2024', 'dd-mm-yyyy'), '3:17 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (359, to_date('26-06-2024', 'dd-mm-yyyy'), '3:34 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (360, to_date('31-07-2024', 'dd-mm-yyyy'), '4:58 AM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (361, to_date('10-10-2024', 'dd-mm-yyyy'), '7:51 AM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (362, to_date('16-09-2024', 'dd-mm-yyyy'), '11:26 PM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (363, to_date('20-04-2024', 'dd-mm-yyyy'), '3:54 AM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (364, to_date('15-12-2023', 'dd-mm-yyyy'), '6:31 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (365, to_date('14-06-2024', 'dd-mm-yyyy'), '11:37 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (366, to_date('06-12-2023', 'dd-mm-yyyy'), '10:29 PM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (367, to_date('19-05-2024', 'dd-mm-yyyy'), '7:29 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (368, to_date('20-01-2024', 'dd-mm-yyyy'), '10:24 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (369, to_date('29-10-2024', 'dd-mm-yyyy'), '11:48 AM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (370, to_date('04-06-2024', 'dd-mm-yyyy'), '2:46 AM', 20);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (371, to_date('05-02-2024', 'dd-mm-yyyy'), '9:07 AM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (372, to_date('09-03-2024', 'dd-mm-yyyy'), '5:45 AM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (373, to_date('27-09-2024', 'dd-mm-yyyy'), '5:14 AM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (374, to_date('13-11-2024', 'dd-mm-yyyy'), '8:41 AM', 14);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (375, to_date('13-04-2024', 'dd-mm-yyyy'), '5:43 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (376, to_date('28-05-2024', 'dd-mm-yyyy'), '11:29 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (377, to_date('07-08-2024', 'dd-mm-yyyy'), '8:47 PM', 16);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (378, to_date('16-01-2024', 'dd-mm-yyyy'), '12:03 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (379, to_date('05-06-2024', 'dd-mm-yyyy'), '6:38 AM', 9);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (380, to_date('26-04-2024', 'dd-mm-yyyy'), '3:18 PM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (381, to_date('10-10-2024', 'dd-mm-yyyy'), '11:54 PM', 18);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (382, to_date('07-03-2024', 'dd-mm-yyyy'), '2:41 PM', 6);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (383, to_date('26-10-2024', 'dd-mm-yyyy'), '12:21 AM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (384, to_date('09-12-2023', 'dd-mm-yyyy'), '8:35 AM', 17);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (385, to_date('19-07-2024', 'dd-mm-yyyy'), '6:18 PM', 1);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (386, to_date('01-07-2024', 'dd-mm-yyyy'), '2:09 AM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (387, to_date('22-06-2024', 'dd-mm-yyyy'), '12:29 AM', 19);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (388, to_date('22-07-2024', 'dd-mm-yyyy'), '2:14 AM', 7);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (389, to_date('13-01-2024', 'dd-mm-yyyy'), '4:30 PM', 10);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (390, to_date('24-01-2024', 'dd-mm-yyyy'), '11:15 AM', 21);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (391, to_date('26-03-2024', 'dd-mm-yyyy'), '2:46 AM', 15);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (392, to_date('03-10-2024', 'dd-mm-yyyy'), '12:39 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (393, to_date('17-03-2024', 'dd-mm-yyyy'), '2:46 AM', 4);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (394, to_date('05-05-2024', 'dd-mm-yyyy'), '4:34 PM', 8);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (395, to_date('30-06-2024', 'dd-mm-yyyy'), '10:53 PM', 23);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (396, to_date('24-10-2024', 'dd-mm-yyyy'), '10:36 PM', 22);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (397, to_date('26-08-2024', 'dd-mm-yyyy'), '1:55 AM', 13);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (398, to_date('05-10-2024', 'dd-mm-yyyy'), '2:45 AM', 12);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (399, to_date('14-12-2023', 'dd-mm-yyyy'), '6:32 AM', 11);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (400, to_date('25-05-2024', 'dd-mm-yyyy'), '12:48 PM', 3);
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (401, to_date('27-11-2023', 'dd-mm-yyyy'), '10:35', 105);
commit;
prompt 400 records committed...
insert into APPOINTMENT (appointment_id, app_date, hour, room)
values (402, to_date('06-07-2023', 'dd-mm-yyyy'), '10:35', 109);
commit;
prompt 401 records loaded
prompt Loading CHILD...
insert into CHILD (child_id, name, birth_date)
values (100, 'Tay', to_date('12-11-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (101, 'Lou', to_date('30-01-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (102, 'Mar', to_date('03-06-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (103, 'Tin', to_date('05-07-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (104, 'Jef', to_date('24-11-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (105, 'Ray', to_date('13-12-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (106, 'Emi', to_date('28-01-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (107, 'Chr', to_date('07-05-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (108, 'Isa', to_date('27-04-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (109, 'Jas', to_date('07-12-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (110, 'Joh', to_date('11-12-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (111, 'Mac', to_date('15-07-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (112, 'Ash', to_date('17-01-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (113, 'Gab', to_date('28-08-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (114, 'Cat', to_date('05-05-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (115, 'Jos', to_date('24-11-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (116, 'Chr', to_date('25-06-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (117, 'Jos', to_date('12-07-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (118, 'Phi', to_date('12-01-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (119, 'Eri', to_date('29-10-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (120, 'Jos', to_date('12-03-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (121, 'Dav', to_date('22-09-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (122, 'Ste', to_date('10-05-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (123, 'Rob', to_date('27-04-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (124, 'Sar', to_date('20-05-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (125, 'She', to_date('20-03-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (126, 'Jam', to_date('01-10-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (127, 'Jos', to_date('16-11-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (128, 'Dar', to_date('16-08-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (129, 'Yvo', to_date('19-10-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (130, 'Mar', to_date('12-05-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (131, 'Lis', to_date('20-09-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (132, 'Lau', to_date('03-06-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (133, 'Wil', to_date('16-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (134, 'And', to_date('07-12-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (135, 'Mel', to_date('30-09-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (136, 'Ric', to_date('29-12-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (137, 'Glo', to_date('14-01-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (138, 'Chr', to_date('20-03-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (139, 'Cha', to_date('25-11-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (140, 'Cha', to_date('17-01-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (141, 'Chr', to_date('17-10-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (142, 'Wil', to_date('25-07-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (143, 'Jas', to_date('05-04-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (144, 'Tam', to_date('29-03-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (145, 'Jos', to_date('09-03-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (146, 'And', to_date('24-08-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (147, 'Cyn', to_date('08-06-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (148, 'Ste', to_date('05-12-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (149, 'Kar', to_date('31-05-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (150, 'Bar', to_date('04-11-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (151, 'Cat', to_date('05-02-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (152, 'Eri', to_date('20-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (153, 'Bra', to_date('13-04-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (154, 'Lin', to_date('26-06-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (155, 'Ant', to_date('01-02-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (156, 'Kay', to_date('12-02-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (157, 'Jam', to_date('08-08-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (158, 'Jon', to_date('03-02-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (159, 'Jen', to_date('21-11-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (160, 'Ste', to_date('08-08-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (161, 'Kei', to_date('04-09-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (162, 'Chr', to_date('13-05-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (163, 'Mel', to_date('12-02-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (164, 'Sha', to_date('07-02-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (165, 'Tra', to_date('24-09-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (166, 'Lis', to_date('16-02-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (167, 'Rod', to_date('28-10-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (168, 'Sus', to_date('21-09-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (169, 'Jos', to_date('06-02-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (170, 'Col', to_date('21-03-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (171, 'Reb', to_date('19-06-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (172, 'Jam', to_date('16-11-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (173, 'Kat', to_date('30-07-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (174, 'Meg', to_date('01-03-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (175, 'Kat', to_date('17-09-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (176, 'Han', to_date('26-03-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (177, 'Bon', to_date('31-05-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (178, 'Mic', to_date('05-12-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (179, 'Kat', to_date('06-04-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (180, 'Bra', to_date('03-07-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (181, 'Jes', to_date('10-10-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (182, 'Jon', to_date('05-05-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (183, 'Jai', to_date('09-11-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (184, 'Tin', to_date('29-04-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (185, 'Sel', to_date('16-10-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (186, 'Yvo', to_date('13-04-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (187, 'Geo', to_date('23-06-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (188, 'Jos', to_date('28-02-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (189, 'Jef', to_date('06-06-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (190, 'Jef', to_date('10-11-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (191, 'Kar', to_date('09-04-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (192, 'Val', to_date('30-04-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (193, 'Ken', to_date('05-05-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (194, 'Mat', to_date('05-11-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (195, 'Kev', to_date('17-01-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (196, 'Tyl', to_date('23-07-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (197, 'Sha', to_date('10-07-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (198, 'Ada', to_date('28-07-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (199, 'Jon', to_date('16-01-2020', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into CHILD (child_id, name, birth_date)
values (200, 'Eri', to_date('23-07-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (201, 'Dav', to_date('07-08-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (202, 'Chr', to_date('26-05-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (203, 'Meg', to_date('03-01-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (204, 'And', to_date('27-10-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (205, 'Bra', to_date('14-02-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (206, 'Lea', to_date('13-02-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (207, 'Chr', to_date('24-06-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (208, 'Che', to_date('19-06-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (209, 'Car', to_date('24-08-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (210, 'Lau', to_date('24-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (211, 'Jos', to_date('21-08-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (212, 'Pau', to_date('22-06-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (213, 'Aly', to_date('02-02-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (214, 'Mor', to_date('08-03-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (215, 'Ada', to_date('08-02-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (216, 'Tho', to_date('25-06-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (217, 'Gar', to_date('05-04-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (218, 'Ada', to_date('09-05-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (219, 'Rya', to_date('07-07-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (220, 'Ale', to_date('11-04-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (221, 'Mar', to_date('09-07-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (222, 'Joh', to_date('09-02-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (223, 'Ver', to_date('28-12-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (224, 'Bri', to_date('08-01-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (225, 'Jas', to_date('05-01-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (226, 'Chr', to_date('31-03-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (227, 'Dan', to_date('14-09-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (228, 'And', to_date('28-04-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (229, 'Cry', to_date('08-11-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (230, 'Lin', to_date('30-11-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (231, 'Jam', to_date('08-03-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (232, 'Tro', to_date('03-02-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (233, 'Jam', to_date('14-08-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (234, 'Nic', to_date('21-08-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (235, 'Gab', to_date('07-11-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (236, 'Tam', to_date('21-07-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (237, 'Lea', to_date('10-08-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (238, 'Joh', to_date('09-07-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (239, 'Jul', to_date('21-08-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (240, 'Ter', to_date('16-01-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (241, 'Rya', to_date('22-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (242, 'Wil', to_date('30-01-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (243, 'Van', to_date('08-10-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (244, 'Ken', to_date('06-06-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (245, 'Ant', to_date('09-03-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (246, 'Sus', to_date('26-09-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (247, 'Ama', to_date('16-12-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (248, 'Ric', to_date('21-01-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (249, 'Bri', to_date('01-02-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (250, 'Gab', to_date('25-04-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (251, 'Mic', to_date('07-01-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (252, 'Edw', to_date('30-12-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (253, 'Vic', to_date('07-08-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (254, 'Hol', to_date('13-01-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (255, 'Jen', to_date('03-12-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (256, 'Mic', to_date('07-07-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (257, 'Dev', to_date('22-05-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (258, 'Pau', to_date('09-09-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (259, 'Jus', to_date('14-02-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (260, 'Jes', to_date('20-10-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (261, 'Rac', to_date('15-10-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (262, 'Rho', to_date('03-12-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (263, 'Jua', to_date('06-05-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (264, 'Jef', to_date('19-09-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (265, 'Cha', to_date('02-04-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (266, 'Jos', to_date('26-12-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (267, 'Cas', to_date('04-01-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (268, 'Amy', to_date('07-10-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (269, 'Tin', to_date('19-11-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (270, 'Eth', to_date('30-11-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (271, 'Abi', to_date('27-04-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (272, 'Mat', to_date('13-10-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (273, 'Reb', to_date('15-07-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (274, 'Kev', to_date('21-07-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (275, 'Aus', to_date('30-09-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (276, 'Kel', to_date('28-04-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (277, 'Gre', to_date('27-06-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (278, 'Jen', to_date('01-05-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (279, 'Jam', to_date('23-03-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (280, 'Pat', to_date('07-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (281, 'Jay', to_date('06-10-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (282, 'Mic', to_date('19-10-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (283, 'Joe', to_date('29-10-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (284, 'Kat', to_date('14-06-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (285, 'Mon', to_date('11-04-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (286, 'Tam', to_date('24-04-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (287, 'San', to_date('03-10-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (288, 'Den', to_date('06-11-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (289, 'Gar', to_date('12-11-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (290, 'Jos', to_date('09-10-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (291, 'Lar', to_date('02-10-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (292, 'Pat', to_date('10-08-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (293, 'Luk', to_date('06-08-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (294, 'Sus', to_date('06-11-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (295, 'Nic', to_date('20-03-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (296, 'Nan', to_date('05-05-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (297, 'Shi', to_date('26-10-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (298, 'Phi', to_date('22-05-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (299, 'Eil', to_date('14-11-2019', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into CHILD (child_id, name, birth_date)
values (300, 'Kel', to_date('18-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (301, 'Tho', to_date('01-11-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (302, 'Jul', to_date('01-06-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (303, 'Reg', to_date('13-01-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (304, 'Sco', to_date('17-02-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (305, 'Mar', to_date('22-12-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (306, 'Mic', to_date('29-07-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (307, 'Mor', to_date('01-09-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (308, 'Kat', to_date('30-05-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (309, 'Dav', to_date('16-09-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (310, 'Deb', to_date('11-08-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (311, 'Wan', to_date('21-02-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (312, 'Gab', to_date('26-11-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (313, 'Jua', to_date('01-12-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (314, 'Mic', to_date('04-07-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (315, 'Mr.', to_date('10-03-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (316, 'Wen', to_date('04-03-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (317, 'Cai', to_date('12-08-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (318, 'Cha', to_date('28-07-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (319, 'And', to_date('05-01-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (320, 'Lyd', to_date('02-08-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (321, 'Fre', to_date('24-06-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (322, 'Tra', to_date('05-05-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (323, 'Kir', to_date('27-04-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (324, 'Ric', to_date('17-12-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (325, 'Eri', to_date('29-03-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (326, 'Lau', to_date('15-02-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (327, 'Dou', to_date('10-03-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (328, 'Meg', to_date('05-09-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (329, 'Dr.', to_date('16-03-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (330, 'Pai', to_date('18-05-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (331, 'Ric', to_date('27-12-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (332, 'Amy', to_date('05-06-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (333, 'Dav', to_date('03-09-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (334, 'Jos', to_date('05-07-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (335, 'Sco', to_date('10-05-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (336, 'Phi', to_date('02-01-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (337, 'Con', to_date('23-11-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (338, 'Ter', to_date('12-09-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (339, 'Sha', to_date('17-05-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (340, 'Ker', to_date('12-08-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (341, 'Cha', to_date('05-07-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (342, 'Ran', to_date('31-07-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (343, 'Sar', to_date('10-08-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (344, 'Jam', to_date('17-08-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (345, 'Joh', to_date('05-07-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (346, 'Jen', to_date('18-07-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (347, 'Kat', to_date('22-05-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (348, 'Vir', to_date('25-12-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (349, 'Sab', to_date('30-01-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (350, 'Sus', to_date('06-07-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (351, 'Tho', to_date('29-06-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (352, 'Tim', to_date('06-11-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (353, 'Jef', to_date('11-09-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (354, 'Zac', to_date('20-06-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (355, 'And', to_date('29-05-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (356, 'Sha', to_date('22-05-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (357, 'Lui', to_date('07-05-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (358, 'Aar', to_date('03-11-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (359, 'Ver', to_date('13-02-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (360, 'Han', to_date('29-05-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (361, 'Kar', to_date('28-07-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (362, 'Bru', to_date('16-04-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (363, 'Jua', to_date('16-12-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (364, 'Amy', to_date('16-05-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (365, 'Lor', to_date('06-09-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (366, 'Jan', to_date('19-08-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (367, 'Car', to_date('10-06-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (368, 'Mon', to_date('27-12-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (369, 'Sar', to_date('01-03-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (370, 'Jen', to_date('22-11-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (371, 'Chr', to_date('07-11-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (372, 'Mas', to_date('05-01-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (373, 'Kat', to_date('30-01-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (374, 'Mic', to_date('25-05-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (375, 'Ste', to_date('31-01-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (376, 'Mic', to_date('10-10-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (377, 'Ale', to_date('18-09-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (378, 'Hea', to_date('30-05-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (379, 'Lau', to_date('19-01-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (380, 'Lin', to_date('15-07-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (381, 'Jes', to_date('20-04-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (382, 'Ama', to_date('25-08-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (383, 'Rob', to_date('18-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (384, 'Mic', to_date('20-06-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (385, 'Jay', to_date('04-05-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (386, 'Con', to_date('22-01-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (387, 'Tim', to_date('07-11-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (388, 'Cla', to_date('28-06-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (389, 'Rob', to_date('06-06-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (390, 'Cam', to_date('21-09-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (391, 'Ang', to_date('20-09-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (392, 'Mic', to_date('12-04-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (393, 'Lea', to_date('27-04-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (394, 'Bri', to_date('17-07-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (395, 'Kar', to_date('12-08-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (396, 'Ale', to_date('22-03-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (397, 'Ali', to_date('01-09-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (398, 'Sal', to_date('09-08-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (399, 'Chr', to_date('18-01-2015', 'dd-mm-yyyy'));
commit;
prompt 300 records committed...
insert into CHILD (child_id, name, birth_date)
values (400, 'Jas', to_date('22-03-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (401, 'Amb', to_date('09-07-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (402, 'Rac', to_date('20-08-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (403, 'Osc', to_date('08-11-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (404, 'Cla', to_date('09-09-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (405, 'Ant', to_date('31-01-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (406, 'Chr', to_date('05-03-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (407, 'Mon', to_date('02-06-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (408, 'Mat', to_date('29-01-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (409, 'Lau', to_date('14-06-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (410, 'Ama', to_date('24-02-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (411, 'Jen', to_date('17-06-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (412, 'Mel', to_date('28-03-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (413, 'Mic', to_date('17-07-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (414, 'Mar', to_date('01-11-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (415, 'Kar', to_date('01-07-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (416, 'Vic', to_date('10-12-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (417, 'Mic', to_date('16-01-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (418, 'Joh', to_date('28-01-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (419, 'Ric', to_date('17-02-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (420, 'Mic', to_date('12-12-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (421, 'Rya', to_date('23-02-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (422, 'Kim', to_date('12-12-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (423, 'Ste', to_date('10-01-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (424, 'Tho', to_date('20-12-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (425, 'Log', to_date('04-01-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (426, 'Mic', to_date('29-03-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (427, 'San', to_date('24-12-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (428, 'Bra', to_date('20-08-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (429, 'Chr', to_date('26-05-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (430, 'Mat', to_date('05-04-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (431, 'Sar', to_date('17-09-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (432, 'And', to_date('11-11-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (433, 'Ver', to_date('27-11-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (434, 'Pau', to_date('06-06-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (435, 'Pat', to_date('13-08-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (436, 'Cyn', to_date('11-11-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (437, 'Dyl', to_date('15-04-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (438, 'Jan', to_date('23-01-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (439, 'Ste', to_date('28-08-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (440, 'Mic', to_date('05-08-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (441, 'Mel', to_date('06-12-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (442, 'Wil', to_date('03-12-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (443, 'Tra', to_date('24-09-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (444, 'Van', to_date('09-10-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (445, 'Sha', to_date('07-10-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (446, 'Dia', to_date('25-12-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (447, 'Daw', to_date('18-04-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (448, 'Chr', to_date('19-08-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (449, 'Jul', to_date('21-05-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (450, 'Mrs', to_date('08-01-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (451, 'Bry', to_date('11-01-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (452, 'Pau', to_date('20-07-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (453, 'Mis', to_date('05-10-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (454, 'Ste', to_date('16-09-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (455, 'Wil', to_date('19-04-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (456, 'Lis', to_date('17-08-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (457, 'Mar', to_date('14-08-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (458, 'Zac', to_date('24-07-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (459, 'Mic', to_date('18-06-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (460, 'Cat', to_date('14-05-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (461, 'Chr', to_date('13-11-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (462, 'Bri', to_date('26-06-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (463, 'Dav', to_date('19-05-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (464, 'Jen', to_date('04-10-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (465, 'Vic', to_date('26-04-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (466, 'Dav', to_date('07-09-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (467, 'Kyl', to_date('16-12-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (468, 'Hol', to_date('15-01-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (469, 'Kri', to_date('12-04-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (470, 'Che', to_date('09-08-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (471, 'Ada', to_date('30-01-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (472, 'Ale', to_date('31-07-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (473, 'Mr.', to_date('22-08-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (474, 'Gre', to_date('05-10-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (475, 'Mic', to_date('09-10-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (476, 'Mar', to_date('14-08-2015', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (477, 'Bre', to_date('12-03-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (478, 'Tho', to_date('06-06-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (479, 'Aly', to_date('30-11-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (480, 'Jor', to_date('26-12-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (481, 'Bil', to_date('28-01-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (482, 'Rob', to_date('11-04-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (483, 'Ant', to_date('28-04-2016', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (484, 'Mar', to_date('29-10-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (485, 'Eth', to_date('09-12-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (486, 'Adr', to_date('27-04-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (487, 'Meg', to_date('23-12-2013', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (488, 'Kim', to_date('30-03-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (489, 'Jan', to_date('27-01-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (490, 'Eli', to_date('10-03-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (491, 'Sam', to_date('10-07-2014', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (492, 'Mel', to_date('30-08-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (493, 'Mar', to_date('17-03-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (494, 'Amb', to_date('13-10-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (495, 'Eri', to_date('14-09-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (496, 'Don', to_date('18-12-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (497, 'Jos', to_date('27-08-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (498, 'Mig', to_date('06-12-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (499, 'Wil', to_date('02-05-2020', 'dd-mm-yyyy'));
commit;
prompt 400 records loaded
prompt Loading GUARDIAN...
insert into GUARDIAN (guardian_id, name, birth_date)
values (101, 'Dr.', to_date('18-04-1982', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (102, 'Rob', to_date('25-02-1973', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (103, 'Ash', to_date('20-10-1964', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (106, 'Dr.', to_date('13-12-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (107, 'She', to_date('24-10-1986', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (109, 'Ant', to_date('12-03-1977', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (110, 'Jam', to_date('13-05-1975', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (111, 'Cha', to_date('09-04-1987', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (112, 'Cas', to_date('22-03-1977', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (113, 'Ste', to_date('25-08-1989', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (115, 'Phi', to_date('28-11-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (116, 'Rya', to_date('01-04-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (117, 'Jes', to_date('12-12-1985', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (118, 'Tod', to_date('24-02-1994', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (121, 'Mel', to_date('28-06-1977', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (124, 'All', to_date('15-08-1974', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (125, 'Car', to_date('28-11-1968', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (126, 'Chr', to_date('14-09-1970', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (127, 'Mar', to_date('19-02-1992', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (128, 'Den', to_date('13-02-1984', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (129, 'Tod', to_date('18-01-1983', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (130, 'Wil', to_date('03-02-1964', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (131, 'Bra', to_date('22-05-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (133, 'Mel', to_date('25-07-1989', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (137, 'Kyl', to_date('21-12-1966', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (139, 'Lau', to_date('26-12-1990', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (140, 'Ter', to_date('22-12-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (141, 'Jas', to_date('11-04-1964', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (143, 'Tro', to_date('22-01-1980', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (145, 'And', to_date('17-07-1973', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (147, 'Kev', to_date('06-10-1969', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (148, 'Ste', to_date('03-02-1966', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (155, 'Jef', to_date('15-06-1985', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (156, 'Nic', to_date('15-12-1965', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (161, 'Osc', to_date('17-04-1964', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (163, 'Kim', to_date('04-09-1963', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (164, 'Nat', to_date('06-08-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (165, 'Jil', to_date('17-10-1974', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (166, 'Chr', to_date('19-08-1986', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (167, 'Dav', to_date('26-10-1981', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (169, 'Tod', to_date('23-02-1972', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (170, 'Pat', to_date('26-03-1971', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (171, 'Mat', to_date('20-11-1966', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (172, 'Con', to_date('07-04-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (173, 'Kat', to_date('16-10-1968', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (174, 'Cyn', to_date('15-02-1984', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (175, 'Car', to_date('20-12-1984', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (176, 'Don', to_date('29-06-1969', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (177, 'Bra', to_date('06-06-1976', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (178, 'Cha', to_date('22-02-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (179, 'Mel', to_date('16-11-1963', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (180, 'Mat', to_date('01-10-1969', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (183, 'Val', to_date('12-07-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (184, 'Reb', to_date('22-02-1972', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (186, 'Mr.', to_date('21-09-1972', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (187, 'Eli', to_date('06-08-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (188, 'Mar', to_date('12-08-1976', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (189, 'Pat', to_date('17-10-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (190, 'Bry', to_date('24-04-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (191, 'And', to_date('08-02-1975', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (192, 'Kri', to_date('21-08-1975', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (193, 'Ral', to_date('05-01-1973', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (194, 'Rob', to_date('07-10-1992', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (195, 'Eri', to_date('28-07-1974', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (197, 'Ant', to_date('19-09-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (198, 'Kry', to_date('06-05-1966', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (200, 'Jas', to_date('21-01-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (201, 'Cod', to_date('19-05-1986', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (202, 'Jus', to_date('28-10-1972', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (203, 'Der', to_date('26-03-1972', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (204, 'The', to_date('31-05-1992', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (206, 'Kar', to_date('09-02-1967', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (208, 'Kim', to_date('15-03-1968', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (212, 'All', to_date('01-06-1973', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (213, 'Jon', to_date('01-06-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (216, 'Mor', to_date('04-02-1980', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (217, 'Tim', to_date('03-05-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (218, 'Mik', to_date('29-10-1989', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (219, 'Pet', to_date('11-10-1968', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (221, 'Sco', to_date('19-12-1984', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (222, 'Ant', to_date('16-04-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (223, 'Pat', to_date('09-12-1973', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (224, 'Tam', to_date('30-09-1964', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (225, 'Ste', to_date('24-07-1984', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (227, 'Bri', to_date('02-11-1981', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (232, 'Ash', to_date('20-11-1981', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (233, 'Sea', to_date('09-03-1983', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (235, 'Kel', to_date('02-09-1967', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (236, 'Sus', to_date('23-04-1994', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (238, 'Jes', to_date('17-01-1985', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (239, 'Ken', to_date('19-01-1973', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (241, 'Dia', to_date('01-10-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (242, 'Mat', to_date('09-12-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (244, 'Jen', to_date('30-03-1972', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (246, 'And', to_date('08-09-1968', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (247, 'Jos', to_date('11-11-1989', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (248, 'Mrs', to_date('14-08-1965', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (250, 'Jan', to_date('04-06-1981', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (251, 'Gre', to_date('02-10-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (252, 'Ann', to_date('09-02-1986', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into GUARDIAN (guardian_id, name, birth_date)
values (259, 'Lea', to_date('12-04-1965', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (260, 'Dr.', to_date('20-09-1972', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (261, 'Wil', to_date('26-07-1980', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (263, 'Vic', to_date('10-08-1985', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (264, 'Tam', to_date('27-04-1973', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (265, 'Mel', to_date('05-06-1963', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (266, 'Lin', to_date('08-09-1963', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (268, 'Mar', to_date('10-03-1967', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (269, 'She', to_date('25-11-1977', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (270, 'Ric', to_date('26-08-1975', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (271, 'Eli', to_date('25-02-1968', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (272, 'Jea', to_date('18-02-1989', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (274, 'Aar', to_date('11-09-1976', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (275, 'Jam', to_date('30-12-1981', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (277, 'Lau', to_date('24-06-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (278, 'Kri', to_date('24-09-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (283, 'Mr.', to_date('27-03-1976', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (284, 'Ari', to_date('28-01-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (285, 'Rob', to_date('04-09-1970', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (286, 'Kel', to_date('02-06-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (287, 'Peg', to_date('16-01-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (289, 'Rus', to_date('04-12-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (290, 'Joh', to_date('14-02-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (292, 'Emi', to_date('27-05-1972', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (293, 'Tif', to_date('22-05-1982', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (294, 'Jul', to_date('15-03-1966', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (295, 'Pat', to_date('19-05-1965', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (296, 'Jes', to_date('09-12-1968', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (298, 'Cin', to_date('18-05-1968', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (301, 'Kar', to_date('24-03-1970', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (302, 'Ste', to_date('17-09-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (303, 'Lee', to_date('01-06-1985', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (306, 'Nat', to_date('12-11-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (307, 'Bra', to_date('12-11-1990', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (308, 'All', to_date('24-07-1968', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (309, 'Jef', to_date('27-06-1986', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (310, 'Mic', to_date('05-08-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (312, 'Eri', to_date('02-08-1970', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (314, 'Tim', to_date('01-10-1982', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (316, 'Eri', to_date('26-08-1975', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (317, 'Les', to_date('27-09-1983', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (318, 'Jon', to_date('19-10-1975', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (319, 'Dan', to_date('15-07-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (320, 'Ray', to_date('30-05-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (321, 'Jes', to_date('30-07-1990', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (322, 'Dak', to_date('22-06-1969', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (324, 'Kur', to_date('29-12-1983', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (326, 'Bob', to_date('14-10-1990', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (327, 'Cor', to_date('02-10-1966', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (329, 'Con', to_date('08-06-1985', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (330, 'Spe', to_date('07-11-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (331, 'Den', to_date('12-06-1967', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (333, 'And', to_date('24-04-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (335, 'Jac', to_date('18-08-1976', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (336, 'Kay', to_date('30-09-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (338, 'Ang', to_date('16-03-1971', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (339, 'Wal', to_date('05-01-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (340, 'Tif', to_date('06-03-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (345, 'Joh', to_date('22-09-1976', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (346, 'How', to_date('12-08-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (347, 'Zac', to_date('17-09-1977', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (348, 'Ali', to_date('17-12-1976', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (351, 'Dan', to_date('03-12-1972', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (352, 'Jen', to_date('21-03-1966', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (354, 'Zac', to_date('16-09-1984', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (355, 'Ali', to_date('14-01-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (357, 'She', to_date('30-07-1976', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (358, 'Lau', to_date('26-02-1975', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (359, 'Pam', to_date('16-04-1964', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (360, 'Rho', to_date('30-06-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (362, 'Kim', to_date('15-06-1980', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (365, 'Jac', to_date('26-03-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (366, 'Han', to_date('04-07-1965', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (367, 'Ang', to_date('09-10-1987', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (369, 'Car', to_date('12-09-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (372, 'Bil', to_date('12-02-1992', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (373, 'Tho', to_date('19-12-1981', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (374, 'Pau', to_date('18-02-1982', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (375, 'Jon', to_date('08-08-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (376, 'Sar', to_date('26-10-1981', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (377, 'Mic', to_date('13-11-1984', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (378, 'Geo', to_date('26-10-1980', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (379, 'Chr', to_date('04-12-1977', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (380, 'Ben', to_date('02-03-1985', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (382, 'Amy', to_date('28-01-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (386, 'Tho', to_date('26-06-1964', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (387, 'Lea', to_date('09-11-1983', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (390, 'Chr', to_date('17-02-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (391, 'Eli', to_date('30-10-1990', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (392, 'Mar', to_date('13-03-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (393, 'Cla', to_date('02-05-1969', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (394, 'Tim', to_date('08-03-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (395, 'Vic', to_date('18-02-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (396, 'Bri', to_date('30-10-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (398, 'Jen', to_date('20-10-1971', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (400, 'Pam', to_date('07-05-1964', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (402, 'Mic', to_date('25-10-1970', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (403, 'Ang', to_date('31-08-1974', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (404, 'Meg', to_date('23-10-1983', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (405, 'Tam', to_date('10-02-1964', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into GUARDIAN (guardian_id, name, birth_date)
values (406, 'Eil', to_date('10-07-1981', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (407, 'Bra', to_date('29-04-1990', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (408, 'Che', to_date('25-08-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (410, 'Pat', to_date('01-03-1970', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (411, 'Chr', to_date('06-09-1966', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (416, 'Amy', to_date('22-10-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (417, 'Amy', to_date('25-10-1992', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (418, 'Rya', to_date('24-04-1986', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (419, 'Rac', to_date('19-07-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (420, 'Eri', to_date('20-04-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (421, 'Cyn', to_date('29-07-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (422, 'Ste', to_date('06-01-1973', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (424, 'Sar', to_date('27-08-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (425, 'Ant', to_date('02-06-1964', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (426, 'Mar', to_date('25-09-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (429, 'Mat', to_date('24-03-1990', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (430, 'Mic', to_date('15-08-1973', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (431, 'Ste', to_date('16-06-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (434, 'Mar', to_date('24-08-1970', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (435, 'Bra', to_date('01-11-1963', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (436, 'Ray', to_date('12-07-1990', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (438, 'Ste', to_date('08-06-1980', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (440, 'Cha', to_date('07-09-1963', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (441, 'Ant', to_date('18-01-1986', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (442, 'Lau', to_date('30-09-1983', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (444, 'Chr', to_date('27-11-1975', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (445, 'She', to_date('16-03-1966', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (446, 'Kar', to_date('15-02-1967', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (447, 'Nic', to_date('21-10-1982', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (448, 'Dr.', to_date('07-01-1970', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (449, 'Wil', to_date('13-06-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (450, 'Rog', to_date('25-04-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (452, 'Rob', to_date('07-01-1989', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (453, 'Cha', to_date('25-02-1994', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (455, 'Bev', to_date('11-08-1986', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (456, 'Den', to_date('17-04-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (462, 'Van', to_date('15-05-1971', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (463, 'Kyl', to_date('01-03-1974', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (466, 'Lin', to_date('13-11-1979', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (468, 'Mic', to_date('31-03-1980', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (469, 'Tam', to_date('06-06-1970', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (471, 'Suz', to_date('07-06-1986', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (472, 'Tay', to_date('15-12-1969', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (473, 'Cyn', to_date('18-05-1987', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (474, 'Hea', to_date('15-02-1968', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (475, 'Ang', to_date('14-08-1985', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (476, 'Joh', to_date('04-06-1977', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (478, 'Bre', to_date('21-09-1990', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (480, 'Jan', to_date('14-08-1982', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (481, 'Cur', to_date('25-06-1976', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (482, 'Mic', to_date('24-06-1975', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (483, 'Ric', to_date('19-03-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (486, 'Mic', to_date('21-10-1978', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (489, 'Tim', to_date('08-04-1991', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (490, 'Jil', to_date('30-07-1989', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (491, 'Pau', to_date('14-09-1989', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (492, 'Lin', to_date('04-12-1964', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (494, 'Kim', to_date('08-05-1993', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (496, 'And', to_date('21-01-1980', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (497, 'Hen', to_date('17-11-1988', 'dd-mm-yyyy'));
insert into GUARDIAN (guardian_id, name, birth_date)
values (498, 'Gin', to_date('05-05-1969', 'dd-mm-yyyy'));
commit;
prompt 261 records loaded
prompt Loading GUARDIAN_OF...
insert into GUARDIAN_OF (child_id, guardian_id)
values (100, 111);
insert into GUARDIAN_OF (child_id, guardian_id)
values (101, 455);
insert into GUARDIAN_OF (child_id, guardian_id)
values (102, 112);
insert into GUARDIAN_OF (child_id, guardian_id)
values (103, 221);
insert into GUARDIAN_OF (child_id, guardian_id)
values (104, 339);
insert into GUARDIAN_OF (child_id, guardian_id)
values (105, 287);
insert into GUARDIAN_OF (child_id, guardian_id)
values (106, 387);
insert into GUARDIAN_OF (child_id, guardian_id)
values (107, 223);
insert into GUARDIAN_OF (child_id, guardian_id)
values (108, 321);
insert into GUARDIAN_OF (child_id, guardian_id)
values (109, 269);
insert into GUARDIAN_OF (child_id, guardian_id)
values (110, 452);
insert into GUARDIAN_OF (child_id, guardian_id)
values (111, 359);
insert into GUARDIAN_OF (child_id, guardian_id)
values (112, 411);
insert into GUARDIAN_OF (child_id, guardian_id)
values (113, 283);
insert into GUARDIAN_OF (child_id, guardian_id)
values (114, 204);
insert into GUARDIAN_OF (child_id, guardian_id)
values (115, 444);
insert into GUARDIAN_OF (child_id, guardian_id)
values (116, 408);
insert into GUARDIAN_OF (child_id, guardian_id)
values (117, 107);
insert into GUARDIAN_OF (child_id, guardian_id)
values (118, 338);
insert into GUARDIAN_OF (child_id, guardian_id)
values (119, 481);
insert into GUARDIAN_OF (child_id, guardian_id)
values (120, 482);
insert into GUARDIAN_OF (child_id, guardian_id)
values (121, 410);
insert into GUARDIAN_OF (child_id, guardian_id)
values (122, 403);
insert into GUARDIAN_OF (child_id, guardian_id)
values (123, 318);
insert into GUARDIAN_OF (child_id, guardian_id)
values (124, 294);
insert into GUARDIAN_OF (child_id, guardian_id)
values (125, 336);
insert into GUARDIAN_OF (child_id, guardian_id)
values (126, 186);
insert into GUARDIAN_OF (child_id, guardian_id)
values (127, 351);
insert into GUARDIAN_OF (child_id, guardian_id)
values (128, 212);
insert into GUARDIAN_OF (child_id, guardian_id)
values (129, 340);
insert into GUARDIAN_OF (child_id, guardian_id)
values (130, 178);
insert into GUARDIAN_OF (child_id, guardian_id)
values (131, 410);
insert into GUARDIAN_OF (child_id, guardian_id)
values (132, 202);
insert into GUARDIAN_OF (child_id, guardian_id)
values (133, 248);
insert into GUARDIAN_OF (child_id, guardian_id)
values (134, 148);
insert into GUARDIAN_OF (child_id, guardian_id)
values (135, 440);
insert into GUARDIAN_OF (child_id, guardian_id)
values (136, 110);
insert into GUARDIAN_OF (child_id, guardian_id)
values (137, 213);
insert into GUARDIAN_OF (child_id, guardian_id)
values (138, 197);
insert into GUARDIAN_OF (child_id, guardian_id)
values (139, 292);
insert into GUARDIAN_OF (child_id, guardian_id)
values (140, 307);
insert into GUARDIAN_OF (child_id, guardian_id)
values (141, 330);
insert into GUARDIAN_OF (child_id, guardian_id)
values (142, 298);
insert into GUARDIAN_OF (child_id, guardian_id)
values (143, 456);
insert into GUARDIAN_OF (child_id, guardian_id)
values (144, 203);
insert into GUARDIAN_OF (child_id, guardian_id)
values (145, 380);
insert into GUARDIAN_OF (child_id, guardian_id)
values (146, 106);
insert into GUARDIAN_OF (child_id, guardian_id)
values (147, 436);
insert into GUARDIAN_OF (child_id, guardian_id)
values (148, 222);
insert into GUARDIAN_OF (child_id, guardian_id)
values (149, 475);
insert into GUARDIAN_OF (child_id, guardian_id)
values (150, 446);
insert into GUARDIAN_OF (child_id, guardian_id)
values (151, 404);
insert into GUARDIAN_OF (child_id, guardian_id)
values (152, 128);
insert into GUARDIAN_OF (child_id, guardian_id)
values (153, 268);
insert into GUARDIAN_OF (child_id, guardian_id)
values (154, 449);
insert into GUARDIAN_OF (child_id, guardian_id)
values (155, 239);
insert into GUARDIAN_OF (child_id, guardian_id)
values (156, 301);
insert into GUARDIAN_OF (child_id, guardian_id)
values (157, 103);
insert into GUARDIAN_OF (child_id, guardian_id)
values (158, 369);
insert into GUARDIAN_OF (child_id, guardian_id)
values (159, 172);
insert into GUARDIAN_OF (child_id, guardian_id)
values (160, 250);
insert into GUARDIAN_OF (child_id, guardian_id)
values (161, 367);
insert into GUARDIAN_OF (child_id, guardian_id)
values (162, 219);
insert into GUARDIAN_OF (child_id, guardian_id)
values (163, 167);
insert into GUARDIAN_OF (child_id, guardian_id)
values (164, 366);
insert into GUARDIAN_OF (child_id, guardian_id)
values (165, 216);
insert into GUARDIAN_OF (child_id, guardian_id)
values (166, 483);
insert into GUARDIAN_OF (child_id, guardian_id)
values (167, 435);
insert into GUARDIAN_OF (child_id, guardian_id)
values (168, 203);
insert into GUARDIAN_OF (child_id, guardian_id)
values (169, 147);
insert into GUARDIAN_OF (child_id, guardian_id)
values (170, 434);
insert into GUARDIAN_OF (child_id, guardian_id)
values (171, 425);
insert into GUARDIAN_OF (child_id, guardian_id)
values (172, 271);
insert into GUARDIAN_OF (child_id, guardian_id)
values (173, 175);
insert into GUARDIAN_OF (child_id, guardian_id)
values (174, 118);
insert into GUARDIAN_OF (child_id, guardian_id)
values (175, 490);
insert into GUARDIAN_OF (child_id, guardian_id)
values (176, 462);
insert into GUARDIAN_OF (child_id, guardian_id)
values (177, 298);
insert into GUARDIAN_OF (child_id, guardian_id)
values (178, 130);
insert into GUARDIAN_OF (child_id, guardian_id)
values (179, 156);
insert into GUARDIAN_OF (child_id, guardian_id)
values (180, 272);
insert into GUARDIAN_OF (child_id, guardian_id)
values (181, 402);
insert into GUARDIAN_OF (child_id, guardian_id)
values (182, 238);
insert into GUARDIAN_OF (child_id, guardian_id)
values (183, 217);
insert into GUARDIAN_OF (child_id, guardian_id)
values (184, 133);
insert into GUARDIAN_OF (child_id, guardian_id)
values (185, 494);
insert into GUARDIAN_OF (child_id, guardian_id)
values (186, 394);
insert into GUARDIAN_OF (child_id, guardian_id)
values (187, 360);
insert into GUARDIAN_OF (child_id, guardian_id)
values (188, 441);
insert into GUARDIAN_OF (child_id, guardian_id)
values (189, 208);
insert into GUARDIAN_OF (child_id, guardian_id)
values (190, 176);
insert into GUARDIAN_OF (child_id, guardian_id)
values (191, 161);
insert into GUARDIAN_OF (child_id, guardian_id)
values (192, 173);
insert into GUARDIAN_OF (child_id, guardian_id)
values (193, 283);
insert into GUARDIAN_OF (child_id, guardian_id)
values (194, 406);
insert into GUARDIAN_OF (child_id, guardian_id)
values (195, 141);
insert into GUARDIAN_OF (child_id, guardian_id)
values (196, 293);
insert into GUARDIAN_OF (child_id, guardian_id)
values (197, 346);
insert into GUARDIAN_OF (child_id, guardian_id)
values (198, 391);
insert into GUARDIAN_OF (child_id, guardian_id)
values (199, 139);
commit;
prompt 100 records committed...
insert into GUARDIAN_OF (child_id, guardian_id)
values (200, 431);
insert into GUARDIAN_OF (child_id, guardian_id)
values (201, 303);
insert into GUARDIAN_OF (child_id, guardian_id)
values (202, 318);
insert into GUARDIAN_OF (child_id, guardian_id)
values (203, 277);
insert into GUARDIAN_OF (child_id, guardian_id)
values (204, 239);
insert into GUARDIAN_OF (child_id, guardian_id)
values (205, 284);
insert into GUARDIAN_OF (child_id, guardian_id)
values (206, 463);
insert into GUARDIAN_OF (child_id, guardian_id)
values (207, 377);
insert into GUARDIAN_OF (child_id, guardian_id)
values (208, 115);
insert into GUARDIAN_OF (child_id, guardian_id)
values (209, 219);
insert into GUARDIAN_OF (child_id, guardian_id)
values (210, 148);
insert into GUARDIAN_OF (child_id, guardian_id)
values (211, 118);
insert into GUARDIAN_OF (child_id, guardian_id)
values (212, 473);
insert into GUARDIAN_OF (child_id, guardian_id)
values (213, 213);
insert into GUARDIAN_OF (child_id, guardian_id)
values (214, 296);
insert into GUARDIAN_OF (child_id, guardian_id)
values (215, 366);
insert into GUARDIAN_OF (child_id, guardian_id)
values (216, 489);
insert into GUARDIAN_OF (child_id, guardian_id)
values (217, 191);
insert into GUARDIAN_OF (child_id, guardian_id)
values (218, 312);
insert into GUARDIAN_OF (child_id, guardian_id)
values (219, 203);
insert into GUARDIAN_OF (child_id, guardian_id)
values (220, 471);
insert into GUARDIAN_OF (child_id, guardian_id)
values (221, 174);
insert into GUARDIAN_OF (child_id, guardian_id)
values (222, 161);
insert into GUARDIAN_OF (child_id, guardian_id)
values (223, 247);
insert into GUARDIAN_OF (child_id, guardian_id)
values (224, 188);
insert into GUARDIAN_OF (child_id, guardian_id)
values (225, 263);
insert into GUARDIAN_OF (child_id, guardian_id)
values (226, 163);
insert into GUARDIAN_OF (child_id, guardian_id)
values (227, 213);
insert into GUARDIAN_OF (child_id, guardian_id)
values (228, 324);
insert into GUARDIAN_OF (child_id, guardian_id)
values (229, 303);
insert into GUARDIAN_OF (child_id, guardian_id)
values (230, 357);
insert into GUARDIAN_OF (child_id, guardian_id)
values (231, 316);
insert into GUARDIAN_OF (child_id, guardian_id)
values (232, 362);
insert into GUARDIAN_OF (child_id, guardian_id)
values (233, 476);
insert into GUARDIAN_OF (child_id, guardian_id)
values (234, 177);
insert into GUARDIAN_OF (child_id, guardian_id)
values (235, 236);
insert into GUARDIAN_OF (child_id, guardian_id)
values (236, 295);
insert into GUARDIAN_OF (child_id, guardian_id)
values (237, 218);
insert into GUARDIAN_OF (child_id, guardian_id)
values (238, 492);
insert into GUARDIAN_OF (child_id, guardian_id)
values (239, 265);
insert into GUARDIAN_OF (child_id, guardian_id)
values (240, 444);
insert into GUARDIAN_OF (child_id, guardian_id)
values (241, 110);
insert into GUARDIAN_OF (child_id, guardian_id)
values (242, 140);
insert into GUARDIAN_OF (child_id, guardian_id)
values (243, 164);
insert into GUARDIAN_OF (child_id, guardian_id)
values (244, 197);
insert into GUARDIAN_OF (child_id, guardian_id)
values (245, 316);
insert into GUARDIAN_OF (child_id, guardian_id)
values (246, 404);
insert into GUARDIAN_OF (child_id, guardian_id)
values (247, 133);
insert into GUARDIAN_OF (child_id, guardian_id)
values (248, 141);
insert into GUARDIAN_OF (child_id, guardian_id)
values (249, 447);
insert into GUARDIAN_OF (child_id, guardian_id)
values (250, 183);
insert into GUARDIAN_OF (child_id, guardian_id)
values (251, 419);
insert into GUARDIAN_OF (child_id, guardian_id)
values (252, 200);
insert into GUARDIAN_OF (child_id, guardian_id)
values (253, 201);
insert into GUARDIAN_OF (child_id, guardian_id)
values (254, 289);
insert into GUARDIAN_OF (child_id, guardian_id)
values (255, 193);
insert into GUARDIAN_OF (child_id, guardian_id)
values (256, 455);
insert into GUARDIAN_OF (child_id, guardian_id)
values (257, 264);
insert into GUARDIAN_OF (child_id, guardian_id)
values (258, 223);
insert into GUARDIAN_OF (child_id, guardian_id)
values (259, 391);
insert into GUARDIAN_OF (child_id, guardian_id)
values (260, 260);
insert into GUARDIAN_OF (child_id, guardian_id)
values (261, 236);
insert into GUARDIAN_OF (child_id, guardian_id)
values (262, 468);
insert into GUARDIAN_OF (child_id, guardian_id)
values (263, 161);
insert into GUARDIAN_OF (child_id, guardian_id)
values (264, 124);
insert into GUARDIAN_OF (child_id, guardian_id)
values (265, 444);
insert into GUARDIAN_OF (child_id, guardian_id)
values (266, 244);
insert into GUARDIAN_OF (child_id, guardian_id)
values (267, 217);
insert into GUARDIAN_OF (child_id, guardian_id)
values (268, 176);
insert into GUARDIAN_OF (child_id, guardian_id)
values (269, 222);
insert into GUARDIAN_OF (child_id, guardian_id)
values (270, 372);
insert into GUARDIAN_OF (child_id, guardian_id)
values (271, 130);
insert into GUARDIAN_OF (child_id, guardian_id)
values (272, 290);
insert into GUARDIAN_OF (child_id, guardian_id)
values (273, 118);
insert into GUARDIAN_OF (child_id, guardian_id)
values (274, 190);
insert into GUARDIAN_OF (child_id, guardian_id)
values (275, 272);
insert into GUARDIAN_OF (child_id, guardian_id)
values (276, 271);
insert into GUARDIAN_OF (child_id, guardian_id)
values (277, 400);
insert into GUARDIAN_OF (child_id, guardian_id)
values (278, 355);
insert into GUARDIAN_OF (child_id, guardian_id)
values (279, 426);
insert into GUARDIAN_OF (child_id, guardian_id)
values (280, 194);
insert into GUARDIAN_OF (child_id, guardian_id)
values (281, 329);
insert into GUARDIAN_OF (child_id, guardian_id)
values (282, 294);
insert into GUARDIAN_OF (child_id, guardian_id)
values (283, 391);
insert into GUARDIAN_OF (child_id, guardian_id)
values (284, 294);
insert into GUARDIAN_OF (child_id, guardian_id)
values (285, 375);
insert into GUARDIAN_OF (child_id, guardian_id)
values (286, 327);
insert into GUARDIAN_OF (child_id, guardian_id)
values (287, 392);
insert into GUARDIAN_OF (child_id, guardian_id)
values (288, 292);
insert into GUARDIAN_OF (child_id, guardian_id)
values (289, 424);
insert into GUARDIAN_OF (child_id, guardian_id)
values (290, 224);
insert into GUARDIAN_OF (child_id, guardian_id)
values (291, 418);
insert into GUARDIAN_OF (child_id, guardian_id)
values (292, 156);
insert into GUARDIAN_OF (child_id, guardian_id)
values (293, 374);
insert into GUARDIAN_OF (child_id, guardian_id)
values (294, 421);
insert into GUARDIAN_OF (child_id, guardian_id)
values (295, 101);
insert into GUARDIAN_OF (child_id, guardian_id)
values (296, 396);
insert into GUARDIAN_OF (child_id, guardian_id)
values (297, 365);
insert into GUARDIAN_OF (child_id, guardian_id)
values (298, 259);
insert into GUARDIAN_OF (child_id, guardian_id)
values (299, 471);
commit;
prompt 200 records committed...
insert into GUARDIAN_OF (child_id, guardian_id)
values (300, 478);
insert into GUARDIAN_OF (child_id, guardian_id)
values (301, 420);
insert into GUARDIAN_OF (child_id, guardian_id)
values (302, 475);
insert into GUARDIAN_OF (child_id, guardian_id)
values (303, 183);
insert into GUARDIAN_OF (child_id, guardian_id)
values (304, 448);
insert into GUARDIAN_OF (child_id, guardian_id)
values (305, 171);
insert into GUARDIAN_OF (child_id, guardian_id)
values (306, 490);
insert into GUARDIAN_OF (child_id, guardian_id)
values (307, 147);
insert into GUARDIAN_OF (child_id, guardian_id)
values (308, 179);
insert into GUARDIAN_OF (child_id, guardian_id)
values (309, 232);
insert into GUARDIAN_OF (child_id, guardian_id)
values (310, 347);
insert into GUARDIAN_OF (child_id, guardian_id)
values (311, 189);
insert into GUARDIAN_OF (child_id, guardian_id)
values (312, 308);
insert into GUARDIAN_OF (child_id, guardian_id)
values (313, 486);
insert into GUARDIAN_OF (child_id, guardian_id)
values (314, 438);
insert into GUARDIAN_OF (child_id, guardian_id)
values (315, 235);
insert into GUARDIAN_OF (child_id, guardian_id)
values (316, 278);
insert into GUARDIAN_OF (child_id, guardian_id)
values (317, 260);
insert into GUARDIAN_OF (child_id, guardian_id)
values (318, 251);
insert into GUARDIAN_OF (child_id, guardian_id)
values (319, 270);
insert into GUARDIAN_OF (child_id, guardian_id)
values (320, 172);
insert into GUARDIAN_OF (child_id, guardian_id)
values (321, 261);
insert into GUARDIAN_OF (child_id, guardian_id)
values (322, 310);
insert into GUARDIAN_OF (child_id, guardian_id)
values (323, 164);
insert into GUARDIAN_OF (child_id, guardian_id)
values (324, 324);
insert into GUARDIAN_OF (child_id, guardian_id)
values (325, 227);
insert into GUARDIAN_OF (child_id, guardian_id)
values (326, 316);
insert into GUARDIAN_OF (child_id, guardian_id)
values (327, 192);
insert into GUARDIAN_OF (child_id, guardian_id)
values (328, 418);
insert into GUARDIAN_OF (child_id, guardian_id)
values (329, 377);
insert into GUARDIAN_OF (child_id, guardian_id)
values (330, 269);
insert into GUARDIAN_OF (child_id, guardian_id)
values (331, 378);
insert into GUARDIAN_OF (child_id, guardian_id)
values (332, 251);
insert into GUARDIAN_OF (child_id, guardian_id)
values (333, 416);
insert into GUARDIAN_OF (child_id, guardian_id)
values (334, 178);
insert into GUARDIAN_OF (child_id, guardian_id)
values (335, 463);
insert into GUARDIAN_OF (child_id, guardian_id)
values (336, 471);
insert into GUARDIAN_OF (child_id, guardian_id)
values (337, 379);
insert into GUARDIAN_OF (child_id, guardian_id)
values (338, 137);
insert into GUARDIAN_OF (child_id, guardian_id)
values (339, 429);
insert into GUARDIAN_OF (child_id, guardian_id)
values (340, 462);
insert into GUARDIAN_OF (child_id, guardian_id)
values (341, 466);
insert into GUARDIAN_OF (child_id, guardian_id)
values (342, 186);
insert into GUARDIAN_OF (child_id, guardian_id)
values (343, 393);
insert into GUARDIAN_OF (child_id, guardian_id)
values (344, 298);
insert into GUARDIAN_OF (child_id, guardian_id)
values (345, 346);
insert into GUARDIAN_OF (child_id, guardian_id)
values (346, 314);
insert into GUARDIAN_OF (child_id, guardian_id)
values (347, 395);
insert into GUARDIAN_OF (child_id, guardian_id)
values (348, 130);
insert into GUARDIAN_OF (child_id, guardian_id)
values (349, 102);
insert into GUARDIAN_OF (child_id, guardian_id)
values (350, 242);
insert into GUARDIAN_OF (child_id, guardian_id)
values (351, 283);
insert into GUARDIAN_OF (child_id, guardian_id)
values (352, 126);
insert into GUARDIAN_OF (child_id, guardian_id)
values (353, 275);
insert into GUARDIAN_OF (child_id, guardian_id)
values (354, 331);
insert into GUARDIAN_OF (child_id, guardian_id)
values (355, 435);
insert into GUARDIAN_OF (child_id, guardian_id)
values (356, 133);
insert into GUARDIAN_OF (child_id, guardian_id)
values (357, 187);
insert into GUARDIAN_OF (child_id, guardian_id)
values (358, 263);
insert into GUARDIAN_OF (child_id, guardian_id)
values (359, 125);
insert into GUARDIAN_OF (child_id, guardian_id)
values (360, 382);
insert into GUARDIAN_OF (child_id, guardian_id)
values (361, 201);
insert into GUARDIAN_OF (child_id, guardian_id)
values (362, 225);
insert into GUARDIAN_OF (child_id, guardian_id)
values (363, 449);
insert into GUARDIAN_OF (child_id, guardian_id)
values (364, 203);
insert into GUARDIAN_OF (child_id, guardian_id)
values (365, 498);
insert into GUARDIAN_OF (child_id, guardian_id)
values (366, 266);
insert into GUARDIAN_OF (child_id, guardian_id)
values (367, 442);
insert into GUARDIAN_OF (child_id, guardian_id)
values (368, 265);
insert into GUARDIAN_OF (child_id, guardian_id)
values (369, 233);
insert into GUARDIAN_OF (child_id, guardian_id)
values (370, 335);
insert into GUARDIAN_OF (child_id, guardian_id)
values (371, 285);
insert into GUARDIAN_OF (child_id, guardian_id)
values (372, 316);
insert into GUARDIAN_OF (child_id, guardian_id)
values (373, 232);
insert into GUARDIAN_OF (child_id, guardian_id)
values (374, 481);
insert into GUARDIAN_OF (child_id, guardian_id)
values (375, 445);
insert into GUARDIAN_OF (child_id, guardian_id)
values (376, 137);
insert into GUARDIAN_OF (child_id, guardian_id)
values (377, 121);
insert into GUARDIAN_OF (child_id, guardian_id)
values (378, 327);
insert into GUARDIAN_OF (child_id, guardian_id)
values (379, 450);
insert into GUARDIAN_OF (child_id, guardian_id)
values (380, 286);
insert into GUARDIAN_OF (child_id, guardian_id)
values (381, 429);
insert into GUARDIAN_OF (child_id, guardian_id)
values (382, 287);
insert into GUARDIAN_OF (child_id, guardian_id)
values (383, 317);
insert into GUARDIAN_OF (child_id, guardian_id)
values (384, 139);
insert into GUARDIAN_OF (child_id, guardian_id)
values (385, 348);
insert into GUARDIAN_OF (child_id, guardian_id)
values (386, 246);
insert into GUARDIAN_OF (child_id, guardian_id)
values (387, 164);
insert into GUARDIAN_OF (child_id, guardian_id)
values (388, 407);
insert into GUARDIAN_OF (child_id, guardian_id)
values (389, 326);
insert into GUARDIAN_OF (child_id, guardian_id)
values (390, 373);
insert into GUARDIAN_OF (child_id, guardian_id)
values (391, 417);
insert into GUARDIAN_OF (child_id, guardian_id)
values (392, 239);
insert into GUARDIAN_OF (child_id, guardian_id)
values (393, 338);
insert into GUARDIAN_OF (child_id, guardian_id)
values (394, 386);
insert into GUARDIAN_OF (child_id, guardian_id)
values (395, 327);
insert into GUARDIAN_OF (child_id, guardian_id)
values (396, 298);
insert into GUARDIAN_OF (child_id, guardian_id)
values (397, 435);
insert into GUARDIAN_OF (child_id, guardian_id)
values (398, 129);
insert into GUARDIAN_OF (child_id, guardian_id)
values (399, 223);
commit;
prompt 300 records committed...
insert into GUARDIAN_OF (child_id, guardian_id)
values (400, 496);
insert into GUARDIAN_OF (child_id, guardian_id)
values (401, 203);
insert into GUARDIAN_OF (child_id, guardian_id)
values (402, 394);
insert into GUARDIAN_OF (child_id, guardian_id)
values (403, 216);
insert into GUARDIAN_OF (child_id, guardian_id)
values (404, 393);
insert into GUARDIAN_OF (child_id, guardian_id)
values (405, 345);
insert into GUARDIAN_OF (child_id, guardian_id)
values (406, 250);
insert into GUARDIAN_OF (child_id, guardian_id)
values (407, 180);
insert into GUARDIAN_OF (child_id, guardian_id)
values (408, 352);
insert into GUARDIAN_OF (child_id, guardian_id)
values (409, 405);
insert into GUARDIAN_OF (child_id, guardian_id)
values (410, 390);
insert into GUARDIAN_OF (child_id, guardian_id)
values (411, 307);
insert into GUARDIAN_OF (child_id, guardian_id)
values (412, 438);
insert into GUARDIAN_OF (child_id, guardian_id)
values (413, 449);
insert into GUARDIAN_OF (child_id, guardian_id)
values (414, 179);
insert into GUARDIAN_OF (child_id, guardian_id)
values (415, 491);
insert into GUARDIAN_OF (child_id, guardian_id)
values (416, 155);
insert into GUARDIAN_OF (child_id, guardian_id)
values (417, 143);
insert into GUARDIAN_OF (child_id, guardian_id)
values (418, 117);
insert into GUARDIAN_OF (child_id, guardian_id)
values (419, 419);
insert into GUARDIAN_OF (child_id, guardian_id)
values (420, 227);
insert into GUARDIAN_OF (child_id, guardian_id)
values (421, 398);
insert into GUARDIAN_OF (child_id, guardian_id)
values (422, 369);
insert into GUARDIAN_OF (child_id, guardian_id)
values (423, 422);
insert into GUARDIAN_OF (child_id, guardian_id)
values (424, 497);
insert into GUARDIAN_OF (child_id, guardian_id)
values (425, 473);
insert into GUARDIAN_OF (child_id, guardian_id)
values (426, 118);
insert into GUARDIAN_OF (child_id, guardian_id)
values (427, 386);
insert into GUARDIAN_OF (child_id, guardian_id)
values (428, 156);
insert into GUARDIAN_OF (child_id, guardian_id)
values (429, 274);
insert into GUARDIAN_OF (child_id, guardian_id)
values (430, 164);
insert into GUARDIAN_OF (child_id, guardian_id)
values (431, 140);
insert into GUARDIAN_OF (child_id, guardian_id)
values (432, 184);
insert into GUARDIAN_OF (child_id, guardian_id)
values (433, 145);
insert into GUARDIAN_OF (child_id, guardian_id)
values (434, 131);
insert into GUARDIAN_OF (child_id, guardian_id)
values (435, 456);
insert into GUARDIAN_OF (child_id, guardian_id)
values (436, 402);
insert into GUARDIAN_OF (child_id, guardian_id)
values (437, 498);
insert into GUARDIAN_OF (child_id, guardian_id)
values (438, 116);
insert into GUARDIAN_OF (child_id, guardian_id)
values (439, 263);
insert into GUARDIAN_OF (child_id, guardian_id)
values (440, 430);
insert into GUARDIAN_OF (child_id, guardian_id)
values (441, 169);
insert into GUARDIAN_OF (child_id, guardian_id)
values (442, 320);
insert into GUARDIAN_OF (child_id, guardian_id)
values (443, 206);
insert into GUARDIAN_OF (child_id, guardian_id)
values (444, 333);
insert into GUARDIAN_OF (child_id, guardian_id)
values (445, 453);
insert into GUARDIAN_OF (child_id, guardian_id)
values (446, 320);
insert into GUARDIAN_OF (child_id, guardian_id)
values (447, 354);
insert into GUARDIAN_OF (child_id, guardian_id)
values (448, 472);
insert into GUARDIAN_OF (child_id, guardian_id)
values (449, 302);
insert into GUARDIAN_OF (child_id, guardian_id)
values (450, 113);
insert into GUARDIAN_OF (child_id, guardian_id)
values (451, 396);
insert into GUARDIAN_OF (child_id, guardian_id)
values (452, 130);
insert into GUARDIAN_OF (child_id, guardian_id)
values (453, 239);
insert into GUARDIAN_OF (child_id, guardian_id)
values (454, 376);
insert into GUARDIAN_OF (child_id, guardian_id)
values (455, 322);
insert into GUARDIAN_OF (child_id, guardian_id)
values (456, 217);
insert into GUARDIAN_OF (child_id, guardian_id)
values (457, 268);
insert into GUARDIAN_OF (child_id, guardian_id)
values (458, 290);
insert into GUARDIAN_OF (child_id, guardian_id)
values (459, 131);
insert into GUARDIAN_OF (child_id, guardian_id)
values (460, 252);
insert into GUARDIAN_OF (child_id, guardian_id)
values (461, 348);
insert into GUARDIAN_OF (child_id, guardian_id)
values (462, 174);
insert into GUARDIAN_OF (child_id, guardian_id)
values (463, 358);
insert into GUARDIAN_OF (child_id, guardian_id)
values (464, 306);
insert into GUARDIAN_OF (child_id, guardian_id)
values (465, 492);
insert into GUARDIAN_OF (child_id, guardian_id)
values (466, 269);
insert into GUARDIAN_OF (child_id, guardian_id)
values (467, 165);
insert into GUARDIAN_OF (child_id, guardian_id)
values (468, 310);
insert into GUARDIAN_OF (child_id, guardian_id)
values (469, 469);
insert into GUARDIAN_OF (child_id, guardian_id)
values (470, 309);
insert into GUARDIAN_OF (child_id, guardian_id)
values (471, 195);
insert into GUARDIAN_OF (child_id, guardian_id)
values (472, 410);
insert into GUARDIAN_OF (child_id, guardian_id)
values (473, 369);
insert into GUARDIAN_OF (child_id, guardian_id)
values (474, 241);
insert into GUARDIAN_OF (child_id, guardian_id)
values (475, 318);
insert into GUARDIAN_OF (child_id, guardian_id)
values (476, 175);
insert into GUARDIAN_OF (child_id, guardian_id)
values (477, 212);
insert into GUARDIAN_OF (child_id, guardian_id)
values (478, 115);
insert into GUARDIAN_OF (child_id, guardian_id)
values (479, 489);
insert into GUARDIAN_OF (child_id, guardian_id)
values (480, 145);
insert into GUARDIAN_OF (child_id, guardian_id)
values (481, 453);
insert into GUARDIAN_OF (child_id, guardian_id)
values (482, 111);
insert into GUARDIAN_OF (child_id, guardian_id)
values (483, 224);
insert into GUARDIAN_OF (child_id, guardian_id)
values (484, 109);
insert into GUARDIAN_OF (child_id, guardian_id)
values (485, 166);
insert into GUARDIAN_OF (child_id, guardian_id)
values (486, 127);
insert into GUARDIAN_OF (child_id, guardian_id)
values (487, 330);
insert into GUARDIAN_OF (child_id, guardian_id)
values (488, 219);
insert into GUARDIAN_OF (child_id, guardian_id)
values (489, 170);
insert into GUARDIAN_OF (child_id, guardian_id)
values (490, 480);
insert into GUARDIAN_OF (child_id, guardian_id)
values (491, 198);
insert into GUARDIAN_OF (child_id, guardian_id)
values (492, 319);
insert into GUARDIAN_OF (child_id, guardian_id)
values (493, 468);
insert into GUARDIAN_OF (child_id, guardian_id)
values (494, 169);
insert into GUARDIAN_OF (child_id, guardian_id)
values (495, 474);
insert into GUARDIAN_OF (child_id, guardian_id)
values (496, 195);
insert into GUARDIAN_OF (child_id, guardian_id)
values (497, 260);
insert into GUARDIAN_OF (child_id, guardian_id)
values (498, 435);
commit;
prompt 399 records loaded
prompt Loading STOCK...
insert into STOCK (stock_id, shelf_id, amount)
values (100, 14, 577);
insert into STOCK (stock_id, shelf_id, amount)
values (101, 34, 362);
insert into STOCK (stock_id, shelf_id, amount)
values (102, 25, 631);
insert into STOCK (stock_id, shelf_id, amount)
values (103, 17, 270);
insert into STOCK (stock_id, shelf_id, amount)
values (104, 13, 38);
insert into STOCK (stock_id, shelf_id, amount)
values (105, 28, 774);
insert into STOCK (stock_id, shelf_id, amount)
values (106, 21, 129);
insert into STOCK (stock_id, shelf_id, amount)
values (107, 48, 785);
insert into STOCK (stock_id, shelf_id, amount)
values (108, 17, 725);
insert into STOCK (stock_id, shelf_id, amount)
values (109, 31, 652);
insert into STOCK (stock_id, shelf_id, amount)
values (110, 1, 695);
insert into STOCK (stock_id, shelf_id, amount)
values (111, 30, 633);
insert into STOCK (stock_id, shelf_id, amount)
values (112, 35, 860);
insert into STOCK (stock_id, shelf_id, amount)
values (113, 22, 823);
insert into STOCK (stock_id, shelf_id, amount)
values (114, 26, 537);
insert into STOCK (stock_id, shelf_id, amount)
values (115, 13, 640);
insert into STOCK (stock_id, shelf_id, amount)
values (116, 27, 644);
insert into STOCK (stock_id, shelf_id, amount)
values (117, 3, 805);
insert into STOCK (stock_id, shelf_id, amount)
values (118, 47, 133);
insert into STOCK (stock_id, shelf_id, amount)
values (119, 2, 751);
insert into STOCK (stock_id, shelf_id, amount)
values (120, 45, 284);
insert into STOCK (stock_id, shelf_id, amount)
values (121, 23, 871);
insert into STOCK (stock_id, shelf_id, amount)
values (122, 15, 400);
insert into STOCK (stock_id, shelf_id, amount)
values (123, 29, 308);
insert into STOCK (stock_id, shelf_id, amount)
values (124, 3, 759);
insert into STOCK (stock_id, shelf_id, amount)
values (125, 15, 187);
insert into STOCK (stock_id, shelf_id, amount)
values (126, 18, 820);
insert into STOCK (stock_id, shelf_id, amount)
values (127, 42, 847);
insert into STOCK (stock_id, shelf_id, amount)
values (128, 12, 622);
insert into STOCK (stock_id, shelf_id, amount)
values (129, 31, 795);
insert into STOCK (stock_id, shelf_id, amount)
values (130, 39, 123);
insert into STOCK (stock_id, shelf_id, amount)
values (131, 41, 649);
insert into STOCK (stock_id, shelf_id, amount)
values (132, 39, 859);
insert into STOCK (stock_id, shelf_id, amount)
values (133, 46, 641);
insert into STOCK (stock_id, shelf_id, amount)
values (134, 48, 171);
insert into STOCK (stock_id, shelf_id, amount)
values (135, 18, 519);
insert into STOCK (stock_id, shelf_id, amount)
values (136, 46, 100);
insert into STOCK (stock_id, shelf_id, amount)
values (137, 43, 0);
insert into STOCK (stock_id, shelf_id, amount)
values (138, 26, 246);
insert into STOCK (stock_id, shelf_id, amount)
values (139, 31, 725);
insert into STOCK (stock_id, shelf_id, amount)
values (140, 37, 238);
insert into STOCK (stock_id, shelf_id, amount)
values (141, 16, 469);
insert into STOCK (stock_id, shelf_id, amount)
values (142, 13, 0);
insert into STOCK (stock_id, shelf_id, amount)
values (143, 8, 540);
insert into STOCK (stock_id, shelf_id, amount)
values (144, 34, 357);
insert into STOCK (stock_id, shelf_id, amount)
values (145, 38, 767);
insert into STOCK (stock_id, shelf_id, amount)
values (146, 5, 922);
insert into STOCK (stock_id, shelf_id, amount)
values (147, 27, 408);
insert into STOCK (stock_id, shelf_id, amount)
values (148, 43, 529);
insert into STOCK (stock_id, shelf_id, amount)
values (149, 37, 158);
insert into STOCK (stock_id, shelf_id, amount)
values (150, 29, 784);
insert into STOCK (stock_id, shelf_id, amount)
values (151, 15, 830);
insert into STOCK (stock_id, shelf_id, amount)
values (152, 10, 577);
insert into STOCK (stock_id, shelf_id, amount)
values (153, 40, 999);
insert into STOCK (stock_id, shelf_id, amount)
values (154, 25, 267);
insert into STOCK (stock_id, shelf_id, amount)
values (155, 3, 452);
insert into STOCK (stock_id, shelf_id, amount)
values (156, 49, 829);
insert into STOCK (stock_id, shelf_id, amount)
values (157, 5, 805);
insert into STOCK (stock_id, shelf_id, amount)
values (158, 37, 403);
insert into STOCK (stock_id, shelf_id, amount)
values (159, 33, 882);
insert into STOCK (stock_id, shelf_id, amount)
values (160, 7, 121);
insert into STOCK (stock_id, shelf_id, amount)
values (161, 49, 675);
insert into STOCK (stock_id, shelf_id, amount)
values (162, 35, 681);
insert into STOCK (stock_id, shelf_id, amount)
values (163, 13, 439);
insert into STOCK (stock_id, shelf_id, amount)
values (164, 16, 543);
insert into STOCK (stock_id, shelf_id, amount)
values (165, 15, 557);
insert into STOCK (stock_id, shelf_id, amount)
values (166, 18, 38);
insert into STOCK (stock_id, shelf_id, amount)
values (167, 45, 585);
insert into STOCK (stock_id, shelf_id, amount)
values (168, 50, 924);
insert into STOCK (stock_id, shelf_id, amount)
values (169, 7, 587);
insert into STOCK (stock_id, shelf_id, amount)
values (170, 10, 837);
insert into STOCK (stock_id, shelf_id, amount)
values (171, 19, 94);
insert into STOCK (stock_id, shelf_id, amount)
values (172, 3, 0);
insert into STOCK (stock_id, shelf_id, amount)
values (173, 46, 651);
insert into STOCK (stock_id, shelf_id, amount)
values (174, 27, 70);
insert into STOCK (stock_id, shelf_id, amount)
values (175, 44, 211);
insert into STOCK (stock_id, shelf_id, amount)
values (176, 42, 850);
insert into STOCK (stock_id, shelf_id, amount)
values (177, 2, 721);
insert into STOCK (stock_id, shelf_id, amount)
values (178, 38, 758);
insert into STOCK (stock_id, shelf_id, amount)
values (179, 8, 548);
insert into STOCK (stock_id, shelf_id, amount)
values (180, 40, 799);
insert into STOCK (stock_id, shelf_id, amount)
values (181, 31, 730);
insert into STOCK (stock_id, shelf_id, amount)
values (182, 40, 655);
insert into STOCK (stock_id, shelf_id, amount)
values (183, 47, 584);
insert into STOCK (stock_id, shelf_id, amount)
values (184, 6, 167);
insert into STOCK (stock_id, shelf_id, amount)
values (185, 5, 867);
insert into STOCK (stock_id, shelf_id, amount)
values (186, 26, 526);
insert into STOCK (stock_id, shelf_id, amount)
values (187, 49, 149);
insert into STOCK (stock_id, shelf_id, amount)
values (188, 3, 35);
insert into STOCK (stock_id, shelf_id, amount)
values (189, 24, 661);
insert into STOCK (stock_id, shelf_id, amount)
values (190, 49, 431);
insert into STOCK (stock_id, shelf_id, amount)
values (191, 26, 756);
insert into STOCK (stock_id, shelf_id, amount)
values (192, 17, 933);
insert into STOCK (stock_id, shelf_id, amount)
values (193, 33, 107);
insert into STOCK (stock_id, shelf_id, amount)
values (194, 9, 567);
insert into STOCK (stock_id, shelf_id, amount)
values (195, 31, 487);
insert into STOCK (stock_id, shelf_id, amount)
values (196, 49, 430);
insert into STOCK (stock_id, shelf_id, amount)
values (197, 10, 196);
insert into STOCK (stock_id, shelf_id, amount)
values (198, 48, 721);
insert into STOCK (stock_id, shelf_id, amount)
values (199, 43, 440);
commit;
prompt 100 records committed...
insert into STOCK (stock_id, shelf_id, amount)
values (200, 46, 868);
insert into STOCK (stock_id, shelf_id, amount)
values (201, 49, 612);
insert into STOCK (stock_id, shelf_id, amount)
values (202, 45, 878);
insert into STOCK (stock_id, shelf_id, amount)
values (203, 23, 165);
insert into STOCK (stock_id, shelf_id, amount)
values (204, 21, 693);
insert into STOCK (stock_id, shelf_id, amount)
values (205, 30, 719);
insert into STOCK (stock_id, shelf_id, amount)
values (206, 24, 83);
insert into STOCK (stock_id, shelf_id, amount)
values (207, 35, 232);
insert into STOCK (stock_id, shelf_id, amount)
values (208, 20, 644);
insert into STOCK (stock_id, shelf_id, amount)
values (209, 38, 698);
insert into STOCK (stock_id, shelf_id, amount)
values (210, 6, 584);
insert into STOCK (stock_id, shelf_id, amount)
values (211, 24, 327);
insert into STOCK (stock_id, shelf_id, amount)
values (212, 17, 43);
insert into STOCK (stock_id, shelf_id, amount)
values (213, 16, 465);
insert into STOCK (stock_id, shelf_id, amount)
values (214, 32, 891);
insert into STOCK (stock_id, shelf_id, amount)
values (215, 12, 177);
insert into STOCK (stock_id, shelf_id, amount)
values (216, 30, 167);
insert into STOCK (stock_id, shelf_id, amount)
values (217, 48, 830);
insert into STOCK (stock_id, shelf_id, amount)
values (218, 10, 0);
insert into STOCK (stock_id, shelf_id, amount)
values (219, 30, 259);
insert into STOCK (stock_id, shelf_id, amount)
values (220, 43, 814);
insert into STOCK (stock_id, shelf_id, amount)
values (221, 1, 874);
insert into STOCK (stock_id, shelf_id, amount)
values (222, 42, 62);
insert into STOCK (stock_id, shelf_id, amount)
values (223, 27, 234);
insert into STOCK (stock_id, shelf_id, amount)
values (224, 18, 950);
insert into STOCK (stock_id, shelf_id, amount)
values (225, 25, 508);
insert into STOCK (stock_id, shelf_id, amount)
values (226, 5, 109);
insert into STOCK (stock_id, shelf_id, amount)
values (227, 43, 341);
insert into STOCK (stock_id, shelf_id, amount)
values (228, 28, 33);
insert into STOCK (stock_id, shelf_id, amount)
values (229, 21, 407);
insert into STOCK (stock_id, shelf_id, amount)
values (230, 7, 974);
insert into STOCK (stock_id, shelf_id, amount)
values (231, 13, 931);
insert into STOCK (stock_id, shelf_id, amount)
values (232, 37, 479);
insert into STOCK (stock_id, shelf_id, amount)
values (233, 3, 691);
insert into STOCK (stock_id, shelf_id, amount)
values (234, 33, 199);
insert into STOCK (stock_id, shelf_id, amount)
values (235, 49, 117);
insert into STOCK (stock_id, shelf_id, amount)
values (236, 48, 710);
insert into STOCK (stock_id, shelf_id, amount)
values (237, 28, 715);
insert into STOCK (stock_id, shelf_id, amount)
values (238, 26, 65);
insert into STOCK (stock_id, shelf_id, amount)
values (239, 9, 858);
insert into STOCK (stock_id, shelf_id, amount)
values (240, 36, 710);
insert into STOCK (stock_id, shelf_id, amount)
values (241, 47, 386);
insert into STOCK (stock_id, shelf_id, amount)
values (242, 33, 757);
insert into STOCK (stock_id, shelf_id, amount)
values (243, 41, 986);
insert into STOCK (stock_id, shelf_id, amount)
values (244, 46, 910);
insert into STOCK (stock_id, shelf_id, amount)
values (245, 41, 579);
insert into STOCK (stock_id, shelf_id, amount)
values (246, 49, 964);
insert into STOCK (stock_id, shelf_id, amount)
values (247, 19, 599);
insert into STOCK (stock_id, shelf_id, amount)
values (248, 4, 994);
insert into STOCK (stock_id, shelf_id, amount)
values (249, 7, 73);
insert into STOCK (stock_id, shelf_id, amount)
values (250, 12, 738);
insert into STOCK (stock_id, shelf_id, amount)
values (251, 41, 715);
insert into STOCK (stock_id, shelf_id, amount)
values (252, 16, 693);
insert into STOCK (stock_id, shelf_id, amount)
values (253, 50, 146);
insert into STOCK (stock_id, shelf_id, amount)
values (254, 11, 724);
insert into STOCK (stock_id, shelf_id, amount)
values (255, 5, 182);
insert into STOCK (stock_id, shelf_id, amount)
values (256, 11, 417);
insert into STOCK (stock_id, shelf_id, amount)
values (257, 39, 170);
insert into STOCK (stock_id, shelf_id, amount)
values (258, 1, 801);
insert into STOCK (stock_id, shelf_id, amount)
values (259, 6, 367);
insert into STOCK (stock_id, shelf_id, amount)
values (260, 39, 302);
insert into STOCK (stock_id, shelf_id, amount)
values (261, 16, 977);
insert into STOCK (stock_id, shelf_id, amount)
values (262, 40, 479);
insert into STOCK (stock_id, shelf_id, amount)
values (263, 33, 867);
insert into STOCK (stock_id, shelf_id, amount)
values (264, 10, 385);
insert into STOCK (stock_id, shelf_id, amount)
values (265, 22, 129);
insert into STOCK (stock_id, shelf_id, amount)
values (266, 2, 912);
insert into STOCK (stock_id, shelf_id, amount)
values (267, 26, 928);
insert into STOCK (stock_id, shelf_id, amount)
values (268, 4, 95);
insert into STOCK (stock_id, shelf_id, amount)
values (269, 11, 991);
insert into STOCK (stock_id, shelf_id, amount)
values (270, 5, 602);
insert into STOCK (stock_id, shelf_id, amount)
values (271, 38, 443);
insert into STOCK (stock_id, shelf_id, amount)
values (272, 5, 174);
insert into STOCK (stock_id, shelf_id, amount)
values (273, 25, 135);
insert into STOCK (stock_id, shelf_id, amount)
values (274, 23, 217);
insert into STOCK (stock_id, shelf_id, amount)
values (275, 30, 615);
insert into STOCK (stock_id, shelf_id, amount)
values (276, 25, 436);
insert into STOCK (stock_id, shelf_id, amount)
values (277, 39, 159);
insert into STOCK (stock_id, shelf_id, amount)
values (278, 30, 884);
insert into STOCK (stock_id, shelf_id, amount)
values (279, 38, 810);
insert into STOCK (stock_id, shelf_id, amount)
values (280, 6, 528);
insert into STOCK (stock_id, shelf_id, amount)
values (281, 48, 903);
insert into STOCK (stock_id, shelf_id, amount)
values (282, 40, 793);
insert into STOCK (stock_id, shelf_id, amount)
values (283, 48, 608);
insert into STOCK (stock_id, shelf_id, amount)
values (284, 28, 276);
insert into STOCK (stock_id, shelf_id, amount)
values (285, 2, 143);
insert into STOCK (stock_id, shelf_id, amount)
values (286, 3, 221);
insert into STOCK (stock_id, shelf_id, amount)
values (287, 19, 467);
insert into STOCK (stock_id, shelf_id, amount)
values (288, 3, 501);
insert into STOCK (stock_id, shelf_id, amount)
values (289, 47, 587);
insert into STOCK (stock_id, shelf_id, amount)
values (290, 20, 983);
insert into STOCK (stock_id, shelf_id, amount)
values (291, 6, 218);
insert into STOCK (stock_id, shelf_id, amount)
values (292, 8, 949);
insert into STOCK (stock_id, shelf_id, amount)
values (293, 6, 142);
insert into STOCK (stock_id, shelf_id, amount)
values (294, 40, 169);
insert into STOCK (stock_id, shelf_id, amount)
values (295, 47, 189);
insert into STOCK (stock_id, shelf_id, amount)
values (296, 11, 785);
insert into STOCK (stock_id, shelf_id, amount)
values (297, 28, 699);
insert into STOCK (stock_id, shelf_id, amount)
values (298, 3, 148);
insert into STOCK (stock_id, shelf_id, amount)
values (299, 42, 295);
commit;
prompt 200 records committed...
insert into STOCK (stock_id, shelf_id, amount)
values (300, 36, 793);
insert into STOCK (stock_id, shelf_id, amount)
values (301, 3, 738);
insert into STOCK (stock_id, shelf_id, amount)
values (302, 29, 107);
insert into STOCK (stock_id, shelf_id, amount)
values (303, 26, 469);
insert into STOCK (stock_id, shelf_id, amount)
values (304, 10, 896);
insert into STOCK (stock_id, shelf_id, amount)
values (305, 6, 632);
insert into STOCK (stock_id, shelf_id, amount)
values (306, 37, 216);
insert into STOCK (stock_id, shelf_id, amount)
values (307, 29, 852);
insert into STOCK (stock_id, shelf_id, amount)
values (308, 45, 626);
insert into STOCK (stock_id, shelf_id, amount)
values (309, 47, 865);
insert into STOCK (stock_id, shelf_id, amount)
values (310, 32, 32);
insert into STOCK (stock_id, shelf_id, amount)
values (311, 3, 72);
insert into STOCK (stock_id, shelf_id, amount)
values (312, 33, 49);
insert into STOCK (stock_id, shelf_id, amount)
values (313, 1, 888);
insert into STOCK (stock_id, shelf_id, amount)
values (314, 32, 502);
insert into STOCK (stock_id, shelf_id, amount)
values (315, 2, 396);
insert into STOCK (stock_id, shelf_id, amount)
values (316, 47, 940);
insert into STOCK (stock_id, shelf_id, amount)
values (317, 49, 493);
insert into STOCK (stock_id, shelf_id, amount)
values (318, 25, 772);
insert into STOCK (stock_id, shelf_id, amount)
values (319, 9, 350);
insert into STOCK (stock_id, shelf_id, amount)
values (320, 26, 508);
insert into STOCK (stock_id, shelf_id, amount)
values (321, 11, 506);
insert into STOCK (stock_id, shelf_id, amount)
values (322, 36, 305);
insert into STOCK (stock_id, shelf_id, amount)
values (323, 41, 631);
insert into STOCK (stock_id, shelf_id, amount)
values (324, 20, 186);
insert into STOCK (stock_id, shelf_id, amount)
values (325, 39, 592);
insert into STOCK (stock_id, shelf_id, amount)
values (326, 44, 304);
insert into STOCK (stock_id, shelf_id, amount)
values (327, 50, 893);
insert into STOCK (stock_id, shelf_id, amount)
values (328, 39, 753);
insert into STOCK (stock_id, shelf_id, amount)
values (329, 33, 106);
insert into STOCK (stock_id, shelf_id, amount)
values (330, 20, 557);
insert into STOCK (stock_id, shelf_id, amount)
values (331, 31, 901);
insert into STOCK (stock_id, shelf_id, amount)
values (332, 18, 614);
insert into STOCK (stock_id, shelf_id, amount)
values (333, 48, 956);
insert into STOCK (stock_id, shelf_id, amount)
values (334, 40, 909);
insert into STOCK (stock_id, shelf_id, amount)
values (335, 50, 648);
insert into STOCK (stock_id, shelf_id, amount)
values (336, 11, 578);
insert into STOCK (stock_id, shelf_id, amount)
values (337, 13, 42);
insert into STOCK (stock_id, shelf_id, amount)
values (338, 42, 649);
insert into STOCK (stock_id, shelf_id, amount)
values (339, 41, 515);
insert into STOCK (stock_id, shelf_id, amount)
values (340, 46, 556);
insert into STOCK (stock_id, shelf_id, amount)
values (341, 6, 773);
insert into STOCK (stock_id, shelf_id, amount)
values (342, 13, 399);
insert into STOCK (stock_id, shelf_id, amount)
values (343, 21, 415);
insert into STOCK (stock_id, shelf_id, amount)
values (344, 12, 417);
insert into STOCK (stock_id, shelf_id, amount)
values (345, 13, 419);
insert into STOCK (stock_id, shelf_id, amount)
values (346, 14, 0);
insert into STOCK (stock_id, shelf_id, amount)
values (347, 27, 381);
insert into STOCK (stock_id, shelf_id, amount)
values (348, 31, 972);
insert into STOCK (stock_id, shelf_id, amount)
values (349, 36, 995);
insert into STOCK (stock_id, shelf_id, amount)
values (350, 4, 562);
insert into STOCK (stock_id, shelf_id, amount)
values (351, 34, 885);
insert into STOCK (stock_id, shelf_id, amount)
values (352, 21, 44);
insert into STOCK (stock_id, shelf_id, amount)
values (353, 41, 884);
insert into STOCK (stock_id, shelf_id, amount)
values (354, 18, 376);
insert into STOCK (stock_id, shelf_id, amount)
values (355, 39, 402);
insert into STOCK (stock_id, shelf_id, amount)
values (356, 37, 26);
insert into STOCK (stock_id, shelf_id, amount)
values (357, 10, 705);
insert into STOCK (stock_id, shelf_id, amount)
values (358, 15, 477);
insert into STOCK (stock_id, shelf_id, amount)
values (359, 48, 47);
insert into STOCK (stock_id, shelf_id, amount)
values (360, 33, 743);
insert into STOCK (stock_id, shelf_id, amount)
values (361, 18, 459);
insert into STOCK (stock_id, shelf_id, amount)
values (362, 2, 492);
insert into STOCK (stock_id, shelf_id, amount)
values (363, 47, 450);
insert into STOCK (stock_id, shelf_id, amount)
values (364, 29, 894);
insert into STOCK (stock_id, shelf_id, amount)
values (365, 38, 924);
insert into STOCK (stock_id, shelf_id, amount)
values (366, 10, 938);
insert into STOCK (stock_id, shelf_id, amount)
values (367, 8, 719);
insert into STOCK (stock_id, shelf_id, amount)
values (368, 12, 245);
insert into STOCK (stock_id, shelf_id, amount)
values (369, 19, 372);
insert into STOCK (stock_id, shelf_id, amount)
values (370, 42, 370);
insert into STOCK (stock_id, shelf_id, amount)
values (371, 13, 650);
insert into STOCK (stock_id, shelf_id, amount)
values (372, 46, 787);
insert into STOCK (stock_id, shelf_id, amount)
values (373, 20, 731);
insert into STOCK (stock_id, shelf_id, amount)
values (374, 3, 407);
insert into STOCK (stock_id, shelf_id, amount)
values (375, 10, 795);
insert into STOCK (stock_id, shelf_id, amount)
values (376, 10, 548);
insert into STOCK (stock_id, shelf_id, amount)
values (377, 19, 563);
insert into STOCK (stock_id, shelf_id, amount)
values (378, 2, 778);
insert into STOCK (stock_id, shelf_id, amount)
values (379, 41, 59);
insert into STOCK (stock_id, shelf_id, amount)
values (380, 30, 341);
insert into STOCK (stock_id, shelf_id, amount)
values (381, 40, 184);
insert into STOCK (stock_id, shelf_id, amount)
values (382, 48, 309);
insert into STOCK (stock_id, shelf_id, amount)
values (383, 29, 559);
insert into STOCK (stock_id, shelf_id, amount)
values (384, 25, 136);
insert into STOCK (stock_id, shelf_id, amount)
values (385, 47, 780);
insert into STOCK (stock_id, shelf_id, amount)
values (386, 32, 701);
insert into STOCK (stock_id, shelf_id, amount)
values (387, 41, 133);
insert into STOCK (stock_id, shelf_id, amount)
values (388, 6, 657);
insert into STOCK (stock_id, shelf_id, amount)
values (389, 26, 244);
insert into STOCK (stock_id, shelf_id, amount)
values (390, 47, 445);
insert into STOCK (stock_id, shelf_id, amount)
values (391, 23, 502);
insert into STOCK (stock_id, shelf_id, amount)
values (392, 31, 997);
insert into STOCK (stock_id, shelf_id, amount)
values (393, 47, 157);
insert into STOCK (stock_id, shelf_id, amount)
values (394, 13, 819);
insert into STOCK (stock_id, shelf_id, amount)
values (395, 28, 906);
insert into STOCK (stock_id, shelf_id, amount)
values (396, 43, 677);
insert into STOCK (stock_id, shelf_id, amount)
values (397, 3, 372);
insert into STOCK (stock_id, shelf_id, amount)
values (398, 3, 702);
insert into STOCK (stock_id, shelf_id, amount)
values (399, 45, 721);
commit;
prompt 300 records committed...
insert into STOCK (stock_id, shelf_id, amount)
values (400, 18, 787);
insert into STOCK (stock_id, shelf_id, amount)
values (401, 11, 688);
insert into STOCK (stock_id, shelf_id, amount)
values (402, 14, 247);
insert into STOCK (stock_id, shelf_id, amount)
values (403, 20, 0);
insert into STOCK (stock_id, shelf_id, amount)
values (404, 34, 431);
insert into STOCK (stock_id, shelf_id, amount)
values (405, 13, 946);
insert into STOCK (stock_id, shelf_id, amount)
values (406, 27, 810);
insert into STOCK (stock_id, shelf_id, amount)
values (407, 28, 576);
insert into STOCK (stock_id, shelf_id, amount)
values (408, 20, 372);
insert into STOCK (stock_id, shelf_id, amount)
values (409, 27, 328);
insert into STOCK (stock_id, shelf_id, amount)
values (410, 3, 39);
insert into STOCK (stock_id, shelf_id, amount)
values (411, 36, 919);
insert into STOCK (stock_id, shelf_id, amount)
values (412, 21, 850);
insert into STOCK (stock_id, shelf_id, amount)
values (413, 28, 773);
insert into STOCK (stock_id, shelf_id, amount)
values (414, 4, 129);
insert into STOCK (stock_id, shelf_id, amount)
values (415, 32, 565);
insert into STOCK (stock_id, shelf_id, amount)
values (416, 4, 871);
insert into STOCK (stock_id, shelf_id, amount)
values (417, 9, 110);
insert into STOCK (stock_id, shelf_id, amount)
values (418, 21, 199);
insert into STOCK (stock_id, shelf_id, amount)
values (419, 12, 535);
insert into STOCK (stock_id, shelf_id, amount)
values (420, 31, 232);
insert into STOCK (stock_id, shelf_id, amount)
values (421, 16, 313);
insert into STOCK (stock_id, shelf_id, amount)
values (422, 35, 214);
insert into STOCK (stock_id, shelf_id, amount)
values (423, 28, 200);
insert into STOCK (stock_id, shelf_id, amount)
values (424, 37, 264);
insert into STOCK (stock_id, shelf_id, amount)
values (425, 40, 392);
insert into STOCK (stock_id, shelf_id, amount)
values (426, 6, 50);
insert into STOCK (stock_id, shelf_id, amount)
values (427, 15, 62);
insert into STOCK (stock_id, shelf_id, amount)
values (428, 20, 97);
insert into STOCK (stock_id, shelf_id, amount)
values (429, 43, 27);
insert into STOCK (stock_id, shelf_id, amount)
values (430, 37, 975);
insert into STOCK (stock_id, shelf_id, amount)
values (431, 19, 725);
insert into STOCK (stock_id, shelf_id, amount)
values (432, 21, 843);
insert into STOCK (stock_id, shelf_id, amount)
values (433, 37, 288);
insert into STOCK (stock_id, shelf_id, amount)
values (434, 29, 637);
insert into STOCK (stock_id, shelf_id, amount)
values (435, 29, 784);
insert into STOCK (stock_id, shelf_id, amount)
values (436, 43, 56);
insert into STOCK (stock_id, shelf_id, amount)
values (437, 41, 907);
insert into STOCK (stock_id, shelf_id, amount)
values (438, 18, 185);
insert into STOCK (stock_id, shelf_id, amount)
values (439, 30, 895);
insert into STOCK (stock_id, shelf_id, amount)
values (440, 50, 506);
insert into STOCK (stock_id, shelf_id, amount)
values (441, 27, 613);
insert into STOCK (stock_id, shelf_id, amount)
values (442, 49, 445);
insert into STOCK (stock_id, shelf_id, amount)
values (443, 25, 465);
insert into STOCK (stock_id, shelf_id, amount)
values (444, 1, 248);
insert into STOCK (stock_id, shelf_id, amount)
values (445, 28, 138);
insert into STOCK (stock_id, shelf_id, amount)
values (446, 21, 200);
insert into STOCK (stock_id, shelf_id, amount)
values (447, 39, 792);
insert into STOCK (stock_id, shelf_id, amount)
values (448, 21, 659);
insert into STOCK (stock_id, shelf_id, amount)
values (449, 43, 531);
insert into STOCK (stock_id, shelf_id, amount)
values (450, 28, 672);
insert into STOCK (stock_id, shelf_id, amount)
values (451, 44, 327);
insert into STOCK (stock_id, shelf_id, amount)
values (452, 5, 791);
insert into STOCK (stock_id, shelf_id, amount)
values (453, 47, 801);
insert into STOCK (stock_id, shelf_id, amount)
values (454, 34, 835);
insert into STOCK (stock_id, shelf_id, amount)
values (455, 35, 507);
insert into STOCK (stock_id, shelf_id, amount)
values (456, 17, 695);
insert into STOCK (stock_id, shelf_id, amount)
values (457, 34, 432);
insert into STOCK (stock_id, shelf_id, amount)
values (458, 28, 123);
insert into STOCK (stock_id, shelf_id, amount)
values (459, 48, 623);
insert into STOCK (stock_id, shelf_id, amount)
values (460, 6, 69);
insert into STOCK (stock_id, shelf_id, amount)
values (461, 36, 354);
insert into STOCK (stock_id, shelf_id, amount)
values (462, 41, 169);
insert into STOCK (stock_id, shelf_id, amount)
values (463, 48, 313);
insert into STOCK (stock_id, shelf_id, amount)
values (464, 38, 498);
insert into STOCK (stock_id, shelf_id, amount)
values (465, 5, 789);
insert into STOCK (stock_id, shelf_id, amount)
values (466, 1, 564);
insert into STOCK (stock_id, shelf_id, amount)
values (467, 23, 990);
insert into STOCK (stock_id, shelf_id, amount)
values (468, 10, 126);
insert into STOCK (stock_id, shelf_id, amount)
values (469, 20, 747);
insert into STOCK (stock_id, shelf_id, amount)
values (470, 25, 905);
insert into STOCK (stock_id, shelf_id, amount)
values (471, 14, 456);
insert into STOCK (stock_id, shelf_id, amount)
values (472, 46, 436);
insert into STOCK (stock_id, shelf_id, amount)
values (473, 22, 630);
insert into STOCK (stock_id, shelf_id, amount)
values (474, 34, 590);
insert into STOCK (stock_id, shelf_id, amount)
values (475, 30, 310);
insert into STOCK (stock_id, shelf_id, amount)
values (476, 40, 932);
insert into STOCK (stock_id, shelf_id, amount)
values (477, 50, 800);
insert into STOCK (stock_id, shelf_id, amount)
values (478, 49, 352);
insert into STOCK (stock_id, shelf_id, amount)
values (479, 29, 349);
insert into STOCK (stock_id, shelf_id, amount)
values (480, 18, 613);
insert into STOCK (stock_id, shelf_id, amount)
values (481, 34, 853);
insert into STOCK (stock_id, shelf_id, amount)
values (482, 6, 668);
insert into STOCK (stock_id, shelf_id, amount)
values (483, 25, 0);
insert into STOCK (stock_id, shelf_id, amount)
values (484, 35, 646);
insert into STOCK (stock_id, shelf_id, amount)
values (485, 40, 29);
insert into STOCK (stock_id, shelf_id, amount)
values (486, 9, 288);
insert into STOCK (stock_id, shelf_id, amount)
values (487, 31, 347);
insert into STOCK (stock_id, shelf_id, amount)
values (488, 31, 483);
insert into STOCK (stock_id, shelf_id, amount)
values (489, 27, 448);
insert into STOCK (stock_id, shelf_id, amount)
values (490, 32, 810);
insert into STOCK (stock_id, shelf_id, amount)
values (491, 9, 536);
insert into STOCK (stock_id, shelf_id, amount)
values (492, 50, 159);
insert into STOCK (stock_id, shelf_id, amount)
values (493, 43, 698);
insert into STOCK (stock_id, shelf_id, amount)
values (494, 38, 819);
insert into STOCK (stock_id, shelf_id, amount)
values (495, 26, 460);
insert into STOCK (stock_id, shelf_id, amount)
values (496, 1, 782);
insert into STOCK (stock_id, shelf_id, amount)
values (497, 33, 562);
insert into STOCK (stock_id, shelf_id, amount)
values (498, 13, 323);
insert into STOCK (stock_id, shelf_id, amount)
values (499, 34, 935);
commit;
prompt 400 records loaded
prompt Loading INJECTED...
insert into INJECTED (appointment_id, stock_id)
values (1, 146);
insert into INJECTED (appointment_id, stock_id)
values (1, 369);
insert into INJECTED (appointment_id, stock_id)
values (2, 186);
insert into INJECTED (appointment_id, stock_id)
values (2, 489);
insert into INJECTED (appointment_id, stock_id)
values (3, 319);
insert into INJECTED (appointment_id, stock_id)
values (3, 480);
insert into INJECTED (appointment_id, stock_id)
values (4, 294);
insert into INJECTED (appointment_id, stock_id)
values (4, 319);
insert into INJECTED (appointment_id, stock_id)
values (5, 128);
insert into INJECTED (appointment_id, stock_id)
values (5, 143);
insert into INJECTED (appointment_id, stock_id)
values (6, 195);
insert into INJECTED (appointment_id, stock_id)
values (6, 313);
insert into INJECTED (appointment_id, stock_id)
values (7, 172);
insert into INJECTED (appointment_id, stock_id)
values (7, 424);
insert into INJECTED (appointment_id, stock_id)
values (8, 198);
insert into INJECTED (appointment_id, stock_id)
values (8, 227);
insert into INJECTED (appointment_id, stock_id)
values (9, 177);
insert into INJECTED (appointment_id, stock_id)
values (9, 427);
insert into INJECTED (appointment_id, stock_id)
values (10, 461);
insert into INJECTED (appointment_id, stock_id)
values (10, 464);
insert into INJECTED (appointment_id, stock_id)
values (11, 256);
insert into INJECTED (appointment_id, stock_id)
values (11, 491);
insert into INJECTED (appointment_id, stock_id)
values (12, 243);
insert into INJECTED (appointment_id, stock_id)
values (12, 388);
insert into INJECTED (appointment_id, stock_id)
values (13, 230);
insert into INJECTED (appointment_id, stock_id)
values (13, 413);
insert into INJECTED (appointment_id, stock_id)
values (14, 177);
insert into INJECTED (appointment_id, stock_id)
values (14, 360);
insert into INJECTED (appointment_id, stock_id)
values (15, 115);
insert into INJECTED (appointment_id, stock_id)
values (15, 434);
insert into INJECTED (appointment_id, stock_id)
values (16, 345);
insert into INJECTED (appointment_id, stock_id)
values (16, 448);
insert into INJECTED (appointment_id, stock_id)
values (17, 180);
insert into INJECTED (appointment_id, stock_id)
values (17, 435);
insert into INJECTED (appointment_id, stock_id)
values (18, 341);
insert into INJECTED (appointment_id, stock_id)
values (18, 399);
insert into INJECTED (appointment_id, stock_id)
values (19, 132);
insert into INJECTED (appointment_id, stock_id)
values (19, 334);
insert into INJECTED (appointment_id, stock_id)
values (20, 189);
insert into INJECTED (appointment_id, stock_id)
values (20, 237);
insert into INJECTED (appointment_id, stock_id)
values (21, 210);
insert into INJECTED (appointment_id, stock_id)
values (21, 426);
insert into INJECTED (appointment_id, stock_id)
values (22, 146);
insert into INJECTED (appointment_id, stock_id)
values (22, 160);
insert into INJECTED (appointment_id, stock_id)
values (23, 326);
insert into INJECTED (appointment_id, stock_id)
values (23, 387);
insert into INJECTED (appointment_id, stock_id)
values (24, 161);
insert into INJECTED (appointment_id, stock_id)
values (24, 394);
insert into INJECTED (appointment_id, stock_id)
values (25, 186);
insert into INJECTED (appointment_id, stock_id)
values (25, 423);
insert into INJECTED (appointment_id, stock_id)
values (26, 272);
insert into INJECTED (appointment_id, stock_id)
values (26, 444);
insert into INJECTED (appointment_id, stock_id)
values (27, 171);
insert into INJECTED (appointment_id, stock_id)
values (27, 187);
insert into INJECTED (appointment_id, stock_id)
values (28, 324);
insert into INJECTED (appointment_id, stock_id)
values (28, 349);
insert into INJECTED (appointment_id, stock_id)
values (29, 170);
insert into INJECTED (appointment_id, stock_id)
values (29, 413);
insert into INJECTED (appointment_id, stock_id)
values (30, 236);
insert into INJECTED (appointment_id, stock_id)
values (30, 401);
insert into INJECTED (appointment_id, stock_id)
values (31, 123);
insert into INJECTED (appointment_id, stock_id)
values (31, 468);
insert into INJECTED (appointment_id, stock_id)
values (32, 222);
insert into INJECTED (appointment_id, stock_id)
values (32, 338);
insert into INJECTED (appointment_id, stock_id)
values (33, 293);
insert into INJECTED (appointment_id, stock_id)
values (33, 472);
insert into INJECTED (appointment_id, stock_id)
values (34, 217);
insert into INJECTED (appointment_id, stock_id)
values (34, 367);
insert into INJECTED (appointment_id, stock_id)
values (35, 104);
insert into INJECTED (appointment_id, stock_id)
values (35, 343);
insert into INJECTED (appointment_id, stock_id)
values (36, 265);
insert into INJECTED (appointment_id, stock_id)
values (36, 453);
insert into INJECTED (appointment_id, stock_id)
values (37, 153);
insert into INJECTED (appointment_id, stock_id)
values (37, 355);
insert into INJECTED (appointment_id, stock_id)
values (38, 143);
insert into INJECTED (appointment_id, stock_id)
values (38, 406);
insert into INJECTED (appointment_id, stock_id)
values (39, 146);
insert into INJECTED (appointment_id, stock_id)
values (39, 477);
insert into INJECTED (appointment_id, stock_id)
values (40, 218);
insert into INJECTED (appointment_id, stock_id)
values (40, 292);
insert into INJECTED (appointment_id, stock_id)
values (41, 312);
insert into INJECTED (appointment_id, stock_id)
values (41, 355);
insert into INJECTED (appointment_id, stock_id)
values (42, 365);
insert into INJECTED (appointment_id, stock_id)
values (42, 462);
insert into INJECTED (appointment_id, stock_id)
values (43, 380);
insert into INJECTED (appointment_id, stock_id)
values (43, 474);
insert into INJECTED (appointment_id, stock_id)
values (44, 258);
insert into INJECTED (appointment_id, stock_id)
values (44, 266);
insert into INJECTED (appointment_id, stock_id)
values (45, 323);
insert into INJECTED (appointment_id, stock_id)
values (45, 355);
insert into INJECTED (appointment_id, stock_id)
values (46, 211);
insert into INJECTED (appointment_id, stock_id)
values (46, 239);
insert into INJECTED (appointment_id, stock_id)
values (47, 118);
insert into INJECTED (appointment_id, stock_id)
values (47, 416);
insert into INJECTED (appointment_id, stock_id)
values (48, 246);
insert into INJECTED (appointment_id, stock_id)
values (48, 434);
insert into INJECTED (appointment_id, stock_id)
values (49, 316);
insert into INJECTED (appointment_id, stock_id)
values (49, 405);
insert into INJECTED (appointment_id, stock_id)
values (50, 147);
insert into INJECTED (appointment_id, stock_id)
values (50, 491);
commit;
prompt 100 records committed...
insert into INJECTED (appointment_id, stock_id)
values (51, 123);
insert into INJECTED (appointment_id, stock_id)
values (51, 286);
insert into INJECTED (appointment_id, stock_id)
values (52, 235);
insert into INJECTED (appointment_id, stock_id)
values (52, 341);
insert into INJECTED (appointment_id, stock_id)
values (53, 349);
insert into INJECTED (appointment_id, stock_id)
values (53, 371);
insert into INJECTED (appointment_id, stock_id)
values (54, 141);
insert into INJECTED (appointment_id, stock_id)
values (54, 334);
insert into INJECTED (appointment_id, stock_id)
values (55, 176);
insert into INJECTED (appointment_id, stock_id)
values (55, 458);
insert into INJECTED (appointment_id, stock_id)
values (56, 167);
insert into INJECTED (appointment_id, stock_id)
values (56, 236);
insert into INJECTED (appointment_id, stock_id)
values (57, 232);
insert into INJECTED (appointment_id, stock_id)
values (57, 327);
insert into INJECTED (appointment_id, stock_id)
values (58, 225);
insert into INJECTED (appointment_id, stock_id)
values (58, 412);
insert into INJECTED (appointment_id, stock_id)
values (59, 136);
insert into INJECTED (appointment_id, stock_id)
values (59, 496);
insert into INJECTED (appointment_id, stock_id)
values (60, 164);
insert into INJECTED (appointment_id, stock_id)
values (60, 368);
insert into INJECTED (appointment_id, stock_id)
values (61, 161);
insert into INJECTED (appointment_id, stock_id)
values (61, 312);
insert into INJECTED (appointment_id, stock_id)
values (62, 111);
insert into INJECTED (appointment_id, stock_id)
values (62, 260);
insert into INJECTED (appointment_id, stock_id)
values (63, 136);
insert into INJECTED (appointment_id, stock_id)
values (63, 317);
insert into INJECTED (appointment_id, stock_id)
values (64, 199);
insert into INJECTED (appointment_id, stock_id)
values (64, 288);
insert into INJECTED (appointment_id, stock_id)
values (65, 309);
insert into INJECTED (appointment_id, stock_id)
values (65, 447);
insert into INJECTED (appointment_id, stock_id)
values (66, 294);
insert into INJECTED (appointment_id, stock_id)
values (66, 443);
insert into INJECTED (appointment_id, stock_id)
values (67, 270);
insert into INJECTED (appointment_id, stock_id)
values (67, 374);
insert into INJECTED (appointment_id, stock_id)
values (68, 254);
insert into INJECTED (appointment_id, stock_id)
values (68, 367);
insert into INJECTED (appointment_id, stock_id)
values (69, 189);
insert into INJECTED (appointment_id, stock_id)
values (69, 404);
insert into INJECTED (appointment_id, stock_id)
values (70, 216);
insert into INJECTED (appointment_id, stock_id)
values (70, 326);
insert into INJECTED (appointment_id, stock_id)
values (71, 348);
insert into INJECTED (appointment_id, stock_id)
values (71, 398);
insert into INJECTED (appointment_id, stock_id)
values (72, 354);
insert into INJECTED (appointment_id, stock_id)
values (72, 444);
insert into INJECTED (appointment_id, stock_id)
values (73, 100);
insert into INJECTED (appointment_id, stock_id)
values (73, 219);
insert into INJECTED (appointment_id, stock_id)
values (74, 343);
insert into INJECTED (appointment_id, stock_id)
values (74, 411);
insert into INJECTED (appointment_id, stock_id)
values (75, 209);
insert into INJECTED (appointment_id, stock_id)
values (75, 434);
insert into INJECTED (appointment_id, stock_id)
values (76, 115);
insert into INJECTED (appointment_id, stock_id)
values (76, 487);
insert into INJECTED (appointment_id, stock_id)
values (77, 435);
insert into INJECTED (appointment_id, stock_id)
values (77, 486);
insert into INJECTED (appointment_id, stock_id)
values (78, 310);
insert into INJECTED (appointment_id, stock_id)
values (78, 323);
insert into INJECTED (appointment_id, stock_id)
values (79, 343);
insert into INJECTED (appointment_id, stock_id)
values (79, 493);
insert into INJECTED (appointment_id, stock_id)
values (80, 161);
insert into INJECTED (appointment_id, stock_id)
values (80, 424);
insert into INJECTED (appointment_id, stock_id)
values (81, 254);
insert into INJECTED (appointment_id, stock_id)
values (81, 463);
insert into INJECTED (appointment_id, stock_id)
values (82, 225);
insert into INJECTED (appointment_id, stock_id)
values (82, 348);
insert into INJECTED (appointment_id, stock_id)
values (83, 255);
insert into INJECTED (appointment_id, stock_id)
values (83, 465);
insert into INJECTED (appointment_id, stock_id)
values (84, 103);
insert into INJECTED (appointment_id, stock_id)
values (84, 157);
insert into INJECTED (appointment_id, stock_id)
values (85, 148);
insert into INJECTED (appointment_id, stock_id)
values (85, 431);
insert into INJECTED (appointment_id, stock_id)
values (86, 137);
insert into INJECTED (appointment_id, stock_id)
values (86, 337);
insert into INJECTED (appointment_id, stock_id)
values (87, 205);
insert into INJECTED (appointment_id, stock_id)
values (87, 297);
insert into INJECTED (appointment_id, stock_id)
values (88, 301);
insert into INJECTED (appointment_id, stock_id)
values (88, 456);
insert into INJECTED (appointment_id, stock_id)
values (89, 404);
insert into INJECTED (appointment_id, stock_id)
values (89, 464);
insert into INJECTED (appointment_id, stock_id)
values (90, 309);
insert into INJECTED (appointment_id, stock_id)
values (90, 354);
insert into INJECTED (appointment_id, stock_id)
values (91, 305);
insert into INJECTED (appointment_id, stock_id)
values (91, 330);
insert into INJECTED (appointment_id, stock_id)
values (92, 198);
insert into INJECTED (appointment_id, stock_id)
values (92, 460);
insert into INJECTED (appointment_id, stock_id)
values (93, 233);
insert into INJECTED (appointment_id, stock_id)
values (93, 403);
insert into INJECTED (appointment_id, stock_id)
values (94, 257);
insert into INJECTED (appointment_id, stock_id)
values (94, 309);
insert into INJECTED (appointment_id, stock_id)
values (95, 163);
insert into INJECTED (appointment_id, stock_id)
values (95, 273);
insert into INJECTED (appointment_id, stock_id)
values (96, 415);
insert into INJECTED (appointment_id, stock_id)
values (96, 493);
insert into INJECTED (appointment_id, stock_id)
values (97, 295);
insert into INJECTED (appointment_id, stock_id)
values (97, 373);
insert into INJECTED (appointment_id, stock_id)
values (98, 239);
insert into INJECTED (appointment_id, stock_id)
values (98, 303);
insert into INJECTED (appointment_id, stock_id)
values (99, 130);
insert into INJECTED (appointment_id, stock_id)
values (99, 404);
insert into INJECTED (appointment_id, stock_id)
values (100, 181);
insert into INJECTED (appointment_id, stock_id)
values (100, 358);
commit;
prompt 200 records committed...
insert into INJECTED (appointment_id, stock_id)
values (101, 112);
insert into INJECTED (appointment_id, stock_id)
values (101, 401);
insert into INJECTED (appointment_id, stock_id)
values (102, 144);
insert into INJECTED (appointment_id, stock_id)
values (102, 373);
insert into INJECTED (appointment_id, stock_id)
values (103, 395);
insert into INJECTED (appointment_id, stock_id)
values (103, 434);
insert into INJECTED (appointment_id, stock_id)
values (104, 245);
insert into INJECTED (appointment_id, stock_id)
values (104, 448);
insert into INJECTED (appointment_id, stock_id)
values (105, 183);
insert into INJECTED (appointment_id, stock_id)
values (105, 495);
insert into INJECTED (appointment_id, stock_id)
values (106, 364);
insert into INJECTED (appointment_id, stock_id)
values (106, 422);
insert into INJECTED (appointment_id, stock_id)
values (107, 207);
insert into INJECTED (appointment_id, stock_id)
values (107, 409);
insert into INJECTED (appointment_id, stock_id)
values (108, 186);
insert into INJECTED (appointment_id, stock_id)
values (108, 492);
insert into INJECTED (appointment_id, stock_id)
values (109, 255);
insert into INJECTED (appointment_id, stock_id)
values (109, 285);
insert into INJECTED (appointment_id, stock_id)
values (110, 263);
insert into INJECTED (appointment_id, stock_id)
values (110, 376);
insert into INJECTED (appointment_id, stock_id)
values (111, 173);
insert into INJECTED (appointment_id, stock_id)
values (111, 350);
insert into INJECTED (appointment_id, stock_id)
values (112, 379);
insert into INJECTED (appointment_id, stock_id)
values (113, 317);
insert into INJECTED (appointment_id, stock_id)
values (113, 433);
insert into INJECTED (appointment_id, stock_id)
values (114, 209);
insert into INJECTED (appointment_id, stock_id)
values (114, 389);
insert into INJECTED (appointment_id, stock_id)
values (115, 176);
insert into INJECTED (appointment_id, stock_id)
values (115, 383);
insert into INJECTED (appointment_id, stock_id)
values (116, 149);
insert into INJECTED (appointment_id, stock_id)
values (116, 438);
insert into INJECTED (appointment_id, stock_id)
values (117, 182);
insert into INJECTED (appointment_id, stock_id)
values (117, 484);
insert into INJECTED (appointment_id, stock_id)
values (118, 119);
insert into INJECTED (appointment_id, stock_id)
values (118, 162);
insert into INJECTED (appointment_id, stock_id)
values (119, 343);
insert into INJECTED (appointment_id, stock_id)
values (119, 355);
insert into INJECTED (appointment_id, stock_id)
values (120, 130);
insert into INJECTED (appointment_id, stock_id)
values (120, 285);
insert into INJECTED (appointment_id, stock_id)
values (121, 388);
insert into INJECTED (appointment_id, stock_id)
values (121, 429);
insert into INJECTED (appointment_id, stock_id)
values (122, 440);
insert into INJECTED (appointment_id, stock_id)
values (122, 479);
insert into INJECTED (appointment_id, stock_id)
values (123, 281);
insert into INJECTED (appointment_id, stock_id)
values (123, 407);
insert into INJECTED (appointment_id, stock_id)
values (124, 118);
insert into INJECTED (appointment_id, stock_id)
values (124, 241);
insert into INJECTED (appointment_id, stock_id)
values (125, 429);
insert into INJECTED (appointment_id, stock_id)
values (125, 486);
insert into INJECTED (appointment_id, stock_id)
values (126, 226);
insert into INJECTED (appointment_id, stock_id)
values (126, 292);
insert into INJECTED (appointment_id, stock_id)
values (127, 263);
insert into INJECTED (appointment_id, stock_id)
values (127, 466);
insert into INJECTED (appointment_id, stock_id)
values (128, 198);
insert into INJECTED (appointment_id, stock_id)
values (128, 268);
insert into INJECTED (appointment_id, stock_id)
values (129, 124);
insert into INJECTED (appointment_id, stock_id)
values (129, 497);
insert into INJECTED (appointment_id, stock_id)
values (130, 139);
insert into INJECTED (appointment_id, stock_id)
values (130, 157);
insert into INJECTED (appointment_id, stock_id)
values (131, 114);
insert into INJECTED (appointment_id, stock_id)
values (131, 382);
insert into INJECTED (appointment_id, stock_id)
values (132, 396);
insert into INJECTED (appointment_id, stock_id)
values (132, 479);
insert into INJECTED (appointment_id, stock_id)
values (133, 296);
insert into INJECTED (appointment_id, stock_id)
values (133, 497);
insert into INJECTED (appointment_id, stock_id)
values (134, 364);
insert into INJECTED (appointment_id, stock_id)
values (134, 431);
insert into INJECTED (appointment_id, stock_id)
values (135, 136);
insert into INJECTED (appointment_id, stock_id)
values (135, 433);
insert into INJECTED (appointment_id, stock_id)
values (136, 110);
insert into INJECTED (appointment_id, stock_id)
values (136, 275);
insert into INJECTED (appointment_id, stock_id)
values (137, 330);
insert into INJECTED (appointment_id, stock_id)
values (137, 468);
insert into INJECTED (appointment_id, stock_id)
values (138, 277);
insert into INJECTED (appointment_id, stock_id)
values (138, 415);
insert into INJECTED (appointment_id, stock_id)
values (139, 101);
insert into INJECTED (appointment_id, stock_id)
values (139, 412);
insert into INJECTED (appointment_id, stock_id)
values (140, 332);
insert into INJECTED (appointment_id, stock_id)
values (140, 423);
insert into INJECTED (appointment_id, stock_id)
values (141, 175);
insert into INJECTED (appointment_id, stock_id)
values (141, 272);
insert into INJECTED (appointment_id, stock_id)
values (142, 151);
insert into INJECTED (appointment_id, stock_id)
values (142, 160);
insert into INJECTED (appointment_id, stock_id)
values (143, 104);
insert into INJECTED (appointment_id, stock_id)
values (143, 398);
insert into INJECTED (appointment_id, stock_id)
values (144, 143);
insert into INJECTED (appointment_id, stock_id)
values (144, 494);
insert into INJECTED (appointment_id, stock_id)
values (145, 454);
insert into INJECTED (appointment_id, stock_id)
values (145, 457);
insert into INJECTED (appointment_id, stock_id)
values (146, 132);
insert into INJECTED (appointment_id, stock_id)
values (146, 319);
insert into INJECTED (appointment_id, stock_id)
values (147, 246);
insert into INJECTED (appointment_id, stock_id)
values (147, 479);
insert into INJECTED (appointment_id, stock_id)
values (148, 111);
insert into INJECTED (appointment_id, stock_id)
values (148, 345);
insert into INJECTED (appointment_id, stock_id)
values (149, 111);
insert into INJECTED (appointment_id, stock_id)
values (149, 266);
insert into INJECTED (appointment_id, stock_id)
values (150, 182);
insert into INJECTED (appointment_id, stock_id)
values (150, 376);
insert into INJECTED (appointment_id, stock_id)
values (151, 251);
commit;
prompt 300 records committed...
insert into INJECTED (appointment_id, stock_id)
values (151, 388);
insert into INJECTED (appointment_id, stock_id)
values (152, 463);
insert into INJECTED (appointment_id, stock_id)
values (152, 498);
insert into INJECTED (appointment_id, stock_id)
values (153, 175);
insert into INJECTED (appointment_id, stock_id)
values (153, 255);
insert into INJECTED (appointment_id, stock_id)
values (154, 338);
insert into INJECTED (appointment_id, stock_id)
values (154, 477);
insert into INJECTED (appointment_id, stock_id)
values (155, 147);
insert into INJECTED (appointment_id, stock_id)
values (155, 203);
insert into INJECTED (appointment_id, stock_id)
values (156, 293);
insert into INJECTED (appointment_id, stock_id)
values (156, 439);
insert into INJECTED (appointment_id, stock_id)
values (157, 397);
insert into INJECTED (appointment_id, stock_id)
values (157, 489);
insert into INJECTED (appointment_id, stock_id)
values (158, 105);
insert into INJECTED (appointment_id, stock_id)
values (158, 110);
insert into INJECTED (appointment_id, stock_id)
values (159, 215);
insert into INJECTED (appointment_id, stock_id)
values (159, 343);
insert into INJECTED (appointment_id, stock_id)
values (160, 150);
insert into INJECTED (appointment_id, stock_id)
values (160, 445);
insert into INJECTED (appointment_id, stock_id)
values (161, 189);
insert into INJECTED (appointment_id, stock_id)
values (161, 481);
insert into INJECTED (appointment_id, stock_id)
values (162, 300);
insert into INJECTED (appointment_id, stock_id)
values (162, 483);
insert into INJECTED (appointment_id, stock_id)
values (163, 231);
insert into INJECTED (appointment_id, stock_id)
values (163, 320);
insert into INJECTED (appointment_id, stock_id)
values (164, 142);
insert into INJECTED (appointment_id, stock_id)
values (164, 482);
insert into INJECTED (appointment_id, stock_id)
values (165, 156);
insert into INJECTED (appointment_id, stock_id)
values (165, 336);
insert into INJECTED (appointment_id, stock_id)
values (166, 364);
insert into INJECTED (appointment_id, stock_id)
values (166, 419);
insert into INJECTED (appointment_id, stock_id)
values (167, 319);
insert into INJECTED (appointment_id, stock_id)
values (167, 381);
insert into INJECTED (appointment_id, stock_id)
values (168, 113);
insert into INJECTED (appointment_id, stock_id)
values (168, 339);
insert into INJECTED (appointment_id, stock_id)
values (169, 149);
insert into INJECTED (appointment_id, stock_id)
values (169, 320);
insert into INJECTED (appointment_id, stock_id)
values (170, 113);
insert into INJECTED (appointment_id, stock_id)
values (170, 214);
insert into INJECTED (appointment_id, stock_id)
values (171, 199);
insert into INJECTED (appointment_id, stock_id)
values (171, 314);
insert into INJECTED (appointment_id, stock_id)
values (172, 220);
insert into INJECTED (appointment_id, stock_id)
values (172, 400);
insert into INJECTED (appointment_id, stock_id)
values (173, 132);
insert into INJECTED (appointment_id, stock_id)
values (173, 354);
insert into INJECTED (appointment_id, stock_id)
values (174, 208);
insert into INJECTED (appointment_id, stock_id)
values (174, 368);
insert into INJECTED (appointment_id, stock_id)
values (175, 279);
insert into INJECTED (appointment_id, stock_id)
values (175, 442);
insert into INJECTED (appointment_id, stock_id)
values (176, 167);
insert into INJECTED (appointment_id, stock_id)
values (176, 278);
insert into INJECTED (appointment_id, stock_id)
values (177, 343);
insert into INJECTED (appointment_id, stock_id)
values (177, 479);
insert into INJECTED (appointment_id, stock_id)
values (178, 131);
insert into INJECTED (appointment_id, stock_id)
values (178, 232);
insert into INJECTED (appointment_id, stock_id)
values (179, 205);
insert into INJECTED (appointment_id, stock_id)
values (179, 252);
insert into INJECTED (appointment_id, stock_id)
values (180, 178);
insert into INJECTED (appointment_id, stock_id)
values (180, 376);
insert into INJECTED (appointment_id, stock_id)
values (181, 132);
insert into INJECTED (appointment_id, stock_id)
values (181, 308);
insert into INJECTED (appointment_id, stock_id)
values (182, 304);
insert into INJECTED (appointment_id, stock_id)
values (182, 352);
insert into INJECTED (appointment_id, stock_id)
values (183, 309);
insert into INJECTED (appointment_id, stock_id)
values (183, 471);
insert into INJECTED (appointment_id, stock_id)
values (184, 330);
insert into INJECTED (appointment_id, stock_id)
values (184, 436);
insert into INJECTED (appointment_id, stock_id)
values (185, 180);
insert into INJECTED (appointment_id, stock_id)
values (185, 286);
insert into INJECTED (appointment_id, stock_id)
values (186, 318);
insert into INJECTED (appointment_id, stock_id)
values (186, 333);
insert into INJECTED (appointment_id, stock_id)
values (187, 319);
insert into INJECTED (appointment_id, stock_id)
values (187, 498);
insert into INJECTED (appointment_id, stock_id)
values (188, 165);
insert into INJECTED (appointment_id, stock_id)
values (188, 493);
insert into INJECTED (appointment_id, stock_id)
values (189, 238);
insert into INJECTED (appointment_id, stock_id)
values (189, 425);
insert into INJECTED (appointment_id, stock_id)
values (190, 355);
insert into INJECTED (appointment_id, stock_id)
values (190, 373);
insert into INJECTED (appointment_id, stock_id)
values (191, 286);
insert into INJECTED (appointment_id, stock_id)
values (191, 300);
insert into INJECTED (appointment_id, stock_id)
values (192, 237);
insert into INJECTED (appointment_id, stock_id)
values (192, 475);
insert into INJECTED (appointment_id, stock_id)
values (193, 366);
insert into INJECTED (appointment_id, stock_id)
values (193, 445);
insert into INJECTED (appointment_id, stock_id)
values (194, 133);
insert into INJECTED (appointment_id, stock_id)
values (194, 339);
insert into INJECTED (appointment_id, stock_id)
values (195, 287);
insert into INJECTED (appointment_id, stock_id)
values (195, 467);
insert into INJECTED (appointment_id, stock_id)
values (196, 111);
insert into INJECTED (appointment_id, stock_id)
values (196, 453);
insert into INJECTED (appointment_id, stock_id)
values (197, 341);
insert into INJECTED (appointment_id, stock_id)
values (197, 469);
insert into INJECTED (appointment_id, stock_id)
values (198, 158);
insert into INJECTED (appointment_id, stock_id)
values (198, 418);
insert into INJECTED (appointment_id, stock_id)
values (199, 179);
insert into INJECTED (appointment_id, stock_id)
values (199, 418);
insert into INJECTED (appointment_id, stock_id)
values (200, 277);
insert into INJECTED (appointment_id, stock_id)
values (200, 383);
insert into INJECTED (appointment_id, stock_id)
values (201, 262);
commit;
prompt 400 records committed...
insert into INJECTED (appointment_id, stock_id)
values (201, 358);
insert into INJECTED (appointment_id, stock_id)
values (202, 186);
insert into INJECTED (appointment_id, stock_id)
values (202, 250);
insert into INJECTED (appointment_id, stock_id)
values (203, 374);
insert into INJECTED (appointment_id, stock_id)
values (203, 456);
insert into INJECTED (appointment_id, stock_id)
values (204, 158);
insert into INJECTED (appointment_id, stock_id)
values (204, 492);
insert into INJECTED (appointment_id, stock_id)
values (205, 151);
insert into INJECTED (appointment_id, stock_id)
values (205, 489);
insert into INJECTED (appointment_id, stock_id)
values (206, 201);
insert into INJECTED (appointment_id, stock_id)
values (206, 450);
insert into INJECTED (appointment_id, stock_id)
values (207, 256);
insert into INJECTED (appointment_id, stock_id)
values (207, 304);
insert into INJECTED (appointment_id, stock_id)
values (208, 117);
insert into INJECTED (appointment_id, stock_id)
values (208, 280);
insert into INJECTED (appointment_id, stock_id)
values (209, 132);
insert into INJECTED (appointment_id, stock_id)
values (209, 318);
insert into INJECTED (appointment_id, stock_id)
values (210, 301);
insert into INJECTED (appointment_id, stock_id)
values (210, 344);
insert into INJECTED (appointment_id, stock_id)
values (211, 189);
insert into INJECTED (appointment_id, stock_id)
values (211, 440);
insert into INJECTED (appointment_id, stock_id)
values (212, 261);
insert into INJECTED (appointment_id, stock_id)
values (212, 292);
insert into INJECTED (appointment_id, stock_id)
values (213, 441);
insert into INJECTED (appointment_id, stock_id)
values (213, 482);
insert into INJECTED (appointment_id, stock_id)
values (214, 208);
insert into INJECTED (appointment_id, stock_id)
values (214, 405);
insert into INJECTED (appointment_id, stock_id)
values (215, 252);
insert into INJECTED (appointment_id, stock_id)
values (215, 359);
insert into INJECTED (appointment_id, stock_id)
values (216, 262);
insert into INJECTED (appointment_id, stock_id)
values (216, 329);
insert into INJECTED (appointment_id, stock_id)
values (217, 184);
insert into INJECTED (appointment_id, stock_id)
values (217, 241);
insert into INJECTED (appointment_id, stock_id)
values (218, 157);
insert into INJECTED (appointment_id, stock_id)
values (218, 256);
insert into INJECTED (appointment_id, stock_id)
values (219, 219);
insert into INJECTED (appointment_id, stock_id)
values (219, 304);
insert into INJECTED (appointment_id, stock_id)
values (220, 347);
insert into INJECTED (appointment_id, stock_id)
values (220, 462);
insert into INJECTED (appointment_id, stock_id)
values (221, 411);
insert into INJECTED (appointment_id, stock_id)
values (221, 487);
insert into INJECTED (appointment_id, stock_id)
values (222, 301);
insert into INJECTED (appointment_id, stock_id)
values (222, 316);
insert into INJECTED (appointment_id, stock_id)
values (223, 455);
insert into INJECTED (appointment_id, stock_id)
values (223, 460);
insert into INJECTED (appointment_id, stock_id)
values (224, 206);
insert into INJECTED (appointment_id, stock_id)
values (224, 418);
insert into INJECTED (appointment_id, stock_id)
values (226, 105);
insert into INJECTED (appointment_id, stock_id)
values (226, 219);
insert into INJECTED (appointment_id, stock_id)
values (227, 176);
insert into INJECTED (appointment_id, stock_id)
values (227, 222);
insert into INJECTED (appointment_id, stock_id)
values (228, 108);
insert into INJECTED (appointment_id, stock_id)
values (228, 354);
insert into INJECTED (appointment_id, stock_id)
values (229, 285);
insert into INJECTED (appointment_id, stock_id)
values (229, 398);
insert into INJECTED (appointment_id, stock_id)
values (230, 136);
insert into INJECTED (appointment_id, stock_id)
values (230, 419);
insert into INJECTED (appointment_id, stock_id)
values (231, 227);
insert into INJECTED (appointment_id, stock_id)
values (231, 443);
insert into INJECTED (appointment_id, stock_id)
values (232, 306);
insert into INJECTED (appointment_id, stock_id)
values (232, 458);
insert into INJECTED (appointment_id, stock_id)
values (233, 233);
insert into INJECTED (appointment_id, stock_id)
values (233, 286);
insert into INJECTED (appointment_id, stock_id)
values (234, 161);
insert into INJECTED (appointment_id, stock_id)
values (234, 486);
insert into INJECTED (appointment_id, stock_id)
values (235, 144);
insert into INJECTED (appointment_id, stock_id)
values (235, 374);
insert into INJECTED (appointment_id, stock_id)
values (236, 237);
insert into INJECTED (appointment_id, stock_id)
values (236, 374);
insert into INJECTED (appointment_id, stock_id)
values (237, 295);
insert into INJECTED (appointment_id, stock_id)
values (237, 335);
insert into INJECTED (appointment_id, stock_id)
values (238, 167);
insert into INJECTED (appointment_id, stock_id)
values (238, 274);
insert into INJECTED (appointment_id, stock_id)
values (239, 113);
insert into INJECTED (appointment_id, stock_id)
values (239, 327);
insert into INJECTED (appointment_id, stock_id)
values (240, 118);
insert into INJECTED (appointment_id, stock_id)
values (240, 174);
insert into INJECTED (appointment_id, stock_id)
values (241, 405);
insert into INJECTED (appointment_id, stock_id)
values (241, 489);
insert into INJECTED (appointment_id, stock_id)
values (242, 208);
insert into INJECTED (appointment_id, stock_id)
values (242, 295);
insert into INJECTED (appointment_id, stock_id)
values (243, 473);
insert into INJECTED (appointment_id, stock_id)
values (243, 479);
insert into INJECTED (appointment_id, stock_id)
values (244, 155);
insert into INJECTED (appointment_id, stock_id)
values (244, 161);
insert into INJECTED (appointment_id, stock_id)
values (245, 164);
insert into INJECTED (appointment_id, stock_id)
values (245, 267);
insert into INJECTED (appointment_id, stock_id)
values (246, 288);
insert into INJECTED (appointment_id, stock_id)
values (246, 468);
insert into INJECTED (appointment_id, stock_id)
values (247, 125);
insert into INJECTED (appointment_id, stock_id)
values (247, 137);
insert into INJECTED (appointment_id, stock_id)
values (248, 328);
insert into INJECTED (appointment_id, stock_id)
values (248, 454);
insert into INJECTED (appointment_id, stock_id)
values (249, 465);
insert into INJECTED (appointment_id, stock_id)
values (249, 474);
insert into INJECTED (appointment_id, stock_id)
values (250, 153);
insert into INJECTED (appointment_id, stock_id)
values (250, 424);
insert into INJECTED (appointment_id, stock_id)
values (251, 299);
insert into INJECTED (appointment_id, stock_id)
values (251, 442);
insert into INJECTED (appointment_id, stock_id)
values (252, 360);
commit;
prompt 500 records committed...
insert into INJECTED (appointment_id, stock_id)
values (252, 482);
insert into INJECTED (appointment_id, stock_id)
values (253, 378);
insert into INJECTED (appointment_id, stock_id)
values (253, 404);
insert into INJECTED (appointment_id, stock_id)
values (254, 253);
insert into INJECTED (appointment_id, stock_id)
values (254, 478);
insert into INJECTED (appointment_id, stock_id)
values (255, 227);
insert into INJECTED (appointment_id, stock_id)
values (255, 458);
insert into INJECTED (appointment_id, stock_id)
values (256, 460);
insert into INJECTED (appointment_id, stock_id)
values (256, 465);
insert into INJECTED (appointment_id, stock_id)
values (257, 226);
insert into INJECTED (appointment_id, stock_id)
values (257, 406);
insert into INJECTED (appointment_id, stock_id)
values (258, 278);
insert into INJECTED (appointment_id, stock_id)
values (258, 306);
insert into INJECTED (appointment_id, stock_id)
values (259, 380);
insert into INJECTED (appointment_id, stock_id)
values (259, 433);
insert into INJECTED (appointment_id, stock_id)
values (260, 262);
insert into INJECTED (appointment_id, stock_id)
values (260, 413);
insert into INJECTED (appointment_id, stock_id)
values (261, 302);
insert into INJECTED (appointment_id, stock_id)
values (261, 486);
insert into INJECTED (appointment_id, stock_id)
values (262, 174);
insert into INJECTED (appointment_id, stock_id)
values (262, 416);
insert into INJECTED (appointment_id, stock_id)
values (263, 169);
insert into INJECTED (appointment_id, stock_id)
values (263, 197);
insert into INJECTED (appointment_id, stock_id)
values (264, 123);
insert into INJECTED (appointment_id, stock_id)
values (264, 379);
insert into INJECTED (appointment_id, stock_id)
values (265, 192);
insert into INJECTED (appointment_id, stock_id)
values (265, 375);
insert into INJECTED (appointment_id, stock_id)
values (266, 191);
insert into INJECTED (appointment_id, stock_id)
values (266, 488);
insert into INJECTED (appointment_id, stock_id)
values (267, 267);
insert into INJECTED (appointment_id, stock_id)
values (267, 400);
insert into INJECTED (appointment_id, stock_id)
values (268, 160);
insert into INJECTED (appointment_id, stock_id)
values (268, 294);
insert into INJECTED (appointment_id, stock_id)
values (269, 316);
insert into INJECTED (appointment_id, stock_id)
values (269, 398);
insert into INJECTED (appointment_id, stock_id)
values (270, 459);
insert into INJECTED (appointment_id, stock_id)
values (270, 479);
insert into INJECTED (appointment_id, stock_id)
values (271, 148);
insert into INJECTED (appointment_id, stock_id)
values (271, 469);
insert into INJECTED (appointment_id, stock_id)
values (272, 116);
insert into INJECTED (appointment_id, stock_id)
values (272, 202);
insert into INJECTED (appointment_id, stock_id)
values (273, 306);
insert into INJECTED (appointment_id, stock_id)
values (273, 484);
insert into INJECTED (appointment_id, stock_id)
values (274, 381);
insert into INJECTED (appointment_id, stock_id)
values (274, 444);
insert into INJECTED (appointment_id, stock_id)
values (275, 306);
insert into INJECTED (appointment_id, stock_id)
values (275, 472);
insert into INJECTED (appointment_id, stock_id)
values (276, 266);
insert into INJECTED (appointment_id, stock_id)
values (276, 422);
insert into INJECTED (appointment_id, stock_id)
values (277, 199);
insert into INJECTED (appointment_id, stock_id)
values (277, 309);
insert into INJECTED (appointment_id, stock_id)
values (278, 230);
insert into INJECTED (appointment_id, stock_id)
values (278, 269);
insert into INJECTED (appointment_id, stock_id)
values (279, 414);
insert into INJECTED (appointment_id, stock_id)
values (279, 486);
insert into INJECTED (appointment_id, stock_id)
values (280, 383);
insert into INJECTED (appointment_id, stock_id)
values (280, 492);
insert into INJECTED (appointment_id, stock_id)
values (281, 101);
insert into INJECTED (appointment_id, stock_id)
values (281, 480);
insert into INJECTED (appointment_id, stock_id)
values (282, 437);
insert into INJECTED (appointment_id, stock_id)
values (282, 467);
insert into INJECTED (appointment_id, stock_id)
values (283, 334);
insert into INJECTED (appointment_id, stock_id)
values (283, 443);
insert into INJECTED (appointment_id, stock_id)
values (284, 158);
insert into INJECTED (appointment_id, stock_id)
values (284, 445);
insert into INJECTED (appointment_id, stock_id)
values (285, 129);
insert into INJECTED (appointment_id, stock_id)
values (285, 313);
insert into INJECTED (appointment_id, stock_id)
values (286, 132);
insert into INJECTED (appointment_id, stock_id)
values (286, 473);
insert into INJECTED (appointment_id, stock_id)
values (287, 380);
insert into INJECTED (appointment_id, stock_id)
values (287, 490);
insert into INJECTED (appointment_id, stock_id)
values (288, 137);
insert into INJECTED (appointment_id, stock_id)
values (288, 458);
insert into INJECTED (appointment_id, stock_id)
values (289, 377);
insert into INJECTED (appointment_id, stock_id)
values (289, 410);
insert into INJECTED (appointment_id, stock_id)
values (290, 173);
insert into INJECTED (appointment_id, stock_id)
values (290, 213);
insert into INJECTED (appointment_id, stock_id)
values (291, 257);
insert into INJECTED (appointment_id, stock_id)
values (291, 313);
insert into INJECTED (appointment_id, stock_id)
values (292, 259);
insert into INJECTED (appointment_id, stock_id)
values (292, 283);
insert into INJECTED (appointment_id, stock_id)
values (293, 278);
insert into INJECTED (appointment_id, stock_id)
values (293, 454);
insert into INJECTED (appointment_id, stock_id)
values (294, 165);
insert into INJECTED (appointment_id, stock_id)
values (294, 275);
insert into INJECTED (appointment_id, stock_id)
values (295, 226);
insert into INJECTED (appointment_id, stock_id)
values (295, 346);
insert into INJECTED (appointment_id, stock_id)
values (296, 133);
insert into INJECTED (appointment_id, stock_id)
values (296, 271);
insert into INJECTED (appointment_id, stock_id)
values (297, 328);
insert into INJECTED (appointment_id, stock_id)
values (297, 378);
insert into INJECTED (appointment_id, stock_id)
values (298, 248);
insert into INJECTED (appointment_id, stock_id)
values (298, 489);
insert into INJECTED (appointment_id, stock_id)
values (299, 354);
insert into INJECTED (appointment_id, stock_id)
values (299, 450);
insert into INJECTED (appointment_id, stock_id)
values (300, 352);
insert into INJECTED (appointment_id, stock_id)
values (300, 364);
insert into INJECTED (appointment_id, stock_id)
values (301, 235);
insert into INJECTED (appointment_id, stock_id)
values (301, 255);
insert into INJECTED (appointment_id, stock_id)
values (302, 256);
commit;
prompt 600 records committed...
insert into INJECTED (appointment_id, stock_id)
values (302, 363);
insert into INJECTED (appointment_id, stock_id)
values (303, 156);
insert into INJECTED (appointment_id, stock_id)
values (303, 232);
insert into INJECTED (appointment_id, stock_id)
values (304, 256);
insert into INJECTED (appointment_id, stock_id)
values (304, 395);
insert into INJECTED (appointment_id, stock_id)
values (305, 109);
insert into INJECTED (appointment_id, stock_id)
values (305, 207);
insert into INJECTED (appointment_id, stock_id)
values (306, 151);
insert into INJECTED (appointment_id, stock_id)
values (306, 437);
insert into INJECTED (appointment_id, stock_id)
values (307, 142);
insert into INJECTED (appointment_id, stock_id)
values (307, 150);
insert into INJECTED (appointment_id, stock_id)
values (308, 308);
insert into INJECTED (appointment_id, stock_id)
values (308, 401);
insert into INJECTED (appointment_id, stock_id)
values (309, 342);
insert into INJECTED (appointment_id, stock_id)
values (309, 490);
insert into INJECTED (appointment_id, stock_id)
values (310, 167);
insert into INJECTED (appointment_id, stock_id)
values (310, 173);
insert into INJECTED (appointment_id, stock_id)
values (311, 157);
insert into INJECTED (appointment_id, stock_id)
values (311, 173);
insert into INJECTED (appointment_id, stock_id)
values (312, 115);
insert into INJECTED (appointment_id, stock_id)
values (312, 274);
insert into INJECTED (appointment_id, stock_id)
values (313, 122);
insert into INJECTED (appointment_id, stock_id)
values (313, 140);
insert into INJECTED (appointment_id, stock_id)
values (314, 191);
insert into INJECTED (appointment_id, stock_id)
values (314, 252);
insert into INJECTED (appointment_id, stock_id)
values (315, 368);
insert into INJECTED (appointment_id, stock_id)
values (315, 414);
insert into INJECTED (appointment_id, stock_id)
values (316, 183);
insert into INJECTED (appointment_id, stock_id)
values (316, 342);
insert into INJECTED (appointment_id, stock_id)
values (317, 448);
insert into INJECTED (appointment_id, stock_id)
values (317, 493);
insert into INJECTED (appointment_id, stock_id)
values (318, 426);
insert into INJECTED (appointment_id, stock_id)
values (318, 435);
insert into INJECTED (appointment_id, stock_id)
values (319, 220);
insert into INJECTED (appointment_id, stock_id)
values (319, 465);
insert into INJECTED (appointment_id, stock_id)
values (320, 290);
insert into INJECTED (appointment_id, stock_id)
values (320, 315);
insert into INJECTED (appointment_id, stock_id)
values (321, 349);
insert into INJECTED (appointment_id, stock_id)
values (321, 438);
insert into INJECTED (appointment_id, stock_id)
values (322, 200);
insert into INJECTED (appointment_id, stock_id)
values (322, 351);
insert into INJECTED (appointment_id, stock_id)
values (323, 294);
insert into INJECTED (appointment_id, stock_id)
values (323, 380);
insert into INJECTED (appointment_id, stock_id)
values (324, 158);
insert into INJECTED (appointment_id, stock_id)
values (324, 238);
insert into INJECTED (appointment_id, stock_id)
values (325, 257);
insert into INJECTED (appointment_id, stock_id)
values (325, 409);
insert into INJECTED (appointment_id, stock_id)
values (326, 456);
insert into INJECTED (appointment_id, stock_id)
values (326, 490);
insert into INJECTED (appointment_id, stock_id)
values (327, 115);
insert into INJECTED (appointment_id, stock_id)
values (327, 297);
insert into INJECTED (appointment_id, stock_id)
values (328, 289);
insert into INJECTED (appointment_id, stock_id)
values (328, 296);
insert into INJECTED (appointment_id, stock_id)
values (329, 113);
insert into INJECTED (appointment_id, stock_id)
values (329, 302);
insert into INJECTED (appointment_id, stock_id)
values (330, 103);
insert into INJECTED (appointment_id, stock_id)
values (330, 213);
insert into INJECTED (appointment_id, stock_id)
values (331, 130);
insert into INJECTED (appointment_id, stock_id)
values (331, 365);
insert into INJECTED (appointment_id, stock_id)
values (332, 192);
insert into INJECTED (appointment_id, stock_id)
values (332, 334);
insert into INJECTED (appointment_id, stock_id)
values (333, 240);
insert into INJECTED (appointment_id, stock_id)
values (333, 248);
insert into INJECTED (appointment_id, stock_id)
values (334, 324);
insert into INJECTED (appointment_id, stock_id)
values (334, 329);
insert into INJECTED (appointment_id, stock_id)
values (335, 392);
insert into INJECTED (appointment_id, stock_id)
values (335, 493);
insert into INJECTED (appointment_id, stock_id)
values (336, 230);
insert into INJECTED (appointment_id, stock_id)
values (336, 422);
insert into INJECTED (appointment_id, stock_id)
values (337, 376);
insert into INJECTED (appointment_id, stock_id)
values (337, 408);
insert into INJECTED (appointment_id, stock_id)
values (338, 113);
insert into INJECTED (appointment_id, stock_id)
values (338, 345);
insert into INJECTED (appointment_id, stock_id)
values (339, 442);
insert into INJECTED (appointment_id, stock_id)
values (339, 478);
insert into INJECTED (appointment_id, stock_id)
values (340, 380);
insert into INJECTED (appointment_id, stock_id)
values (340, 420);
insert into INJECTED (appointment_id, stock_id)
values (341, 120);
insert into INJECTED (appointment_id, stock_id)
values (341, 303);
insert into INJECTED (appointment_id, stock_id)
values (342, 110);
insert into INJECTED (appointment_id, stock_id)
values (342, 160);
insert into INJECTED (appointment_id, stock_id)
values (343, 204);
insert into INJECTED (appointment_id, stock_id)
values (343, 390);
insert into INJECTED (appointment_id, stock_id)
values (344, 410);
insert into INJECTED (appointment_id, stock_id)
values (344, 427);
insert into INJECTED (appointment_id, stock_id)
values (345, 414);
insert into INJECTED (appointment_id, stock_id)
values (346, 467);
insert into INJECTED (appointment_id, stock_id)
values (347, 419);
insert into INJECTED (appointment_id, stock_id)
values (348, 318);
insert into INJECTED (appointment_id, stock_id)
values (349, 301);
insert into INJECTED (appointment_id, stock_id)
values (350, 113);
insert into INJECTED (appointment_id, stock_id)
values (351, 427);
insert into INJECTED (appointment_id, stock_id)
values (352, 402);
insert into INJECTED (appointment_id, stock_id)
values (353, 297);
insert into INJECTED (appointment_id, stock_id)
values (354, 374);
insert into INJECTED (appointment_id, stock_id)
values (355, 423);
insert into INJECTED (appointment_id, stock_id)
values (356, 297);
insert into INJECTED (appointment_id, stock_id)
values (357, 437);
insert into INJECTED (appointment_id, stock_id)
values (358, 272);
insert into INJECTED (appointment_id, stock_id)
values (359, 472);
commit;
prompt 700 records committed...
insert into INJECTED (appointment_id, stock_id)
values (360, 202);
insert into INJECTED (appointment_id, stock_id)
values (361, 200);
insert into INJECTED (appointment_id, stock_id)
values (362, 323);
insert into INJECTED (appointment_id, stock_id)
values (363, 263);
insert into INJECTED (appointment_id, stock_id)
values (364, 406);
insert into INJECTED (appointment_id, stock_id)
values (365, 110);
insert into INJECTED (appointment_id, stock_id)
values (366, 414);
insert into INJECTED (appointment_id, stock_id)
values (367, 262);
insert into INJECTED (appointment_id, stock_id)
values (368, 300);
insert into INJECTED (appointment_id, stock_id)
values (369, 359);
insert into INJECTED (appointment_id, stock_id)
values (370, 394);
insert into INJECTED (appointment_id, stock_id)
values (371, 451);
insert into INJECTED (appointment_id, stock_id)
values (372, 165);
insert into INJECTED (appointment_id, stock_id)
values (373, 125);
insert into INJECTED (appointment_id, stock_id)
values (374, 132);
insert into INJECTED (appointment_id, stock_id)
values (375, 382);
insert into INJECTED (appointment_id, stock_id)
values (376, 330);
insert into INJECTED (appointment_id, stock_id)
values (377, 147);
insert into INJECTED (appointment_id, stock_id)
values (378, 278);
insert into INJECTED (appointment_id, stock_id)
values (379, 374);
insert into INJECTED (appointment_id, stock_id)
values (380, 401);
insert into INJECTED (appointment_id, stock_id)
values (381, 434);
insert into INJECTED (appointment_id, stock_id)
values (382, 279);
insert into INJECTED (appointment_id, stock_id)
values (383, 152);
insert into INJECTED (appointment_id, stock_id)
values (384, 148);
insert into INJECTED (appointment_id, stock_id)
values (385, 275);
insert into INJECTED (appointment_id, stock_id)
values (386, 286);
insert into INJECTED (appointment_id, stock_id)
values (387, 157);
insert into INJECTED (appointment_id, stock_id)
values (388, 140);
insert into INJECTED (appointment_id, stock_id)
values (389, 204);
insert into INJECTED (appointment_id, stock_id)
values (390, 497);
insert into INJECTED (appointment_id, stock_id)
values (391, 455);
insert into INJECTED (appointment_id, stock_id)
values (392, 339);
insert into INJECTED (appointment_id, stock_id)
values (393, 122);
insert into INJECTED (appointment_id, stock_id)
values (394, 389);
insert into INJECTED (appointment_id, stock_id)
values (395, 241);
insert into INJECTED (appointment_id, stock_id)
values (396, 121);
insert into INJECTED (appointment_id, stock_id)
values (397, 202);
insert into INJECTED (appointment_id, stock_id)
values (398, 366);
insert into INJECTED (appointment_id, stock_id)
values (399, 281);
insert into INJECTED (appointment_id, stock_id)
values (399, 361);
insert into INJECTED (appointment_id, stock_id)
values (399, 456);
insert into INJECTED (appointment_id, stock_id)
values (400, 257);
insert into INJECTED (appointment_id, stock_id)
values (400, 425);
insert into INJECTED (appointment_id, stock_id)
values (401, 219);
insert into INJECTED (appointment_id, stock_id)
values (402, 103);
commit;
prompt 746 records loaded
prompt Loading NURSE...
insert into NURSE (nurse_id, name, birth_date)
values (100, 'Joh', to_date('01-03-1998', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (101, 'Eri', to_date('08-09-1985', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (102, 'Aar', to_date('09-09-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (103, 'Joa', to_date('29-05-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (107, 'Jos', to_date('04-10-1993', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (109, 'Mat', to_date('14-01-1975', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (112, 'Jos', to_date('26-11-1982', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (113, 'Ann', to_date('22-09-1995', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (118, 'Chr', to_date('10-09-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (122, 'Nic', to_date('08-07-1986', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (123, 'Jac', to_date('24-09-1977', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (124, 'She', to_date('13-10-1981', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (125, 'Jam', to_date('29-12-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (126, 'Fra', to_date('09-04-1977', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (127, 'Tam', to_date('06-04-1987', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (128, 'Jos', to_date('19-12-1994', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (129, 'Tod', to_date('26-03-1993', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (130, 'Den', to_date('28-12-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (132, 'Bry', to_date('25-08-1973', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (133, 'Sam', to_date('27-04-1987', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (135, 'Kim', to_date('30-10-1990', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (136, 'Kri', to_date('11-11-1992', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (139, 'Kev', to_date('26-04-1982', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (143, 'Dr.', to_date('22-07-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (145, 'Mic', to_date('04-11-1996', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (146, 'Jam', to_date('19-04-1995', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (147, 'Ant', to_date('11-08-1990', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (149, 'Tho', to_date('30-05-1986', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (153, 'Cha', to_date('22-06-1986', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (154, 'Kev', to_date('02-12-1996', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (155, 'Dia', to_date('31-08-1986', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (156, 'Ang', to_date('17-05-1985', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (157, 'Ste', to_date('28-12-1986', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (158, 'Tam', to_date('14-04-1990', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (160, 'Wil', to_date('06-04-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (161, 'Kai', to_date('18-10-1977', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (168, 'Mat', to_date('09-02-1981', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (169, 'Lau', to_date('20-01-1999', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (171, 'The', to_date('10-10-1977', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (174, 'Wil', to_date('17-01-1996', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (175, 'Lis', to_date('07-01-1995', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (176, 'Tre', to_date('31-12-1993', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (178, 'Mr.', to_date('01-09-1990', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (180, 'Dar', to_date('02-03-1993', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (181, 'Eli', to_date('29-06-1990', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (182, 'Zac', to_date('08-04-1996', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (184, 'Ada', to_date('25-06-1987', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (185, 'Mic', to_date('25-08-1981', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (186, 'Lau', to_date('21-11-1980', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (187, 'Dua', to_date('05-04-1979', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (189, 'Lis', to_date('25-07-1977', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (191, 'Mar', to_date('12-12-1984', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (192, 'Ant', to_date('06-12-1992', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (193, 'Ric', to_date('31-03-1999', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (194, 'Ste', to_date('01-03-1998', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (195, 'Tay', to_date('27-05-1982', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (196, 'Cas', to_date('02-12-1975', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (197, 'Mic', to_date('04-08-1982', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (199, 'Cou', to_date('16-07-1979', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (200, 'Mar', to_date('05-02-1975', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (201, 'Jil', to_date('18-09-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (202, 'Sal', to_date('13-06-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (203, 'Kev', to_date('08-08-1974', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (205, 'And', to_date('07-09-1976', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (206, 'Pau', to_date('16-03-1984', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (207, 'Ste', to_date('11-08-1979', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (208, 'Vic', to_date('23-09-1977', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (209, 'Der', to_date('14-09-1974', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (210, 'And', to_date('04-01-1995', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (211, 'Zac', to_date('23-01-1980', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (212, 'Mic', to_date('18-02-1990', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (215, 'Ang', to_date('02-12-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (216, 'Ian', to_date('02-07-1979', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (218, 'Kay', to_date('23-02-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (220, 'Jus', to_date('10-05-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (221, 'Mr.', to_date('17-09-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (222, 'Ann', to_date('24-11-1984', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (223, 'Kel', to_date('17-05-1994', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (224, 'Gab', to_date('18-05-1999', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (225, 'Eri', to_date('07-07-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (226, 'Mic', to_date('17-05-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (227, 'Mak', to_date('27-11-1981', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (228, 'She', to_date('07-12-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (229, 'Kim', to_date('23-08-1990', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (231, 'Tay', to_date('18-06-1984', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (232, 'Den', to_date('02-06-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (233, 'Can', to_date('11-10-1998', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (235, 'Tim', to_date('08-12-1995', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (237, 'Dan', to_date('15-04-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (239, 'Ant', to_date('12-09-1981', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (240, 'Kat', to_date('14-04-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (242, 'Sus', to_date('08-09-1982', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (243, 'Jor', to_date('10-02-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (244, 'Gab', to_date('04-06-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (245, 'Rho', to_date('10-08-1998', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (247, 'Bob', to_date('16-03-1987', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (249, 'Aar', to_date('27-09-1998', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (252, 'Jen', to_date('08-04-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (253, 'Tar', to_date('26-03-1999', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (254, 'Mrs', to_date('02-04-1997', 'dd-mm-yyyy'));
commit;
prompt 100 records committed...
insert into NURSE (nurse_id, name, birth_date)
values (255, 'Lar', to_date('24-04-1995', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (256, 'Jas', to_date('22-01-1975', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (257, 'Ron', to_date('19-05-1994', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (258, 'Mel', to_date('29-08-1984', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (260, 'Ril', to_date('01-05-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (261, 'Ben', to_date('30-03-1992', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (262, 'Jer', to_date('19-08-1986', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (263, 'Pau', to_date('02-05-1981', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (264, 'Nic', to_date('14-09-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (265, 'Lin', to_date('07-03-1977', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (266, 'Eli', to_date('18-09-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (268, 'Lis', to_date('12-10-1976', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (269, 'Jus', to_date('14-08-1988', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (270, 'Cou', to_date('16-01-1981', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (271, 'Mar', to_date('08-10-1975', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (274, 'Sus', to_date('22-04-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (275, 'Fai', to_date('18-05-1979', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (277, 'Tin', to_date('10-05-1980', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (278, 'Sar', to_date('18-03-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (279, 'Syd', to_date('11-10-1982', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (280, 'Mat', to_date('22-05-1998', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (281, 'Lis', to_date('25-04-1996', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (282, 'Ali', to_date('13-12-1990', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (284, 'Lin', to_date('18-10-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (285, 'Dan', to_date('24-11-1979', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (286, 'Cyn', to_date('26-10-1988', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (287, 'Kyl', to_date('06-03-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (288, 'Dav', to_date('13-10-1974', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (290, 'Jas', to_date('17-12-1980', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (291, 'Jac', to_date('07-05-1980', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (293, 'Pau', to_date('13-08-1975', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (294, 'Dav', to_date('14-04-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (295, 'Chr', to_date('15-12-1976', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (299, 'Jer', to_date('26-03-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (302, 'Ian', to_date('22-02-1980', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (304, 'Jos', to_date('02-02-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (307, 'Phi', to_date('14-10-1973', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (308, 'Kel', to_date('04-03-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (309, 'Ant', to_date('10-07-1975', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (310, 'Rob', to_date('20-03-1975', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (311, 'Rob', to_date('03-07-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (313, 'Jen', to_date('29-11-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (314, 'Joa', to_date('18-03-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (315, 'Cas', to_date('27-05-1996', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (316, 'Sar', to_date('03-05-1999', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (318, 'Mar', to_date('18-01-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (320, 'Rob', to_date('11-11-1974', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (322, 'Nic', to_date('23-07-1973', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (325, 'Fra', to_date('13-07-1982', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (326, 'Ric', to_date('31-12-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (327, 'Bar', to_date('30-10-1974', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (328, 'Mrs', to_date('10-11-1985', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (329, 'Ang', to_date('25-01-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (330, 'Tin', to_date('28-02-1992', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (331, 'Jan', to_date('20-02-1981', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (332, 'Jon', to_date('01-08-1994', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (333, 'Lis', to_date('27-04-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (334, 'Bri', to_date('26-09-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (335, 'Mar', to_date('22-08-1988', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (336, 'Tim', to_date('14-11-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (337, 'Mr.', to_date('17-05-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (339, 'Sar', to_date('18-10-1980', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (341, 'Joh', to_date('10-08-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (342, 'Mar', to_date('28-03-1981', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (344, 'And', to_date('04-08-1998', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (345, 'Ste', to_date('03-04-1981', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (348, 'Rho', to_date('24-09-1977', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (351, 'Bry', to_date('04-10-1986', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (352, 'Ms.', to_date('02-08-1975', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (353, 'Dou', to_date('15-10-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (355, 'Jon', to_date('24-11-1994', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (356, 'Jen', to_date('14-06-1974', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (358, 'Tra', to_date('20-02-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (359, 'Tim', to_date('15-01-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (360, 'Kev', to_date('09-06-1977', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (362, 'Ray', to_date('16-10-1974', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (363, 'Ann', to_date('02-05-1994', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (365, 'Tra', to_date('05-11-1987', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (366, 'Mar', to_date('06-12-1980', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (370, 'Ann', to_date('24-05-1984', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (373, 'Gar', to_date('26-01-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (375, 'Mic', to_date('08-04-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (376, 'Chr', to_date('04-04-1979', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (379, 'Mic', to_date('20-08-1979', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (380, 'Jos', to_date('26-09-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (384, 'Eli', to_date('25-01-1993', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (387, 'Eli', to_date('15-04-1975', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (388, 'Rob', to_date('06-12-1993', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (392, 'Bri', to_date('13-02-1992', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (393, 'Ste', to_date('20-02-1980', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (394, 'Kim', to_date('09-04-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (395, 'Dr.', to_date('29-03-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (396, 'Pam', to_date('15-11-1997', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (397, 'Ang', to_date('15-06-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (398, 'Mat', to_date('26-02-1988', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (400, 'Bla', to_date('26-03-1976', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (401, 'Ani', to_date('05-04-1998', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (402, 'Meg', to_date('28-07-1994', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (403, 'Sam', to_date('12-11-1994', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (404, 'Ash', to_date('18-03-1986', 'dd-mm-yyyy'));
commit;
prompt 200 records committed...
insert into NURSE (nurse_id, name, birth_date)
values (405, 'Ang', to_date('02-08-1996', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (406, 'Dar', to_date('14-05-1974', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (408, 'Chr', to_date('02-11-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (409, 'Cha', to_date('10-04-1989', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (411, 'Nan', to_date('31-05-1992', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (412, 'And', to_date('28-05-1983', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (414, 'Dan', to_date('15-03-1984', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (416, 'Tam', to_date('31-07-1987', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (417, 'Jam', to_date('16-09-1979', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (418, 'Cor', to_date('24-08-1986', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (419, 'Rob', to_date('29-05-1988', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (420, 'Eli', to_date('14-04-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (422, 'Dus', to_date('29-02-1988', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (423, 'And', to_date('04-05-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (426, 'Jen', to_date('29-06-1978', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (427, 'Mar', to_date('17-01-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (431, 'Ter', to_date('02-04-1986', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (432, 'Ric', to_date('22-06-1992', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (437, 'Jos', to_date('18-11-1976', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (438, 'Bri', to_date('13-10-1986', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (439, 'Reb', to_date('20-02-1993', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (440, 'Dr.', to_date('23-09-1985', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (441, 'Aar', to_date('18-02-1999', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (444, 'Jas', to_date('15-03-1976', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (445, 'Tim', to_date('02-12-1991', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (448, 'Jos', to_date('11-02-1988', 'dd-mm-yyyy'));
insert into NURSE (nurse_id, name, birth_date)
values (449, 'Wen', to_date('15-10-1985', 'dd-mm-yyyy'));
commit;
prompt 227 records loaded
prompt Loading INJECTED_BY...
insert into INJECTED_BY (appointment_id, nurse_id)
values (1, 275);
insert into INJECTED_BY (appointment_id, nurse_id)
values (2, 373);
insert into INJECTED_BY (appointment_id, nurse_id)
values (3, 242);
insert into INJECTED_BY (appointment_id, nurse_id)
values (4, 308);
insert into INJECTED_BY (appointment_id, nurse_id)
values (5, 315);
insert into INJECTED_BY (appointment_id, nurse_id)
values (6, 189);
insert into INJECTED_BY (appointment_id, nurse_id)
values (7, 194);
insert into INJECTED_BY (appointment_id, nurse_id)
values (8, 423);
insert into INJECTED_BY (appointment_id, nurse_id)
values (9, 147);
insert into INJECTED_BY (appointment_id, nurse_id)
values (10, 252);
insert into INJECTED_BY (appointment_id, nurse_id)
values (11, 327);
insert into INJECTED_BY (appointment_id, nurse_id)
values (12, 322);
insert into INJECTED_BY (appointment_id, nurse_id)
values (13, 352);
insert into INJECTED_BY (appointment_id, nurse_id)
values (14, 216);
insert into INJECTED_BY (appointment_id, nurse_id)
values (15, 176);
insert into INJECTED_BY (appointment_id, nurse_id)
values (16, 405);
insert into INJECTED_BY (appointment_id, nurse_id)
values (17, 358);
insert into INJECTED_BY (appointment_id, nurse_id)
values (18, 393);
insert into INJECTED_BY (appointment_id, nurse_id)
values (19, 207);
insert into INJECTED_BY (appointment_id, nurse_id)
values (20, 245);
insert into INJECTED_BY (appointment_id, nurse_id)
values (21, 266);
insert into INJECTED_BY (appointment_id, nurse_id)
values (22, 133);
insert into INJECTED_BY (appointment_id, nurse_id)
values (23, 441);
insert into INJECTED_BY (appointment_id, nurse_id)
values (24, 444);
insert into INJECTED_BY (appointment_id, nurse_id)
values (25, 216);
insert into INJECTED_BY (appointment_id, nurse_id)
values (26, 440);
insert into INJECTED_BY (appointment_id, nurse_id)
values (27, 275);
insert into INJECTED_BY (appointment_id, nurse_id)
values (28, 311);
insert into INJECTED_BY (appointment_id, nurse_id)
values (29, 244);
insert into INJECTED_BY (appointment_id, nurse_id)
values (30, 231);
insert into INJECTED_BY (appointment_id, nurse_id)
values (31, 195);
insert into INJECTED_BY (appointment_id, nurse_id)
values (32, 102);
insert into INJECTED_BY (appointment_id, nurse_id)
values (33, 128);
insert into INJECTED_BY (appointment_id, nurse_id)
values (34, 291);
insert into INJECTED_BY (appointment_id, nurse_id)
values (35, 206);
insert into INJECTED_BY (appointment_id, nurse_id)
values (36, 155);
insert into INJECTED_BY (appointment_id, nurse_id)
values (37, 231);
insert into INJECTED_BY (appointment_id, nurse_id)
values (38, 286);
insert into INJECTED_BY (appointment_id, nurse_id)
values (39, 406);
insert into INJECTED_BY (appointment_id, nurse_id)
values (40, 237);
insert into INJECTED_BY (appointment_id, nurse_id)
values (41, 229);
insert into INJECTED_BY (appointment_id, nurse_id)
values (42, 260);
insert into INJECTED_BY (appointment_id, nurse_id)
values (43, 109);
insert into INJECTED_BY (appointment_id, nurse_id)
values (44, 384);
insert into INJECTED_BY (appointment_id, nurse_id)
values (45, 402);
insert into INJECTED_BY (appointment_id, nurse_id)
values (46, 220);
insert into INJECTED_BY (appointment_id, nurse_id)
values (47, 412);
insert into INJECTED_BY (appointment_id, nurse_id)
values (48, 408);
insert into INJECTED_BY (appointment_id, nurse_id)
values (49, 438);
insert into INJECTED_BY (appointment_id, nurse_id)
values (50, 295);
insert into INJECTED_BY (appointment_id, nurse_id)
values (51, 128);
insert into INJECTED_BY (appointment_id, nurse_id)
values (52, 222);
insert into INJECTED_BY (appointment_id, nurse_id)
values (53, 271);
insert into INJECTED_BY (appointment_id, nurse_id)
values (54, 158);
insert into INJECTED_BY (appointment_id, nurse_id)
values (55, 333);
insert into INJECTED_BY (appointment_id, nurse_id)
values (56, 445);
insert into INJECTED_BY (appointment_id, nurse_id)
values (57, 178);
insert into INJECTED_BY (appointment_id, nurse_id)
values (58, 360);
insert into INJECTED_BY (appointment_id, nurse_id)
values (59, 239);
insert into INJECTED_BY (appointment_id, nurse_id)
values (60, 353);
insert into INJECTED_BY (appointment_id, nurse_id)
values (61, 262);
insert into INJECTED_BY (appointment_id, nurse_id)
values (62, 253);
insert into INJECTED_BY (appointment_id, nurse_id)
values (63, 185);
insert into INJECTED_BY (appointment_id, nurse_id)
values (64, 178);
insert into INJECTED_BY (appointment_id, nurse_id)
values (65, 235);
insert into INJECTED_BY (appointment_id, nurse_id)
values (66, 220);
insert into INJECTED_BY (appointment_id, nurse_id)
values (67, 243);
insert into INJECTED_BY (appointment_id, nurse_id)
values (68, 432);
insert into INJECTED_BY (appointment_id, nurse_id)
values (69, 157);
insert into INJECTED_BY (appointment_id, nurse_id)
values (70, 264);
insert into INJECTED_BY (appointment_id, nurse_id)
values (71, 228);
insert into INJECTED_BY (appointment_id, nurse_id)
values (72, 171);
insert into INJECTED_BY (appointment_id, nurse_id)
values (73, 416);
insert into INJECTED_BY (appointment_id, nurse_id)
values (74, 395);
insert into INJECTED_BY (appointment_id, nurse_id)
values (75, 308);
insert into INJECTED_BY (appointment_id, nurse_id)
values (76, 394);
insert into INJECTED_BY (appointment_id, nurse_id)
values (77, 363);
insert into INJECTED_BY (appointment_id, nurse_id)
values (78, 299);
insert into INJECTED_BY (appointment_id, nurse_id)
values (79, 118);
insert into INJECTED_BY (appointment_id, nurse_id)
values (80, 269);
insert into INJECTED_BY (appointment_id, nurse_id)
values (81, 395);
insert into INJECTED_BY (appointment_id, nurse_id)
values (82, 408);
insert into INJECTED_BY (appointment_id, nurse_id)
values (83, 304);
insert into INJECTED_BY (appointment_id, nurse_id)
values (84, 288);
insert into INJECTED_BY (appointment_id, nurse_id)
values (85, 401);
insert into INJECTED_BY (appointment_id, nurse_id)
values (86, 261);
insert into INJECTED_BY (appointment_id, nurse_id)
values (87, 362);
insert into INJECTED_BY (appointment_id, nurse_id)
values (88, 199);
insert into INJECTED_BY (appointment_id, nurse_id)
values (89, 231);
insert into INJECTED_BY (appointment_id, nurse_id)
values (90, 314);
insert into INJECTED_BY (appointment_id, nurse_id)
values (91, 392);
insert into INJECTED_BY (appointment_id, nurse_id)
values (92, 405);
insert into INJECTED_BY (appointment_id, nurse_id)
values (93, 218);
insert into INJECTED_BY (appointment_id, nurse_id)
values (94, 112);
insert into INJECTED_BY (appointment_id, nurse_id)
values (95, 103);
insert into INJECTED_BY (appointment_id, nurse_id)
values (96, 445);
insert into INJECTED_BY (appointment_id, nurse_id)
values (97, 195);
insert into INJECTED_BY (appointment_id, nurse_id)
values (98, 215);
insert into INJECTED_BY (appointment_id, nurse_id)
values (99, 401);
insert into INJECTED_BY (appointment_id, nurse_id)
values (100, 277);
commit;
prompt 100 records committed...
insert into INJECTED_BY (appointment_id, nurse_id)
values (101, 126);
insert into INJECTED_BY (appointment_id, nurse_id)
values (102, 240);
insert into INJECTED_BY (appointment_id, nurse_id)
values (103, 375);
insert into INJECTED_BY (appointment_id, nurse_id)
values (104, 256);
insert into INJECTED_BY (appointment_id, nurse_id)
values (105, 284);
insert into INJECTED_BY (appointment_id, nurse_id)
values (106, 256);
insert into INJECTED_BY (appointment_id, nurse_id)
values (107, 107);
insert into INJECTED_BY (appointment_id, nurse_id)
values (108, 427);
insert into INJECTED_BY (appointment_id, nurse_id)
values (109, 400);
insert into INJECTED_BY (appointment_id, nurse_id)
values (110, 181);
insert into INJECTED_BY (appointment_id, nurse_id)
values (111, 178);
insert into INJECTED_BY (appointment_id, nurse_id)
values (112, 146);
insert into INJECTED_BY (appointment_id, nurse_id)
values (113, 445);
insert into INJECTED_BY (appointment_id, nurse_id)
values (114, 360);
insert into INJECTED_BY (appointment_id, nurse_id)
values (115, 412);
insert into INJECTED_BY (appointment_id, nurse_id)
values (116, 186);
insert into INJECTED_BY (appointment_id, nurse_id)
values (117, 207);
insert into INJECTED_BY (appointment_id, nurse_id)
values (118, 266);
insert into INJECTED_BY (appointment_id, nurse_id)
values (119, 128);
insert into INJECTED_BY (appointment_id, nurse_id)
values (120, 124);
insert into INJECTED_BY (appointment_id, nurse_id)
values (121, 129);
insert into INJECTED_BY (appointment_id, nurse_id)
values (122, 439);
insert into INJECTED_BY (appointment_id, nurse_id)
values (123, 160);
insert into INJECTED_BY (appointment_id, nurse_id)
values (124, 359);
insert into INJECTED_BY (appointment_id, nurse_id)
values (125, 411);
insert into INJECTED_BY (appointment_id, nurse_id)
values (126, 210);
insert into INJECTED_BY (appointment_id, nurse_id)
values (127, 330);
insert into INJECTED_BY (appointment_id, nurse_id)
values (128, 307);
insert into INJECTED_BY (appointment_id, nurse_id)
values (129, 313);
insert into INJECTED_BY (appointment_id, nurse_id)
values (130, 356);
insert into INJECTED_BY (appointment_id, nurse_id)
values (131, 161);
insert into INJECTED_BY (appointment_id, nurse_id)
values (132, 215);
insert into INJECTED_BY (appointment_id, nurse_id)
values (133, 437);
insert into INJECTED_BY (appointment_id, nurse_id)
values (134, 270);
insert into INJECTED_BY (appointment_id, nurse_id)
values (135, 209);
insert into INJECTED_BY (appointment_id, nurse_id)
values (136, 416);
insert into INJECTED_BY (appointment_id, nurse_id)
values (137, 295);
insert into INJECTED_BY (appointment_id, nurse_id)
values (138, 348);
insert into INJECTED_BY (appointment_id, nurse_id)
values (139, 403);
insert into INJECTED_BY (appointment_id, nurse_id)
values (140, 370);
insert into INJECTED_BY (appointment_id, nurse_id)
values (141, 419);
insert into INJECTED_BY (appointment_id, nurse_id)
values (142, 414);
insert into INJECTED_BY (appointment_id, nurse_id)
values (143, 295);
insert into INJECTED_BY (appointment_id, nurse_id)
values (144, 266);
insert into INJECTED_BY (appointment_id, nurse_id)
values (145, 107);
insert into INJECTED_BY (appointment_id, nurse_id)
values (146, 158);
insert into INJECTED_BY (appointment_id, nurse_id)
values (147, 266);
insert into INJECTED_BY (appointment_id, nurse_id)
values (148, 345);
insert into INJECTED_BY (appointment_id, nurse_id)
values (149, 212);
insert into INJECTED_BY (appointment_id, nurse_id)
values (150, 288);
insert into INJECTED_BY (appointment_id, nurse_id)
values (151, 334);
insert into INJECTED_BY (appointment_id, nurse_id)
values (152, 180);
insert into INJECTED_BY (appointment_id, nurse_id)
values (153, 161);
insert into INJECTED_BY (appointment_id, nurse_id)
values (154, 379);
insert into INJECTED_BY (appointment_id, nurse_id)
values (155, 334);
insert into INJECTED_BY (appointment_id, nurse_id)
values (156, 268);
insert into INJECTED_BY (appointment_id, nurse_id)
values (157, 181);
insert into INJECTED_BY (appointment_id, nurse_id)
values (158, 359);
insert into INJECTED_BY (appointment_id, nurse_id)
values (159, 418);
insert into INJECTED_BY (appointment_id, nurse_id)
values (160, 290);
insert into INJECTED_BY (appointment_id, nurse_id)
values (161, 200);
insert into INJECTED_BY (appointment_id, nurse_id)
values (162, 401);
insert into INJECTED_BY (appointment_id, nurse_id)
values (163, 195);
insert into INJECTED_BY (appointment_id, nurse_id)
values (164, 403);
insert into INJECTED_BY (appointment_id, nurse_id)
values (165, 258);
insert into INJECTED_BY (appointment_id, nurse_id)
values (166, 352);
insert into INJECTED_BY (appointment_id, nurse_id)
values (167, 196);
insert into INJECTED_BY (appointment_id, nurse_id)
values (168, 123);
insert into INJECTED_BY (appointment_id, nurse_id)
values (169, 388);
insert into INJECTED_BY (appointment_id, nurse_id)
values (170, 326);
insert into INJECTED_BY (appointment_id, nurse_id)
values (171, 302);
insert into INJECTED_BY (appointment_id, nurse_id)
values (172, 266);
insert into INJECTED_BY (appointment_id, nurse_id)
values (173, 423);
insert into INJECTED_BY (appointment_id, nurse_id)
values (174, 254);
insert into INJECTED_BY (appointment_id, nurse_id)
values (175, 397);
insert into INJECTED_BY (appointment_id, nurse_id)
values (176, 229);
insert into INJECTED_BY (appointment_id, nurse_id)
values (177, 308);
insert into INJECTED_BY (appointment_id, nurse_id)
values (178, 186);
insert into INJECTED_BY (appointment_id, nurse_id)
values (179, 168);
insert into INJECTED_BY (appointment_id, nurse_id)
values (180, 126);
insert into INJECTED_BY (appointment_id, nurse_id)
values (181, 156);
insert into INJECTED_BY (appointment_id, nurse_id)
values (182, 380);
insert into INJECTED_BY (appointment_id, nurse_id)
values (183, 329);
insert into INJECTED_BY (appointment_id, nurse_id)
values (184, 224);
insert into INJECTED_BY (appointment_id, nurse_id)
values (185, 444);
insert into INJECTED_BY (appointment_id, nurse_id)
values (186, 326);
insert into INJECTED_BY (appointment_id, nurse_id)
values (187, 263);
insert into INJECTED_BY (appointment_id, nurse_id)
values (188, 344);
insert into INJECTED_BY (appointment_id, nurse_id)
values (189, 365);
insert into INJECTED_BY (appointment_id, nurse_id)
values (190, 139);
insert into INJECTED_BY (appointment_id, nurse_id)
values (191, 145);
insert into INJECTED_BY (appointment_id, nurse_id)
values (192, 291);
insert into INJECTED_BY (appointment_id, nurse_id)
values (193, 171);
insert into INJECTED_BY (appointment_id, nurse_id)
values (194, 132);
insert into INJECTED_BY (appointment_id, nurse_id)
values (195, 260);
insert into INJECTED_BY (appointment_id, nurse_id)
values (196, 282);
insert into INJECTED_BY (appointment_id, nurse_id)
values (197, 426);
insert into INJECTED_BY (appointment_id, nurse_id)
values (198, 420);
insert into INJECTED_BY (appointment_id, nurse_id)
values (199, 147);
insert into INJECTED_BY (appointment_id, nurse_id)
values (200, 146);
commit;
prompt 200 records committed...
insert into INJECTED_BY (appointment_id, nurse_id)
values (201, 333);
insert into INJECTED_BY (appointment_id, nurse_id)
values (202, 396);
insert into INJECTED_BY (appointment_id, nurse_id)
values (203, 275);
insert into INJECTED_BY (appointment_id, nurse_id)
values (204, 318);
insert into INJECTED_BY (appointment_id, nurse_id)
values (205, 154);
insert into INJECTED_BY (appointment_id, nurse_id)
values (206, 127);
insert into INJECTED_BY (appointment_id, nurse_id)
values (207, 287);
insert into INJECTED_BY (appointment_id, nurse_id)
values (208, 403);
insert into INJECTED_BY (appointment_id, nurse_id)
values (209, 228);
insert into INJECTED_BY (appointment_id, nurse_id)
values (210, 156);
insert into INJECTED_BY (appointment_id, nurse_id)
values (211, 205);
insert into INJECTED_BY (appointment_id, nurse_id)
values (212, 277);
insert into INJECTED_BY (appointment_id, nurse_id)
values (213, 397);
insert into INJECTED_BY (appointment_id, nurse_id)
values (214, 185);
insert into INJECTED_BY (appointment_id, nurse_id)
values (215, 212);
insert into INJECTED_BY (appointment_id, nurse_id)
values (216, 359);
insert into INJECTED_BY (appointment_id, nurse_id)
values (217, 225);
insert into INJECTED_BY (appointment_id, nurse_id)
values (218, 327);
insert into INJECTED_BY (appointment_id, nurse_id)
values (219, 310);
insert into INJECTED_BY (appointment_id, nurse_id)
values (220, 255);
insert into INJECTED_BY (appointment_id, nurse_id)
values (221, 139);
insert into INJECTED_BY (appointment_id, nurse_id)
values (222, 295);
insert into INJECTED_BY (appointment_id, nurse_id)
values (223, 215);
insert into INJECTED_BY (appointment_id, nurse_id)
values (224, 278);
insert into INJECTED_BY (appointment_id, nurse_id)
values (226, 417);
insert into INJECTED_BY (appointment_id, nurse_id)
values (227, 249);
insert into INJECTED_BY (appointment_id, nurse_id)
values (228, 327);
insert into INJECTED_BY (appointment_id, nurse_id)
values (229, 293);
insert into INJECTED_BY (appointment_id, nurse_id)
values (230, 351);
insert into INJECTED_BY (appointment_id, nurse_id)
values (231, 274);
insert into INJECTED_BY (appointment_id, nurse_id)
values (232, 449);
insert into INJECTED_BY (appointment_id, nurse_id)
values (233, 431);
insert into INJECTED_BY (appointment_id, nurse_id)
values (234, 269);
insert into INJECTED_BY (appointment_id, nurse_id)
values (235, 402);
insert into INJECTED_BY (appointment_id, nurse_id)
values (236, 186);
insert into INJECTED_BY (appointment_id, nurse_id)
values (237, 149);
insert into INJECTED_BY (appointment_id, nurse_id)
values (238, 222);
insert into INJECTED_BY (appointment_id, nurse_id)
values (239, 342);
insert into INJECTED_BY (appointment_id, nurse_id)
values (240, 180);
insert into INJECTED_BY (appointment_id, nurse_id)
values (241, 103);
insert into INJECTED_BY (appointment_id, nurse_id)
values (242, 156);
insert into INJECTED_BY (appointment_id, nurse_id)
values (243, 252);
insert into INJECTED_BY (appointment_id, nurse_id)
values (244, 122);
insert into INJECTED_BY (appointment_id, nurse_id)
values (245, 158);
insert into INJECTED_BY (appointment_id, nurse_id)
values (246, 339);
insert into INJECTED_BY (appointment_id, nurse_id)
values (247, 132);
insert into INJECTED_BY (appointment_id, nurse_id)
values (248, 235);
insert into INJECTED_BY (appointment_id, nurse_id)
values (249, 334);
insert into INJECTED_BY (appointment_id, nurse_id)
values (250, 280);
insert into INJECTED_BY (appointment_id, nurse_id)
values (251, 100);
insert into INJECTED_BY (appointment_id, nurse_id)
values (252, 178);
insert into INJECTED_BY (appointment_id, nurse_id)
values (253, 174);
insert into INJECTED_BY (appointment_id, nurse_id)
values (254, 285);
insert into INJECTED_BY (appointment_id, nurse_id)
values (255, 153);
insert into INJECTED_BY (appointment_id, nurse_id)
values (256, 290);
insert into INJECTED_BY (appointment_id, nurse_id)
values (257, 256);
insert into INJECTED_BY (appointment_id, nurse_id)
values (258, 392);
insert into INJECTED_BY (appointment_id, nurse_id)
values (259, 192);
insert into INJECTED_BY (appointment_id, nurse_id)
values (260, 295);
insert into INJECTED_BY (appointment_id, nurse_id)
values (261, 182);
insert into INJECTED_BY (appointment_id, nurse_id)
values (262, 311);
insert into INJECTED_BY (appointment_id, nurse_id)
values (263, 136);
insert into INJECTED_BY (appointment_id, nurse_id)
values (264, 189);
insert into INJECTED_BY (appointment_id, nurse_id)
values (265, 113);
insert into INJECTED_BY (appointment_id, nurse_id)
values (266, 208);
insert into INJECTED_BY (appointment_id, nurse_id)
values (267, 376);
insert into INJECTED_BY (appointment_id, nurse_id)
values (268, 392);
insert into INJECTED_BY (appointment_id, nurse_id)
values (269, 339);
insert into INJECTED_BY (appointment_id, nurse_id)
values (270, 143);
insert into INJECTED_BY (appointment_id, nurse_id)
values (271, 112);
insert into INJECTED_BY (appointment_id, nurse_id)
values (272, 423);
insert into INJECTED_BY (appointment_id, nurse_id)
values (273, 176);
insert into INJECTED_BY (appointment_id, nurse_id)
values (274, 302);
insert into INJECTED_BY (appointment_id, nurse_id)
values (275, 320);
insert into INJECTED_BY (appointment_id, nurse_id)
values (276, 379);
insert into INJECTED_BY (appointment_id, nurse_id)
values (277, 334);
insert into INJECTED_BY (appointment_id, nurse_id)
values (278, 362);
insert into INJECTED_BY (appointment_id, nurse_id)
values (279, 288);
insert into INJECTED_BY (appointment_id, nurse_id)
values (280, 448);
insert into INJECTED_BY (appointment_id, nurse_id)
values (281, 379);
insert into INJECTED_BY (appointment_id, nurse_id)
values (282, 287);
insert into INJECTED_BY (appointment_id, nurse_id)
values (283, 270);
insert into INJECTED_BY (appointment_id, nurse_id)
values (284, 101);
insert into INJECTED_BY (appointment_id, nurse_id)
values (285, 184);
insert into INJECTED_BY (appointment_id, nurse_id)
values (286, 384);
insert into INJECTED_BY (appointment_id, nurse_id)
values (287, 412);
insert into INJECTED_BY (appointment_id, nurse_id)
values (288, 439);
insert into INJECTED_BY (appointment_id, nurse_id)
values (289, 329);
insert into INJECTED_BY (appointment_id, nurse_id)
values (290, 274);
insert into INJECTED_BY (appointment_id, nurse_id)
values (291, 257);
insert into INJECTED_BY (appointment_id, nurse_id)
values (292, 279);
insert into INJECTED_BY (appointment_id, nurse_id)
values (293, 335);
insert into INJECTED_BY (appointment_id, nurse_id)
values (294, 406);
insert into INJECTED_BY (appointment_id, nurse_id)
values (295, 396);
insert into INJECTED_BY (appointment_id, nurse_id)
values (296, 175);
insert into INJECTED_BY (appointment_id, nurse_id)
values (297, 392);
insert into INJECTED_BY (appointment_id, nurse_id)
values (298, 327);
insert into INJECTED_BY (appointment_id, nurse_id)
values (299, 201);
insert into INJECTED_BY (appointment_id, nurse_id)
values (300, 211);
insert into INJECTED_BY (appointment_id, nurse_id)
values (301, 394);
commit;
prompt 300 records committed...
insert into INJECTED_BY (appointment_id, nurse_id)
values (302, 309);
insert into INJECTED_BY (appointment_id, nurse_id)
values (303, 426);
insert into INJECTED_BY (appointment_id, nurse_id)
values (304, 314);
insert into INJECTED_BY (appointment_id, nurse_id)
values (305, 345);
insert into INJECTED_BY (appointment_id, nurse_id)
values (306, 388);
insert into INJECTED_BY (appointment_id, nurse_id)
values (307, 206);
insert into INJECTED_BY (appointment_id, nurse_id)
values (308, 339);
insert into INJECTED_BY (appointment_id, nurse_id)
values (309, 337);
insert into INJECTED_BY (appointment_id, nurse_id)
values (310, 420);
insert into INJECTED_BY (appointment_id, nurse_id)
values (311, 226);
insert into INJECTED_BY (appointment_id, nurse_id)
values (312, 438);
insert into INJECTED_BY (appointment_id, nurse_id)
values (313, 149);
insert into INJECTED_BY (appointment_id, nurse_id)
values (314, 302);
insert into INJECTED_BY (appointment_id, nurse_id)
values (315, 366);
insert into INJECTED_BY (appointment_id, nurse_id)
values (316, 169);
insert into INJECTED_BY (appointment_id, nurse_id)
values (317, 325);
insert into INJECTED_BY (appointment_id, nurse_id)
values (318, 279);
insert into INJECTED_BY (appointment_id, nurse_id)
values (319, 265);
insert into INJECTED_BY (appointment_id, nurse_id)
values (320, 203);
insert into INJECTED_BY (appointment_id, nurse_id)
values (321, 404);
insert into INJECTED_BY (appointment_id, nurse_id)
values (322, 309);
insert into INJECTED_BY (appointment_id, nurse_id)
values (323, 398);
insert into INJECTED_BY (appointment_id, nurse_id)
values (324, 353);
insert into INJECTED_BY (appointment_id, nurse_id)
values (325, 206);
insert into INJECTED_BY (appointment_id, nurse_id)
values (326, 331);
insert into INJECTED_BY (appointment_id, nurse_id)
values (327, 360);
insert into INJECTED_BY (appointment_id, nurse_id)
values (328, 409);
insert into INJECTED_BY (appointment_id, nurse_id)
values (329, 358);
insert into INJECTED_BY (appointment_id, nurse_id)
values (330, 242);
insert into INJECTED_BY (appointment_id, nurse_id)
values (331, 193);
insert into INJECTED_BY (appointment_id, nurse_id)
values (332, 133);
insert into INJECTED_BY (appointment_id, nurse_id)
values (333, 432);
insert into INJECTED_BY (appointment_id, nurse_id)
values (334, 203);
insert into INJECTED_BY (appointment_id, nurse_id)
values (335, 229);
insert into INJECTED_BY (appointment_id, nurse_id)
values (336, 157);
insert into INJECTED_BY (appointment_id, nurse_id)
values (337, 160);
insert into INJECTED_BY (appointment_id, nurse_id)
values (338, 233);
insert into INJECTED_BY (appointment_id, nurse_id)
values (339, 197);
insert into INJECTED_BY (appointment_id, nurse_id)
values (340, 334);
insert into INJECTED_BY (appointment_id, nurse_id)
values (341, 195);
insert into INJECTED_BY (appointment_id, nurse_id)
values (342, 263);
insert into INJECTED_BY (appointment_id, nurse_id)
values (343, 242);
insert into INJECTED_BY (appointment_id, nurse_id)
values (344, 243);
insert into INJECTED_BY (appointment_id, nurse_id)
values (345, 316);
insert into INJECTED_BY (appointment_id, nurse_id)
values (346, 128);
insert into INJECTED_BY (appointment_id, nurse_id)
values (347, 247);
insert into INJECTED_BY (appointment_id, nurse_id)
values (348, 336);
insert into INJECTED_BY (appointment_id, nurse_id)
values (349, 146);
insert into INJECTED_BY (appointment_id, nurse_id)
values (350, 126);
insert into INJECTED_BY (appointment_id, nurse_id)
values (351, 261);
insert into INJECTED_BY (appointment_id, nurse_id)
values (352, 186);
insert into INJECTED_BY (appointment_id, nurse_id)
values (353, 123);
insert into INJECTED_BY (appointment_id, nurse_id)
values (354, 419);
insert into INJECTED_BY (appointment_id, nurse_id)
values (355, 355);
insert into INJECTED_BY (appointment_id, nurse_id)
values (356, 227);
insert into INJECTED_BY (appointment_id, nurse_id)
values (357, 223);
insert into INJECTED_BY (appointment_id, nurse_id)
values (358, 422);
insert into INJECTED_BY (appointment_id, nurse_id)
values (359, 438);
insert into INJECTED_BY (appointment_id, nurse_id)
values (360, 439);
insert into INJECTED_BY (appointment_id, nurse_id)
values (361, 335);
insert into INJECTED_BY (appointment_id, nurse_id)
values (362, 124);
insert into INJECTED_BY (appointment_id, nurse_id)
values (363, 281);
insert into INJECTED_BY (appointment_id, nurse_id)
values (364, 101);
insert into INJECTED_BY (appointment_id, nurse_id)
values (365, 309);
insert into INJECTED_BY (appointment_id, nurse_id)
values (366, 123);
insert into INJECTED_BY (appointment_id, nurse_id)
values (367, 449);
insert into INJECTED_BY (appointment_id, nurse_id)
values (368, 329);
insert into INJECTED_BY (appointment_id, nurse_id)
values (369, 232);
insert into INJECTED_BY (appointment_id, nurse_id)
values (370, 387);
insert into INJECTED_BY (appointment_id, nurse_id)
values (371, 363);
insert into INJECTED_BY (appointment_id, nurse_id)
values (372, 328);
insert into INJECTED_BY (appointment_id, nurse_id)
values (373, 206);
insert into INJECTED_BY (appointment_id, nurse_id)
values (374, 287);
insert into INJECTED_BY (appointment_id, nurse_id)
values (375, 332);
insert into INJECTED_BY (appointment_id, nurse_id)
values (376, 149);
insert into INJECTED_BY (appointment_id, nurse_id)
values (377, 328);
insert into INJECTED_BY (appointment_id, nurse_id)
values (378, 125);
insert into INJECTED_BY (appointment_id, nurse_id)
values (379, 437);
insert into INJECTED_BY (appointment_id, nurse_id)
values (380, 362);
insert into INJECTED_BY (appointment_id, nurse_id)
values (381, 341);
insert into INJECTED_BY (appointment_id, nurse_id)
values (382, 191);
insert into INJECTED_BY (appointment_id, nurse_id)
values (383, 125);
insert into INJECTED_BY (appointment_id, nurse_id)
values (384, 363);
insert into INJECTED_BY (appointment_id, nurse_id)
values (385, 187);
insert into INJECTED_BY (appointment_id, nurse_id)
values (386, 202);
insert into INJECTED_BY (appointment_id, nurse_id)
values (387, 355);
insert into INJECTED_BY (appointment_id, nurse_id)
values (388, 294);
insert into INJECTED_BY (appointment_id, nurse_id)
values (389, 380);
insert into INJECTED_BY (appointment_id, nurse_id)
values (390, 253);
insert into INJECTED_BY (appointment_id, nurse_id)
values (391, 387);
insert into INJECTED_BY (appointment_id, nurse_id)
values (392, 408);
insert into INJECTED_BY (appointment_id, nurse_id)
values (393, 126);
insert into INJECTED_BY (appointment_id, nurse_id)
values (394, 344);
insert into INJECTED_BY (appointment_id, nurse_id)
values (395, 353);
insert into INJECTED_BY (appointment_id, nurse_id)
values (396, 221);
insert into INJECTED_BY (appointment_id, nurse_id)
values (397, 327);
insert into INJECTED_BY (appointment_id, nurse_id)
values (398, 135);
insert into INJECTED_BY (appointment_id, nurse_id)
values (399, 130);
insert into INJECTED_BY (appointment_id, nurse_id)
values (401, 103);
insert into INJECTED_BY (appointment_id, nurse_id)
values (402, 102);
commit;
prompt 400 records loaded
prompt Loading INJECTED_TO...
insert into INJECTED_TO (appointment_id, child_id)
values (1, 336);
insert into INJECTED_TO (appointment_id, child_id)
values (2, 113);
insert into INJECTED_TO (appointment_id, child_id)
values (3, 265);
insert into INJECTED_TO (appointment_id, child_id)
values (4, 303);
insert into INJECTED_TO (appointment_id, child_id)
values (5, 490);
insert into INJECTED_TO (appointment_id, child_id)
values (6, 342);
insert into INJECTED_TO (appointment_id, child_id)
values (7, 183);
insert into INJECTED_TO (appointment_id, child_id)
values (8, 345);
insert into INJECTED_TO (appointment_id, child_id)
values (9, 226);
insert into INJECTED_TO (appointment_id, child_id)
values (10, 178);
insert into INJECTED_TO (appointment_id, child_id)
values (11, 376);
insert into INJECTED_TO (appointment_id, child_id)
values (12, 107);
insert into INJECTED_TO (appointment_id, child_id)
values (13, 186);
insert into INJECTED_TO (appointment_id, child_id)
values (14, 400);
insert into INJECTED_TO (appointment_id, child_id)
values (15, 493);
insert into INJECTED_TO (appointment_id, child_id)
values (16, 163);
insert into INJECTED_TO (appointment_id, child_id)
values (17, 415);
insert into INJECTED_TO (appointment_id, child_id)
values (18, 175);
insert into INJECTED_TO (appointment_id, child_id)
values (19, 161);
insert into INJECTED_TO (appointment_id, child_id)
values (20, 292);
insert into INJECTED_TO (appointment_id, child_id)
values (21, 278);
insert into INJECTED_TO (appointment_id, child_id)
values (22, 205);
insert into INJECTED_TO (appointment_id, child_id)
values (23, 172);
insert into INJECTED_TO (appointment_id, child_id)
values (24, 356);
insert into INJECTED_TO (appointment_id, child_id)
values (25, 145);
insert into INJECTED_TO (appointment_id, child_id)
values (26, 326);
insert into INJECTED_TO (appointment_id, child_id)
values (27, 364);
insert into INJECTED_TO (appointment_id, child_id)
values (28, 317);
insert into INJECTED_TO (appointment_id, child_id)
values (29, 342);
insert into INJECTED_TO (appointment_id, child_id)
values (30, 246);
insert into INJECTED_TO (appointment_id, child_id)
values (31, 366);
insert into INJECTED_TO (appointment_id, child_id)
values (32, 104);
insert into INJECTED_TO (appointment_id, child_id)
values (33, 159);
insert into INJECTED_TO (appointment_id, child_id)
values (34, 170);
insert into INJECTED_TO (appointment_id, child_id)
values (35, 226);
insert into INJECTED_TO (appointment_id, child_id)
values (36, 150);
insert into INJECTED_TO (appointment_id, child_id)
values (37, 223);
insert into INJECTED_TO (appointment_id, child_id)
values (38, 203);
insert into INJECTED_TO (appointment_id, child_id)
values (39, 484);
insert into INJECTED_TO (appointment_id, child_id)
values (40, 321);
insert into INJECTED_TO (appointment_id, child_id)
values (41, 402);
insert into INJECTED_TO (appointment_id, child_id)
values (42, 286);
insert into INJECTED_TO (appointment_id, child_id)
values (43, 123);
insert into INJECTED_TO (appointment_id, child_id)
values (44, 251);
insert into INJECTED_TO (appointment_id, child_id)
values (45, 361);
insert into INJECTED_TO (appointment_id, child_id)
values (46, 132);
insert into INJECTED_TO (appointment_id, child_id)
values (47, 146);
insert into INJECTED_TO (appointment_id, child_id)
values (48, 204);
insert into INJECTED_TO (appointment_id, child_id)
values (49, 352);
insert into INJECTED_TO (appointment_id, child_id)
values (50, 347);
insert into INJECTED_TO (appointment_id, child_id)
values (51, 224);
insert into INJECTED_TO (appointment_id, child_id)
values (52, 483);
insert into INJECTED_TO (appointment_id, child_id)
values (53, 326);
insert into INJECTED_TO (appointment_id, child_id)
values (54, 381);
insert into INJECTED_TO (appointment_id, child_id)
values (55, 355);
insert into INJECTED_TO (appointment_id, child_id)
values (56, 303);
insert into INJECTED_TO (appointment_id, child_id)
values (57, 376);
insert into INJECTED_TO (appointment_id, child_id)
values (58, 298);
insert into INJECTED_TO (appointment_id, child_id)
values (59, 381);
insert into INJECTED_TO (appointment_id, child_id)
values (60, 344);
insert into INJECTED_TO (appointment_id, child_id)
values (61, 390);
insert into INJECTED_TO (appointment_id, child_id)
values (62, 229);
insert into INJECTED_TO (appointment_id, child_id)
values (63, 302);
insert into INJECTED_TO (appointment_id, child_id)
values (64, 115);
insert into INJECTED_TO (appointment_id, child_id)
values (65, 113);
insert into INJECTED_TO (appointment_id, child_id)
values (66, 259);
insert into INJECTED_TO (appointment_id, child_id)
values (67, 441);
insert into INJECTED_TO (appointment_id, child_id)
values (68, 126);
insert into INJECTED_TO (appointment_id, child_id)
values (69, 120);
insert into INJECTED_TO (appointment_id, child_id)
values (70, 453);
insert into INJECTED_TO (appointment_id, child_id)
values (71, 186);
insert into INJECTED_TO (appointment_id, child_id)
values (72, 209);
insert into INJECTED_TO (appointment_id, child_id)
values (73, 276);
insert into INJECTED_TO (appointment_id, child_id)
values (74, 349);
insert into INJECTED_TO (appointment_id, child_id)
values (75, 180);
insert into INJECTED_TO (appointment_id, child_id)
values (76, 197);
insert into INJECTED_TO (appointment_id, child_id)
values (77, 395);
insert into INJECTED_TO (appointment_id, child_id)
values (78, 217);
insert into INJECTED_TO (appointment_id, child_id)
values (79, 465);
insert into INJECTED_TO (appointment_id, child_id)
values (80, 470);
insert into INJECTED_TO (appointment_id, child_id)
values (81, 283);
insert into INJECTED_TO (appointment_id, child_id)
values (82, 441);
insert into INJECTED_TO (appointment_id, child_id)
values (83, 466);
insert into INJECTED_TO (appointment_id, child_id)
values (84, 412);
insert into INJECTED_TO (appointment_id, child_id)
values (85, 450);
insert into INJECTED_TO (appointment_id, child_id)
values (86, 287);
insert into INJECTED_TO (appointment_id, child_id)
values (87, 326);
insert into INJECTED_TO (appointment_id, child_id)
values (88, 469);
insert into INJECTED_TO (appointment_id, child_id)
values (89, 113);
insert into INJECTED_TO (appointment_id, child_id)
values (90, 239);
insert into INJECTED_TO (appointment_id, child_id)
values (91, 448);
insert into INJECTED_TO (appointment_id, child_id)
values (92, 447);
insert into INJECTED_TO (appointment_id, child_id)
values (93, 343);
insert into INJECTED_TO (appointment_id, child_id)
values (94, 167);
insert into INJECTED_TO (appointment_id, child_id)
values (95, 192);
insert into INJECTED_TO (appointment_id, child_id)
values (96, 361);
insert into INJECTED_TO (appointment_id, child_id)
values (97, 388);
insert into INJECTED_TO (appointment_id, child_id)
values (98, 481);
insert into INJECTED_TO (appointment_id, child_id)
values (99, 363);
insert into INJECTED_TO (appointment_id, child_id)
values (100, 255);
commit;
prompt 100 records committed...
insert into INJECTED_TO (appointment_id, child_id)
values (101, 446);
insert into INJECTED_TO (appointment_id, child_id)
values (102, 371);
insert into INJECTED_TO (appointment_id, child_id)
values (103, 239);
insert into INJECTED_TO (appointment_id, child_id)
values (104, 306);
insert into INJECTED_TO (appointment_id, child_id)
values (105, 277);
insert into INJECTED_TO (appointment_id, child_id)
values (106, 465);
insert into INJECTED_TO (appointment_id, child_id)
values (107, 378);
insert into INJECTED_TO (appointment_id, child_id)
values (108, 250);
insert into INJECTED_TO (appointment_id, child_id)
values (109, 368);
insert into INJECTED_TO (appointment_id, child_id)
values (110, 206);
insert into INJECTED_TO (appointment_id, child_id)
values (111, 150);
insert into INJECTED_TO (appointment_id, child_id)
values (112, 414);
insert into INJECTED_TO (appointment_id, child_id)
values (113, 425);
insert into INJECTED_TO (appointment_id, child_id)
values (114, 299);
insert into INJECTED_TO (appointment_id, child_id)
values (115, 246);
insert into INJECTED_TO (appointment_id, child_id)
values (116, 417);
insert into INJECTED_TO (appointment_id, child_id)
values (117, 495);
insert into INJECTED_TO (appointment_id, child_id)
values (118, 293);
insert into INJECTED_TO (appointment_id, child_id)
values (119, 487);
insert into INJECTED_TO (appointment_id, child_id)
values (120, 416);
insert into INJECTED_TO (appointment_id, child_id)
values (121, 112);
insert into INJECTED_TO (appointment_id, child_id)
values (122, 286);
insert into INJECTED_TO (appointment_id, child_id)
values (123, 199);
insert into INJECTED_TO (appointment_id, child_id)
values (124, 347);
insert into INJECTED_TO (appointment_id, child_id)
values (125, 158);
insert into INJECTED_TO (appointment_id, child_id)
values (126, 202);
insert into INJECTED_TO (appointment_id, child_id)
values (127, 488);
insert into INJECTED_TO (appointment_id, child_id)
values (128, 262);
insert into INJECTED_TO (appointment_id, child_id)
values (129, 230);
insert into INJECTED_TO (appointment_id, child_id)
values (130, 219);
insert into INJECTED_TO (appointment_id, child_id)
values (131, 254);
insert into INJECTED_TO (appointment_id, child_id)
values (132, 191);
insert into INJECTED_TO (appointment_id, child_id)
values (133, 423);
insert into INJECTED_TO (appointment_id, child_id)
values (134, 417);
insert into INJECTED_TO (appointment_id, child_id)
values (135, 298);
insert into INJECTED_TO (appointment_id, child_id)
values (136, 440);
insert into INJECTED_TO (appointment_id, child_id)
values (137, 491);
insert into INJECTED_TO (appointment_id, child_id)
values (138, 210);
insert into INJECTED_TO (appointment_id, child_id)
values (139, 355);
insert into INJECTED_TO (appointment_id, child_id)
values (140, 147);
insert into INJECTED_TO (appointment_id, child_id)
values (141, 316);
insert into INJECTED_TO (appointment_id, child_id)
values (142, 230);
insert into INJECTED_TO (appointment_id, child_id)
values (143, 410);
insert into INJECTED_TO (appointment_id, child_id)
values (144, 422);
insert into INJECTED_TO (appointment_id, child_id)
values (145, 455);
insert into INJECTED_TO (appointment_id, child_id)
values (146, 244);
insert into INJECTED_TO (appointment_id, child_id)
values (147, 128);
insert into INJECTED_TO (appointment_id, child_id)
values (148, 469);
insert into INJECTED_TO (appointment_id, child_id)
values (149, 462);
insert into INJECTED_TO (appointment_id, child_id)
values (150, 353);
insert into INJECTED_TO (appointment_id, child_id)
values (151, 346);
insert into INJECTED_TO (appointment_id, child_id)
values (152, 437);
insert into INJECTED_TO (appointment_id, child_id)
values (153, 389);
insert into INJECTED_TO (appointment_id, child_id)
values (154, 457);
insert into INJECTED_TO (appointment_id, child_id)
values (155, 275);
insert into INJECTED_TO (appointment_id, child_id)
values (156, 397);
insert into INJECTED_TO (appointment_id, child_id)
values (157, 149);
insert into INJECTED_TO (appointment_id, child_id)
values (158, 255);
insert into INJECTED_TO (appointment_id, child_id)
values (159, 152);
insert into INJECTED_TO (appointment_id, child_id)
values (160, 168);
insert into INJECTED_TO (appointment_id, child_id)
values (161, 343);
insert into INJECTED_TO (appointment_id, child_id)
values (162, 135);
insert into INJECTED_TO (appointment_id, child_id)
values (163, 382);
insert into INJECTED_TO (appointment_id, child_id)
values (164, 420);
insert into INJECTED_TO (appointment_id, child_id)
values (165, 230);
insert into INJECTED_TO (appointment_id, child_id)
values (166, 235);
insert into INJECTED_TO (appointment_id, child_id)
values (167, 324);
insert into INJECTED_TO (appointment_id, child_id)
values (168, 367);
insert into INJECTED_TO (appointment_id, child_id)
values (169, 259);
insert into INJECTED_TO (appointment_id, child_id)
values (170, 244);
insert into INJECTED_TO (appointment_id, child_id)
values (171, 354);
insert into INJECTED_TO (appointment_id, child_id)
values (172, 258);
insert into INJECTED_TO (appointment_id, child_id)
values (173, 232);
insert into INJECTED_TO (appointment_id, child_id)
values (174, 202);
insert into INJECTED_TO (appointment_id, child_id)
values (175, 157);
insert into INJECTED_TO (appointment_id, child_id)
values (176, 208);
insert into INJECTED_TO (appointment_id, child_id)
values (177, 302);
insert into INJECTED_TO (appointment_id, child_id)
values (178, 280);
insert into INJECTED_TO (appointment_id, child_id)
values (179, 282);
insert into INJECTED_TO (appointment_id, child_id)
values (180, 168);
insert into INJECTED_TO (appointment_id, child_id)
values (181, 106);
insert into INJECTED_TO (appointment_id, child_id)
values (182, 397);
insert into INJECTED_TO (appointment_id, child_id)
values (183, 118);
insert into INJECTED_TO (appointment_id, child_id)
values (184, 356);
insert into INJECTED_TO (appointment_id, child_id)
values (185, 211);
insert into INJECTED_TO (appointment_id, child_id)
values (186, 251);
insert into INJECTED_TO (appointment_id, child_id)
values (187, 323);
insert into INJECTED_TO (appointment_id, child_id)
values (188, 381);
insert into INJECTED_TO (appointment_id, child_id)
values (189, 188);
insert into INJECTED_TO (appointment_id, child_id)
values (190, 431);
insert into INJECTED_TO (appointment_id, child_id)
values (191, 249);
insert into INJECTED_TO (appointment_id, child_id)
values (192, 160);
insert into INJECTED_TO (appointment_id, child_id)
values (193, 484);
insert into INJECTED_TO (appointment_id, child_id)
values (194, 175);
insert into INJECTED_TO (appointment_id, child_id)
values (195, 219);
insert into INJECTED_TO (appointment_id, child_id)
values (196, 260);
insert into INJECTED_TO (appointment_id, child_id)
values (197, 201);
insert into INJECTED_TO (appointment_id, child_id)
values (198, 247);
insert into INJECTED_TO (appointment_id, child_id)
values (199, 185);
insert into INJECTED_TO (appointment_id, child_id)
values (200, 178);
commit;
prompt 200 records committed...
insert into INJECTED_TO (appointment_id, child_id)
values (201, 180);
insert into INJECTED_TO (appointment_id, child_id)
values (202, 306);
insert into INJECTED_TO (appointment_id, child_id)
values (203, 426);
insert into INJECTED_TO (appointment_id, child_id)
values (204, 382);
insert into INJECTED_TO (appointment_id, child_id)
values (205, 464);
insert into INJECTED_TO (appointment_id, child_id)
values (206, 215);
insert into INJECTED_TO (appointment_id, child_id)
values (207, 410);
insert into INJECTED_TO (appointment_id, child_id)
values (208, 422);
insert into INJECTED_TO (appointment_id, child_id)
values (209, 154);
insert into INJECTED_TO (appointment_id, child_id)
values (210, 492);
insert into INJECTED_TO (appointment_id, child_id)
values (211, 484);
insert into INJECTED_TO (appointment_id, child_id)
values (212, 347);
insert into INJECTED_TO (appointment_id, child_id)
values (213, 140);
insert into INJECTED_TO (appointment_id, child_id)
values (214, 341);
insert into INJECTED_TO (appointment_id, child_id)
values (215, 325);
insert into INJECTED_TO (appointment_id, child_id)
values (216, 328);
insert into INJECTED_TO (appointment_id, child_id)
values (217, 106);
insert into INJECTED_TO (appointment_id, child_id)
values (218, 250);
insert into INJECTED_TO (appointment_id, child_id)
values (219, 196);
insert into INJECTED_TO (appointment_id, child_id)
values (220, 315);
insert into INJECTED_TO (appointment_id, child_id)
values (221, 102);
insert into INJECTED_TO (appointment_id, child_id)
values (222, 213);
insert into INJECTED_TO (appointment_id, child_id)
values (223, 352);
insert into INJECTED_TO (appointment_id, child_id)
values (224, 452);
insert into INJECTED_TO (appointment_id, child_id)
values (226, 363);
insert into INJECTED_TO (appointment_id, child_id)
values (227, 445);
insert into INJECTED_TO (appointment_id, child_id)
values (228, 258);
insert into INJECTED_TO (appointment_id, child_id)
values (229, 428);
insert into INJECTED_TO (appointment_id, child_id)
values (230, 460);
insert into INJECTED_TO (appointment_id, child_id)
values (231, 457);
insert into INJECTED_TO (appointment_id, child_id)
values (232, 294);
insert into INJECTED_TO (appointment_id, child_id)
values (233, 108);
insert into INJECTED_TO (appointment_id, child_id)
values (234, 418);
insert into INJECTED_TO (appointment_id, child_id)
values (235, 427);
insert into INJECTED_TO (appointment_id, child_id)
values (236, 149);
insert into INJECTED_TO (appointment_id, child_id)
values (237, 117);
insert into INJECTED_TO (appointment_id, child_id)
values (238, 145);
insert into INJECTED_TO (appointment_id, child_id)
values (239, 295);
insert into INJECTED_TO (appointment_id, child_id)
values (240, 241);
insert into INJECTED_TO (appointment_id, child_id)
values (241, 453);
insert into INJECTED_TO (appointment_id, child_id)
values (242, 247);
insert into INJECTED_TO (appointment_id, child_id)
values (243, 117);
insert into INJECTED_TO (appointment_id, child_id)
values (244, 271);
insert into INJECTED_TO (appointment_id, child_id)
values (245, 234);
insert into INJECTED_TO (appointment_id, child_id)
values (246, 481);
insert into INJECTED_TO (appointment_id, child_id)
values (247, 193);
insert into INJECTED_TO (appointment_id, child_id)
values (248, 438);
insert into INJECTED_TO (appointment_id, child_id)
values (249, 257);
insert into INJECTED_TO (appointment_id, child_id)
values (250, 113);
insert into INJECTED_TO (appointment_id, child_id)
values (251, 353);
insert into INJECTED_TO (appointment_id, child_id)
values (252, 444);
insert into INJECTED_TO (appointment_id, child_id)
values (253, 473);
insert into INJECTED_TO (appointment_id, child_id)
values (254, 467);
insert into INJECTED_TO (appointment_id, child_id)
values (255, 140);
insert into INJECTED_TO (appointment_id, child_id)
values (256, 188);
insert into INJECTED_TO (appointment_id, child_id)
values (257, 370);
insert into INJECTED_TO (appointment_id, child_id)
values (258, 409);
insert into INJECTED_TO (appointment_id, child_id)
values (259, 145);
insert into INJECTED_TO (appointment_id, child_id)
values (260, 193);
insert into INJECTED_TO (appointment_id, child_id)
values (261, 358);
insert into INJECTED_TO (appointment_id, child_id)
values (262, 458);
insert into INJECTED_TO (appointment_id, child_id)
values (263, 418);
insert into INJECTED_TO (appointment_id, child_id)
values (264, 267);
insert into INJECTED_TO (appointment_id, child_id)
values (265, 353);
insert into INJECTED_TO (appointment_id, child_id)
values (266, 482);
insert into INJECTED_TO (appointment_id, child_id)
values (267, 419);
insert into INJECTED_TO (appointment_id, child_id)
values (268, 223);
insert into INJECTED_TO (appointment_id, child_id)
values (269, 254);
insert into INJECTED_TO (appointment_id, child_id)
values (270, 448);
insert into INJECTED_TO (appointment_id, child_id)
values (271, 245);
insert into INJECTED_TO (appointment_id, child_id)
values (272, 175);
insert into INJECTED_TO (appointment_id, child_id)
values (273, 300);
insert into INJECTED_TO (appointment_id, child_id)
values (274, 193);
insert into INJECTED_TO (appointment_id, child_id)
values (275, 171);
insert into INJECTED_TO (appointment_id, child_id)
values (276, 433);
insert into INJECTED_TO (appointment_id, child_id)
values (277, 212);
insert into INJECTED_TO (appointment_id, child_id)
values (278, 292);
insert into INJECTED_TO (appointment_id, child_id)
values (279, 457);
insert into INJECTED_TO (appointment_id, child_id)
values (280, 306);
insert into INJECTED_TO (appointment_id, child_id)
values (281, 100);
insert into INJECTED_TO (appointment_id, child_id)
values (282, 186);
insert into INJECTED_TO (appointment_id, child_id)
values (283, 259);
insert into INJECTED_TO (appointment_id, child_id)
values (284, 448);
insert into INJECTED_TO (appointment_id, child_id)
values (285, 241);
insert into INJECTED_TO (appointment_id, child_id)
values (286, 241);
insert into INJECTED_TO (appointment_id, child_id)
values (287, 199);
insert into INJECTED_TO (appointment_id, child_id)
values (288, 243);
insert into INJECTED_TO (appointment_id, child_id)
values (289, 114);
insert into INJECTED_TO (appointment_id, child_id)
values (290, 499);
insert into INJECTED_TO (appointment_id, child_id)
values (291, 413);
insert into INJECTED_TO (appointment_id, child_id)
values (292, 276);
insert into INJECTED_TO (appointment_id, child_id)
values (293, 394);
insert into INJECTED_TO (appointment_id, child_id)
values (294, 209);
insert into INJECTED_TO (appointment_id, child_id)
values (295, 456);
insert into INJECTED_TO (appointment_id, child_id)
values (296, 380);
insert into INJECTED_TO (appointment_id, child_id)
values (297, 482);
insert into INJECTED_TO (appointment_id, child_id)
values (298, 282);
insert into INJECTED_TO (appointment_id, child_id)
values (299, 271);
insert into INJECTED_TO (appointment_id, child_id)
values (300, 296);
insert into INJECTED_TO (appointment_id, child_id)
values (301, 290);
commit;
prompt 300 records committed...
insert into INJECTED_TO (appointment_id, child_id)
values (302, 161);
insert into INJECTED_TO (appointment_id, child_id)
values (303, 397);
insert into INJECTED_TO (appointment_id, child_id)
values (304, 466);
insert into INJECTED_TO (appointment_id, child_id)
values (305, 250);
insert into INJECTED_TO (appointment_id, child_id)
values (306, 257);
insert into INJECTED_TO (appointment_id, child_id)
values (307, 440);
insert into INJECTED_TO (appointment_id, child_id)
values (308, 161);
insert into INJECTED_TO (appointment_id, child_id)
values (309, 458);
insert into INJECTED_TO (appointment_id, child_id)
values (310, 432);
insert into INJECTED_TO (appointment_id, child_id)
values (311, 155);
insert into INJECTED_TO (appointment_id, child_id)
values (312, 280);
insert into INJECTED_TO (appointment_id, child_id)
values (313, 333);
insert into INJECTED_TO (appointment_id, child_id)
values (314, 292);
insert into INJECTED_TO (appointment_id, child_id)
values (315, 388);
insert into INJECTED_TO (appointment_id, child_id)
values (316, 235);
insert into INJECTED_TO (appointment_id, child_id)
values (317, 301);
insert into INJECTED_TO (appointment_id, child_id)
values (318, 362);
insert into INJECTED_TO (appointment_id, child_id)
values (319, 419);
insert into INJECTED_TO (appointment_id, child_id)
values (320, 425);
insert into INJECTED_TO (appointment_id, child_id)
values (321, 286);
insert into INJECTED_TO (appointment_id, child_id)
values (322, 104);
insert into INJECTED_TO (appointment_id, child_id)
values (323, 347);
insert into INJECTED_TO (appointment_id, child_id)
values (324, 350);
insert into INJECTED_TO (appointment_id, child_id)
values (325, 295);
insert into INJECTED_TO (appointment_id, child_id)
values (326, 461);
insert into INJECTED_TO (appointment_id, child_id)
values (327, 463);
insert into INJECTED_TO (appointment_id, child_id)
values (328, 447);
insert into INJECTED_TO (appointment_id, child_id)
values (329, 117);
insert into INJECTED_TO (appointment_id, child_id)
values (330, 283);
insert into INJECTED_TO (appointment_id, child_id)
values (331, 457);
insert into INJECTED_TO (appointment_id, child_id)
values (332, 294);
insert into INJECTED_TO (appointment_id, child_id)
values (333, 400);
insert into INJECTED_TO (appointment_id, child_id)
values (334, 105);
insert into INJECTED_TO (appointment_id, child_id)
values (335, 197);
insert into INJECTED_TO (appointment_id, child_id)
values (336, 286);
insert into INJECTED_TO (appointment_id, child_id)
values (337, 316);
insert into INJECTED_TO (appointment_id, child_id)
values (338, 452);
insert into INJECTED_TO (appointment_id, child_id)
values (339, 327);
insert into INJECTED_TO (appointment_id, child_id)
values (340, 412);
insert into INJECTED_TO (appointment_id, child_id)
values (341, 307);
insert into INJECTED_TO (appointment_id, child_id)
values (342, 342);
insert into INJECTED_TO (appointment_id, child_id)
values (343, 234);
insert into INJECTED_TO (appointment_id, child_id)
values (344, 241);
insert into INJECTED_TO (appointment_id, child_id)
values (345, 104);
insert into INJECTED_TO (appointment_id, child_id)
values (346, 138);
insert into INJECTED_TO (appointment_id, child_id)
values (347, 215);
insert into INJECTED_TO (appointment_id, child_id)
values (348, 345);
insert into INJECTED_TO (appointment_id, child_id)
values (349, 306);
insert into INJECTED_TO (appointment_id, child_id)
values (350, 240);
insert into INJECTED_TO (appointment_id, child_id)
values (351, 397);
insert into INJECTED_TO (appointment_id, child_id)
values (352, 271);
insert into INJECTED_TO (appointment_id, child_id)
values (353, 325);
insert into INJECTED_TO (appointment_id, child_id)
values (354, 374);
insert into INJECTED_TO (appointment_id, child_id)
values (355, 250);
insert into INJECTED_TO (appointment_id, child_id)
values (356, 288);
insert into INJECTED_TO (appointment_id, child_id)
values (357, 379);
insert into INJECTED_TO (appointment_id, child_id)
values (358, 345);
insert into INJECTED_TO (appointment_id, child_id)
values (359, 239);
insert into INJECTED_TO (appointment_id, child_id)
values (360, 216);
insert into INJECTED_TO (appointment_id, child_id)
values (361, 140);
insert into INJECTED_TO (appointment_id, child_id)
values (362, 431);
insert into INJECTED_TO (appointment_id, child_id)
values (363, 460);
insert into INJECTED_TO (appointment_id, child_id)
values (364, 372);
insert into INJECTED_TO (appointment_id, child_id)
values (365, 314);
insert into INJECTED_TO (appointment_id, child_id)
values (366, 478);
insert into INJECTED_TO (appointment_id, child_id)
values (367, 393);
insert into INJECTED_TO (appointment_id, child_id)
values (368, 138);
insert into INJECTED_TO (appointment_id, child_id)
values (369, 365);
insert into INJECTED_TO (appointment_id, child_id)
values (370, 469);
insert into INJECTED_TO (appointment_id, child_id)
values (371, 438);
insert into INJECTED_TO (appointment_id, child_id)
values (372, 174);
insert into INJECTED_TO (appointment_id, child_id)
values (373, 455);
insert into INJECTED_TO (appointment_id, child_id)
values (374, 241);
insert into INJECTED_TO (appointment_id, child_id)
values (375, 346);
insert into INJECTED_TO (appointment_id, child_id)
values (376, 399);
insert into INJECTED_TO (appointment_id, child_id)
values (377, 223);
insert into INJECTED_TO (appointment_id, child_id)
values (378, 108);
insert into INJECTED_TO (appointment_id, child_id)
values (379, 227);
insert into INJECTED_TO (appointment_id, child_id)
values (380, 350);
insert into INJECTED_TO (appointment_id, child_id)
values (381, 264);
insert into INJECTED_TO (appointment_id, child_id)
values (382, 266);
insert into INJECTED_TO (appointment_id, child_id)
values (383, 239);
insert into INJECTED_TO (appointment_id, child_id)
values (384, 251);
insert into INJECTED_TO (appointment_id, child_id)
values (385, 327);
insert into INJECTED_TO (appointment_id, child_id)
values (386, 142);
insert into INJECTED_TO (appointment_id, child_id)
values (387, 435);
insert into INJECTED_TO (appointment_id, child_id)
values (388, 393);
insert into INJECTED_TO (appointment_id, child_id)
values (389, 316);
insert into INJECTED_TO (appointment_id, child_id)
values (390, 172);
insert into INJECTED_TO (appointment_id, child_id)
values (391, 290);
insert into INJECTED_TO (appointment_id, child_id)
values (392, 162);
insert into INJECTED_TO (appointment_id, child_id)
values (393, 283);
insert into INJECTED_TO (appointment_id, child_id)
values (394, 154);
insert into INJECTED_TO (appointment_id, child_id)
values (395, 366);
insert into INJECTED_TO (appointment_id, child_id)
values (396, 118);
insert into INJECTED_TO (appointment_id, child_id)
values (397, 119);
insert into INJECTED_TO (appointment_id, child_id)
values (398, 462);
insert into INJECTED_TO (appointment_id, child_id)
values (399, 245);
insert into INJECTED_TO (appointment_id, child_id)
values (400, 258);
insert into INJECTED_TO (appointment_id, child_id)
values (401, 102);
commit;
prompt 400 records committed...
insert into INJECTED_TO (appointment_id, child_id)
values (402, 108);
commit;
prompt 401 records loaded
prompt Loading INJECTION...
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (900, 'Tom', 'Car', 4, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (901, 'Ram', 'Whi', 10, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (902, 'Rob', 'Dou', 8, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (903, 'Von', 'Ros', 4, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (904, 'Dia', 'Sil', 4, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (1, 'Tem', 'Tem', 5.5, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (2, 'Sun', 'dex', .38, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (3, 'Zyv', 'lin', 4.61, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (4, 'sil', 'sil', 1.82, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (5, 'Due', '.BE', 5.47, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (6, 'Eaz', 'Aco', 2.51, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (7, 'HYD', 'HYD', .83, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (8, 'Ola', 'Ola', .47, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (9, 'OXY', 'OXY', .57, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (10, 'hea', 'phe', 4.05, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (11, 'Rim', 'OCT', 2.14, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (12, 'Sug', 'Sug', 5.15, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (13, 'Ins', 'Ins', 5.24, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (14, 'Bio', 'not', 4.46, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (15, 'Pre', 'Bac', 4.32, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (16, 'Tri', 'fen', 4.47, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (17, 'All', 'Ace', 4.3, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (18, 'Wee', 'All', .84, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (19, 'Cef', 'cef', 2.1, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (20, 'Asp', 'Asp', 4.31, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (21, 'Tol', 'tol', 4.72, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (22, 'Hyd', 'Hyd', 5.11, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (23, 'Eps', 'Mag', 4.7, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (24, 'Mou', 'Mou', .2, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (25, 'Lev', 'Lev', .18, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (26, 'Pol', 'Tre', .4, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (27, 'But', 'But', .76, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (28, 'Bla', 'Bla', 3.46, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (29, 'Flu', 'flu', 6.45, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (30, 'Gav', 'alu', 6.98, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (31, 'Pep', 'fam', 3.08, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (32, 'HYD', 'HYD', 3.87, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (33, 'Sor', 'Phe', 4.57, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (34, 'Cyc', 'Cyc', 2, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (35, 'ATO', 'MEN', 2.81, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (36, 'CER', 'Hum', 3.72, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (37, 'Don', 'Don', 5.86, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (38, 'CLE', 'Oct', .1, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (39, 'Dr ', 'Mus', 6.85, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (40, 'asp', 'Asp', 6.34, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (41, 'Ter', 'Ter', 3.93, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (42, 'SHO', 'OXY', 5.39, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (43, 'LBE', 'Oct', 2.73, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (44, 'Han', 'ALC', 3.17, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (45, 'car', 'Ace', 2.88, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (46, 'Alo', 'ALC', .29, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (47, 'Col', 'Sod', 6.35, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (48, 'Spi', 'Spi', 3.56, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (49, 'Ben', 'ery', 6.27, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (50, 'Sma', 'Ace', 3.2, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (51, 'Lis', 'lis', 6.86, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (52, 'Top', 'Tol', .88, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (53, 'Car', 'ALC', 3.95, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (54, 'Dio', 'OCT', 4.32, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (55, 'Elt', 'zin', 2.16, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (56, 'hem', 'coc', 6.35, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (57, 'Dil', 'Dil', 1.2, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (58, 'Ple', 'myc', 5.92, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (59, 'Lea', 'Cal', 2.39, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (60, 'ck ', 'Tit', 6.81, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (61, 'Hou', 'Hou', 3.6, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (62, 'SoC', 'Met', 1.04, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (63, 'PRO', 'Cod', 5, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (64, 'Met', 'met', 6.13, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (65, 'Fam', 'Fam', 4.32, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (66, 'Hev', 'ANA', 5.59, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (67, 'Nab', 'Nab', 3.2, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (68, 'QVA', 'bec', 6.27, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (69, 'Dox', 'dox', 5.05, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (70, 'Fen', 'fen', 5.66, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (71, 'AMO', 'OCT', 1.81, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (72, 'Van', 'ALC', 3.25, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (73, 'TRU', 'OCT', 1.33, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (74, 'Tar', 'Euc', 1.24, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (75, 'Ber', 'Ber', 5.59, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (76, 'ENA', 'ENA', 1.05, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (77, 'Sea', 'Oct', 6.29, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (78, 'Mix', 'Mix', 3.05, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (79, 'ABI', 'ABI', 4.41, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (80, 'pai', 'Ace', 5.47, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (81, 'Tac', 'cal', 3.31, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (82, 'MET', 'MET', .92, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (83, 'Ena', 'Ena', .9, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (84, 'HCG', 'Hum', 2.59, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (85, 'Pen', 'Pen', 3.84, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (86, 'LIS', 'LIS', 3.09, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (87, 'Bet', 'Bet', 4.85, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (88, 'Ate', 'ate', 3.44, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (89, 'Jan', 'War', 4.87, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (90, 'FLU', 'FLU', 3.55, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (91, 'PRO', 'ZIN', 3.58, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (92, 'PEG', 'Pol', 2.41, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (93, 'Alt', 'Dex', 5.5, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (94, 'car', 'car', 2.13, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (95, 'Pan', 'Pan', 5.61, 4);
commit;
prompt 100 records committed...
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (96, 'Cri', 'pro', 4.86, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (97, 'Nap', 'Nap', .06, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (98, 'DIP', 'DIP', 6.1, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (99, 'Ast', 'Ars', 4.24, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (100, 'Goo', 'Caf', 4.99, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (101, 'Sho', 'Bac', 2.18, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (102, 'PNV', '.Al', 1.99, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (103, 'Ram', 'Ram', 1.41, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (104, 'Met', 'Met', 1.25, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (105, 'Fam', 'Fam', 4.68, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (106, 'DES', 'DES', 4.43, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (107, 'DOX', 'dox', 6.34, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (108, 'Col', 'Ace', 3.52, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (109, 'Tri', 'Fol', 3.4, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (110, 'OXY', 'OXY', 2.09, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (111, 'TC ', 'Tri', 6.35, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (112, 'Gly', 'Gly', 5.97, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (113, 'Sof', 'lip', 5.9, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (114, 'Alc', 'ALC', 6.79, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (115, 'Ven', 'Ven', 3.7, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (116, 'Sul', 'Sul', 2.15, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (117, 'Tre', 'tre', 2.34, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (118, 'Sen', 'SEN', 4.79, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (119, 'Rit', 'ZIN', 3.74, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (120, 'POL', 'pol', 2.2, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (121, 'Nam', 'mem', 2.85, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (122, 'Deg', 'Alu', 6.54, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (123, 'Sug', 'Sug', 6.28, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (124, 'Cal', 'Cal', 1.17, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (125, 'Dr ', 'Che', 6.93, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (126, 'SSD', 'Sil', 4.28, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (127, 'hea', 'Alu', 4.18, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (128, 'ANT', 'TRI', 5.24, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (129, 'Opi', 'Mor', 2.38, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (130, 'cep', 'cep', .44, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (131, 'sal', 'Sal', 3.35, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (132, 'ck ', 'Tit', 2.19, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (133, 'Cle', 'Cle', 1.38, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (134, 'Met', 'met', 5.29, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (135, 'Tam', 'Tam', 1.98, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (136, 'For', 'Ter', 1.04, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (137, 'Ins', 'Eth', 1.04, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (138, 'DEX', 'dex', 1.76, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (139, 'Flu', 'Inf', 1.68, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (140, 'Kro', 'OCT', 6.05, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (141, 'Ban', 'Dip', 2.42, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (142, 'Bro', 'Gua', 1.53, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (143, 'Eno', 'Eno', 5.84, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (144, 'Aci', 'Ran', .72, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (145, 'bar', 'Tit', 3.8, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (146, 'TOP', 'PYR', 1.52, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (147, 'Wes', 'AVO', 1.06, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (148, 'pol', 'Bac', 3, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (149, 'Gli', 'Gli', 1.91, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (150, 'SHO', 'BAC', 1.07, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (151, 'wal', 'Ket', 3.13, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (152, 'OCE', 'dro', 3.99, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (153, 'CAR', 'CAR', 5.05, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (154, 'BSS', 'bal', 4.02, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (155, 'Lea', 'DOC', 3.58, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (156, 'MOI', 'BEN', 3.74, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (157, 'Mel', 'Mel', 4.59, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (158, 'BAB', 'Pan', 3.5, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (159, 'Pil', 'Pil', 2.87, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (160, 'Fen', 'Fen', 3.82, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (161, 'Ola', 'Ola', 2.5, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (162, 'Don', 'Don', 6.45, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (163, 'May', 'Tit', .17, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (164, 'KET', 'KET', 6.55, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (165, 'Tac', 'tac', 1.9, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (166, 'CON', 'OCT', 1.1, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (167, 'IXI', 'Jap', 3.5, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (168, 'Ant', 'ANT', 6.03, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (169, 'Pin', 'BEN', 6.41, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (170, 'PUR', 'Pan', 3.7, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (171, 'Luc', 'Sod', 6.89, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (172, 'Aml', 'Aml', 6.87, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (173, 'Sup', 'Gly', .31, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (174, 'Lev', 'Lev', 4.22, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (175, 'Hyd', 'Hyd', 3.44, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (176, 'Ice', 'Ice', 3.89, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (177, 'Tam', 'Tam', 5.04, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (178, 'Kal', 'Kal', .37, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (179, 'Zyv', 'Coc', 4.5, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (180, 'Max', 'Ace', 4.95, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (181, 'PRO', 'pro', 4.89, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (182, 'BAN', 'AVO', 2.09, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (183, 'Zaf', 'Zaf', 1.5, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (184, 'AMA', 'Pig', 6.82, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (185, 'OUT', 'ALC', 1.93, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (186, 'Tre', 'Tre', 3.4, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (187, 'Ola', 'Ola', 6.14, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (188, 'GIN', 'gin', 3.78, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (189, 'Cal', 'Arn', 4.53, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (190, 'Oxy', 'Oxy', 6.61, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (191, 'Oxy', 'Oxy', 5.83, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (192, 'Lan', 'lan', 5.6, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (193, 'Acy', 'acy', 1.67, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (194, 'Cal', 'Cal', .32, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (195, 'Ond', 'Ond', 4.99, 17);
commit;
prompt 200 records committed...
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (196, 'Iod', 'Iod', .36, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (197, 'ZES', 'Lis', 1.48, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (198, 'Rop', 'Rop', 1.89, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (199, 'Swi', 'Ant', 5.1, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (200, 'Met', 'Met', 1.55, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (201, 'Deg', 'Alu', 4.11, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (202, 'Aml', 'Aml', .6, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (203, 'Oxy', 'Oxy', 5.74, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (204, 'Ant', 'Euc', 2.64, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (205, 'REP', 'Zin', 2.03, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (206, 'Eye', 'wat', .56, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (207, 'MAX', 'MEN', 1, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (208, 'LOR', 'Hyd', 3.94, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (209, 'Bup', 'Bup', 2.49, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (210, 'DOC', 'DOC', .58, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (211, 'ESS', 'GLY', 2.2, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (212, 'Qua', 'wit', 5.54, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (213, 'GAV', 'Pol', 5.71, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (214, 'Lot', 'Ben', .53, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (215, 'TOM', 'OCT', 3.42, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (216, 'PIL', 'PIL', 4.1, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (217, 'Rob', 'Met', 4.09, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (218, 'Lid', 'LID', 3.85, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (219, 'LIS', 'LIS', .83, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (220, 'GRA', 'tbo', 2.35, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (221, 'jun', 'Ace', 3.18, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (222, 'Hur', 'Ben', 3.25, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (223, 'CD ', 'OCT', 2.75, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (224, 'LAN', 'OCT', 5.83, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (225, 'Nar', 'ROP', 2.8, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (226, 'Geo', 'zip', 5.78, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (227, 'Bla', 'Bla', 4.63, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (228, 'Dex', 'Dex', 6.68, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (229, 'Sco', 'Dex', .63, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (230, 'Rel', 'Ana', 3.55, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (231, 'Gli', 'Gli', .6, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (232, 'Con', 'Abi', .6, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (233, 'Ond', 'ond', 2.07, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (234, 'Dex', 'dex', 5.45, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (235, 'Bet', 'Bet', .17, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (236, 'Bic', 'bic', 5.66, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (237, 'Ber', 'Ber', 1.34, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (238, 'LAM', 'lam', 3.62, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (239, 'Oxy', 'Oxy', 6.08, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (240, 'Atr', 'Atr', .61, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (241, 'sma', 'Nic', 2.91, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (242, 'Iso', 'Alc', .22, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (243, 'Hyd', 'Hyd', 4.3, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (244, 'Fin', 'Fin', 2.84, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (245, 'Cou', 'Ars', 1.44, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (246, 'Pan', 'Pan', 2.72, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (247, 'Met', 'Met', .97, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (248, 'AK-', 'Nap', .6, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (249, 'Aml', 'aml', 1.42, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (250, 'Day', 'ACE', 1.27, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (251, 'CLA', 'Cla', 2.63, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (252, 'Ren', 'Ren', 1.49, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (253, 'Sul', 'Sul', 2.01, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (254, 'Sor', 'Phe', 4.21, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (255, 'TAX', 'Bal', 3.56, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (256, 'Mec', 'Mec', 6.74, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (257, 'Vol', 'EUC', 3.66, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (258, 'Tin', 'Tol', 3.05, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (259, 'TOP', 'TOP', 6.38, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (260, 'ReC', 'Oct', 5.91, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (261, 'Iso', 'Iso', 3.79, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (262, 'Pro', 'OCT', .6, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (263, 'Cle', 'cli', 1.37, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (264, 'Ame', 'Lev', 1.16, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (265, 'RUE', 'ALC', 3.56, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (266, 'Oxy', 'Oxy', 2.36, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (267, 'Ant', 'BEN', 3.02, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (268, 'Mir', 'Mir', 5.55, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (269, 'Hyd', 'Hyd', .15, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (270, 'But', 'But', 1.44, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (271, 'Fre', 'Tri', 1.25, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (273, 'Fex', 'Fex', 2.41, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (274, 'Ple', 'cit', .1, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (275, 'Hyd', 'hyd', 2.9, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (276, 'Jet', 'ACO', 1.37, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (278, 'Lis', 'Lis', 5.83, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (279, 'Art', 'Bap', 1.3, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (280, 'Lem', 'Tri', 1.87, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (282, 'DUR', 'DUR', 1.34, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (283, 'Leu', 'leu', 5.74, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (284, 'Sec', 'Alu', 6.04, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (286, 'GAB', 'tia', 1.59, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (287, 'Pri', 'des', 3.41, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (288, 'ROD', 'TIT', 5.13, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (289, 'Lan', 'Lan', 6.93, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (291, 'Hel', 'Hel', 3.61, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (292, 'LIS', 'LIS', 3.01, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (293, 'LBE', 'OCT', 2.73, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (295, 'Inf', 'ace', 6.87, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (296, 'Sul', 'SUL', 5.73, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (297, 'Haw', 'Oct', 1.17, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (299, 'Que', 'Que', 6.43, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (300, 'MED', 'MEN', 3.52, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (301, 'Sag', 'Sag', 1.28, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (302, 'Lip', 'Oct', 4.06, 17);
commit;
prompt 300 records committed...
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (304, 'Met', 'Ars', 4.73, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (305, 'Eve', 'Pyr', 2.7, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (306, 'Neu', 'Tit', 5.08, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (308, 'Riv', 'Bet', 2.43, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (309, 'Pre', 'Pre', .75, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (310, 'RIC', 'OCT', .59, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (312, 'Foc', 'dex', 2.42, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (313, 'Dul', 'sim', 4.59, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (314, 'Lov', 'Lov', .64, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (316, 'Sle', 'Dip', 2.34, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (317, 'Hum', 'Hum', 2.33, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (318, 'Oxy', 'Oxy', 5.87, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (319, 'Cou', 'CAL', 1.47, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (321, 'Dib', 'Dib', 2.06, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (322, 'AML', 'AML', 1.97, 9);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (323, 'Fer', 'Fer', 5.74, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (325, 'MET', 'MET', 6.91, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (326, 'Gly', 'Gly', 1.17, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (327, 'Bur', 'Sod', 2.21, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (329, 'Lor', 'Lor', 6.81, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (330, 'Cal', 'Cal', 6.69, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (331, 'Est', 'Est', 2.86, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (332, 'Ter', 'Ter', 3.36, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (334, 'Euc', 'Men', 6.08, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (335, 'Zol', 'Zol', 2.28, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (336, 'Ana', 'SEM', 6.53, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (338, 'Lad', 'Alu', 3.09, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (339, 'Mon', 'dox', 2.38, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (340, 'Spa', 'Chl', 4.98, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (341, 'Baz', 'Zin', 4.66, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (343, 'Ter', 'Thu', 1.66, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (344, 'Cef', 'Cef', 2.81, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (345, 'FRE', 'TRI', 3.19, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (347, 'Moi', 'Eth', 4.82, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (348, 'Nex', 'eto', .09, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (349, 'Eno', 'Eno', 2.85, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (351, 'ERO', 'MEN', 2.44, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (352, 'VAP', 'con', 6.83, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (353, 'Dio', 'TIT', 1.88, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (354, 'Esc', 'esc', .85, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (355, 'flo', 'OCT', 2.05, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (356, 'Nit', 'Nit', .3, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (357, 'Ant', 'Eth', 4.31, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (358, 'Hom', 'Can', 4.89, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (359, 'flu', 'flu', 2.26, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (360, 'TON', 'CAM', 4.3, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (361, 'Ste', 'Ste', 4.38, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (362, 'Amo', 'Amo', .44, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (363, 'Ace', 'Ace', 6.15, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (364, 'Exc', 'Ace', 6.3, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (365, 'Aml', 'Aml', .9, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (366, 'Rim', 'Oct', 3.95, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (367, 'CEN', 'All', 1.28, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (368, 'PAS', 'Bah', 5.14, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (369, 'Sec', 'ALU', 2.67, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (370, 'Ser', 'Ser', 6.33, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (371, 'Eli', 'Cal', .84, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (372, 'lic', 'Pip', 3.8, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (373, 'Ate', 'Ate', 6.27, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (374, 'Tri', 'tri', 1.6, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (375, 'Acy', 'Acy', 5.91, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (376, 'SER', 'QUE', 5.35, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (377, 'Eve', 'Tit', 3.7, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (378, 'Arn', 'Arn', .57, 13);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (379, 'Sal', 'Sal', 4.9, 1);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (380, 'Van', 'Van', 5.78, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (381, 'Equ', 'alu', 5.35, 4);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (382, 'Tre', 'Tre', 1.63, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (383, 'Pie', 'Ant', 4.3, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (384, 'LAN', 'dig', 4.65, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (385, 'Rib', 'Rib', 2.79, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (386, 'Old', 'Alu', .55, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (387, 'LAB', 'OCT', 2.3, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (388, 'Cal', 'Cal', 4.75, 11);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (389, 'Klo', 'Clo', 1.39, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (390, 'Irb', 'IRB', 4.75, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (391, 'Len', 'LID', 5.71, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (392, 'Azi', 'Azi', 2.55, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (393, 'Sar', 'SAR', .02, 0);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (394, 'Chi', 'Dex', 4.85, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (395, 'Cef', 'Cef', .46, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (396, 'Vel', 'Vel', .55, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (397, 'Clo', 'Clo', 3.79, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (398, 'CEL', 'Cel', 5.74, 8);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (399, 'Tre', 'Tre', .9, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (400, 'Nor', 'aml', 1.5, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (272, 'Ris', 'Ris', 2.12, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (277, 'Oxy', 'oxy', 3.48, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (281, 'Pai', 'Ace', 1.31, 18);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (285, 'MET', 'MET', 3.5, 7);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (290, 'Bab', 'Col', 5.82, 6);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (294, 'PRO', 'Pro', 2.99, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (298, 'Ech', 'Ech', 2.63, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (303, 'Neu', 'Tit', .72, 12);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (307, 'Gem', 'Gem', .33, 17);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (311, 'Man', 'MAN', 1.8, 10);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (315, 'Riz', 'Riz', 4.48, 15);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (320, 'Cep', 'Phe', 3.9, 3);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (324, 'Dox', 'Dox', 6.58, 2);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (328, 'Mes', 'Mes', 5.64, 4);
commit;
prompt 400 records committed...
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (333, 'Gon', 'FOL', 4.73, 5);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (337, 'Flu', 'Flu', 2.76, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (342, 'Chi', 'Ibu', 2.32, 16);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (346, 'CD ', 'OCT', .38, 14);
insert into INJECTION (injection_id, name, disease, dosage, age_injection)
values (350, 'ck ', 'Tit', 5.41, 16);
commit;
prompt 405 records loaded
prompt Loading IN_STOCK...
insert into IN_STOCK (injection_id, stock_id)
values (1, 469);
insert into IN_STOCK (injection_id, stock_id)
values (2, 152);
insert into IN_STOCK (injection_id, stock_id)
values (3, 331);
insert into IN_STOCK (injection_id, stock_id)
values (4, 450);
insert into IN_STOCK (injection_id, stock_id)
values (5, 497);
insert into IN_STOCK (injection_id, stock_id)
values (6, 352);
insert into IN_STOCK (injection_id, stock_id)
values (7, 473);
insert into IN_STOCK (injection_id, stock_id)
values (8, 313);
insert into IN_STOCK (injection_id, stock_id)
values (9, 453);
insert into IN_STOCK (injection_id, stock_id)
values (10, 139);
insert into IN_STOCK (injection_id, stock_id)
values (11, 211);
insert into IN_STOCK (injection_id, stock_id)
values (12, 154);
insert into IN_STOCK (injection_id, stock_id)
values (13, 165);
insert into IN_STOCK (injection_id, stock_id)
values (14, 247);
insert into IN_STOCK (injection_id, stock_id)
values (15, 321);
insert into IN_STOCK (injection_id, stock_id)
values (16, 417);
insert into IN_STOCK (injection_id, stock_id)
values (17, 202);
insert into IN_STOCK (injection_id, stock_id)
values (18, 336);
insert into IN_STOCK (injection_id, stock_id)
values (19, 234);
insert into IN_STOCK (injection_id, stock_id)
values (20, 226);
insert into IN_STOCK (injection_id, stock_id)
values (21, 294);
insert into IN_STOCK (injection_id, stock_id)
values (22, 341);
insert into IN_STOCK (injection_id, stock_id)
values (23, 361);
insert into IN_STOCK (injection_id, stock_id)
values (24, 469);
insert into IN_STOCK (injection_id, stock_id)
values (25, 150);
insert into IN_STOCK (injection_id, stock_id)
values (26, 256);
insert into IN_STOCK (injection_id, stock_id)
values (27, 220);
insert into IN_STOCK (injection_id, stock_id)
values (28, 314);
insert into IN_STOCK (injection_id, stock_id)
values (29, 211);
insert into IN_STOCK (injection_id, stock_id)
values (30, 368);
insert into IN_STOCK (injection_id, stock_id)
values (31, 338);
insert into IN_STOCK (injection_id, stock_id)
values (32, 196);
insert into IN_STOCK (injection_id, stock_id)
values (33, 346);
insert into IN_STOCK (injection_id, stock_id)
values (34, 404);
insert into IN_STOCK (injection_id, stock_id)
values (35, 395);
insert into IN_STOCK (injection_id, stock_id)
values (36, 411);
insert into IN_STOCK (injection_id, stock_id)
values (37, 210);
insert into IN_STOCK (injection_id, stock_id)
values (38, 212);
insert into IN_STOCK (injection_id, stock_id)
values (39, 181);
insert into IN_STOCK (injection_id, stock_id)
values (40, 171);
insert into IN_STOCK (injection_id, stock_id)
values (41, 289);
insert into IN_STOCK (injection_id, stock_id)
values (42, 251);
insert into IN_STOCK (injection_id, stock_id)
values (43, 430);
insert into IN_STOCK (injection_id, stock_id)
values (44, 458);
insert into IN_STOCK (injection_id, stock_id)
values (45, 345);
insert into IN_STOCK (injection_id, stock_id)
values (46, 291);
insert into IN_STOCK (injection_id, stock_id)
values (47, 306);
insert into IN_STOCK (injection_id, stock_id)
values (48, 121);
insert into IN_STOCK (injection_id, stock_id)
values (49, 482);
insert into IN_STOCK (injection_id, stock_id)
values (50, 424);
insert into IN_STOCK (injection_id, stock_id)
values (51, 404);
insert into IN_STOCK (injection_id, stock_id)
values (52, 367);
insert into IN_STOCK (injection_id, stock_id)
values (53, 151);
insert into IN_STOCK (injection_id, stock_id)
values (54, 159);
insert into IN_STOCK (injection_id, stock_id)
values (55, 241);
insert into IN_STOCK (injection_id, stock_id)
values (56, 469);
insert into IN_STOCK (injection_id, stock_id)
values (57, 118);
insert into IN_STOCK (injection_id, stock_id)
values (58, 325);
insert into IN_STOCK (injection_id, stock_id)
values (59, 496);
insert into IN_STOCK (injection_id, stock_id)
values (60, 471);
insert into IN_STOCK (injection_id, stock_id)
values (61, 496);
insert into IN_STOCK (injection_id, stock_id)
values (62, 140);
insert into IN_STOCK (injection_id, stock_id)
values (63, 380);
insert into IN_STOCK (injection_id, stock_id)
values (64, 291);
insert into IN_STOCK (injection_id, stock_id)
values (65, 490);
insert into IN_STOCK (injection_id, stock_id)
values (66, 374);
insert into IN_STOCK (injection_id, stock_id)
values (67, 198);
insert into IN_STOCK (injection_id, stock_id)
values (68, 399);
insert into IN_STOCK (injection_id, stock_id)
values (69, 343);
insert into IN_STOCK (injection_id, stock_id)
values (70, 379);
insert into IN_STOCK (injection_id, stock_id)
values (71, 463);
insert into IN_STOCK (injection_id, stock_id)
values (72, 103);
insert into IN_STOCK (injection_id, stock_id)
values (73, 122);
insert into IN_STOCK (injection_id, stock_id)
values (74, 478);
insert into IN_STOCK (injection_id, stock_id)
values (75, 256);
insert into IN_STOCK (injection_id, stock_id)
values (76, 374);
insert into IN_STOCK (injection_id, stock_id)
values (77, 454);
insert into IN_STOCK (injection_id, stock_id)
values (78, 127);
insert into IN_STOCK (injection_id, stock_id)
values (79, 372);
insert into IN_STOCK (injection_id, stock_id)
values (80, 277);
insert into IN_STOCK (injection_id, stock_id)
values (81, 430);
insert into IN_STOCK (injection_id, stock_id)
values (82, 319);
insert into IN_STOCK (injection_id, stock_id)
values (83, 137);
insert into IN_STOCK (injection_id, stock_id)
values (84, 135);
insert into IN_STOCK (injection_id, stock_id)
values (85, 406);
insert into IN_STOCK (injection_id, stock_id)
values (86, 444);
insert into IN_STOCK (injection_id, stock_id)
values (87, 465);
insert into IN_STOCK (injection_id, stock_id)
values (88, 273);
insert into IN_STOCK (injection_id, stock_id)
values (89, 303);
insert into IN_STOCK (injection_id, stock_id)
values (90, 280);
insert into IN_STOCK (injection_id, stock_id)
values (91, 214);
insert into IN_STOCK (injection_id, stock_id)
values (92, 291);
insert into IN_STOCK (injection_id, stock_id)
values (93, 140);
insert into IN_STOCK (injection_id, stock_id)
values (94, 331);
insert into IN_STOCK (injection_id, stock_id)
values (95, 223);
insert into IN_STOCK (injection_id, stock_id)
values (96, 303);
insert into IN_STOCK (injection_id, stock_id)
values (97, 413);
insert into IN_STOCK (injection_id, stock_id)
values (98, 182);
insert into IN_STOCK (injection_id, stock_id)
values (99, 284);
insert into IN_STOCK (injection_id, stock_id)
values (100, 492);
commit;
prompt 100 records committed...
insert into IN_STOCK (injection_id, stock_id)
values (101, 432);
insert into IN_STOCK (injection_id, stock_id)
values (102, 284);
insert into IN_STOCK (injection_id, stock_id)
values (103, 431);
insert into IN_STOCK (injection_id, stock_id)
values (104, 219);
insert into IN_STOCK (injection_id, stock_id)
values (105, 449);
insert into IN_STOCK (injection_id, stock_id)
values (106, 252);
insert into IN_STOCK (injection_id, stock_id)
values (107, 406);
insert into IN_STOCK (injection_id, stock_id)
values (108, 430);
insert into IN_STOCK (injection_id, stock_id)
values (109, 286);
insert into IN_STOCK (injection_id, stock_id)
values (110, 474);
insert into IN_STOCK (injection_id, stock_id)
values (111, 478);
insert into IN_STOCK (injection_id, stock_id)
values (112, 419);
insert into IN_STOCK (injection_id, stock_id)
values (113, 476);
insert into IN_STOCK (injection_id, stock_id)
values (114, 320);
insert into IN_STOCK (injection_id, stock_id)
values (115, 470);
insert into IN_STOCK (injection_id, stock_id)
values (116, 461);
insert into IN_STOCK (injection_id, stock_id)
values (117, 458);
insert into IN_STOCK (injection_id, stock_id)
values (118, 355);
insert into IN_STOCK (injection_id, stock_id)
values (119, 387);
insert into IN_STOCK (injection_id, stock_id)
values (120, 392);
insert into IN_STOCK (injection_id, stock_id)
values (121, 417);
insert into IN_STOCK (injection_id, stock_id)
values (122, 434);
insert into IN_STOCK (injection_id, stock_id)
values (123, 482);
insert into IN_STOCK (injection_id, stock_id)
values (124, 256);
insert into IN_STOCK (injection_id, stock_id)
values (125, 304);
insert into IN_STOCK (injection_id, stock_id)
values (126, 491);
insert into IN_STOCK (injection_id, stock_id)
values (127, 363);
insert into IN_STOCK (injection_id, stock_id)
values (128, 473);
insert into IN_STOCK (injection_id, stock_id)
values (129, 460);
insert into IN_STOCK (injection_id, stock_id)
values (130, 102);
insert into IN_STOCK (injection_id, stock_id)
values (131, 380);
insert into IN_STOCK (injection_id, stock_id)
values (132, 274);
insert into IN_STOCK (injection_id, stock_id)
values (133, 344);
insert into IN_STOCK (injection_id, stock_id)
values (134, 217);
insert into IN_STOCK (injection_id, stock_id)
values (135, 277);
insert into IN_STOCK (injection_id, stock_id)
values (136, 434);
insert into IN_STOCK (injection_id, stock_id)
values (137, 398);
insert into IN_STOCK (injection_id, stock_id)
values (138, 164);
insert into IN_STOCK (injection_id, stock_id)
values (139, 177);
insert into IN_STOCK (injection_id, stock_id)
values (140, 463);
insert into IN_STOCK (injection_id, stock_id)
values (141, 167);
insert into IN_STOCK (injection_id, stock_id)
values (142, 311);
insert into IN_STOCK (injection_id, stock_id)
values (143, 261);
insert into IN_STOCK (injection_id, stock_id)
values (144, 491);
insert into IN_STOCK (injection_id, stock_id)
values (145, 282);
insert into IN_STOCK (injection_id, stock_id)
values (146, 480);
insert into IN_STOCK (injection_id, stock_id)
values (147, 420);
insert into IN_STOCK (injection_id, stock_id)
values (148, 183);
insert into IN_STOCK (injection_id, stock_id)
values (149, 443);
insert into IN_STOCK (injection_id, stock_id)
values (150, 308);
insert into IN_STOCK (injection_id, stock_id)
values (151, 439);
insert into IN_STOCK (injection_id, stock_id)
values (152, 346);
insert into IN_STOCK (injection_id, stock_id)
values (153, 403);
insert into IN_STOCK (injection_id, stock_id)
values (154, 253);
insert into IN_STOCK (injection_id, stock_id)
values (155, 187);
insert into IN_STOCK (injection_id, stock_id)
values (156, 154);
insert into IN_STOCK (injection_id, stock_id)
values (157, 279);
insert into IN_STOCK (injection_id, stock_id)
values (158, 426);
insert into IN_STOCK (injection_id, stock_id)
values (159, 181);
insert into IN_STOCK (injection_id, stock_id)
values (160, 246);
insert into IN_STOCK (injection_id, stock_id)
values (161, 209);
insert into IN_STOCK (injection_id, stock_id)
values (162, 167);
insert into IN_STOCK (injection_id, stock_id)
values (163, 195);
insert into IN_STOCK (injection_id, stock_id)
values (164, 434);
insert into IN_STOCK (injection_id, stock_id)
values (165, 280);
insert into IN_STOCK (injection_id, stock_id)
values (166, 122);
insert into IN_STOCK (injection_id, stock_id)
values (167, 477);
insert into IN_STOCK (injection_id, stock_id)
values (168, 470);
insert into IN_STOCK (injection_id, stock_id)
values (169, 129);
insert into IN_STOCK (injection_id, stock_id)
values (170, 358);
insert into IN_STOCK (injection_id, stock_id)
values (171, 245);
insert into IN_STOCK (injection_id, stock_id)
values (172, 413);
insert into IN_STOCK (injection_id, stock_id)
values (173, 153);
insert into IN_STOCK (injection_id, stock_id)
values (174, 472);
insert into IN_STOCK (injection_id, stock_id)
values (175, 240);
insert into IN_STOCK (injection_id, stock_id)
values (176, 440);
insert into IN_STOCK (injection_id, stock_id)
values (177, 338);
insert into IN_STOCK (injection_id, stock_id)
values (178, 209);
insert into IN_STOCK (injection_id, stock_id)
values (179, 185);
insert into IN_STOCK (injection_id, stock_id)
values (180, 443);
insert into IN_STOCK (injection_id, stock_id)
values (181, 425);
insert into IN_STOCK (injection_id, stock_id)
values (182, 378);
insert into IN_STOCK (injection_id, stock_id)
values (183, 137);
insert into IN_STOCK (injection_id, stock_id)
values (184, 259);
insert into IN_STOCK (injection_id, stock_id)
values (185, 437);
insert into IN_STOCK (injection_id, stock_id)
values (186, 361);
insert into IN_STOCK (injection_id, stock_id)
values (187, 397);
insert into IN_STOCK (injection_id, stock_id)
values (188, 280);
insert into IN_STOCK (injection_id, stock_id)
values (189, 286);
insert into IN_STOCK (injection_id, stock_id)
values (190, 198);
insert into IN_STOCK (injection_id, stock_id)
values (191, 336);
insert into IN_STOCK (injection_id, stock_id)
values (192, 273);
insert into IN_STOCK (injection_id, stock_id)
values (193, 466);
insert into IN_STOCK (injection_id, stock_id)
values (194, 163);
insert into IN_STOCK (injection_id, stock_id)
values (195, 218);
insert into IN_STOCK (injection_id, stock_id)
values (196, 368);
insert into IN_STOCK (injection_id, stock_id)
values (197, 368);
insert into IN_STOCK (injection_id, stock_id)
values (198, 401);
insert into IN_STOCK (injection_id, stock_id)
values (199, 185);
insert into IN_STOCK (injection_id, stock_id)
values (200, 255);
commit;
prompt 200 records committed...
insert into IN_STOCK (injection_id, stock_id)
values (201, 431);
insert into IN_STOCK (injection_id, stock_id)
values (202, 137);
insert into IN_STOCK (injection_id, stock_id)
values (203, 273);
insert into IN_STOCK (injection_id, stock_id)
values (204, 328);
insert into IN_STOCK (injection_id, stock_id)
values (205, 433);
insert into IN_STOCK (injection_id, stock_id)
values (206, 447);
insert into IN_STOCK (injection_id, stock_id)
values (207, 218);
insert into IN_STOCK (injection_id, stock_id)
values (208, 221);
insert into IN_STOCK (injection_id, stock_id)
values (209, 368);
insert into IN_STOCK (injection_id, stock_id)
values (210, 272);
insert into IN_STOCK (injection_id, stock_id)
values (211, 345);
insert into IN_STOCK (injection_id, stock_id)
values (212, 289);
insert into IN_STOCK (injection_id, stock_id)
values (213, 398);
insert into IN_STOCK (injection_id, stock_id)
values (214, 293);
insert into IN_STOCK (injection_id, stock_id)
values (215, 478);
insert into IN_STOCK (injection_id, stock_id)
values (216, 463);
insert into IN_STOCK (injection_id, stock_id)
values (217, 125);
insert into IN_STOCK (injection_id, stock_id)
values (218, 138);
insert into IN_STOCK (injection_id, stock_id)
values (219, 364);
insert into IN_STOCK (injection_id, stock_id)
values (220, 235);
insert into IN_STOCK (injection_id, stock_id)
values (221, 281);
insert into IN_STOCK (injection_id, stock_id)
values (222, 125);
insert into IN_STOCK (injection_id, stock_id)
values (223, 369);
insert into IN_STOCK (injection_id, stock_id)
values (224, 412);
insert into IN_STOCK (injection_id, stock_id)
values (225, 470);
insert into IN_STOCK (injection_id, stock_id)
values (226, 436);
insert into IN_STOCK (injection_id, stock_id)
values (227, 118);
insert into IN_STOCK (injection_id, stock_id)
values (228, 179);
insert into IN_STOCK (injection_id, stock_id)
values (229, 272);
insert into IN_STOCK (injection_id, stock_id)
values (230, 311);
insert into IN_STOCK (injection_id, stock_id)
values (231, 439);
insert into IN_STOCK (injection_id, stock_id)
values (232, 325);
insert into IN_STOCK (injection_id, stock_id)
values (233, 326);
insert into IN_STOCK (injection_id, stock_id)
values (234, 359);
insert into IN_STOCK (injection_id, stock_id)
values (235, 499);
insert into IN_STOCK (injection_id, stock_id)
values (236, 362);
insert into IN_STOCK (injection_id, stock_id)
values (237, 126);
insert into IN_STOCK (injection_id, stock_id)
values (238, 382);
insert into IN_STOCK (injection_id, stock_id)
values (239, 476);
insert into IN_STOCK (injection_id, stock_id)
values (240, 196);
insert into IN_STOCK (injection_id, stock_id)
values (241, 127);
insert into IN_STOCK (injection_id, stock_id)
values (242, 391);
insert into IN_STOCK (injection_id, stock_id)
values (243, 261);
insert into IN_STOCK (injection_id, stock_id)
values (244, 279);
insert into IN_STOCK (injection_id, stock_id)
values (245, 291);
insert into IN_STOCK (injection_id, stock_id)
values (246, 239);
insert into IN_STOCK (injection_id, stock_id)
values (247, 338);
insert into IN_STOCK (injection_id, stock_id)
values (248, 295);
insert into IN_STOCK (injection_id, stock_id)
values (249, 103);
insert into IN_STOCK (injection_id, stock_id)
values (250, 121);
insert into IN_STOCK (injection_id, stock_id)
values (251, 317);
insert into IN_STOCK (injection_id, stock_id)
values (252, 125);
insert into IN_STOCK (injection_id, stock_id)
values (253, 348);
insert into IN_STOCK (injection_id, stock_id)
values (254, 381);
insert into IN_STOCK (injection_id, stock_id)
values (255, 305);
insert into IN_STOCK (injection_id, stock_id)
values (256, 126);
insert into IN_STOCK (injection_id, stock_id)
values (257, 292);
insert into IN_STOCK (injection_id, stock_id)
values (258, 285);
insert into IN_STOCK (injection_id, stock_id)
values (259, 348);
insert into IN_STOCK (injection_id, stock_id)
values (260, 275);
insert into IN_STOCK (injection_id, stock_id)
values (261, 382);
insert into IN_STOCK (injection_id, stock_id)
values (262, 365);
insert into IN_STOCK (injection_id, stock_id)
values (263, 157);
insert into IN_STOCK (injection_id, stock_id)
values (264, 218);
insert into IN_STOCK (injection_id, stock_id)
values (265, 267);
insert into IN_STOCK (injection_id, stock_id)
values (266, 239);
insert into IN_STOCK (injection_id, stock_id)
values (267, 146);
insert into IN_STOCK (injection_id, stock_id)
values (268, 374);
insert into IN_STOCK (injection_id, stock_id)
values (269, 483);
insert into IN_STOCK (injection_id, stock_id)
values (270, 280);
insert into IN_STOCK (injection_id, stock_id)
values (271, 177);
insert into IN_STOCK (injection_id, stock_id)
values (272, 331);
insert into IN_STOCK (injection_id, stock_id)
values (273, 199);
insert into IN_STOCK (injection_id, stock_id)
values (274, 447);
insert into IN_STOCK (injection_id, stock_id)
values (275, 476);
insert into IN_STOCK (injection_id, stock_id)
values (276, 472);
insert into IN_STOCK (injection_id, stock_id)
values (277, 363);
insert into IN_STOCK (injection_id, stock_id)
values (278, 457);
insert into IN_STOCK (injection_id, stock_id)
values (279, 476);
insert into IN_STOCK (injection_id, stock_id)
values (280, 499);
insert into IN_STOCK (injection_id, stock_id)
values (281, 441);
insert into IN_STOCK (injection_id, stock_id)
values (282, 402);
insert into IN_STOCK (injection_id, stock_id)
values (283, 271);
insert into IN_STOCK (injection_id, stock_id)
values (284, 164);
insert into IN_STOCK (injection_id, stock_id)
values (285, 302);
insert into IN_STOCK (injection_id, stock_id)
values (286, 198);
insert into IN_STOCK (injection_id, stock_id)
values (287, 246);
insert into IN_STOCK (injection_id, stock_id)
values (288, 487);
insert into IN_STOCK (injection_id, stock_id)
values (289, 433);
insert into IN_STOCK (injection_id, stock_id)
values (290, 367);
insert into IN_STOCK (injection_id, stock_id)
values (291, 141);
insert into IN_STOCK (injection_id, stock_id)
values (292, 170);
insert into IN_STOCK (injection_id, stock_id)
values (293, 224);
insert into IN_STOCK (injection_id, stock_id)
values (294, 334);
insert into IN_STOCK (injection_id, stock_id)
values (295, 139);
insert into IN_STOCK (injection_id, stock_id)
values (296, 482);
insert into IN_STOCK (injection_id, stock_id)
values (297, 138);
insert into IN_STOCK (injection_id, stock_id)
values (298, 146);
insert into IN_STOCK (injection_id, stock_id)
values (299, 217);
insert into IN_STOCK (injection_id, stock_id)
values (300, 332);
commit;
prompt 300 records committed...
insert into IN_STOCK (injection_id, stock_id)
values (301, 485);
insert into IN_STOCK (injection_id, stock_id)
values (302, 400);
insert into IN_STOCK (injection_id, stock_id)
values (303, 167);
insert into IN_STOCK (injection_id, stock_id)
values (304, 199);
insert into IN_STOCK (injection_id, stock_id)
values (305, 403);
insert into IN_STOCK (injection_id, stock_id)
values (306, 472);
insert into IN_STOCK (injection_id, stock_id)
values (307, 314);
insert into IN_STOCK (injection_id, stock_id)
values (308, 438);
insert into IN_STOCK (injection_id, stock_id)
values (309, 401);
insert into IN_STOCK (injection_id, stock_id)
values (310, 445);
insert into IN_STOCK (injection_id, stock_id)
values (311, 333);
insert into IN_STOCK (injection_id, stock_id)
values (312, 424);
insert into IN_STOCK (injection_id, stock_id)
values (313, 238);
insert into IN_STOCK (injection_id, stock_id)
values (314, 229);
insert into IN_STOCK (injection_id, stock_id)
values (315, 419);
insert into IN_STOCK (injection_id, stock_id)
values (316, 272);
insert into IN_STOCK (injection_id, stock_id)
values (317, 492);
insert into IN_STOCK (injection_id, stock_id)
values (318, 263);
insert into IN_STOCK (injection_id, stock_id)
values (319, 378);
insert into IN_STOCK (injection_id, stock_id)
values (320, 171);
insert into IN_STOCK (injection_id, stock_id)
values (321, 225);
insert into IN_STOCK (injection_id, stock_id)
values (322, 295);
insert into IN_STOCK (injection_id, stock_id)
values (323, 311);
insert into IN_STOCK (injection_id, stock_id)
values (324, 487);
insert into IN_STOCK (injection_id, stock_id)
values (325, 452);
insert into IN_STOCK (injection_id, stock_id)
values (326, 443);
insert into IN_STOCK (injection_id, stock_id)
values (327, 264);
insert into IN_STOCK (injection_id, stock_id)
values (328, 270);
insert into IN_STOCK (injection_id, stock_id)
values (329, 455);
insert into IN_STOCK (injection_id, stock_id)
values (330, 408);
insert into IN_STOCK (injection_id, stock_id)
values (331, 298);
insert into IN_STOCK (injection_id, stock_id)
values (332, 308);
insert into IN_STOCK (injection_id, stock_id)
values (333, 445);
insert into IN_STOCK (injection_id, stock_id)
values (334, 457);
insert into IN_STOCK (injection_id, stock_id)
values (335, 171);
insert into IN_STOCK (injection_id, stock_id)
values (336, 181);
insert into IN_STOCK (injection_id, stock_id)
values (337, 187);
insert into IN_STOCK (injection_id, stock_id)
values (338, 258);
insert into IN_STOCK (injection_id, stock_id)
values (339, 278);
insert into IN_STOCK (injection_id, stock_id)
values (340, 450);
insert into IN_STOCK (injection_id, stock_id)
values (341, 128);
insert into IN_STOCK (injection_id, stock_id)
values (342, 158);
insert into IN_STOCK (injection_id, stock_id)
values (343, 429);
insert into IN_STOCK (injection_id, stock_id)
values (344, 427);
insert into IN_STOCK (injection_id, stock_id)
values (345, 424);
insert into IN_STOCK (injection_id, stock_id)
values (346, 409);
insert into IN_STOCK (injection_id, stock_id)
values (347, 336);
insert into IN_STOCK (injection_id, stock_id)
values (348, 473);
insert into IN_STOCK (injection_id, stock_id)
values (349, 196);
insert into IN_STOCK (injection_id, stock_id)
values (350, 318);
insert into IN_STOCK (injection_id, stock_id)
values (351, 168);
insert into IN_STOCK (injection_id, stock_id)
values (352, 260);
insert into IN_STOCK (injection_id, stock_id)
values (353, 232);
insert into IN_STOCK (injection_id, stock_id)
values (354, 238);
insert into IN_STOCK (injection_id, stock_id)
values (355, 454);
insert into IN_STOCK (injection_id, stock_id)
values (356, 152);
insert into IN_STOCK (injection_id, stock_id)
values (357, 453);
insert into IN_STOCK (injection_id, stock_id)
values (358, 175);
insert into IN_STOCK (injection_id, stock_id)
values (359, 294);
insert into IN_STOCK (injection_id, stock_id)
values (360, 142);
insert into IN_STOCK (injection_id, stock_id)
values (361, 365);
insert into IN_STOCK (injection_id, stock_id)
values (362, 108);
insert into IN_STOCK (injection_id, stock_id)
values (363, 152);
insert into IN_STOCK (injection_id, stock_id)
values (364, 480);
insert into IN_STOCK (injection_id, stock_id)
values (365, 407);
insert into IN_STOCK (injection_id, stock_id)
values (366, 422);
insert into IN_STOCK (injection_id, stock_id)
values (367, 396);
insert into IN_STOCK (injection_id, stock_id)
values (368, 262);
insert into IN_STOCK (injection_id, stock_id)
values (369, 229);
insert into IN_STOCK (injection_id, stock_id)
values (370, 152);
insert into IN_STOCK (injection_id, stock_id)
values (371, 455);
insert into IN_STOCK (injection_id, stock_id)
values (372, 289);
insert into IN_STOCK (injection_id, stock_id)
values (373, 395);
insert into IN_STOCK (injection_id, stock_id)
values (374, 407);
insert into IN_STOCK (injection_id, stock_id)
values (375, 367);
insert into IN_STOCK (injection_id, stock_id)
values (376, 271);
insert into IN_STOCK (injection_id, stock_id)
values (377, 163);
insert into IN_STOCK (injection_id, stock_id)
values (378, 101);
insert into IN_STOCK (injection_id, stock_id)
values (379, 178);
insert into IN_STOCK (injection_id, stock_id)
values (380, 100);
insert into IN_STOCK (injection_id, stock_id)
values (381, 424);
insert into IN_STOCK (injection_id, stock_id)
values (382, 363);
insert into IN_STOCK (injection_id, stock_id)
values (383, 363);
insert into IN_STOCK (injection_id, stock_id)
values (384, 243);
insert into IN_STOCK (injection_id, stock_id)
values (385, 249);
insert into IN_STOCK (injection_id, stock_id)
values (386, 122);
insert into IN_STOCK (injection_id, stock_id)
values (387, 145);
insert into IN_STOCK (injection_id, stock_id)
values (388, 399);
insert into IN_STOCK (injection_id, stock_id)
values (389, 344);
insert into IN_STOCK (injection_id, stock_id)
values (390, 269);
insert into IN_STOCK (injection_id, stock_id)
values (391, 274);
insert into IN_STOCK (injection_id, stock_id)
values (392, 462);
insert into IN_STOCK (injection_id, stock_id)
values (393, 444);
insert into IN_STOCK (injection_id, stock_id)
values (394, 285);
insert into IN_STOCK (injection_id, stock_id)
values (395, 129);
insert into IN_STOCK (injection_id, stock_id)
values (396, 334);
insert into IN_STOCK (injection_id, stock_id)
values (397, 148);
insert into IN_STOCK (injection_id, stock_id)
values (398, 124);
insert into IN_STOCK (injection_id, stock_id)
values (399, 331);
insert into IN_STOCK (injection_id, stock_id)
values (400, 434);
commit;
prompt 400 records loaded
prompt Enabling foreign key constraints for GUARDIAN_OF...
alter table GUARDIAN_OF enable constraint SYS_C007490;
alter table GUARDIAN_OF enable constraint SYS_C007491;
prompt Enabling foreign key constraints for INJECTED...
alter table INJECTED enable constraint SYS_C007520;
alter table INJECTED enable constraint SYS_C007521;
prompt Enabling foreign key constraints for INJECTED_BY...
alter table INJECTED_BY enable constraint SYS_C007498;
alter table INJECTED_BY enable constraint SYS_C007499;
prompt Enabling foreign key constraints for INJECTED_TO...
alter table INJECTED_TO enable constraint SYS_C007503;
alter table INJECTED_TO enable constraint SYS_C007504;
prompt Enabling foreign key constraints for IN_STOCK...
alter table IN_STOCK enable constraint SYS_C007517;
alter table IN_STOCK enable constraint SYS_C007518;
prompt Enabling triggers for APPOINTMENT...
alter table APPOINTMENT enable all triggers;
prompt Enabling triggers for CHILD...
alter table CHILD enable all triggers;
prompt Enabling triggers for GUARDIAN...
alter table GUARDIAN enable all triggers;
prompt Enabling triggers for GUARDIAN_OF...
alter table GUARDIAN_OF enable all triggers;
prompt Enabling triggers for STOCK...
alter table STOCK enable all triggers;
prompt Enabling triggers for INJECTED...
alter table INJECTED enable all triggers;
prompt Enabling triggers for NURSE...
alter table NURSE enable all triggers;
prompt Enabling triggers for INJECTED_BY...
alter table INJECTED_BY enable all triggers;
prompt Enabling triggers for INJECTED_TO...
alter table INJECTED_TO enable all triggers;
prompt Enabling triggers for INJECTION...
alter table INJECTION enable all triggers;
prompt Enabling triggers for IN_STOCK...
alter table IN_STOCK enable all triggers;
set feedback on
set define on
prompt Done.
