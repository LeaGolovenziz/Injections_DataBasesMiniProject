prompt PL/SQL Developer import file
prompt Created on יום שני 22 יולי 2024 by golol
set feedback off
set define off
prompt Creating CHILD...
create table CHILD
(
  child_id   NUMBER not null,
  name       VARCHAR2(30) not null,
  birth_date DATE not null
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

prompt Creating STAFF...
create table STAFF
(
  saddress VARCHAR2(55) not null,
  smobile  CHAR(10) not null,
  sname    VARCHAR2(30) not null,
  smail    VARCHAR2(35) not null,
  sid      NUMBER(5) not null
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
alter table STAFF
  add primary key (SID)
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

prompt Creating DOCTOR...
create table DOCTOR
(
  license     VARCHAR2(15) not null,
  specialties VARCHAR2(15) not null,
  sid         NUMBER(5) not null
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
alter table DOCTOR
  add primary key (SID)
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
alter table DOCTOR
  add foreign key (SID)
  references STAFF (SID);

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

prompt Creating INJECTION_APPOINTMENT...
create table INJECTION_APPOINTMENT
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
alter table INJECTION_APPOINTMENT
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
alter table INJECTION_APPOINTMENT
  add constraint CHK_ROOM_NUMBER
  check (room = ROUND(room));

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
  references INJECTION_APPOINTMENT (APPOINTMENT_ID);
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
  references INJECTION_APPOINTMENT (APPOINTMENT_ID);
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
  references INJECTION_APPOINTMENT (APPOINTMENT_ID);
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

prompt Creating MATERIAL...
create table MATERIAL
(
  mid    NUMBER(5) not null,
  mname  VARCHAR2(15) not null,
  amount NUMBER(5) not null
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
alter table MATERIAL
  add primary key (MID)
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

prompt Creating TREATMENT...
create table TREATMENT
(
  ttype       VARCHAR2(15) not null,
  description VARCHAR2(200) not null,
  price       NUMBER(5) not null,
  tid         NUMBER(5) not null,
  time        NUMBER not null
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
alter table TREATMENT
  add primary key (TID)
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
alter table TREATMENT
  add constraint CHECK_P
  check (PRICE > 0);
alter table TREATMENT
  add constraint CHECK_PRICE
  check (PRICE > 0);

prompt Creating MUSEDINT...
create table MUSEDINT
(
  tid NUMBER(5) not null,
  mid NUMBER(5) not null
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
alter table MUSEDINT
  add primary key (TID, MID)
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
alter table MUSEDINT
  add foreign key (TID)
  references TREATMENT (TID);
alter table MUSEDINT
  add foreign key (MID)
  references MATERIAL (MID);

prompt Creating OFFICE...
create table OFFICE
(
  otype VARCHAR2(15) not null,
  sid   NUMBER(5) not null
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
alter table OFFICE
  add primary key (SID)
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
alter table OFFICE
  add foreign key (SID)
  references STAFF (SID);

prompt Creating TEETH_APPOINTMENT...
create table TEETH_APPOINTMENT
(
  adate         DATE default TRUNC(SYSDATE) not null,
  appointmentid NUMBER(7) not null,
  sid           NUMBER(5) not null,
  child_id      NUMBER(5)
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
alter table TEETH_APPOINTMENT
  add primary key (APPOINTMENTID)
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
alter table TEETH_APPOINTMENT
  add constraint FK_APPOINTMENT_CHILD_ID foreign key (CHILD_ID)
  references CHILD (CHILD_ID);
alter table TEETH_APPOINTMENT
  add foreign key (SID)
  references DOCTOR (SID);

prompt Creating OMAKEA...
create table OMAKEA
(
  appointmentid NUMBER(5) not null,
  sid           NUMBER(5) not null
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
alter table OMAKEA
  add primary key (APPOINTMENTID, SID)
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
alter table OMAKEA
  add foreign key (APPOINTMENTID)
  references TEETH_APPOINTMENT (APPOINTMENTID);
alter table OMAKEA
  add foreign key (SID)
  references OFFICE (SID);

prompt Creating PAYMENT...
create table PAYMENT
(
  id            NUMBER(5) not null,
  totalprice    NUMBER(10) not null,
  pdate         DATE not null,
  appointmentid NUMBER(5) not null
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
alter table PAYMENT
  add primary key (ID)
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
alter table PAYMENT
  add foreign key (APPOINTMENTID)
  references TEETH_APPOINTMENT (APPOINTMENTID);

prompt Creating TPREFORMEDINA...
create table TPREFORMEDINA
(
  tid           NUMBER(5) not null,
  appointmentid NUMBER(5) not null
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
alter table TPREFORMEDINA
  add primary key (TID, APPOINTMENTID)
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
alter table TPREFORMEDINA
  add foreign key (TID)
  references TREATMENT (TID);
alter table TPREFORMEDINA
  add foreign key (APPOINTMENTID)
  references TEETH_APPOINTMENT (APPOINTMENTID);

prompt Disabling triggers for CHILD...
alter table CHILD disable all triggers;
prompt Disabling triggers for STAFF...
alter table STAFF disable all triggers;
prompt Disabling triggers for DOCTOR...
alter table DOCTOR disable all triggers;
prompt Disabling triggers for GUARDIAN...
alter table GUARDIAN disable all triggers;
prompt Disabling triggers for GUARDIAN_OF...
alter table GUARDIAN_OF disable all triggers;
prompt Disabling triggers for INJECTION_APPOINTMENT...
alter table INJECTION_APPOINTMENT disable all triggers;
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
prompt Disabling triggers for MATERIAL...
alter table MATERIAL disable all triggers;
prompt Disabling triggers for TREATMENT...
alter table TREATMENT disable all triggers;
prompt Disabling triggers for MUSEDINT...
alter table MUSEDINT disable all triggers;
prompt Disabling triggers for OFFICE...
alter table OFFICE disable all triggers;
prompt Disabling triggers for TEETH_APPOINTMENT...
alter table TEETH_APPOINTMENT disable all triggers;
prompt Disabling triggers for OMAKEA...
alter table OMAKEA disable all triggers;
prompt Disabling triggers for PAYMENT...
alter table PAYMENT disable all triggers;
prompt Disabling triggers for TPREFORMEDINA...
alter table TPREFORMEDINA disable all triggers;
prompt Disabling foreign key constraints for DOCTOR...
alter table DOCTOR disable constraint SYS_C007716;
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
prompt Disabling foreign key constraints for MUSEDINT...
alter table MUSEDINT disable constraint SYS_C007750;
alter table MUSEDINT disable constraint SYS_C007751;
prompt Disabling foreign key constraints for OFFICE...
alter table OFFICE disable constraint SYS_C007755;
prompt Disabling foreign key constraints for TEETH_APPOINTMENT...
alter table TEETH_APPOINTMENT disable constraint FK_APPOINTMENT_CHILD_ID;
alter table TEETH_APPOINTMENT disable constraint SYS_C007733;
prompt Disabling foreign key constraints for OMAKEA...
alter table OMAKEA disable constraint SYS_C007759;
alter table OMAKEA disable constraint SYS_C007760;
prompt Disabling foreign key constraints for PAYMENT...
alter table PAYMENT disable constraint SYS_C007766;
prompt Disabling foreign key constraints for TPREFORMEDINA...
alter table TPREFORMEDINA disable constraint SYS_C007770;
alter table TPREFORMEDINA disable constraint SYS_C007771;
prompt Deleting TPREFORMEDINA...
delete from TPREFORMEDINA;
commit;
prompt Deleting PAYMENT...
delete from PAYMENT;
commit;
prompt Deleting OMAKEA...
delete from OMAKEA;
commit;
prompt Deleting TEETH_APPOINTMENT...
delete from TEETH_APPOINTMENT;
commit;
prompt Deleting OFFICE...
delete from OFFICE;
commit;
prompt Deleting MUSEDINT...
delete from MUSEDINT;
commit;
prompt Deleting TREATMENT...
delete from TREATMENT;
commit;
prompt Deleting MATERIAL...
delete from MATERIAL;
commit;
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
prompt Deleting INJECTION_APPOINTMENT...
delete from INJECTION_APPOINTMENT;
commit;
prompt Deleting GUARDIAN_OF...
delete from GUARDIAN_OF;
commit;
prompt Deleting GUARDIAN...
delete from GUARDIAN;
commit;
prompt Deleting DOCTOR...
delete from DOCTOR;
commit;
prompt Deleting STAFF...
delete from STAFF;
commit;
prompt Deleting CHILD...
delete from CHILD;
commit;
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
prompt 400 records committed...
insert into CHILD (child_id, name, birth_date)
values (727, 'Reagan Berry', to_date('23-12-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (764, 'Bradley Baxter', to_date('23-08-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (934, 'Rajah Wilder', to_date('29-06-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (717, 'Megan Molina', to_date('19-08-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (600, 'Adam Bond', to_date('18-06-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (910, 'Gloria Mckee', to_date('26-04-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (989, 'Basil Russo', to_date('28-04-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (856, 'Shay Dillon', to_date('06-08-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (610, 'Timon Dickson', to_date('08-05-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (889, 'Leo Jordan', to_date('21-08-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (676, 'Madison Madden', to_date('02-07-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (736, 'Charlotte Nguyen', to_date('05-09-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (538, 'Cecilia Butler', to_date('25-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (832, 'Xavier Bowen', to_date('08-05-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (662, 'Alma Herrera', to_date('12-10-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (657, 'Shaine Gonzalez', to_date('27-09-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (777, 'Fredericka Alexander', to_date('27-12-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (634, 'Rinah Conley', to_date('18-10-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (672, 'Lamar Conrad', to_date('08-12-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (758, 'Josiah Barker', to_date('06-03-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (994, 'Jack Sanford', to_date('12-08-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (765, 'Kylan Peterson', to_date('04-04-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (714, 'Lynn Sheppard', to_date('15-01-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (995, 'Paula Nash', to_date('08-12-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (766, 'Lucius Gross', to_date('15-07-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (619, 'Cairo Clemons', to_date('06-03-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (559, 'Rhona Maxwell', to_date('09-12-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (962, 'Mercedes Larsen', to_date('10-11-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (800, 'Trevor Zamora', to_date('26-01-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (654, 'Berk Buckner', to_date('16-02-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (839, 'Bevis Wise', to_date('01-07-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (586, 'Chase Slater', to_date('26-04-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (530, 'Macon Russo', to_date('11-06-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (701, 'Hayden Macias', to_date('14-12-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (652, 'Kasimir Mejia', to_date('02-02-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (683, 'Carter Vaughn', to_date('04-08-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (984, 'Ashely Wilcox', to_date('28-08-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (775, 'Maris Witt', to_date('28-02-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (914, 'Ivana Bullock', to_date('26-01-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (650, 'Harlan Dawson', to_date('30-07-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (902, 'Davis Glenn', to_date('07-09-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (523, 'Rashad Daugherty', to_date('29-11-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (518, 'Alan Head', to_date('02-12-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (572, 'Brady Potts', to_date('22-12-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (631, 'Cairo Jackson', to_date('24-09-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (769, 'Erich Pugh', to_date('09-04-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (975, 'Brody Alvarado', to_date('28-10-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (585, 'Daphne Osborne', to_date('03-03-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (656, 'Ezekiel Thomas', to_date('24-12-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (776, 'Florence Mcleod', to_date('24-08-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (899, 'Pascale Stafford', to_date('02-10-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (729, 'Lisandra Guzman', to_date('02-09-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (511, 'Giselle May', to_date('27-10-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (647, 'Laith Todd', to_date('29-01-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (867, 'Maia Mcintyre', to_date('01-01-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (804, 'Risa Wynn', to_date('08-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (590, 'Oren Navarro', to_date('25-10-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (978, 'Gary Black', to_date('06-06-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (900, 'Hyatt Cain', to_date('29-06-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (831, 'Frances Harper', to_date('13-07-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (816, 'Paki Mayo', to_date('12-06-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (884, 'Fay Castro', to_date('26-10-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (778, 'Leilani Heath', to_date('30-11-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (639, 'Sylvester Snow', to_date('16-10-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (922, 'Jorden Britt', to_date('05-08-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (805, 'Garrison Ware', to_date('04-08-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (556, 'Alma Welch', to_date('09-04-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (671, 'April Booth', to_date('22-03-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (501, 'Dahlia Buckley', to_date('07-07-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (686, 'Kieran Montoya', to_date('07-11-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (747, 'Noelani Mcbride', to_date('26-04-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (709, 'Aline Ramos', to_date('01-09-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (715, 'Upton Hawkins', to_date('15-09-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (980, 'Uriel Mayer', to_date('09-11-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (562, 'Ivory Peterson', to_date('25-02-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (660, 'Kane Fulton', to_date('06-05-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (755, 'Genevieve Hebert', to_date('11-07-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (743, 'Shellie Burke', to_date('11-11-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (774, 'Angelica Trujillo', to_date('08-02-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (941, 'Arden Riley', to_date('08-07-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (901, 'Kane Livingston', to_date('28-10-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (513, 'Keefe Sanford', to_date('10-09-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (668, 'Alexa Workman', to_date('14-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (903, 'Lyle Adams', to_date('21-11-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (885, 'Tate Wolfe', to_date('18-03-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (708, 'Timon Osborn', to_date('03-07-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (625, 'Audrey Vega', to_date('01-11-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (877, 'Leilani Mcintyre', to_date('07-04-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (726, 'Rashad Duncan', to_date('21-05-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (760, 'Brynn Merritt', to_date('01-08-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (685, 'Lani Trujillo', to_date('15-02-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (828, 'Carson Hartman', to_date('07-02-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (599, 'Craig Kelley', to_date('24-12-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (848, 'Odessa Mcmahon', to_date('25-12-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (759, 'Ciaran Frost', to_date('16-05-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (809, 'Chancellor Montgomery', to_date('11-04-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (618, 'Reagan Franks', to_date('03-07-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (651, 'Camille Hayes', to_date('12-03-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (588, 'Brady Duran', to_date('12-03-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (705, 'Cynthia Howe', to_date('30-03-2023', 'dd-mm-yyyy'));
commit;
prompt 500 records committed...
insert into CHILD (child_id, name, birth_date)
values (745, 'Juliet Padilla', to_date('13-02-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (895, 'Tyler Madden', to_date('22-02-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (803, 'Jerome Huff', to_date('04-11-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (842, 'Renee Jimenez', to_date('08-09-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (624, 'Benjamin Joyce', to_date('03-07-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (878, 'Clare Molina', to_date('26-11-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (526, 'Micah Koch', to_date('06-01-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (872, 'Miranda Raymond', to_date('06-05-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (807, 'Demetrius Romero', to_date('12-12-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (855, 'Basil Weiss', to_date('11-02-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (700, 'Barrett Bentley', to_date('13-01-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (881, 'Ross Chapman', to_date('23-08-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (835, 'Gregory Odom', to_date('13-02-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (567, 'Naomi Paul', to_date('10-01-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (971, 'Portia Foster', to_date('04-06-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (568, 'Edan Warren', to_date('27-08-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (919, 'Hop Wright', to_date('27-04-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (524, 'Harrison Estrada', to_date('29-09-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (864, 'Martin Pacheco', to_date('21-01-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (833, 'Jordan Mathis', to_date('24-12-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (812, 'Dahlia Reilly', to_date('06-03-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (725, 'Thomas Mendez', to_date('26-05-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (874, 'Marcia Arnold', to_date('28-04-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (713, 'Simone Suarez', to_date('30-06-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (841, 'Kenyon Hall', to_date('01-11-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (690, 'Charlotte Duffy', to_date('10-09-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (696, 'Gannon Garza', to_date('12-12-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (952, 'Cullen Greene', to_date('17-03-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (798, 'Unity Ayala', to_date('19-01-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (616, 'Xander Richards', to_date('08-05-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (707, 'Shea Shepherd', to_date('04-08-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (689, 'Quamar Hughes', to_date('24-08-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (943, 'Cairo Charles', to_date('03-01-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (539, 'Quamar Bradshaw', to_date('12-12-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (829, 'Shana Kent', to_date('17-03-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (25670, 'Bob Smith', to_date('30-04-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (577, 'Eleanor Jefferson', to_date('06-08-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (838, 'Ira Day', to_date('20-07-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (502, 'Maisie Hampton', to_date('28-03-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (597, 'Malachi Sanders', to_date('26-02-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (648, 'Marcia Mcknight', to_date('12-08-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (846, 'Raven Shannon', to_date('14-11-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (584, 'Lewis Mcclure', to_date('26-11-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (553, 'Madison Lott', to_date('03-07-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (897, 'Maia Christensen', to_date('11-08-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (890, 'Regina Puckett', to_date('22-07-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (718, 'Daniel Hunt', to_date('04-10-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (609, 'Ferris Frazier', to_date('21-04-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (633, 'Wade Moody', to_date('23-09-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (659, 'Kylie Rogers', to_date('06-06-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (827, 'Athena Strong', to_date('03-04-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (632, 'Emi Figueroa', to_date('05-09-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (820, 'Hu Mays', to_date('04-08-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (991, 'Lee Nguyen', to_date('07-07-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (923, 'Harriet Pickett', to_date('26-09-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (669, 'Allistair Sheppard', to_date('14-12-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (564, 'Alyssa Lindsay', to_date('02-11-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (751, 'Hamish Villarreal', to_date('15-10-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (930, 'Tatum Greene', to_date('25-11-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (779, 'Idona Mckenzie', to_date('22-07-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (762, 'Acton Christian', to_date('02-04-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (926, 'Alika Garcia', to_date('10-08-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (674, 'Sheila Cortez', to_date('28-12-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (793, 'Hyacinth Bass', to_date('15-12-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (543, 'Beau Bailey', to_date('24-01-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (525, 'Illiana Mcfadden', to_date('31-03-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (753, 'Nero Maldonado', to_date('21-12-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (552, 'Yoko Buck', to_date('18-09-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (653, 'Kaitlin Forbes', to_date('29-07-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (879, 'Noelle Underwood', to_date('31-08-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (698, 'Blythe Stephenson', to_date('25-10-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (542, 'Tanisha Wolfe', to_date('07-12-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (593, 'Julie Barr', to_date('13-08-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (863, 'Cheryl Carpenter', to_date('17-12-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (799, 'Odette Lucas', to_date('26-06-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (569, 'Althea Randolph', to_date('16-10-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (785, 'Leo Palmer', to_date('14-12-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (894, 'Emerald Reynolds', to_date('29-01-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (504, 'Ronan Moss', to_date('18-10-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (20001, 'Alice Johnson', to_date('26-07-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (20002, 'Bob Smith', to_date('14-02-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (20003, 'Charlie Davis', to_date('16-03-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (20004, 'Danielle Wilson', to_date('22-11-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (20005, 'Evan Thompson', to_date('23-08-2017', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (20006, 'Fiona Anderson', to_date('11-11-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (20007, 'George Taylor', to_date('01-05-2019', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (20008, 'Hannah Brown', to_date('07-08-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (20009, 'Ian Garcia', to_date('05-11-2018', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (20010, 'Jill Roberts', to_date('27-09-2020', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (783, 'Louis Harding', to_date('07-02-2021', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (601, 'Bruce Walton', to_date('19-11-2022', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (871, 'Flynn Jensen', to_date('06-11-2023', 'dd-mm-yyyy'));
insert into CHILD (child_id, name, birth_date)
values (946, 'Amanda Mcmahon', to_date('27-02-2020', 'dd-mm-yyyy'));
commit;
prompt 593 records loaded
prompt Loading STAFF...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #136-7681 Aliquet Rd.', '531158076 ', 'Idona York', 'idonayork4706@gmail.com', 68393);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #873-3777 Vitae St.', '533242190 ', 'Dawn Mack', 'dawnmack9547@yahoo.edu', 13243);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 209, 6098 Lacinia Ave', '533672181 ', 'Zane Mason', 'zanemason3835@gmail.edu', 15343);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 718, 2810 Malesuada Ave', '576014371 ', 'Aaron West', 'aaronwest@aol.edu', 22236);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('923-8870 Malesuada Ave', '562428602 ', 'Ria Blair', 'riablair@gmail.net', 33143);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('444-4229 Ipsum. Ave', '585821533 ', 'Tyler Kirk', 'tylerkirk5592@yahoo.net', 89219);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 699, 710 Aliquet Avenue', '560063248 ', 'Vernon Terrell', 'vernonterrell@icloud.ca', 34355);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 423, 6657 Luctus. Ave', '517220662 ', 'Haley Floyd', 'haleyfloyd@gmail.couk', 76479);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8230 Luctus, St.', '533187031 ', 'Amal George', 'amalgeorge2591@aol.org', 99553);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #379-8022 Cras Street', '581654097 ', 'Louis Coffey', 'louiscoffey@yahoo.edu', 92365);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #623-9447 Tincidunt, Rd.', '526281113 ', 'Rashad Morse', 'rashadmorse8467@google.com', 21395);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #836-672 Non, Rd.', '568198026 ', 'Kylie Washington', 'kyliewashington@icloud.couk', 26952);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #186-8377 Magna St.', '580346633 ', 'Lesley Mitchell', 'lesleymitchell@google.net', 78475);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('350-1665 In Ave', '558401857 ', 'Dominique Barron', 'dominiquebarron@aol.net', 46197);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8630 Dictum Rd.', '585728104 ', 'Lillith Juarez', 'lillithjuarez@yahoo.couk', 42122);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #860-3713 Nec Rd.', '583491354 ', 'Amanda Schneider', 'amandaschneider5626@google.net', 77955);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #571-8518 Aliquam Road', '553751328 ', 'Cruz Thomas', 'cruzthomas@icloud.edu', 25991);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 447, 6647 Arcu Avenue', '516365335 ', 'Leslie Sawyer', 'lesliesawyer249@gmail.net', 65725);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('607-8242 Euismod St.', '531186934 ', 'Steven Roberts', 'stevenroberts1344@google.couk', 45148);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('708-2955 Hendrerit Av.', '567582562 ', 'Basia Cabrera', 'basiacabrera@google.com', 36102);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #770-1714 Ipsum Road', '559516128 ', 'Kelsie Anderson', 'kelsieanderson@icloud.edu', 69880);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('427-6416 Eros. Av.', '560467565 ', 'Nola Hunt', 'nolahunt1361@aol.com', 11410);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('349-5844 Porttitor St.', '576740394 ', 'Kyle Castillo', 'kylecastillo7518@aol.edu', 60751);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('125-1770 Aenean Ave', '584744473 ', 'Ahmed Carey', 'ahmedcarey5002@yahoo.org', 37415);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('4585 Mollis St.', '511582703 ', 'Edward Black', 'edwardblack9041@google.net', 28516);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('938-6874 Nullam Rd.', '568671458 ', 'Jolene Grant', 'jolenegrant3628@gmail.com', 81157);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 923, 8101 Non, Road', '530214135 ', 'Hayden Green', 'haydengreen1666@google.com', 41224);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #794-303 Sit Rd.', '508515499 ', 'Janna Hayden', 'jannahayden1610@icloud.ca', 54266);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 111, 6097 Nullam Avenue', '568540267 ', 'Giacomo Day', 'giacomoday@gmail.com', 80537);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #332-8555 Quis Street', '565725845 ', 'Todd Jimenez', 'toddjimenez@aol.couk', 81894);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #713-1789 Sodales. Rd.', '578771307 ', 'Garrett Freeman', 'garrettfreeman@gmail.net', 17853);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('154-9857 Dolor Av.', '533222477 ', 'Caesar French', 'caesarfrench9172@google.com', 29543);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('664-7202 Elit Ave', '560853734 ', 'Beau Horne', 'beauhorne2911@icloud.couk', 30526);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 191, 6074 Mi St.', '585874316 ', 'Jackson Parsons', 'jacksonparsons@aol.com', 83689);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('794-1599 Consectetuer Rd.', '582511229 ', 'Camille Ratliff', 'camilleratliff@yahoo.edu', 19331);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6953 Sollicitudin St.', '537311487 ', 'Ivor Gonzales', 'ivorgonzales9752@google.edu', 51672);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('257-185 Quis, St.', '575363961 ', 'Slade Rivas', 'sladerivas7347@yahoo.com', 34609);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #154-5061 Vel Ave', '512177462 ', 'Olivia Church', 'oliviachurch@google.com', 73659);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('299-3992 Etiam Av.', '565532609 ', 'Jaquelyn Delgado', 'jaquelyndelgado59@google.net', 23953);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 743, 8952 Eu St.', '547847816 ', 'Astra Baker', 'astrabaker1642@google.org', 37004);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #996-3197 Tempor Rd.', '551560128 ', 'Rhoda Waller', 'rhodawaller@aol.couk', 40705);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #834-7751 Rutrum, Avenue', '527856737 ', 'Kevin Guerra', 'kevinguerra3289@google.org', 39365);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('576-1754 Fusce St.', '513537248 ', 'Magee Mccarthy', 'mageemccarthy823@aol.org', 69296);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #570-3303 Mus. Street', '542823752 ', 'Otto Sharpe', 'ottosharpe@yahoo.org', 18773);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #309-2092 Vitae, Rd.', '571389174 ', 'Shad Stein', 'shadstein1487@google.couk', 33749);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('381-262 Mauris Avenue', '545334213 ', 'Nigel Waters', 'nigelwaters5879@aol.ca', 16063);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6305 Cras Rd.', '534811785 ', 'Cruz Neal', 'cruzneal@google.net', 62435);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('134-2600 Sit Av.', '536862815 ', 'Sara Sandoval', 'sarasandoval4151@aol.net', 58235);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #815-5751 Egestas. Ave', '587603023 ', 'Herrod Rowe', 'herrodrowe@aol.net', 78572);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 465, 8105 At Rd.', '555958867 ', 'Jena Barron', 'jenabarron@google.com', 31696);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #434-8747 Fringilla Rd.', '512638817 ', 'Neil Potts', 'neilpotts1191@yahoo.ca', 96641);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #896-8687 Justo Avenue', '588367610 ', 'Maite Delacruz', 'maitedelacruz@gmail.ca', 48188);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('461-8594 A Ave', '584395811 ', 'Nero Riley', 'neroriley@icloud.couk', 45377);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('120-6708 Cursus Av.', '539472154 ', 'Richard Bates', 'richardbates@icloud.com', 91156);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #407-2591 Fusce St.', '599544334 ', 'Griffin Cummings', 'griffincummings1057@yahoo.org', 11311);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8086 Ac Road', '568812899 ', 'Patrick Norton', 'patricknorton6880@gmail.couk', 27600);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('108-7510 Non, Rd.', '537715789 ', 'Whitney Atkinson', 'whitneyatkinson@google.couk', 18401);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #572-4245 Ut Rd.', '564037863 ', 'Imelda Harrington', 'imeldaharrington4459@gmail.com', 53805);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #214-699 Eros. Rd.', '506917833 ', 'Jasper Mercado', 'jaspermercado2111@google.edu', 43573);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('752-1645 Proin St.', '563111331 ', 'Xavier Murphy', 'xaviermurphy@yahoo.com', 68429);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('820-8046 Ligula. Street', '586147840 ', 'Ayanna Underwood', 'ayannaunderwood9150@google.edu', 40492);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #973-6569 Aenean Rd.', '513540692 ', 'Quail Hester', 'quailhester@icloud.edu', 40041);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9808 Auctor St.', '556167576 ', 'Jessica Thornton', 'jessicathornton@icloud.org', 20672);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #788-7084 Mollis St.', '514975733 ', 'Gavin Walker', 'gavinwalker@google.net', 77008);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 712, 8640 Odio. Rd.', '530216427 ', 'Ava Nolan', 'avanolan@gmail.org', 22376);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('560-8645 Risus. Av.', '536481753 ', 'Kato Merrill', 'katomerrill8189@aol.couk', 67810);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('732-9174 Sed Rd.', '574827138 ', 'Gregory Welch', 'gregorywelch1282@google.couk', 27715);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #169-5910 Tincidunt Av.', '518248266 ', 'Heidi Rogers', 'heidirogers@gmail.net', 53235);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8432 Pede. Rd.', '594678748 ', 'Keelie Shannon', 'keelieshannon@aol.net', 89350);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #509-7935 Tempus Ave', '545145090 ', 'Kaye Stephenson', 'kayestephenson@google.com', 44433);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('850-1622 Pretium Road', '538844066 ', 'Imani Cantu', 'imanicantu@gmail.couk', 72479);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 355, 4457 Ut Rd.', '590725614 ', 'Len Harmon', 'lenharmon7633@google.couk', 40849);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9170 Elit Rd.', '571814691 ', 'Randall Reeves', 'randallreeves8335@gmail.com', 30063);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5909 Cras Avenue', '568485264 ', 'Jerome Walters', 'jeromewalters8398@icloud.com', 98364);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 437, 6016 Dolor. Rd.', '558569531 ', 'Sydnee Mclaughlin', 'sydneemclaughlin3424@gmail.com', 61435);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #339-3448 Mollis Street', '568966378 ', 'Valentine Forbes', 'valentineforbes2516@yahoo.ca', 63036);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('489-892 Id Rd.', '506169440 ', 'Lisandra Carson', 'lisandracarson@icloud.org', 12474);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('246-4726 Tellus. Av.', '577187944 ', 'Florence Herrera', 'florenceherrera1097@google.edu', 44023);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('329-5721 Orci, Rd.', '511121883 ', 'Zephania Golden', 'zephaniagolden@aol.net', 91539);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7883 Condimentum. Rd.', '511177873 ', 'Abdul Erickson', 'abdulerickson7535@icloud.org', 60334);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #671-4417 Facilisi. Rd.', '524139451 ', 'Gannon Hudson', 'gannonhudson@yahoo.couk', 25253);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 337, 4911 Laoreet Rd.', '586035372 ', 'Echo Ashley', 'echoashley@google.com', 97879);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('538-8525 Elementum Street', '584845961 ', 'Elmo Richmond', 'elmorichmond92@aol.ca', 10770);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #241-1911 Facilisis Av.', '568971842 ', 'Nichole Hurst', 'nicholehurst3419@gmail.org', 44105);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('662-3825 Lorem St.', '526148534 ', 'Elaine Larson', 'elainelarson@icloud.couk', 75431);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('673-7508 Vivamus Rd.', '520253330 ', 'Devin Briggs', 'devinbriggs4745@gmail.com', 34002);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('447-2896 Neque Av.', '560813114 ', 'Bell Mckay', 'bellmckay@google.couk', 28310);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('926-7645 Velit. Rd.', '572252698 ', 'Liberty Daugherty', 'libertydaugherty5880@yahoo.com', 30893);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 390, 2107 Enim Avenue', '573568453 ', 'Gareth Espinoza', 'garethespinoza7921@icloud.com', 36012);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('109-4906 Amet, Av.', '578145026 ', 'Bevis Mccormick', 'bevismccormick7662@icloud.com', 92442);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('262-5272 Egestas Road', '504178564 ', 'Murphy Jimenez', 'murphyjimenez@icloud.org', 96456);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('556-4976 A, Rd.', '543378125 ', 'Nayda Olson', 'naydaolson7006@gmail.ca', 12979);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('789-1741 Sagittis Rd.', '522758463 ', 'Mia Lindsey', 'mialindsey@google.edu', 66715);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('3001 Sit Avenue', '523982489 ', 'Caleb Battle', 'calebbattle@gmail.ca', 29127);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #753-1712 Amet Avenue', '597366970 ', 'Dennis Walton', 'denniswalton@gmail.ca', 67343);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #634-6226 Nec, Ave', '515070766 ', 'Ferris Hodges', 'ferrishodges1682@yahoo.net', 90477);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 165, 8628 Quis Av.', '589553513 ', 'Wing Ford', 'wingford@icloud.org', 15536);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #664-419 Eu Road', '531261261 ', 'Angelica Cotton', 'angelicacotton@gmail.com', 73586);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('150-9963 Cras Ave', '515535173 ', 'Xena Bennett', 'xenabennett@aol.ca', 48212);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #709-2871 Sodales Rd.', '571174738 ', 'James Bailey', 'jamesbailey@yahoo.net', 79819);
commit;
prompt 100 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('2225 Dolor Street', '575352376 ', 'Hector Melton', 'hectormelton@gmail.org', 78125);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('728-5482 Dolor. Road', '511784241 ', 'Todd Bentley', 'toddbentley8304@gmail.couk', 21570);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #381-170 Nisi. St.', '568018728 ', 'Grant Montgomery', 'grantmontgomery@yahoo.ca', 74606);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #615-7538 Dolor St.', '563242550 ', 'Jocelyn Beasley', 'jocelynbeasley@google.edu', 96750);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('299-7059 Cras Avenue', '523058955 ', 'Keiko Hale', 'keikohale@aol.ca', 32397);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #224-9961 Odio Ave', '514728513 ', 'Rashad Elliott', 'rashadelliott@aol.net', 56697);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 285, 1153 Habitant Street', '511632402 ', 'Miriam Brennan', 'miriambrennan8719@aol.couk', 23821);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #245-8882 Nec Rd.', '530082758 ', 'Martha Wilder', 'marthawilder6889@gmail.net', 26912);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('362-2266 Aliquam Avenue', '560694231 ', 'Emerald Sullivan', 'emeraldsullivan@google.org', 79051);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #914-6465 Non St.', '575503317 ', 'Jada Hatfield', 'jadahatfield@icloud.com', 79374);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6678 Mollis Ave', '545544543 ', 'Irene Rollins', 'irenerollins370@yahoo.net', 48563);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('149-7964 Etiam Avenue', '551433257 ', 'Amaya Mcdaniel', 'amayamcdaniel6249@gmail.net', 99475);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('168-5558 Proin Rd.', '597174527 ', 'Hanna Whitfield', 'hannawhitfield@google.edu', 39663);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 833, 3521 Diam Rd.', '540281202 ', 'Jacqueline Keller', 'jacquelinekeller8356@aol.edu', 26241);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6124 Nunc Rd.', '545950178 ', 'Kasper Mercer', 'kaspermercer@icloud.org', 13227);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #703-6220 Quisque Ave', '504716532 ', 'Flavia Briggs', 'flaviabriggs@google.net', 35451);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('126-5444 Amet Road', '531523808 ', 'Shaeleigh Knight', 'shaeleighknight8537@google.edu', 68627);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('959-7292 Duis Rd.', '563702224 ', 'Isaac Chavez', 'isaacchavez@icloud.org', 24963);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #993-5160 Dui St.', '573687099 ', 'Henry Ochoa', 'henryochoa@google.ca', 45223);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('654-8068 Orci Street', '552158310 ', 'Aimee Schultz', 'aimeeschultz@yahoo.org', 49969);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('111-7283 Pede Avenue', '532535481 ', 'Megan Holt', 'meganholt@aol.com', 17989);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #407-9135 Viverra. St.', '533328760 ', 'Freya Colon', 'freyacolon5598@yahoo.ca', 52410);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #429-5258 Aliquam Rd.', '524152664 ', 'Marsden Branch', 'marsdenbranch26@icloud.com', 51383);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #700-8766 Odio St.', '555711127 ', 'Keegan Ramirez', 'keeganramirez@aol.couk', 26895);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #270-7822 Suspendisse St.', '518674728 ', 'Damian Holloway', 'damianholloway9510@icloud.org', 27379);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('1483 Nisi. Rd.', '514431199 ', 'Honorato Lara', 'honoratolara@icloud.ca', 45674);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 418, 1128 Orci, Street', '514802815 ', 'Wallace Woodward', 'wallacewoodward9518@gmail.ca', 72375);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('12 bu Tel Aviv', '035798612 ', 'Mono OR', 'mono@gmail.com', 10000);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('123 Main St', '123456789 ', 'John Doe', 'john@email.com', 10001);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('456 Oak Ave', '987654321 ', 'Jane Smith', 'jane@email.com', 10002);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('789 Elm St', '456789012 ', 'Michael Johnson', 'michael@email.com', 10003);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('321 Pine Rd', '789012345 ', 'Emily Davis', 'emily@email.com', 10004);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('654 Maple Ln', '345678901 ', 'David Wilson', 'david@email.com', 10005);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('987 Cedar Blvd', '678901234 ', 'Sarah Thompson', 'sarah@email.com', 10006);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('246 Oak Ct', '901234567 ', 'Robert Anderson', 'robert@email.com', 10007);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('579 Elm Way', '234567890 ', 'Jessica Taylor', 'jessica@email.com', 10008);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('813 Pine Ave', '567890123 ', 'Chris Brown', 'chris@email.com', 10009);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('159 Maple St', '890123456 ', 'Amanda Garcia', 'amanda@email.com', 10010);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('101 Birch St', '234123456 ', 'Oliver Martin', 'oliver@email.com', 10011);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('202 Spruce Ln', '567234567 ', 'Sophia Lee', 'sophia@email.com', 10012);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('303 Cherry Ave', '890345678 ', 'Liam Martinez', 'liam@email.com', 10013);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('404 Willow Rd', '123456789 ', 'Mia Rodriguez', 'mia@email.com', 10014);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('505 Poplar St', '234567890 ', 'Noah Davis', 'noah@email.com', 10015);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('606 Aspen Ct', '345678901 ', 'Isabella Lewis', 'isabella@email.com', 10016);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('707 Beech Blvd', '456789012 ', 'James White', 'james@email.com', 10017);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('88 Magnolia Way', '567890123 ', 'Charl Walker', 'charlotte@email.com', 10018);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('909 Oak Dr', '678901234 ', 'Ben Hall', 'benjamin@email.com', 10019);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('100 Redwood Ave', '789012345 ', 'Amelia Young', 'amelia@email.com', 10020);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('196-696 Tincidunt Av.', '576802140 ', 'Shaine Sosa', 'shainesosa8233@gmail.couk', 71870);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #517-3634 Sed Street', '576163875 ', 'Kirsten Foreman', 'kirstenforeman55@google.org', 53162);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #105-1406 Lorem Av.', '577647211 ', 'Hillary Garrett', 'hillarygarrett@yahoo.org', 19365);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 103, 7570 Vestibulum St.', '535653718 ', 'Susan Lester', 'susanlester3407@google.com', 69468);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 128, 3885 Vitae St.', '512974695 ', 'Brianna Holcomb', 'briannaholcomb5084@icloud.ca', 94853);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5640 Justo St.', '533026653 ', 'Imani Clayton', 'imaniclayton@icloud.com', 31979);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('235-3854 Ipsum St.', '554287212 ', 'Colleen Nichols', 'colleennichols3441@gmail.couk', 49506);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('764-1812 Velit. Street', '596111846 ', 'Constance Francis', 'constancefrancis@yahoo.net', 51524);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('3407 Parturient Road', '569438994 ', 'Jamalia Nelson', 'jamalianelson1349@gmail.couk', 50906);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 227, 6260 Ac St.', '588621867 ', 'Axel Brewer', 'axelbrewer1930@aol.com', 24626);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('870-4178 Ut St.', '566568338 ', 'Hoyt Burgess', 'hoytburgess@icloud.org', 21996);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #841-223 Donec Avenue', '502347836 ', 'Ezra Petty', 'ezrapetty@gmail.org', 50112);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #949-2228 Taciti Ave', '546448857 ', 'Stephanie Walters', 'stephaniewalters6553@google.org', 59791);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('988-8976 Phasellus Rd.', '512641152 ', 'Justin Perkins', 'justinperkins@google.couk', 60642);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('960-1858 Vivamus Av.', '516540543 ', 'Charles Russell', 'charlesrussell1550@gmail.org', 88541);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7486 Mollis Avenue', '550467486 ', 'Timon Kirk', 'timonkirk@yahoo.net', 70482);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('172-5884 Orci. Rd.', '525639826 ', 'Yen Boyer', 'yenboyer391@aol.edu', 61721);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('655-8823 Quam Street', '565424647 ', 'Leah Olson', 'leaholson@gmail.ca', 84092);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('727-1258 Et, Rd.', '564758401 ', 'Warren Bradley', 'warrenbradley8891@yahoo.net', 73373);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('187-6770 Ipsum. Avenue', '524397393 ', 'Hanae Salas', 'hanaesalas5714@yahoo.net', 55295);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #704-1734 Urna Road', '554277315 ', 'Hilel Leonard', 'hilelleonard6037@google.net', 12245);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #148-4189 Magna. Av.', '520381736 ', 'Natalie Bishop', 'nataliebishop@aol.net', 43702);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 533, 173 Aliquet Avenue', '573723328 ', 'Nerea Atkins', 'nereaatkins3078@gmail.couk', 52769);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #315-4061 Pellentesque Ave', '512018656 ', 'Keiko Greene', 'keikogreene9814@aol.couk', 74841);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('4830 Nec Ave', '561202638 ', 'August Mayer', 'augustmayer@aol.edu', 92960);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('921-5607 Molestie Rd.', '577522811 ', 'Macey Leonard', 'maceyleonard@google.com', 69582);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #136-7353 Sed Ave', '568035678 ', 'Shannon Leon', 'shannonleon5982@gmail.couk', 68890);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 300, 1799 Gravida. Rd.', '555590456 ', 'Hammett Gill', 'hammettgill3998@yahoo.net', 18791);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #332-9305 Vivamus St.', '573718435 ', 'Shelley Moody', 'shelleymoody@google.net', 89796);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 522, 8963 Ante. Av.', '587582511 ', 'Quynn Holloway', 'quynnholloway@gmail.ca', 95354);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #666-8698 Purus Rd.', '522758221 ', 'Salvador Ashley', 'salvadorashley9273@gmail.com', 57569);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('948-8845 Vel St.', '517414144 ', 'Dahlia Owens', 'dahliaowens@aol.com', 54038);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('489-8703 Arcu. St.', '572652786 ', 'Morgan Hardin', 'morganhardin@yahoo.com', 69221);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('777-555 Fringilla. Av.', '557839415 ', 'Eaton Lott', 'eatonlott5980@yahoo.net', 70250);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #656-7023 Est. St.', '574921141 ', 'Clark Sampson', 'clarksampson4602@gmail.edu', 35553);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('833-8832 Aliquam St.', '580411781 ', 'Garrett Harrison', 'garrettharrison@icloud.ca', 43931);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 969, 908 Cum St.', '562542622 ', 'Madaline Mack', 'madalinemack@aol.net', 27637);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('496-2155 Orci Street', '541521610 ', 'Ali Black', 'aliblack@gmail.org', 50219);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #601-1348 Et Road', '535112874 ', 'Marshall Shannon', 'marshallshannon5759@google.net', 22440);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('309-8129 Feugiat Rd.', '564257271 ', 'Oscar Benjamin', 'oscarbenjamin@aol.edu', 66029);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('786-3330 Nisi Av.', '513778782 ', 'Emerson Cardenas', 'emersoncardenas@icloud.couk', 68854);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7968 Eu Road', '548711235 ', 'Brennan Reid', 'brennanreid@yahoo.edu', 99681);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7783 Phasellus Avenue', '552114866 ', 'Kiara Ayers', 'kiaraayers7858@aol.org', 30610);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #418-6767 Semper. Avenue', '593645385 ', 'Sacha Webster', 'sachawebster6532@yahoo.com', 24608);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #833-5380 Mauris Road', '512145373 ', 'Oscar Mays', 'oscarmays9991@gmail.couk', 47411);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('1014 Aliquet Rd.', '573652779 ', 'Vance Bradley', 'vancebradley@icloud.ca', 13416);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #453-5652 Mollis. Rd.', '564797052 ', 'Karyn Price', 'karynprice@gmail.edu', 18802);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('480-3066 Nunc Rd.', '537150742 ', 'Macon King', 'maconking3176@gmail.net', 16012);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 467, 5418 Duis Road', '564174504 ', 'Connor Mcmillan', 'connormcmillan@google.net', 15963);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #719-4855 Ante St.', '535721837 ', 'Abra Clemons', 'abraclemons2857@aol.org', 84940);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('809 Urna Street', '575013566 ', 'Harrison Stewart', 'harrisonstewart@gmail.net', 19098);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #901-2030 Vel Street', '542991526 ', 'Jeremy Santana', 'jeremysantana@gmail.couk', 69373);
commit;
prompt 200 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('827-8375 Aliquam Rd.', '527581368 ', 'Constance Navarro', 'constancenavarro@icloud.edu', 31845);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('383-3411 Nam Rd.', '566718812 ', 'Colby Shaffer', 'colbyshaffer7949@icloud.couk', 25922);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('279-4046 A, St.', '594524576 ', 'Stacey Mcleod', 'staceymcleod@aol.com', 26135);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('4212 Odio Av.', '521145828 ', 'Gannon Vance', 'gannonvance@google.org', 77934);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 408, 8813 Volutpat. Avenue', '517871957 ', 'Alan Sullivan', 'alansullivan@aol.com', 83782);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8129 Facilisis Av.', '598355463 ', 'Joelle Hoover', 'joellehoover4378@yahoo.couk', 90376);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #331-8940 Ut Road', '521151267 ', 'Kane Velazquez', 'kanevelazquez5579@icloud.com', 90152);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7215 Vestibulum Road', '556769693 ', 'Halee Boyer', 'haleeboyer8640@yahoo.couk', 61039);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 933, 8375 Enim Rd.', '582388653 ', 'Jordan Stanton', 'jordanstanton@gmail.net', 72497);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('112-260 Varius Av.', '576107777 ', 'Jescie Reynolds', 'jesciereynolds4525@icloud.couk', 44135);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #299-1591 Dictum Street', '505456764 ', 'Harding Ballard', 'hardingballard7768@icloud.ca', 41470);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('442-2426 Ut Street', '526678882 ', 'Gavin Foley', 'gavinfoley@yahoo.ca', 16017);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #878-4716 Magna Rd.', '554512612 ', 'Kennedy Atkins', 'kennedyatkins5511@yahoo.net', 68062);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('369-2220 Proin Av.', '556043206 ', 'Keely Lambert', 'keelylambert@aol.couk', 87909);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #778-3523 Nunc Street', '521473627 ', 'Kerry Cantrell', 'kerrycantrell3347@google.couk', 37037);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('214-5228 Turpis St.', '540508616 ', 'Nehru Kane', 'nehrukane@gmail.edu', 13854);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('861-3422 Et, Rd.', '548580479 ', 'Evan Norman', 'evannorman3424@yahoo.net', 20080);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 302, 6246 Risus. St.', '538180461 ', 'Flynn Fulton', 'flynnfulton@google.edu', 48224);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #727-177 Pede Rd.', '545651455 ', 'Indigo Rios', 'indigorios2663@aol.net', 74972);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('242-6132 Laoreet Ave', '535495636 ', 'Dexter Brock', 'dexterbrock@google.edu', 90220);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 452, 4243 Mi Street', '564133153 ', 'Finn Dalton', 'finndalton8241@google.net', 15962);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 745, 426 Sed Avenue', '578738721 ', 'Ryan Farley', 'ryanfarley@aol.couk', 62317);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('431-364 Nulla. Street', '533622703 ', 'Devin Dejesus', 'devindejesus6975@yahoo.com', 19618);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('787-2727 Curabitur St.', '583807736 ', 'Lance Mooney', 'lancemooney@google.com', 65613);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #238-8440 Dapibus Av.', '597121814 ', 'Chadwick May', 'chadwickmay@aol.edu', 96640);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9496 Nulla Ave', '557505223 ', 'Slade Frank', 'sladefrank9577@google.edu', 61696);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7256 Lorem St.', '555586696 ', 'Raymond Warner', 'raymondwarner@icloud.com', 38187);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 334, 4736 Eleifend St.', '580677323 ', 'Gil Morse', 'gilmorse@google.ca', 29872);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #556-2620 Lectus Street', '541851873 ', 'Lesley Clements', 'lesleyclements@gmail.org', 87171);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('551-7034 Semper St.', '532543299 ', 'Berk Brooks', 'berkbrooks5135@gmail.com', 85179);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #189-6621 Gravida. Rd.', '513542253 ', 'Axel Simpson', 'axelsimpson4740@google.com', 72073);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('820-4056 Cras Avenue', '521786146 ', 'Brynne Winters', 'brynnewinters7074@yahoo.com', 98900);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 503, 1178 Metus Ave', '559616521 ', 'Rahim Rodriquez', 'rahimrodriquez@yahoo.edu', 35556);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5718 Vulputate St.', '594666137 ', 'Phoebe Mckinney', 'phoebemckinney@google.ca', 33532);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('560-2948 Non, Rd.', '523156678 ', 'Tanner Peters', 'tannerpeters@icloud.couk', 68549);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('509-4772 Vestibulum Rd.', '524626646 ', 'Flynn Villarreal', 'flynnvillarreal9983@aol.couk', 68614);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('564-5771 Eu Street', '592450737 ', 'Tanisha Morgan', 'tanishamorgan838@google.couk', 11083);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8968 Suspendisse Road', '504006741 ', 'Lunea Emerson', 'luneaemerson@google.net', 38296);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('396-1488 Erat Street', '538383559 ', 'Naida Wade', 'naidawade@icloud.edu', 54635);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('881-5828 Integer St.', '551732000 ', 'Flavia Mcintosh', 'flaviamcintosh@gmail.com', 43915);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #403-2787 Egestas. Street', '573237112 ', 'Karyn Marsh', 'karynmarsh@yahoo.edu', 63761);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('319-2818 Nisl St.', '515333265 ', 'Galvin Ashley', 'galvinashley@gmail.net', 90668);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #522-2184 Amet Av.', '522733464 ', 'Tamara Park', 'tamarapark1701@gmail.com', 71473);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('246-5855 Amet Av.', '515274520 ', 'Griffith Keller', 'griffithkeller7065@icloud.couk', 18863);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('3056 Turpis Rd.', '536953528 ', 'Colleen Drake', 'colleendrake4856@icloud.couk', 84301);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 547, 4627 Molestie Road', '563603836 ', 'Wyatt Lara', 'wyattlara@icloud.com', 51251);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #700-8942 Nunc Street', '516175362 ', 'Rowan Savage', 'rowansavage1753@aol.couk', 82187);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('509 Non Rd.', '546198853 ', 'Zena Howard', 'zenahoward@icloud.couk', 44156);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 445, 7101 Quisque Rd.', '574447573 ', 'Eve Holland', 'eveholland@icloud.couk', 58745);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('700-1021 Elit, Av.', '522656074 ', 'Robert Sims', 'robertsims4427@gmail.com', 18525);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('111-6793 Magna. Av.', '546229625 ', 'Ivory Dunn', 'ivorydunn@google.couk', 99939);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 873, 6303 Nec St.', '576201253 ', 'Uriel Neal', 'urielneal@aol.org', 81284);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('585-1795 Metus Av.', '555092215 ', 'Fritz Weeks', 'fritzweeks5168@yahoo.com', 17105);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #641-3387 Phasellus Avenue', '531410563 ', 'Cheryl Rojas', 'cherylrojas@yahoo.org', 11630);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('950-338 Nascetur Ave', '513777066 ', 'Ferris Gallagher', 'ferrisgallagher1685@icloud.couk', 86538);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #760-5710 Vulputate, Ave', '564394841 ', 'Len Baldwin', 'lenbaldwin@google.com', 64760);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #269-7789 Molestie. Avenue', '585648527 ', 'Jennifer Durham', 'jenniferdurham@aol.net', 32568);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 775, 1674 Odio Avenue', '569446768 ', 'Dominique Travis', 'dominiquetravis@google.edu', 82258);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 714, 4508 Mollis St.', '522208561 ', 'Molly Perry', 'mollyperry@gmail.couk', 63530);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 382, 7049 Non St.', '513075078 ', 'Cara Rosario', 'cararosario5324@google.com', 56476);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #757-1273 Et, St.', '576548447 ', 'Darryl Schmidt', 'darrylschmidt@yahoo.com', 64185);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('555-8195 Augue Rd.', '543118427 ', 'Samson Waller', 'samsonwaller@aol.couk', 88762);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('841 Aliquam St.', '568408287 ', 'Sebastian Brown', 'sebastianbrown@icloud.org', 99769);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #872-7778 Ullamcorper Rd.', '555239556 ', 'Jena Gamble', 'jenagamble9266@gmail.couk', 83831);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #550-8456 Nunc. Road', '513447169 ', 'Emmanuel Burks', 'emmanuelburks@gmail.com', 27991);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #515-9910 Ac Av.', '517415802 ', 'Preston Golden', 'prestongolden@yahoo.ca', 82172);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #492-5770 Nunc Ave', '588137371 ', 'Guy Macdonald', 'guymacdonald@google.net', 35877);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5998 Dolor. Rd.', '578693863 ', 'Eric Wade', 'ericwade@google.com', 61546);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('352-1005 Mauris St.', '562747017 ', 'Sybil Garner', 'sybilgarner@gmail.org', 52116);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('520-5294 Habitant St.', '517443492 ', 'Lillian Parrish', 'lillianparrish@google.org', 80830);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('101-2980 Auctor St.', '523740535 ', 'Beverly Clements', 'beverlyclements881@yahoo.org', 71959);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 485, 6211 Non, Street', '566737527 ', 'Alana Sweet', 'alanasweet@gmail.edu', 37345);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('890-9570 Faucibus Rd.', '516973121 ', 'Ray Waters', 'raywaters@gmail.org', 34214);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('765-6368 Sed Av.', '557582683 ', 'Erin Franks', 'erinfranks6566@aol.ca', 86842);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('366-1556 Phasellus Rd.', '577777975 ', 'Venus Nolan', 'venusnolan2990@aol.com', 91865);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('822-8554 Pellentesque Road', '516661385 ', 'Jaquelyn Meyers', 'jaquelynmeyers5406@icloud.ca', 79825);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('455-9109 Odio Street', '533682586 ', 'Elton Wells', 'eltonwells@yahoo.edu', 14599);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('336-8376 Pede, Rd.', '575701763 ', 'Graham O''brien', 'grahamobrien6608@gmail.org', 12053);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 127, 6219 Eu St.', '546418581 ', 'Joy Jacobson', 'joyjacobson@icloud.ca', 83250);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('868-9853 Vitae, Road', '526222973 ', 'Vance Butler', 'vancebutler2321@aol.org', 57384);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 632, 4151 Turpis St.', '542322210 ', 'Lucy Moses', 'lucymoses@aol.couk', 55244);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9869 Magna Av.', '587828575 ', 'Keaton Mcknight', 'keatonmcknight@yahoo.edu', 12082);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('146-1365 Congue, St.', '527349116 ', 'Valentine Kaufman', 'valentinekaufman@gmail.net', 41120);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('230-6929 Suscipit Road', '596814562 ', 'Chiquita Hines', 'chiquitahines@google.com', 31151);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #513-8280 Enim. Ave', '566358768 ', 'Lars Baird', 'larsbaird94@google.ca', 99596);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 300, 1701 Donec Street', '542121155 ', 'Risa Torres', 'risatorres3860@gmail.org', 31448);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('491-894 Mauris Avenue', '502523876 ', 'Laith Austin', 'laithaustin326@yahoo.couk', 55149);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('789-2466 Eu Rd.', '583569262 ', 'Carissa Baird', 'carissabaird@gmail.org', 83211);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 107, 1303 Donec Road', '565625124 ', 'Helen Rocha', 'helenrocha@yahoo.com', 70610);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('803-6157 Cras Road', '502526397 ', 'Vielka Lopez', 'vielkalopez578@aol.ca', 88875);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 999, 980 Sollicitudin St.', '534253376 ', 'Barrett Beasley', 'barrettbeasley@google.couk', 99342);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #707-9661 Tempus St.', '596105288 ', 'Lee Gould', 'leegould3190@aol.com', 42679);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('1962 Dui. Ave', '582623882 ', 'Sheila Mooney', 'sheilamooney@gmail.couk', 83526);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #851-5065 Fusce Avenue', '596768416 ', 'Tanisha Ruiz', 'tanisharuiz3940@aol.com', 19936);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('989-4140 Aliquet Rd.', '535472519 ', 'Reagan Ashley', 'reaganashley3225@google.com', 81877);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9362 Suspendisse Street', '564069268 ', 'Kenyon Greene', 'kenyongreene@icloud.edu', 50598);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('736-6478 Velit. Rd.', '573703504 ', 'Sheila Banks', 'sheilabanks@aol.org', 89061);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('582-8851 Iaculis St.', '541634727 ', 'Keelie Waters', 'keeliewaters7555@gmail.edu', 76589);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('924-4488 Torquent Avenue', '544831649 ', 'Judah Kerr', 'judahkerr5@google.edu', 25190);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('841-5414 Orci, Rd.', '521844931 ', 'Ryan Castaneda', 'ryancastaneda@aol.couk', 32593);
commit;
prompt 300 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 879, 8486 Congue, Av.', '594677637 ', 'Hilel Baird', 'hilelbaird7340@gmail.edu', 72720);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #322-8694 Vel, Avenue', '551835552 ', 'Melinda Rosario', 'melindarosario@google.ca', 35130);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #237-505 Ullamcorper, St.', '554657269 ', 'Carly Mosley', 'carlymosley5311@icloud.edu', 91368);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('679-9125 Ut Av.', '514407551 ', 'Jenna Graves', 'jennagraves@yahoo.org', 28571);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #804-1927 Vitae St.', '524243801 ', 'Justine Baldwin', 'justinebaldwin8485@google.ca', 87332);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #265-8459 Curabitur Rd.', '539591012 ', 'Alfonso Morales', 'alfonsomorales737@gmail.com', 86483);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('325-1754 Vestibulum Av.', '562876878 ', 'Melissa Schroeder', 'melissaschroeder@google.net', 51740);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 110, 8945 In Avenue', '574646715 ', 'Timon Fleming', 'timonfleming@gmail.net', 79591);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #680-7541 Lorem, Rd.', '577325511 ', 'Abel Byers', 'abelbyers@google.com', 74331);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 746, 6204 Nunc Ave', '564741374 ', 'Henry Sweet', 'henrysweet6041@aol.couk', 74548);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('555-2029 Cursus Rd.', '524579329 ', 'Brady Strickland', 'bradystrickland@yahoo.couk', 52359);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('887-6001 Duis St.', '554222075 ', 'Abel Alvarez', 'abelalvarez@google.ca', 19671);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('898-8406 Nulla. Rd.', '523461780 ', 'Graiden Hutchinson', 'graidenhutchinson@google.org', 28053);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #244-9663 Faucibus Rd.', '586539667 ', 'Melvin Knapp', 'melvinknapp4769@aol.couk', 16712);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('122-8062 Erat. Av.', '580046806 ', 'Kenneth Ashley', 'kennethashley@gmail.org', 59839);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 200, 7870 Laoreet, Avenue', '553212214 ', 'Garrison Lambert', 'garrisonlambert818@gmail.net', 89337);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('727-1250 Scelerisque Ave', '583463722 ', 'Rosalyn Valencia', 'rosalynvalencia@aol.com', 97343);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('105-5667 A, Ave', '574118242 ', 'Grady Maddox', 'gradymaddox@aol.couk', 45839);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #741-1070 Suspendisse Rd.', '510726324 ', 'Flynn Madden', 'flynnmadden1077@aol.com', 10652);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('4121 Dolor. Av.', '592391108 ', 'Jason Wilcox', 'jasonwilcox6386@icloud.edu', 47507);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('135-6253 Nisl Road', '519384725 ', 'Angelica Randall', 'angelicarandall@aol.couk', 57567);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #982-4907 Pede, St.', '541679324 ', 'Germane Newton', 'germanenewton@google.org', 28651);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8085 Est. Rd.', '548734071 ', 'Cedric Fulton', 'cedricfulton@aol.net', 10334);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6720 Sit Avenue', '523468637 ', 'Kerry Petty', 'kerrypetty3896@gmail.ca', 27192);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('9508 Amet, Road', '501773154 ', 'Jemima Little', 'jemimalittle166@icloud.couk', 91660);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('737-6687 Mi. Avenue', '515384361 ', 'Cathleen Winters', 'cathleenwinters2733@yahoo.ca', 95896);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('540-5910 Fringilla St.', '594767325 ', 'Uta Lynch', 'utalynch@google.net', 49666);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('656-6402 Ac Rd.', '579426362 ', 'Erica Ramos', 'ericaramos@gmail.org', 95320);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('960-9429 Vitae Av.', '557048406 ', 'Walter Rodriguez', 'walterrodriguez8240@icloud.edu', 47027);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('411-6658 Natoque Road', '525646654 ', 'Camden Acevedo', 'camdenacevedo1142@aol.net', 15383);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('164-6098 Tincidunt, St.', '558642378 ', 'Brett Vinson', 'brettvinson3881@aol.com', 13261);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('352-9568 Lacus. Rd.', '564658502 ', 'Minerva Knowles', 'minervaknowles@aol.net', 74091);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('781-1796 Mauris St.', '525587831 ', 'Jacqueline Fleming', 'jacquelinefleming4206@google.com', 47970);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5850 Sed Road', '545186956 ', 'MacKenzie Rivera', 'mackenzierivera4426@google.couk', 36074);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('774-6657 Adipiscing, Avenue', '542627439 ', 'Montana Bullock', 'montanabullock6038@google.org', 42023);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 427, 7833 Eget Street', '508652224 ', 'Abel Dillard', 'abeldillard@gmail.edu', 34428);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #115-2097 Purus Av.', '528857826 ', 'Chancellor Bates', 'chancellorbates@aol.org', 15991);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('157-6601 Pellentesque Rd.', '530105577 ', 'Tanisha Kim', 'tanishakim@google.couk', 73025);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('367-5340 Vestibulum, Rd.', '557955774 ', 'Zelenia Robles', 'zeleniarobles5833@aol.couk', 53998);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 208, 7355 Bibendum Street', '514448660 ', 'Jada Gibson', 'jadagibson5119@yahoo.couk', 34404);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('908-6570 Vitae Rd.', '553888816 ', 'Hasad Madden', 'hasadmadden3719@aol.couk', 79255);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('778-828 Tempor St.', '513625224 ', 'Barclay Donovan', 'barclaydonovan@icloud.org', 21312);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7423 Vel Ave', '589795952 ', 'Amena Bowers', 'amenabowers6899@google.edu', 63284);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #715-8187 Vulputate Street', '502841488 ', 'Ignacia Haley', 'ignaciahaley@google.edu', 54246);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #242-1826 Ante Road', '581931122 ', 'Medge Matthews', 'medgematthews@gmail.edu', 17595);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8685 Erat Av.', '542787462 ', 'Hasad Frye', 'hasadfrye7650@yahoo.couk', 29561);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #211-5804 Adipiscing, Street', '554814788 ', 'Bree Blackburn', 'breeblackburn@google.edu', 46150);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('165-9181 Dictum Av.', '558713989 ', 'Pascale Mclean', 'pascalemclean@yahoo.ca', 48255);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 519, 8551 Interdum Av.', '585153685 ', 'Fritz Robles', 'fritzrobles2842@icloud.ca', 98375);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('838-4367 Sem Rd.', '514486364 ', 'Garrison Sims', 'garrisonsims5648@google.couk', 65741);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('430-2424 Aliquet, Avenue', '509955854 ', 'Desiree Drake', 'desireedrake6194@icloud.org', 79859);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('840-8083 Cras Road', '560688853 ', 'Shaine Garcia', 'shainegarcia@gmail.org', 92935);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #881-2381 Luctus Rd.', '531546613 ', 'Carla Park', 'carlapark@yahoo.ca', 24656);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #150-6481 Lorem Avenue', '504367217 ', 'Gregory Hull', 'gregoryhull9722@google.org', 70748);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8110 Nunc Ave', '552884893 ', 'Tucker Holcomb', 'tuckerholcomb@gmail.com', 55269);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('540-7773 Nullam St.', '532912738 ', 'Ferdinand Hunter', 'ferdinandhunter9004@gmail.edu', 47962);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #603-6530 Auctor St.', '535493434 ', 'Seth Mcdonald', 'sethmcdonald2053@icloud.edu', 89885);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('427-2751 Facilisis, St.', '513666362 ', 'Josiah Pacheco', 'josiahpacheco@google.org', 33360);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 571, 7230 In Rd.', '541637088 ', 'Francesca Mendoza', 'francescamendoza8935@yahoo.couk', 88571);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('952-4250 Nulla Av.', '558444542 ', 'Gay Glover', 'gayglover5321@google.org', 49355);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #777-9659 Blandit Avenue', '583816826 ', 'Vincent Wilkinson', 'vincentwilkinson@google.couk', 81875);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #260-5768 Lorem Street', '526494402 ', 'Nerea Flowers', 'nereaflowers2160@yahoo.com', 10709);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 478, 2984 Et Av.', '529168672 ', 'Ulla Richardson', 'ullarichardson@aol.ca', 99447);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 370, 365 Elementum, Av.', '506867633 ', 'Giselle Miranda', 'gisellemiranda4065@aol.net', 80248);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 542, 520 Etiam Rd.', '563614205 ', 'Kato Fowler', 'katofowler7238@google.net', 55385);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8206 Suspendisse Street', '528153403 ', 'Jonah Davis', 'jonahdavis@google.ca', 58938);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #475-7167 Aliquet St.', '576794236 ', 'Ali Mccarty', 'alimccarty@gmail.org', 99778);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('760-4732 Ante Road', '529684949 ', 'Hoyt Terry', 'hoytterry9662@gmail.net', 35535);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('167-396 Sem Rd.', '532851328 ', 'Basil Sawyer', 'basilsawyer@aol.net', 50188);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('8461 Eu St.', '504368535 ', 'Steel French', 'steelfrench7565@aol.net', 64636);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('5527 Eget, Av.', '525465726 ', 'Silas Berger', 'silasberger@icloud.com', 59041);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #901-8937 Magna. St.', '571664224 ', 'Rana Hughes', 'ranahughes@icloud.net', 92716);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #404-2686 Habitant Rd.', '555403678 ', 'Nissim Carter', 'nissimcarter2938@gmail.couk', 39314);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('247-1748 Gravida. Av.', '554380376 ', 'Colleen Kelley', 'colleenkelley8163@aol.org', 64076);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('878-8837 Ornare, Avenue', '560948551 ', 'Madison Clarke', 'madisonclarke@yahoo.net', 66915);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #718-1453 Vel, Ave', '515126338 ', 'Mason Roberts', 'masonroberts5198@google.couk', 39306);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #488-9356 Nisl St.', '538404014 ', 'Slade Bowers', 'sladebowers@gmail.net', 57210);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('3750 Ligula. Ave', '524166350 ', 'Troy Hayden', 'troyhayden@gmail.ca', 81184);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('985-1322 Lacus Rd.', '593164728 ', 'Seth Tanner', 'sethtanner@gmail.net', 93908);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('504-7454 Rutrum Street', '530850760 ', 'Erich Mayer', 'erichmayer2714@icloud.edu', 27277);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #625-8527 Ligula. Av.', '535458431 ', 'Allegra Harper', 'allegraharper@gmail.ca', 15746);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('680-804 Sociis St.', '524168384 ', 'Fulton Sanders', 'fultonsanders@gmail.com', 49449);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #706-799 Phasellus St.', '501794513 ', 'Helen Walters', 'helenwalters4808@aol.com', 33794);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('134-4456 Mi Road', '549835824 ', 'Deanna Taylor', 'deannataylor@google.edu', 68229);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #332-261 Luctus Road', '537254793 ', 'Hanae Mercado', 'hanaemercado1791@icloud.ca', 83271);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 592, 2502 Nulla Avenue', '547128513 ', 'Wilma Mcintyre', 'wilmamcintyre@gmail.ca', 30379);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('382-2358 Sapien. Rd.', '536552445 ', 'Shay Wilkerson', 'shaywilkerson@gmail.couk', 72662);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #953-2828 Semper St.', '532443538 ', 'Reagan Reed', 'reaganreed@yahoo.org', 48384);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #665-9867 Ipsum Rd.', '510334421 ', 'Melyssa Gould', 'melyssagould4067@gmail.com', 34941);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('678-7913 Dolor. Rd.', '583862347 ', 'Haviva Roth', 'havivaroth3316@gmail.net', 15357);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #228-5304 Lectus Av.', '552686566 ', 'Dara Mcclure', 'daramcclure5281@yahoo.couk', 66193);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('3715 Commodo St.', '529985889 ', 'Jameson Sears', 'jamesonsears7830@icloud.net', 60957);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #384-9731 Eget Rd.', '585903313 ', 'Mikayla Ramos', 'mikaylaramos7868@icloud.edu', 72820);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('821 Accumsan Street', '559015656 ', 'Rebecca Glover', 'rebeccaglover5668@aol.net', 45109);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 725, 719 Odio. St.', '536348805 ', 'Vance Mcleod', 'vancemcleod3763@icloud.com', 26921);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('388-6577 Sodales Street', '560653462 ', 'Pamela Wheeler', 'pamelawheeler8490@yahoo.couk', 94830);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6097 Sed St.', '541163753 ', 'Kalia Martinez', 'kaliamartinez@gmail.couk', 82443);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 393, 1086 Justo. Rd.', '514477505 ', 'Benedict Neal', 'benedictneal@gmail.couk', 98750);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #560-4351 Tincidunt, Av.', '510113661 ', 'Eugenia Harmon', 'eugeniaharmon@yahoo.com', 31947);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('747-1905 Sodales Street', '500871371 ', 'Cadman Knapp', 'cadmanknapp9312@aol.net', 57527);
commit;
prompt 400 records committed...
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 192, 7628 Mi St.', '531600723 ', 'Jasmine Holcomb', 'jasmineholcomb4015@icloud.edu', 13794);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 827, 1820 Nec, Avenue', '534165364 ', 'Timon Cameron', 'timoncameron1858@google.ca', 42991);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #590-3472 A, Street', '545885159 ', 'Lavinia Gordon', 'laviniagordon3328@icloud.ca', 30696);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('887-8056 Ornare, Av.', '557618769 ', 'Ignacia Sanders', 'ignaciasanders5602@yahoo.com', 51125);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('6358 Eu Rd.', '573183387 ', 'Keefe Cardenas', 'keefecardenas6920@yahoo.net', 76380);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('105-5302 In Rd.', '522421773 ', 'Imelda Pittman', 'imeldapittman6879@yahoo.net', 91455);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #306-3942 Eget Avenue', '522015243 ', 'Quyn Hamilton', 'quynhamilton1081@google.org', 56263);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 760, 9733 Egestas Street', '553737682 ', 'Alden Murphy', 'aldenmurphy@yahoo.net', 51861);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('120-7097 Egestas. Av.', '545561089 ', 'Zeus Villarreal', 'zeusvillarreal9608@google.net', 62741);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #753-5386 Nunc Ave', '544171861 ', 'Jacob Arnold', 'jacobarnold6727@icloud.edu', 55546);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #675-9070 Dolor. Ave', '534303341 ', 'Chandler Rios', 'chandlerrios@gmail.net', 95541);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('107-4502 Aenean St.', '583194321 ', 'Nicole Pollard', 'nicolepollard7474@yahoo.com', 55777);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('335-5389 Eu, Ave', '565872686 ', 'Xyla Rutledge', 'xylarutledge@google.com', 54662);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #649-8422 Nullam Av.', '517796724 ', 'Maggy Meyer', 'maggymeyer@icloud.edu', 93859);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('635-2003 Sit Av.', '508975168 ', 'Joel Pratt', 'joelpratt@gmail.com', 63762);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('P.O. Box 426, 3188 Nunc. Rd.', '583770774 ', 'Christen Rocha', 'christenrocha@aol.org', 25578);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #328-7014 Consequat Av.', '511215426 ', 'Noel French', 'noelfrench@icloud.net', 86430);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('Ap #777-4122 Facilisis Rd.', '583231436 ', 'Brian Mcgowan', 'brianmcgowan593@gmail.couk', 63961);
insert into STAFF (saddress, smobile, sname, smail, sid)
values ('7351 A Rd.', '516758953 ', 'Harding Ortiz', 'hardingortiz@icloud.net', 90716);
commit;
prompt 419 records loaded
prompt Loading DOCTOR...
insert into DOCTOR (license, specialties, sid)
values ('L461765', 'Orthodontist''', 29561);
insert into DOCTOR (license, specialties, sid)
values ('D757117', 'Dentist', 43931);
insert into DOCTOR (license, specialties, sid)
values ('R217729', 'Orthodontist''', 41224);
insert into DOCTOR (license, specialties, sid)
values ('E209644', 'Dentist', 62435);
insert into DOCTOR (license, specialties, sid)
values ('O066493', 'Dentist', 81284);
insert into DOCTOR (license, specialties, sid)
values ('B032623', 'Orthodontist''', 69221);
insert into DOCTOR (license, specialties, sid)
values ('M565314', 'Dentist', 73373);
insert into DOCTOR (license, specialties, sid)
values ('H212872', 'Dentist', 79819);
insert into DOCTOR (license, specialties, sid)
values ('X325759', 'Dentist', 31696);
insert into DOCTOR (license, specialties, sid)
values ('W791109', 'Orthodontist''', 15746);
insert into DOCTOR (license, specialties, sid)
values ('X491823', 'Dentist', 25922);
insert into DOCTOR (license, specialties, sid)
values ('B835741', 'Orthodontist''', 53998);
insert into DOCTOR (license, specialties, sid)
values ('M272594', 'Orthodontist''', 90668);
insert into DOCTOR (license, specialties, sid)
values ('K485723', 'Orthodontist''', 63036);
insert into DOCTOR (license, specialties, sid)
values ('E679996', 'Dentist', 87909);
insert into DOCTOR (license, specialties, sid)
values ('Q905640', 'Orthodontist''', 91539);
insert into DOCTOR (license, specialties, sid)
values ('Z994120', 'Cosmetic', 57567);
insert into DOCTOR (license, specialties, sid)
values ('O553443', 'Cosmetic', 13794);
insert into DOCTOR (license, specialties, sid)
values ('C052189', 'Orthodontist''', 34941);
insert into DOCTOR (license, specialties, sid)
values ('D227813', 'Orthodontist''', 66193);
insert into DOCTOR (license, specialties, sid)
values ('X525956', 'Cosmetic', 24608);
insert into DOCTOR (license, specialties, sid)
values ('G542657', 'Cosmetic', 52769);
insert into DOCTOR (license, specialties, sid)
values ('H250460', 'Orthodontist''', 19936);
insert into DOCTOR (license, specialties, sid)
values ('X554986', 'Cosmetic', 63284);
insert into DOCTOR (license, specialties, sid)
values ('G119221', 'Orthodontist''', 51672);
insert into DOCTOR (license, specialties, sid)
values ('P768257', 'Dentist', 69296);
insert into DOCTOR (license, specialties, sid)
values ('F113334', 'Orthodontist''', 67810);
insert into DOCTOR (license, specialties, sid)
values ('I221664', 'Cosmetic', 99778);
insert into DOCTOR (license, specialties, sid)
values ('V649726', 'Orthodontist''', 99769);
insert into DOCTOR (license, specialties, sid)
values ('B096930', 'Cosmetic', 20080);
insert into DOCTOR (license, specialties, sid)
values ('I487690', 'Cosmetic', 79374);
insert into DOCTOR (license, specialties, sid)
values ('C535836', 'Orthodontist''', 86483);
insert into DOCTOR (license, specialties, sid)
values ('C758254', 'Orthodontist''', 77008);
insert into DOCTOR (license, specialties, sid)
values ('U588691', 'Orthodontist''', 84940);
insert into DOCTOR (license, specialties, sid)
values ('V315052', 'Cosmetic', 18802);
insert into DOCTOR (license, specialties, sid)
values ('H706091', 'Cosmetic', 74548);
insert into DOCTOR (license, specialties, sid)
values ('T588863', 'Dentist', 46150);
insert into DOCTOR (license, specialties, sid)
values ('W006606', 'Cosmetic', 40041);
insert into DOCTOR (license, specialties, sid)
values ('I792247', 'Dentist', 44156);
insert into DOCTOR (license, specialties, sid)
values ('F170783', 'Dentist', 10012);
insert into DOCTOR (license, specialties, sid)
values ('J088247', 'Dentist', 13261);
insert into DOCTOR (license, specialties, sid)
values ('O224323', 'Dentist', 69880);
insert into DOCTOR (license, specialties, sid)
values ('K392960', 'Dentist', 31845);
insert into DOCTOR (license, specialties, sid)
values ('T117649', 'Orthodontist''', 69468);
insert into DOCTOR (license, specialties, sid)
values ('J670811', 'Cosmetic', 68062);
insert into DOCTOR (license, specialties, sid)
values ('N449816', 'Dentist', 25991);
insert into DOCTOR (license, specialties, sid)
values ('A353940', 'Dentist', 32397);
insert into DOCTOR (license, specialties, sid)
values ('U144582', 'Cosmetic', 76380);
insert into DOCTOR (license, specialties, sid)
values ('F435698', 'Orthodontist''', 28516);
insert into DOCTOR (license, specialties, sid)
values ('B356800', 'Dentist', 50906);
insert into DOCTOR (license, specialties, sid)
values ('G103551', 'Cosmetic', 83782);
insert into DOCTOR (license, specialties, sid)
values ('W294829', 'Orthodontist''', 22236);
insert into DOCTOR (license, specialties, sid)
values ('X854968', 'Cosmetic', 52116);
insert into DOCTOR (license, specialties, sid)
values ('L133155', 'Dentist', 84301);
insert into DOCTOR (license, specialties, sid)
values ('L259846', 'Dentist', 70748);
insert into DOCTOR (license, specialties, sid)
values ('D124076', 'Orthodontist''', 99939);
insert into DOCTOR (license, specialties, sid)
values ('J214892', 'Orthodontist''', 72073);
insert into DOCTOR (license, specialties, sid)
values ('D055815', 'Cosmetic', 74841);
insert into DOCTOR (license, specialties, sid)
values ('D865174', 'Dentist', 91660);
insert into DOCTOR (license, specialties, sid)
values ('T022842', 'Cosmetic', 71959);
insert into DOCTOR (license, specialties, sid)
values ('W006606', 'Dentist', 95541);
insert into DOCTOR (license, specialties, sid)
values ('E401251', 'Orthodontist''', 86842);
insert into DOCTOR (license, specialties, sid)
values ('Z569941', 'Dentist', 96640);
insert into DOCTOR (license, specialties, sid)
values ('P260530', 'Dentist', 32568);
insert into DOCTOR (license, specialties, sid)
values ('Q840576', 'Cosmetic', 90716);
insert into DOCTOR (license, specialties, sid)
values ('C207049', 'Orthodontist''', 48188);
insert into DOCTOR (license, specialties, sid)
values ('N481123', 'Dentist', 74972);
insert into DOCTOR (license, specialties, sid)
values ('Y621780', 'Orthodontist''', 37004);
insert into DOCTOR (license, specialties, sid)
values ('L022602', 'Dentist', 45674);
insert into DOCTOR (license, specialties, sid)
values ('O985935', 'Dentist', 15963);
insert into DOCTOR (license, specialties, sid)
values ('Y119633', 'Dentist', 72479);
insert into DOCTOR (license, specialties, sid)
values ('L1234', 'Orthodontist', 10001);
insert into DOCTOR (license, specialties, sid)
values ('L5678', 'Cosmetic', 10002);
insert into DOCTOR (license, specialties, sid)
values ('L9012', 'Dentist', 10003);
insert into DOCTOR (license, specialties, sid)
values ('L3456', 'Dentist', 10004);
insert into DOCTOR (license, specialties, sid)
values ('L7890', 'Cosmetic', 10005);
insert into DOCTOR (license, specialties, sid)
values ('L2345', 'Dentist', 10006);
insert into DOCTOR (license, specialties, sid)
values ('L6789', 'Dentist', 10007);
insert into DOCTOR (license, specialties, sid)
values ('L0123', 'Orthodontist', 10008);
insert into DOCTOR (license, specialties, sid)
values ('L4567', 'Orthodontist', 10009);
insert into DOCTOR (license, specialties, sid)
values ('L8901', 'Dentist', 10010);
insert into DOCTOR (license, specialties, sid)
values ('N709690', 'Cosmetic', 33532);
insert into DOCTOR (license, specialties, sid)
values ('P790838', 'Orthodontist''', 33794);
insert into DOCTOR (license, specialties, sid)
values ('A853261', 'Orthodontist''', 65613);
insert into DOCTOR (license, specialties, sid)
values ('Y368303', 'Dentist', 51524);
insert into DOCTOR (license, specialties, sid)
values ('V607115', 'Orthodontist''', 95320);
insert into DOCTOR (license, specialties, sid)
values ('R797629', 'Orthodontist''', 25578);
insert into DOCTOR (license, specialties, sid)
values ('W268703', 'Dentist', 56476);
insert into DOCTOR (license, specialties, sid)
values ('M200552', 'Orthodontist''', 61435);
insert into DOCTOR (license, specialties, sid)
values ('V770498', 'Cosmetic', 64185);
insert into DOCTOR (license, specialties, sid)
values ('K750550', 'Orthodontist''', 74091);
insert into DOCTOR (license, specialties, sid)
values ('T346515', 'Orthodontist''', 80248);
insert into DOCTOR (license, specialties, sid)
values ('E998542', 'Cosmetic', 84092);
insert into DOCTOR (license, specialties, sid)
values ('P088902', 'Cosmetic', 27192);
insert into DOCTOR (license, specialties, sid)
values ('R697730', 'Orthodontist''', 89350);
insert into DOCTOR (license, specialties, sid)
values ('W473497', 'Dentist', 68549);
insert into DOCTOR (license, specialties, sid)
values ('N608308', 'Dentist', 27715);
insert into DOCTOR (license, specialties, sid)
values ('N656165', 'Cosmetic', 11630);
insert into DOCTOR (license, specialties, sid)
values ('B766493', 'Orthodontist''', 49666);
insert into DOCTOR (license, specialties, sid)
values ('U508205', 'Cosmetic', 61546);
commit;
prompt 100 records committed...
insert into DOCTOR (license, specialties, sid)
values ('I003396', 'Orthodontist''', 98364);
insert into DOCTOR (license, specialties, sid)
values ('M292821', 'Orthodontist''', 96750);
insert into DOCTOR (license, specialties, sid)
values ('I826892', 'Cosmetic', 34609);
insert into DOCTOR (license, specialties, sid)
values ('R548123', 'Orthodontist''', 37345);
insert into DOCTOR (license, specialties, sid)
values ('R386487', 'Orthodontist''', 92442);
insert into DOCTOR (license, specialties, sid)
values ('I665838', 'Cosmetic', 21996);
insert into DOCTOR (license, specialties, sid)
values ('Y223483', 'Orthodontist''', 10013);
insert into DOCTOR (license, specialties, sid)
values ('G593751', 'Cosmetic', 55269);
insert into DOCTOR (license, specialties, sid)
values ('M562872', 'Orthodontist''', 39663);
insert into DOCTOR (license, specialties, sid)
values ('V105043', 'Cosmetic', 38296);
insert into DOCTOR (license, specialties, sid)
values ('A478640', 'Dentist', 31151);
insert into DOCTOR (license, specialties, sid)
values ('P544230', 'Dentist', 18525);
insert into DOCTOR (license, specialties, sid)
values ('I104058', 'Dentist', 26135);
insert into DOCTOR (license, specialties, sid)
values ('D943728', 'Dentist', 63761);
insert into DOCTOR (license, specialties, sid)
values ('J269639', 'Orthodontist''', 35535);
insert into DOCTOR (license, specialties, sid)
values ('N935982', 'Dentist', 55546);
insert into DOCTOR (license, specialties, sid)
values ('A562040', 'Cosmetic', 80830);
insert into DOCTOR (license, specialties, sid)
values ('G366036', 'Cosmetic', 10014);
insert into DOCTOR (license, specialties, sid)
values ('H704207', 'Cosmetic', 43915);
insert into DOCTOR (license, specialties, sid)
values ('I715511', 'Dentist', 61696);
insert into DOCTOR (license, specialties, sid)
values ('Q068252', 'Orthodontist''', 13227);
insert into DOCTOR (license, specialties, sid)
values ('P311351', 'Orthodontist''', 37415);
insert into DOCTOR (license, specialties, sid)
values ('G702062', 'Dentist', 54635);
insert into DOCTOR (license, specialties, sid)
values ('T152511', 'Dentist', 43702);
insert into DOCTOR (license, specialties, sid)
values ('L216854', 'Cosmetic', 18401);
insert into DOCTOR (license, specialties, sid)
values ('J012983', 'Dentist', 44135);
insert into DOCTOR (license, specialties, sid)
values ('X377564', 'Orthodontist''', 15357);
insert into DOCTOR (license, specialties, sid)
values ('I877544', 'Cosmetic', 57569);
insert into DOCTOR (license, specialties, sid)
values ('S363634', 'Cosmetic', 49355);
insert into DOCTOR (license, specialties, sid)
values ('C707042', 'Cosmetic', 68229);
insert into DOCTOR (license, specialties, sid)
values ('N826726', 'Orthodontist''', 28053);
insert into DOCTOR (license, specialties, sid)
values ('D643611', 'Cosmetic', 89219);
insert into DOCTOR (license, specialties, sid)
values ('M859272', 'Orthodontist''', 47507);
insert into DOCTOR (license, specialties, sid)
values ('Z477842', 'Cosmetic', 17595);
insert into DOCTOR (license, specialties, sid)
values ('W262666', 'Cosmetic', 45148);
insert into DOCTOR (license, specialties, sid)
values ('T599229', 'Orthodontist''', 38187);
insert into DOCTOR (license, specialties, sid)
values ('T364122', 'Cosmetic', 91368);
insert into DOCTOR (license, specialties, sid)
values ('V082932', 'Cosmetic', 27379);
insert into DOCTOR (license, specialties, sid)
values ('K415785', 'Dentist', 88571);
insert into DOCTOR (license, specialties, sid)
values ('O149663', 'Orthodontist''', 15383);
insert into DOCTOR (license, specialties, sid)
values ('W784098', 'Cosmetic', 35130);
insert into DOCTOR (license, specialties, sid)
values ('E033901', 'Dentist', 99681);
insert into DOCTOR (license, specialties, sid)
values ('F557731', 'Cosmetic', 15343);
insert into DOCTOR (license, specialties, sid)
values ('W057505', 'Dentist', 19365);
insert into DOCTOR (license, specialties, sid)
values ('J329052', 'Orthodontist''', 82443);
insert into DOCTOR (license, specialties, sid)
values ('P738107', 'Orthodontist''', 55149);
insert into DOCTOR (license, specialties, sid)
values ('O296894', 'Dentist', 89337);
insert into DOCTOR (license, specialties, sid)
values ('D379867', 'Dentist', 64760);
insert into DOCTOR (license, specialties, sid)
values ('D478618', 'Orthodontist''', 24656);
insert into DOCTOR (license, specialties, sid)
values ('A797001', 'Orthodontist''', 50112);
insert into DOCTOR (license, specialties, sid)
values ('O802501', 'Orthodontist''', 79859);
insert into DOCTOR (license, specialties, sid)
values ('J966809', 'Cosmetic', 81894);
insert into DOCTOR (license, specialties, sid)
values ('B927814', 'Orthodontist''', 72820);
insert into DOCTOR (license, specialties, sid)
values ('W981873', 'Cosmetic', 10016);
insert into DOCTOR (license, specialties, sid)
values ('W122816', 'Orthodontist''', 64076);
insert into DOCTOR (license, specialties, sid)
values ('U041747', 'Cosmetic', 10011);
insert into DOCTOR (license, specialties, sid)
values ('L642104', 'Orthodontist''', 10652);
insert into DOCTOR (license, specialties, sid)
values ('N133159', 'Dentist', 12082);
insert into DOCTOR (license, specialties, sid)
values ('M508774', 'Cosmetic', 63961);
insert into DOCTOR (license, specialties, sid)
values ('V995822', 'Orthodontist''', 21570);
insert into DOCTOR (license, specialties, sid)
values ('U416915', 'Orthodontist''', 39306);
insert into DOCTOR (license, specialties, sid)
values ('C347945', 'Dentist', 31947);
insert into DOCTOR (license, specialties, sid)
values ('R864927', 'Orthodontist''', 10017);
commit;
prompt 163 records loaded
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
prompt Loading INJECTION_APPOINTMENT...
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (1, to_date('06-04-2024', 'dd-mm-yyyy'), '3:15 AM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (2, to_date('20-03-2024', 'dd-mm-yyyy'), '4:52 PM', 24);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (3, to_date('08-10-2024', 'dd-mm-yyyy'), '9:25 AM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (4, to_date('28-05-2024', 'dd-mm-yyyy'), '1:48 AM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (5, to_date('19-09-2024', 'dd-mm-yyyy'), '8:45 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (6, to_date('23-02-2024', 'dd-mm-yyyy'), '4:35 AM', 5);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (7, to_date('24-05-2024', 'dd-mm-yyyy'), '10:26 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (8, to_date('12-09-2024', 'dd-mm-yyyy'), '1:27 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (9, to_date('04-10-2024', 'dd-mm-yyyy'), '8:59 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (10, to_date('18-07-2024', 'dd-mm-yyyy'), '8:37 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (11, to_date('20-08-2024', 'dd-mm-yyyy'), '4:09 AM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (12, to_date('03-10-2024', 'dd-mm-yyyy'), '10:57 PM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (13, to_date('12-03-2024', 'dd-mm-yyyy'), '3:11 PM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (14, to_date('05-07-2024', 'dd-mm-yyyy'), '12:46 AM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (15, to_date('30-11-2023', 'dd-mm-yyyy'), '8:09 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (16, to_date('27-09-2024', 'dd-mm-yyyy'), '1:19 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (17, to_date('03-08-2024', 'dd-mm-yyyy'), '9:25 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (18, to_date('16-04-2024', 'dd-mm-yyyy'), '9:11 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (19, to_date('03-06-2024', 'dd-mm-yyyy'), '3:11 AM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (20, to_date('17-09-2024', 'dd-mm-yyyy'), '11:16 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (21, to_date('21-12-2023', 'dd-mm-yyyy'), '1:43 PM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (22, to_date('03-02-2024', 'dd-mm-yyyy'), '9:09 AM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (23, to_date('26-11-2023', 'dd-mm-yyyy'), '11:37 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (24, to_date('13-01-2024', 'dd-mm-yyyy'), '12:51 PM', 0);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (25, to_date('11-10-2024', 'dd-mm-yyyy'), '6:29 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (26, to_date('29-05-2024', 'dd-mm-yyyy'), '2:44 PM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (27, to_date('29-12-2023', 'dd-mm-yyyy'), '9:30 AM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (28, to_date('20-01-2024', 'dd-mm-yyyy'), '10:22 PM', 24);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (29, to_date('16-02-2024', 'dd-mm-yyyy'), '2:16 AM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (30, to_date('23-04-2024', 'dd-mm-yyyy'), '4:32 AM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (31, to_date('01-07-2024', 'dd-mm-yyyy'), '7:19 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (32, to_date('29-06-2024', 'dd-mm-yyyy'), '9:10 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (33, to_date('26-03-2024', 'dd-mm-yyyy'), '1:01 AM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (34, to_date('09-08-2024', 'dd-mm-yyyy'), '2:30 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (35, to_date('06-01-2024', 'dd-mm-yyyy'), '11:40 PM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (36, to_date('29-07-2024', 'dd-mm-yyyy'), '9:53 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (37, to_date('25-09-2024', 'dd-mm-yyyy'), '10:01 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (38, to_date('18-10-2024', 'dd-mm-yyyy'), '4:57 AM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (39, to_date('09-05-2024', 'dd-mm-yyyy'), '8:29 PM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (40, to_date('27-09-2024', 'dd-mm-yyyy'), '1:26 AM', 9);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (41, to_date('07-09-2024', 'dd-mm-yyyy'), '5:43 PM', 9);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (42, to_date('15-06-2024', 'dd-mm-yyyy'), '9:59 AM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (43, to_date('30-04-2024', 'dd-mm-yyyy'), '7:58 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (44, to_date('08-03-2024', 'dd-mm-yyyy'), '8:39 PM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (45, to_date('14-05-2024', 'dd-mm-yyyy'), '10:47 AM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (46, to_date('14-08-2024', 'dd-mm-yyyy'), '3:30 PM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (47, to_date('22-07-2024', 'dd-mm-yyyy'), '7:11 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (48, to_date('15-12-2023', 'dd-mm-yyyy'), '12:12 PM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (49, to_date('08-10-2024', 'dd-mm-yyyy'), '4:23 AM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (50, to_date('29-02-2024', 'dd-mm-yyyy'), '6:47 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (51, to_date('18-01-2024', 'dd-mm-yyyy'), '2:19 AM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (52, to_date('01-06-2024', 'dd-mm-yyyy'), '4:08 PM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (53, to_date('17-04-2024', 'dd-mm-yyyy'), '8:37 AM', 5);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (54, to_date('15-03-2024', 'dd-mm-yyyy'), '10:49 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (55, to_date('21-08-2024', 'dd-mm-yyyy'), '2:13 PM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (56, to_date('09-02-2024', 'dd-mm-yyyy'), '6:05 AM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (57, to_date('14-09-2024', 'dd-mm-yyyy'), '10:22 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (58, to_date('19-05-2024', 'dd-mm-yyyy'), '1:17 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (59, to_date('04-10-2024', 'dd-mm-yyyy'), '2:41 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (60, to_date('18-06-2024', 'dd-mm-yyyy'), '8:56 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (61, to_date('25-01-2024', 'dd-mm-yyyy'), '9:30 AM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (62, to_date('09-07-2024', 'dd-mm-yyyy'), '3:45 PM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (63, to_date('03-03-2024', 'dd-mm-yyyy'), '11:18 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (64, to_date('30-04-2024', 'dd-mm-yyyy'), '1:54 AM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (65, to_date('07-08-2024', 'dd-mm-yyyy'), '6:29 PM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (66, to_date('23-02-2024', 'dd-mm-yyyy'), '8:01 AM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (67, to_date('28-09-2024', 'dd-mm-yyyy'), '11:48 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (68, to_date('25-06-2024', 'dd-mm-yyyy'), '2:36 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (69, to_date('10-10-2024', 'dd-mm-yyyy'), '3:52 PM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (70, to_date('30-06-2024', 'dd-mm-yyyy'), '9:09 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (71, to_date('14-03-2024', 'dd-mm-yyyy'), '11:15 AM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (72, to_date('18-04-2024', 'dd-mm-yyyy'), '2:30 PM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (73, to_date('03-08-2024', 'dd-mm-yyyy'), '4:45 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (74, to_date('28-02-2024', 'dd-mm-yyyy'), '9:00 PM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (75, to_date('31-10-2024', 'dd-mm-yyyy'), '1:15 PM', 9);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (76, to_date('19-01-2024', 'dd-mm-yyyy'), '5:30 AM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (77, to_date('27-05-2024', 'dd-mm-yyyy'), '7:45 PM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (78, to_date('08-06-2024', 'dd-mm-yyyy'), '10:00 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (79, to_date('19-09-2024', 'dd-mm-yyyy'), '3:15 PM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (80, to_date('25-03-2024', 'dd-mm-yyyy'), '1:30 AM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (81, to_date('25-01-2024', 'dd-mm-yyyy'), '9:30 AM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (82, to_date('09-07-2024', 'dd-mm-yyyy'), '3:45 PM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (83, to_date('03-03-2024', 'dd-mm-yyyy'), '11:18 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (84, to_date('30-04-2024', 'dd-mm-yyyy'), '1:54 AM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (85, to_date('07-08-2024', 'dd-mm-yyyy'), '6:29 PM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (86, to_date('23-02-2024', 'dd-mm-yyyy'), '8:01 AM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (87, to_date('28-09-2024', 'dd-mm-yyyy'), '11:48 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (88, to_date('25-06-2024', 'dd-mm-yyyy'), '2:36 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (89, to_date('10-10-2024', 'dd-mm-yyyy'), '3:52 PM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (90, to_date('30-06-2024', 'dd-mm-yyyy'), '9:09 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (91, to_date('29-06-2024', 'dd-mm-yyyy'), '5:04 PM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (92, to_date('03-08-2024', 'dd-mm-yyyy'), '4:40 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (93, to_date('14-07-2024', 'dd-mm-yyyy'), '12:57 AM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (94, to_date('16-07-2024', 'dd-mm-yyyy'), '3:39 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (95, to_date('20-10-2024', 'dd-mm-yyyy'), '6:18 PM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (96, to_date('28-11-2023', 'dd-mm-yyyy'), '11:30 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (97, to_date('14-06-2024', 'dd-mm-yyyy'), '12:54 AM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (98, to_date('24-04-2024', 'dd-mm-yyyy'), '1:41 AM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (99, to_date('19-09-2024', 'dd-mm-yyyy'), '7:34 PM', 5);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (100, to_date('03-09-2024', 'dd-mm-yyyy'), '2:03 PM', 13);
commit;
prompt 100 records committed...
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (101, to_date('22-08-2024', 'dd-mm-yyyy'), '4:25 AM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (102, to_date('03-04-2024', 'dd-mm-yyyy'), '1:56 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (103, to_date('30-09-2024', 'dd-mm-yyyy'), '1:42 AM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (104, to_date('19-06-2024', 'dd-mm-yyyy'), '7:49 AM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (105, to_date('26-07-2024', 'dd-mm-yyyy'), '11:07 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (106, to_date('30-11-2023', 'dd-mm-yyyy'), '12:45 AM', 9);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (107, to_date('25-08-2024', 'dd-mm-yyyy'), '2:13 AM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (108, to_date('04-05-2024', 'dd-mm-yyyy'), '9:14 PM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (109, to_date('10-02-2024', 'dd-mm-yyyy'), '10:56 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (110, to_date('24-07-2024', 'dd-mm-yyyy'), '2:06 PM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (111, to_date('01-07-2024', 'dd-mm-yyyy'), '1:30 PM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (112, to_date('07-10-2024', 'dd-mm-yyyy'), '12:18 AM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (113, to_date('23-08-2024', 'dd-mm-yyyy'), '1:26 PM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (114, to_date('28-10-2024', 'dd-mm-yyyy'), '8:02 PM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (115, to_date('13-06-2024', 'dd-mm-yyyy'), '2:57 PM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (116, to_date('03-08-2024', 'dd-mm-yyyy'), '4:24 PM', 9);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (117, to_date('07-11-2024', 'dd-mm-yyyy'), '2:10 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (118, to_date('16-05-2024', 'dd-mm-yyyy'), '8:28 AM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (119, to_date('21-11-2024', 'dd-mm-yyyy'), '9:14 AM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (120, to_date('01-09-2024', 'dd-mm-yyyy'), '8:45 AM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (121, to_date('06-03-2024', 'dd-mm-yyyy'), '4:41 AM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (122, to_date('11-04-2024', 'dd-mm-yyyy'), '4:36 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (123, to_date('30-06-2024', 'dd-mm-yyyy'), '6:08 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (124, to_date('29-02-2024', 'dd-mm-yyyy'), '12:21 PM', 24);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (125, to_date('18-11-2024', 'dd-mm-yyyy'), '9:07 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (126, to_date('20-04-2024', 'dd-mm-yyyy'), '4:53 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (127, to_date('27-05-2024', 'dd-mm-yyyy'), '10:31 AM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (128, to_date('29-02-2024', 'dd-mm-yyyy'), '5:30 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (129, to_date('27-01-2024', 'dd-mm-yyyy'), '8:10 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (130, to_date('09-04-2024', 'dd-mm-yyyy'), '9:56 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (131, to_date('28-01-2024', 'dd-mm-yyyy'), '2:15 PM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (132, to_date('25-09-2024', 'dd-mm-yyyy'), '7:52 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (133, to_date('25-05-2024', 'dd-mm-yyyy'), '5:36 AM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (134, to_date('23-09-2024', 'dd-mm-yyyy'), '10:10 PM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (135, to_date('04-12-2023', 'dd-mm-yyyy'), '11:43 AM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (136, to_date('25-10-2024', 'dd-mm-yyyy'), '3:35 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (137, to_date('05-12-2023', 'dd-mm-yyyy'), '7:42 PM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (138, to_date('25-04-2024', 'dd-mm-yyyy'), '11:03 PM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (139, to_date('28-06-2024', 'dd-mm-yyyy'), '7:15 PM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (140, to_date('07-05-2024', 'dd-mm-yyyy'), '8:14 PM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (141, to_date('04-06-2024', 'dd-mm-yyyy'), '8:45 AM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (142, to_date('09-01-2024', 'dd-mm-yyyy'), '11:44 AM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (143, to_date('22-06-2024', 'dd-mm-yyyy'), '5:24 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (144, to_date('05-12-2023', 'dd-mm-yyyy'), '1:41 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (145, to_date('15-02-2024', 'dd-mm-yyyy'), '2:37 PM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (146, to_date('08-05-2024', 'dd-mm-yyyy'), '4:26 PM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (147, to_date('26-08-2024', 'dd-mm-yyyy'), '3:00 PM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (148, to_date('01-02-2024', 'dd-mm-yyyy'), '6:19 AM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (149, to_date('16-06-2024', 'dd-mm-yyyy'), '6:01 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (150, to_date('18-05-2024', 'dd-mm-yyyy'), '11:33 PM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (151, to_date('19-08-2024', 'dd-mm-yyyy'), '3:31 AM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (152, to_date('21-06-2024', 'dd-mm-yyyy'), '9:00 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (153, to_date('21-08-2024', 'dd-mm-yyyy'), '3:44 PM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (154, to_date('04-07-2024', 'dd-mm-yyyy'), '5:34 AM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (155, to_date('21-07-2024', 'dd-mm-yyyy'), '7:10 PM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (156, to_date('18-08-2024', 'dd-mm-yyyy'), '8:11 AM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (157, to_date('28-08-2024', 'dd-mm-yyyy'), '1:49 PM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (158, to_date('20-06-2024', 'dd-mm-yyyy'), '1:34 AM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (159, to_date('08-07-2024', 'dd-mm-yyyy'), '1:53 AM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (160, to_date('11-02-2024', 'dd-mm-yyyy'), '8:42 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (161, to_date('11-04-2024', 'dd-mm-yyyy'), '5:49 PM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (162, to_date('23-09-2024', 'dd-mm-yyyy'), '5:51 AM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (163, to_date('06-08-2024', 'dd-mm-yyyy'), '6:23 PM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (164, to_date('02-08-2024', 'dd-mm-yyyy'), '12:39 PM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (165, to_date('12-11-2024', 'dd-mm-yyyy'), '4:43 AM', 24);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (166, to_date('25-03-2024', 'dd-mm-yyyy'), '9:23 PM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (167, to_date('19-01-2024', 'dd-mm-yyyy'), '10:02 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (168, to_date('31-12-2023', 'dd-mm-yyyy'), '3:55 AM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (169, to_date('21-11-2024', 'dd-mm-yyyy'), '11:16 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (170, to_date('24-10-2024', 'dd-mm-yyyy'), '10:00 AM', 24);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (171, to_date('09-04-2024', 'dd-mm-yyyy'), '3:00 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (172, to_date('26-12-2023', 'dd-mm-yyyy'), '1:30 AM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (173, to_date('24-12-2023', 'dd-mm-yyyy'), '1:52 PM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (174, to_date('21-09-2024', 'dd-mm-yyyy'), '5:02 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (175, to_date('25-02-2024', 'dd-mm-yyyy'), '5:37 AM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (176, to_date('19-03-2024', 'dd-mm-yyyy'), '2:38 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (177, to_date('14-03-2024', 'dd-mm-yyyy'), '11:12 PM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (178, to_date('18-11-2024', 'dd-mm-yyyy'), '10:37 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (179, to_date('11-07-2024', 'dd-mm-yyyy'), '10:19 AM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (180, to_date('09-10-2024', 'dd-mm-yyyy'), '7:37 AM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (181, to_date('31-08-2024', 'dd-mm-yyyy'), '11:38 AM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (182, to_date('23-09-2024', 'dd-mm-yyyy'), '10:58 AM', 0);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (183, to_date('18-07-2024', 'dd-mm-yyyy'), '1:53 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (184, to_date('10-12-2023', 'dd-mm-yyyy'), '4:50 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (185, to_date('20-01-2024', 'dd-mm-yyyy'), '4:34 PM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (186, to_date('10-12-2023', 'dd-mm-yyyy'), '11:54 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (187, to_date('18-05-2024', 'dd-mm-yyyy'), '10:53 PM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (188, to_date('21-12-2023', 'dd-mm-yyyy'), '3:11 AM', 24);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (189, to_date('22-08-2024', 'dd-mm-yyyy'), '8:49 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (190, to_date('28-10-2024', 'dd-mm-yyyy'), '9:45 PM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (191, to_date('19-12-2023', 'dd-mm-yyyy'), '3:34 PM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (192, to_date('20-11-2024', 'dd-mm-yyyy'), '3:09 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (193, to_date('24-07-2024', 'dd-mm-yyyy'), '11:58 PM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (194, to_date('19-10-2024', 'dd-mm-yyyy'), '4:49 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (195, to_date('25-03-2024', 'dd-mm-yyyy'), '7:02 PM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (196, to_date('11-09-2024', 'dd-mm-yyyy'), '3:18 AM', 5);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (197, to_date('11-09-2024', 'dd-mm-yyyy'), '2:54 PM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (198, to_date('12-06-2024', 'dd-mm-yyyy'), '1:39 AM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (199, to_date('13-09-2024', 'dd-mm-yyyy'), '12:30 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (200, to_date('24-05-2024', 'dd-mm-yyyy'), '11:02 AM', 18);
commit;
prompt 200 records committed...
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (201, to_date('07-02-2024', 'dd-mm-yyyy'), '7:21 PM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (202, to_date('13-12-2023', 'dd-mm-yyyy'), '4:19 AM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (203, to_date('01-08-2024', 'dd-mm-yyyy'), '3:32 AM', 0);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (204, to_date('20-12-2023', 'dd-mm-yyyy'), '11:31 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (205, to_date('23-09-2024', 'dd-mm-yyyy'), '11:01 AM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (206, to_date('27-07-2024', 'dd-mm-yyyy'), '2:05 PM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (207, to_date('30-09-2024', 'dd-mm-yyyy'), '5:52 PM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (208, to_date('29-09-2024', 'dd-mm-yyyy'), '7:49 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (209, to_date('06-08-2024', 'dd-mm-yyyy'), '2:35 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (210, to_date('05-03-2024', 'dd-mm-yyyy'), '1:44 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (211, to_date('23-06-2024', 'dd-mm-yyyy'), '9:48 PM', 0);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (212, to_date('01-09-2024', 'dd-mm-yyyy'), '7:39 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (213, to_date('18-03-2024', 'dd-mm-yyyy'), '2:34 PM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (214, to_date('15-04-2024', 'dd-mm-yyyy'), '6:22 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (215, to_date('10-10-2024', 'dd-mm-yyyy'), '4:23 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (216, to_date('23-06-2024', 'dd-mm-yyyy'), '8:59 PM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (217, to_date('29-06-2024', 'dd-mm-yyyy'), '9:25 PM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (218, to_date('29-02-2024', 'dd-mm-yyyy'), '9:19 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (219, to_date('03-11-2024', 'dd-mm-yyyy'), '2:35 AM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (220, to_date('02-04-2024', 'dd-mm-yyyy'), '8:11 AM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (221, to_date('03-07-2024', 'dd-mm-yyyy'), '1:47 PM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (222, to_date('07-03-2024', 'dd-mm-yyyy'), '9:12 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (223, to_date('02-01-2024', 'dd-mm-yyyy'), '12:38 AM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (224, to_date('27-11-2023', 'dd-mm-yyyy'), '10:59 AM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (226, to_date('27-09-2024', 'dd-mm-yyyy'), '11:27 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (227, to_date('02-04-2024', 'dd-mm-yyyy'), '7:43 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (228, to_date('23-01-2024', 'dd-mm-yyyy'), '1:46 AM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (229, to_date('22-09-2024', 'dd-mm-yyyy'), '6:05 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (230, to_date('11-12-2023', 'dd-mm-yyyy'), '12:44 AM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (231, to_date('01-04-2024', 'dd-mm-yyyy'), '5:40 AM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (232, to_date('01-03-2024', 'dd-mm-yyyy'), '1:37 PM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (233, to_date('18-08-2024', 'dd-mm-yyyy'), '12:08 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (234, to_date('15-10-2024', 'dd-mm-yyyy'), '11:17 PM', 9);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (235, to_date('10-06-2024', 'dd-mm-yyyy'), '8:01 AM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (236, to_date('21-01-2024', 'dd-mm-yyyy'), '3:00 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (237, to_date('01-12-2023', 'dd-mm-yyyy'), '8:41 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (238, to_date('13-01-2024', 'dd-mm-yyyy'), '10:39 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (239, to_date('11-12-2023', 'dd-mm-yyyy'), '11:49 PM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (240, to_date('11-02-2024', 'dd-mm-yyyy'), '9:28 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (241, to_date('24-08-2024', 'dd-mm-yyyy'), '9:31 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (242, to_date('13-06-2024', 'dd-mm-yyyy'), '7:16 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (243, to_date('11-12-2023', 'dd-mm-yyyy'), '5:11 PM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (244, to_date('27-04-2024', 'dd-mm-yyyy'), '11:19 AM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (245, to_date('26-05-2024', 'dd-mm-yyyy'), '6:33 AM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (246, to_date('11-11-2024', 'dd-mm-yyyy'), '3:49 AM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (247, to_date('08-09-2024', 'dd-mm-yyyy'), '4:12 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (248, to_date('09-07-2024', 'dd-mm-yyyy'), '7:07 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (249, to_date('13-02-2024', 'dd-mm-yyyy'), '4:20 PM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (250, to_date('29-09-2024', 'dd-mm-yyyy'), '7:12 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (251, to_date('11-02-2024', 'dd-mm-yyyy'), '10:52 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (252, to_date('10-12-2023', 'dd-mm-yyyy'), '8:56 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (253, to_date('13-02-2024', 'dd-mm-yyyy'), '11:08 PM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (254, to_date('04-11-2024', 'dd-mm-yyyy'), '11:54 AM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (255, to_date('17-03-2024', 'dd-mm-yyyy'), '4:34 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (256, to_date('06-02-2024', 'dd-mm-yyyy'), '9:41 PM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (257, to_date('02-04-2024', 'dd-mm-yyyy'), '4:39 AM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (258, to_date('11-04-2024', 'dd-mm-yyyy'), '12:49 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (259, to_date('05-10-2024', 'dd-mm-yyyy'), '12:04 AM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (260, to_date('27-11-2023', 'dd-mm-yyyy'), '8:56 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (261, to_date('05-07-2024', 'dd-mm-yyyy'), '6:11 AM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (262, to_date('28-06-2024', 'dd-mm-yyyy'), '6:24 AM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (263, to_date('30-11-2023', 'dd-mm-yyyy'), '1:24 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (264, to_date('29-09-2024', 'dd-mm-yyyy'), '6:30 AM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (265, to_date('08-05-2024', 'dd-mm-yyyy'), '10:37 AM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (266, to_date('03-02-2024', 'dd-mm-yyyy'), '2:13 PM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (267, to_date('15-09-2024', 'dd-mm-yyyy'), '7:28 PM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (268, to_date('06-03-2024', 'dd-mm-yyyy'), '12:45 PM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (269, to_date('11-11-2024', 'dd-mm-yyyy'), '9:45 PM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (270, to_date('25-12-2023', 'dd-mm-yyyy'), '4:53 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (271, to_date('08-11-2024', 'dd-mm-yyyy'), '9:41 PM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (272, to_date('28-07-2024', 'dd-mm-yyyy'), '7:30 PM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (273, to_date('08-04-2024', 'dd-mm-yyyy'), '6:48 PM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (274, to_date('17-03-2024', 'dd-mm-yyyy'), '2:39 AM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (275, to_date('23-02-2024', 'dd-mm-yyyy'), '4:00 PM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (276, to_date('29-11-2023', 'dd-mm-yyyy'), '6:49 PM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (277, to_date('15-11-2024', 'dd-mm-yyyy'), '11:47 PM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (278, to_date('02-02-2024', 'dd-mm-yyyy'), '1:06 PM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (279, to_date('21-11-2024', 'dd-mm-yyyy'), '11:48 AM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (280, to_date('12-12-2023', 'dd-mm-yyyy'), '7:11 PM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (281, to_date('10-08-2024', 'dd-mm-yyyy'), '7:42 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (282, to_date('31-07-2024', 'dd-mm-yyyy'), '12:30 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (283, to_date('29-12-2023', 'dd-mm-yyyy'), '8:07 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (284, to_date('14-07-2024', 'dd-mm-yyyy'), '1:42 AM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (285, to_date('31-03-2024', 'dd-mm-yyyy'), '9:12 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (286, to_date('01-12-2023', 'dd-mm-yyyy'), '4:20 AM', 24);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (287, to_date('26-12-2023', 'dd-mm-yyyy'), '9:11 AM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (288, to_date('02-06-2024', 'dd-mm-yyyy'), '2:06 AM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (289, to_date('25-12-2023', 'dd-mm-yyyy'), '4:10 PM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (290, to_date('21-03-2024', 'dd-mm-yyyy'), '1:16 AM', 9);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (291, to_date('25-06-2024', 'dd-mm-yyyy'), '5:56 PM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (292, to_date('17-03-2024', 'dd-mm-yyyy'), '2:35 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (293, to_date('24-11-2024', 'dd-mm-yyyy'), '6:17 PM', 24);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (294, to_date('01-12-2023', 'dd-mm-yyyy'), '2:21 AM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (295, to_date('01-04-2024', 'dd-mm-yyyy'), '8:43 PM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (296, to_date('15-02-2024', 'dd-mm-yyyy'), '1:27 PM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (297, to_date('10-09-2024', 'dd-mm-yyyy'), '8:23 AM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (298, to_date('30-06-2024', 'dd-mm-yyyy'), '7:58 PM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (299, to_date('23-12-2023', 'dd-mm-yyyy'), '11:32 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (300, to_date('04-09-2024', 'dd-mm-yyyy'), '10:24 PM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (301, to_date('29-02-2024', 'dd-mm-yyyy'), '1:19 PM', 14);
commit;
prompt 300 records committed...
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (302, to_date('20-07-2024', 'dd-mm-yyyy'), '1:46 AM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (303, to_date('08-06-2024', 'dd-mm-yyyy'), '6:23 AM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (304, to_date('16-09-2024', 'dd-mm-yyyy'), '12:57 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (305, to_date('01-09-2024', 'dd-mm-yyyy'), '9:37 PM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (306, to_date('30-04-2024', 'dd-mm-yyyy'), '8:16 PM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (307, to_date('09-04-2024', 'dd-mm-yyyy'), '12:39 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (308, to_date('15-12-2023', 'dd-mm-yyyy'), '10:19 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (309, to_date('04-09-2024', 'dd-mm-yyyy'), '5:52 PM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (310, to_date('28-05-2024', 'dd-mm-yyyy'), '1:47 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (311, to_date('02-06-2024', 'dd-mm-yyyy'), '6:26 AM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (312, to_date('23-06-2024', 'dd-mm-yyyy'), '3:39 AM', 5);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (313, to_date('01-05-2024', 'dd-mm-yyyy'), '11:46 PM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (314, to_date('28-03-2024', 'dd-mm-yyyy'), '4:09 PM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (315, to_date('26-08-2024', 'dd-mm-yyyy'), '12:20 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (316, to_date('14-04-2024', 'dd-mm-yyyy'), '8:06 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (317, to_date('22-07-2024', 'dd-mm-yyyy'), '8:38 PM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (318, to_date('25-01-2024', 'dd-mm-yyyy'), '12:07 PM', 5);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (319, to_date('20-12-2023', 'dd-mm-yyyy'), '7:39 PM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (320, to_date('02-11-2024', 'dd-mm-yyyy'), '7:35 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (321, to_date('08-12-2023', 'dd-mm-yyyy'), '2:12 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (322, to_date('02-02-2024', 'dd-mm-yyyy'), '8:05 PM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (323, to_date('11-02-2024', 'dd-mm-yyyy'), '1:39 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (324, to_date('20-10-2024', 'dd-mm-yyyy'), '4:37 AM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (325, to_date('09-10-2024', 'dd-mm-yyyy'), '4:36 AM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (326, to_date('15-10-2024', 'dd-mm-yyyy'), '8:07 PM', 5);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (327, to_date('26-10-2024', 'dd-mm-yyyy'), '7:04 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (328, to_date('10-04-2024', 'dd-mm-yyyy'), '4:03 AM', 9);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (329, to_date('23-04-2024', 'dd-mm-yyyy'), '11:19 AM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (330, to_date('17-06-2024', 'dd-mm-yyyy'), '7:48 AM', 9);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (331, to_date('28-07-2024', 'dd-mm-yyyy'), '10:24 AM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (332, to_date('13-09-2024', 'dd-mm-yyyy'), '5:06 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (333, to_date('29-01-2024', 'dd-mm-yyyy'), '6:37 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (334, to_date('16-03-2024', 'dd-mm-yyyy'), '10:19 PM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (335, to_date('12-06-2024', 'dd-mm-yyyy'), '2:58 PM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (336, to_date('23-11-2024', 'dd-mm-yyyy'), '3:12 PM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (337, to_date('01-01-2024', 'dd-mm-yyyy'), '3:31 AM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (338, to_date('09-12-2023', 'dd-mm-yyyy'), '7:09 PM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (339, to_date('24-03-2024', 'dd-mm-yyyy'), '7:30 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (340, to_date('16-09-2024', 'dd-mm-yyyy'), '6:26 PM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (341, to_date('10-12-2023', 'dd-mm-yyyy'), '3:18 PM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (342, to_date('22-11-2024', 'dd-mm-yyyy'), '10:39 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (343, to_date('31-01-2024', 'dd-mm-yyyy'), '2:41 PM', 5);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (344, to_date('16-10-2024', 'dd-mm-yyyy'), '10:42 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (345, to_date('03-01-2024', 'dd-mm-yyyy'), '10:31 AM', 2);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (346, to_date('21-08-2024', 'dd-mm-yyyy'), '6:12 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (347, to_date('23-03-2024', 'dd-mm-yyyy'), '12:06 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (348, to_date('13-03-2024', 'dd-mm-yyyy'), '2:56 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (349, to_date('27-06-2024', 'dd-mm-yyyy'), '12:46 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (350, to_date('02-12-2023', 'dd-mm-yyyy'), '3:56 PM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (351, to_date('01-05-2024', 'dd-mm-yyyy'), '8:55 AM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (352, to_date('28-01-2024', 'dd-mm-yyyy'), '4:10 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (353, to_date('01-03-2024', 'dd-mm-yyyy'), '3:57 PM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (354, to_date('18-06-2024', 'dd-mm-yyyy'), '8:11 AM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (355, to_date('10-04-2024', 'dd-mm-yyyy'), '5:28 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (356, to_date('21-03-2024', 'dd-mm-yyyy'), '11:29 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (357, to_date('02-08-2024', 'dd-mm-yyyy'), '1:00 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (358, to_date('25-10-2024', 'dd-mm-yyyy'), '3:17 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (359, to_date('26-06-2024', 'dd-mm-yyyy'), '3:34 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (360, to_date('31-07-2024', 'dd-mm-yyyy'), '4:58 AM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (361, to_date('10-10-2024', 'dd-mm-yyyy'), '7:51 AM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (362, to_date('16-09-2024', 'dd-mm-yyyy'), '11:26 PM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (363, to_date('20-04-2024', 'dd-mm-yyyy'), '3:54 AM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (364, to_date('15-12-2023', 'dd-mm-yyyy'), '6:31 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (365, to_date('14-06-2024', 'dd-mm-yyyy'), '11:37 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (366, to_date('06-12-2023', 'dd-mm-yyyy'), '10:29 PM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (367, to_date('19-05-2024', 'dd-mm-yyyy'), '7:29 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (368, to_date('20-01-2024', 'dd-mm-yyyy'), '10:24 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (369, to_date('29-10-2024', 'dd-mm-yyyy'), '11:48 AM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (370, to_date('04-06-2024', 'dd-mm-yyyy'), '2:46 AM', 20);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (371, to_date('05-02-2024', 'dd-mm-yyyy'), '9:07 AM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (372, to_date('09-03-2024', 'dd-mm-yyyy'), '5:45 AM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (373, to_date('27-09-2024', 'dd-mm-yyyy'), '5:14 AM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (374, to_date('13-11-2024', 'dd-mm-yyyy'), '8:41 AM', 14);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (375, to_date('13-04-2024', 'dd-mm-yyyy'), '5:43 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (376, to_date('28-05-2024', 'dd-mm-yyyy'), '11:29 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (377, to_date('07-08-2024', 'dd-mm-yyyy'), '8:47 PM', 16);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (378, to_date('16-01-2024', 'dd-mm-yyyy'), '12:03 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (379, to_date('05-06-2024', 'dd-mm-yyyy'), '6:38 AM', 9);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (380, to_date('26-04-2024', 'dd-mm-yyyy'), '3:18 PM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (381, to_date('10-10-2024', 'dd-mm-yyyy'), '11:54 PM', 18);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (382, to_date('07-03-2024', 'dd-mm-yyyy'), '2:41 PM', 6);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (383, to_date('26-10-2024', 'dd-mm-yyyy'), '12:21 AM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (384, to_date('09-12-2023', 'dd-mm-yyyy'), '8:35 AM', 17);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (385, to_date('19-07-2024', 'dd-mm-yyyy'), '6:18 PM', 1);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (386, to_date('01-07-2024', 'dd-mm-yyyy'), '2:09 AM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (387, to_date('22-06-2024', 'dd-mm-yyyy'), '12:29 AM', 19);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (388, to_date('22-07-2024', 'dd-mm-yyyy'), '2:14 AM', 7);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (389, to_date('13-01-2024', 'dd-mm-yyyy'), '4:30 PM', 10);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (390, to_date('24-01-2024', 'dd-mm-yyyy'), '11:15 AM', 21);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (391, to_date('26-03-2024', 'dd-mm-yyyy'), '2:46 AM', 15);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (392, to_date('03-10-2024', 'dd-mm-yyyy'), '12:39 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (393, to_date('17-03-2024', 'dd-mm-yyyy'), '2:46 AM', 4);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (394, to_date('05-05-2024', 'dd-mm-yyyy'), '4:34 PM', 8);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (395, to_date('30-06-2024', 'dd-mm-yyyy'), '10:53 PM', 23);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (396, to_date('24-10-2024', 'dd-mm-yyyy'), '10:36 PM', 22);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (397, to_date('26-08-2024', 'dd-mm-yyyy'), '1:55 AM', 13);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (398, to_date('05-10-2024', 'dd-mm-yyyy'), '2:45 AM', 12);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (399, to_date('14-12-2023', 'dd-mm-yyyy'), '6:32 AM', 11);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (400, to_date('25-05-2024', 'dd-mm-yyyy'), '12:48 PM', 3);
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (401, to_date('27-11-2023', 'dd-mm-yyyy'), '10:35', 105);
commit;
prompt 400 records committed...
insert into INJECTION_APPOINTMENT (appointment_id, app_date, hour, room)
values (402, to_date('06-07-2023', 'dd-mm-yyyy'), '10:35', 109);
commit;
prompt 401 records loaded
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
prompt Loading MATERIAL...
insert into MATERIAL (mid, mname, amount)
values (21355, 'Anestethic Yvwy', 102);
insert into MATERIAL (mid, mname, amount)
values (75523, 'Antibiotic Uvna', 51);
insert into MATERIAL (mid, mname, amount)
values (36647, 'Ointment Xmaudd', 196);
insert into MATERIAL (mid, mname, amount)
values (82577, 'Ointment Fcvics', 61);
insert into MATERIAL (mid, mname, amount)
values (44524, 'Ointment Rwbpyv', 183);
insert into MATERIAL (mid, mname, amount)
values (57368, 'Antibiotic Qbzk', 8);
insert into MATERIAL (mid, mname, amount)
values (83128, 'Septanest Iyovq', 164);
insert into MATERIAL (mid, mname, amount)
values (66227, 'Antibiotic Ipls', 184);
insert into MATERIAL (mid, mname, amount)
values (57861, 'Anestethic Atyu', 114);
insert into MATERIAL (mid, mname, amount)
values (34263, 'Anestethic Kjhd', 132);
insert into MATERIAL (mid, mname, amount)
values (52117, 'Antibiotic Earz', 94);
insert into MATERIAL (mid, mname, amount)
values (62511, 'Anestethic Lpxh', 192);
insert into MATERIAL (mid, mname, amount)
values (47254, 'Ointment Wrrpma', 226);
insert into MATERIAL (mid, mname, amount)
values (58322, 'Septanest Lmxzg', 147);
insert into MATERIAL (mid, mname, amount)
values (22956, 'Pills Qzlokv', 235);
insert into MATERIAL (mid, mname, amount)
values (18523, 'Ointment Xjygdr', 74);
insert into MATERIAL (mid, mname, amount)
values (51181, 'Anestethic Jazq', 33);
insert into MATERIAL (mid, mname, amount)
values (32666, 'Pills Irozgz', 184);
insert into MATERIAL (mid, mname, amount)
values (25813, 'Anestethic Kkfv', 221);
insert into MATERIAL (mid, mname, amount)
values (89432, 'Ointment Qenkyr', 101);
insert into MATERIAL (mid, mname, amount)
values (49631, 'Ointment Ndfbim', 55);
insert into MATERIAL (mid, mname, amount)
values (26412, 'Ointment Xqznvn', 201);
insert into MATERIAL (mid, mname, amount)
values (34865, 'Antibiotic Tdtw', 142);
insert into MATERIAL (mid, mname, amount)
values (24124, 'Pills Zjorvz', 3);
insert into MATERIAL (mid, mname, amount)
values (29411, 'Anestethic Wlnp', 29);
insert into MATERIAL (mid, mname, amount)
values (77646, 'Ointment Omrdjs', 231);
insert into MATERIAL (mid, mname, amount)
values (82665, 'Ointment Ovwqjm', 128);
insert into MATERIAL (mid, mname, amount)
values (81646, 'Antibiotic Pdls', 106);
insert into MATERIAL (mid, mname, amount)
values (54227, 'Ointment Dxmfcx', 107);
insert into MATERIAL (mid, mname, amount)
values (92714, 'Anestethic Gnvb', 7);
insert into MATERIAL (mid, mname, amount)
values (71723, 'Pills Klfnnf', 238);
insert into MATERIAL (mid, mname, amount)
values (54815, 'Anestethic Tqyt', 21);
insert into MATERIAL (mid, mname, amount)
values (88634, 'Pills Svvbwp', 18);
insert into MATERIAL (mid, mname, amount)
values (79344, 'Pills Mcucxa', 214);
insert into MATERIAL (mid, mname, amount)
values (42346, 'Antibiotic Mvyt', 150);
insert into MATERIAL (mid, mname, amount)
values (68343, 'Pills Byqoln', 68);
insert into MATERIAL (mid, mname, amount)
values (56126, 'Ointment Avboqi', 194);
insert into MATERIAL (mid, mname, amount)
values (53235, 'Anestethic Dlpo', 209);
insert into MATERIAL (mid, mname, amount)
values (57995, 'Anestethic Djcu', 220);
insert into MATERIAL (mid, mname, amount)
values (68496, 'Ointment Cosfiw', 144);
insert into MATERIAL (mid, mname, amount)
values (88294, 'Anestethic Xvyc', 241);
insert into MATERIAL (mid, mname, amount)
values (19246, 'Pills Qxsbfw', 84);
insert into MATERIAL (mid, mname, amount)
values (42668, 'Ointment Juyoms', 22);
insert into MATERIAL (mid, mname, amount)
values (51773, 'Anestethic Anju', 111);
insert into MATERIAL (mid, mname, amount)
values (83147, 'Pills Rgliei', 109);
insert into MATERIAL (mid, mname, amount)
values (29336, 'Septanest Iaaqm', 23);
insert into MATERIAL (mid, mname, amount)
values (18298, 'Septanest Blwpf', 52);
insert into MATERIAL (mid, mname, amount)
values (89394, 'Ointment Yakkre', 16);
insert into MATERIAL (mid, mname, amount)
values (78819, 'Antibiotic Axno', 221);
insert into MATERIAL (mid, mname, amount)
values (55438, 'Anestethic Kvzn', 214);
insert into MATERIAL (mid, mname, amount)
values (46422, 'Ointment Khmtdj', 99);
insert into MATERIAL (mid, mname, amount)
values (42395, 'Ointment Glnidn', 106);
insert into MATERIAL (mid, mname, amount)
values (59978, 'Ointment Beyglb', 58);
insert into MATERIAL (mid, mname, amount)
values (36313, 'Pills Vorqjq', 148);
insert into MATERIAL (mid, mname, amount)
values (48555, 'Anestethic Oycp', 88);
insert into MATERIAL (mid, mname, amount)
values (54715, 'Septanest Epclm', 84);
insert into MATERIAL (mid, mname, amount)
values (44141, 'Septanest Njuqc', 48);
insert into MATERIAL (mid, mname, amount)
values (27132, 'Pills Pfgykb', 180);
insert into MATERIAL (mid, mname, amount)
values (47428, 'Ointment Jdipcn', 12);
insert into MATERIAL (mid, mname, amount)
values (27995, 'Septanest Cjigm', 167);
insert into MATERIAL (mid, mname, amount)
values (82918, 'Anestethic Rpll', 173);
insert into MATERIAL (mid, mname, amount)
values (56184, 'Septanest Rpgcz', 62);
insert into MATERIAL (mid, mname, amount)
values (35844, 'Pills Rtwfzs', 147);
insert into MATERIAL (mid, mname, amount)
values (77986, 'Pills Demlia', 44);
insert into MATERIAL (mid, mname, amount)
values (49367, 'Pills Zigtyc', 239);
insert into MATERIAL (mid, mname, amount)
values (79534, 'Septanest Lomwy', 198);
insert into MATERIAL (mid, mname, amount)
values (49899, 'Anestethic Wwxj', 86);
insert into MATERIAL (mid, mname, amount)
values (97659, 'Septanest Zrxxf', 161);
insert into MATERIAL (mid, mname, amount)
values (11871, 'Antibiotic Nuel', 102);
insert into MATERIAL (mid, mname, amount)
values (56868, 'Septanest Ktypa', 211);
insert into MATERIAL (mid, mname, amount)
values (14964, 'Anestethic Myez', 50);
insert into MATERIAL (mid, mname, amount)
values (83983, 'Antibiotic Pcod', 47);
insert into MATERIAL (mid, mname, amount)
values (27259, 'Pills Dddlcb', 182);
insert into MATERIAL (mid, mname, amount)
values (88489, 'Septanest Kajjb', 192);
insert into MATERIAL (mid, mname, amount)
values (22944, 'Pills Svxahc', 162);
insert into MATERIAL (mid, mname, amount)
values (48298, 'Antibiotic Qwdn', 243);
insert into MATERIAL (mid, mname, amount)
values (33518, 'Septanest Oytrx', 172);
insert into MATERIAL (mid, mname, amount)
values (48693, 'Anestethic Tdto', 92);
insert into MATERIAL (mid, mname, amount)
values (92543, 'Pills Xbaqsj', 97);
insert into MATERIAL (mid, mname, amount)
values (28379, 'Anestethic Mbuw', 225);
insert into MATERIAL (mid, mname, amount)
values (97217, 'Pills Sfqmln', 153);
insert into MATERIAL (mid, mname, amount)
values (86223, 'Pills Ayvsog', 11);
insert into MATERIAL (mid, mname, amount)
values (53212, 'Septanest Qyqnt', 120);
insert into MATERIAL (mid, mname, amount)
values (36876, 'Antibiotic Oqex', 146);
insert into MATERIAL (mid, mname, amount)
values (25811, 'Antibiotic Kjsc', 141);
insert into MATERIAL (mid, mname, amount)
values (93566, 'Ointment Hsgzcb', 217);
insert into MATERIAL (mid, mname, amount)
values (44261, 'Ointment Bmotwx', 10);
insert into MATERIAL (mid, mname, amount)
values (64442, 'Ointment Wabyuf', 179);
insert into MATERIAL (mid, mname, amount)
values (26441, 'Anestethic Bqcr', 166);
insert into MATERIAL (mid, mname, amount)
values (55764, 'Ointment Aakmfl', 25);
insert into MATERIAL (mid, mname, amount)
values (44662, 'Ointment Itansw', 102);
insert into MATERIAL (mid, mname, amount)
values (83212, 'Pills Gxqwrt', 243);
insert into MATERIAL (mid, mname, amount)
values (56794, 'Ointment Qjgryy', 17);
insert into MATERIAL (mid, mname, amount)
values (51857, 'Anestethic Fhqu', 231);
insert into MATERIAL (mid, mname, amount)
values (18197, 'Anestethic Kcmt', 69);
insert into MATERIAL (mid, mname, amount)
values (76159, 'Anestethic Uuwy', 235);
insert into MATERIAL (mid, mname, amount)
values (22461, 'Septanest Qjwge', 143);
insert into MATERIAL (mid, mname, amount)
values (71339, 'Ointment Ggyvqx', 126);
insert into MATERIAL (mid, mname, amount)
values (59486, 'Pills Wjrfbr', 195);
insert into MATERIAL (mid, mname, amount)
values (74877, 'Ointment Cmcmhp', 120);
commit;
prompt 100 records committed...
insert into MATERIAL (mid, mname, amount)
values (89574, 'Pills Rmiyre', 210);
insert into MATERIAL (mid, mname, amount)
values (31773, 'Septanest Hqvbn', 156);
insert into MATERIAL (mid, mname, amount)
values (72235, 'Septanest Tugsg', 206);
insert into MATERIAL (mid, mname, amount)
values (41858, 'Anestethic Qlly', 216);
insert into MATERIAL (mid, mname, amount)
values (24167, 'Pills Indtmy', 174);
insert into MATERIAL (mid, mname, amount)
values (52423, 'Pills Wtfbjj', 109);
insert into MATERIAL (mid, mname, amount)
values (44888, 'Antibiotic Itmt', 60);
insert into MATERIAL (mid, mname, amount)
values (29698, 'Septanest Lwjaw', 171);
insert into MATERIAL (mid, mname, amount)
values (78965, 'Pills Dmbycy', 14);
insert into MATERIAL (mid, mname, amount)
values (13198, 'Antibiotic Nyte', 42);
insert into MATERIAL (mid, mname, amount)
values (99962, 'Septanest Gxsre', 53);
insert into MATERIAL (mid, mname, amount)
values (67115, 'Anestethic Sqbm', 228);
insert into MATERIAL (mid, mname, amount)
values (92858, 'Pills Najkrx', 93);
insert into MATERIAL (mid, mname, amount)
values (68849, 'Septanest Nnlua', 196);
insert into MATERIAL (mid, mname, amount)
values (56873, 'Septanest Uqhjh', 19);
insert into MATERIAL (mid, mname, amount)
values (27386, 'Anestethic Tjjz', 204);
insert into MATERIAL (mid, mname, amount)
values (46679, 'Ointment Daiqef', 167);
insert into MATERIAL (mid, mname, amount)
values (44138, 'Anestethic Jqjq', 239);
insert into MATERIAL (mid, mname, amount)
values (49484, 'Antibiotic Sjbh', 191);
insert into MATERIAL (mid, mname, amount)
values (93137, 'Ointment Zqedwm', 161);
insert into MATERIAL (mid, mname, amount)
values (36133, 'Ointment Wcsipo', 143);
insert into MATERIAL (mid, mname, amount)
values (63236, 'Ointment Oujdht', 202);
insert into MATERIAL (mid, mname, amount)
values (15958, 'Anestethic Naha', 144);
insert into MATERIAL (mid, mname, amount)
values (79737, 'Anestethic Uogo', 60);
insert into MATERIAL (mid, mname, amount)
values (29122, 'Pills Fixbcp', 230);
insert into MATERIAL (mid, mname, amount)
values (75629, 'Pills Qnfrsr', 80);
insert into MATERIAL (mid, mname, amount)
values (63414, 'Septanest Lxgnf', 101);
insert into MATERIAL (mid, mname, amount)
values (39851, 'Septanest Vbald', 8);
insert into MATERIAL (mid, mname, amount)
values (86561, 'Antibiotic Hqdb', 206);
insert into MATERIAL (mid, mname, amount)
values (97875, 'Anestethic Khqg', 93);
insert into MATERIAL (mid, mname, amount)
values (24115, 'Antibiotic Wedk', 249);
insert into MATERIAL (mid, mname, amount)
values (25752, 'Anestethic Vhnh', 7);
insert into MATERIAL (mid, mname, amount)
values (64219, 'Pills Lftxqe', 60);
insert into MATERIAL (mid, mname, amount)
values (74929, 'Anestethic Mdjz', 190);
insert into MATERIAL (mid, mname, amount)
values (64317, 'Antibiotic Ejkf', 72);
insert into MATERIAL (mid, mname, amount)
values (63768, 'Anestethic Ruxu', 199);
insert into MATERIAL (mid, mname, amount)
values (24534, 'Septanest Efnsl', 128);
insert into MATERIAL (mid, mname, amount)
values (12999, 'Anestethic Tifg', 181);
insert into MATERIAL (mid, mname, amount)
values (41133, 'Septanest Ugxyy', 82);
insert into MATERIAL (mid, mname, amount)
values (98796, 'Ointment Dighqg', 138);
insert into MATERIAL (mid, mname, amount)
values (59841, 'Anestethic Uxou', 96);
insert into MATERIAL (mid, mname, amount)
values (32832, 'Antibiotic Toit', 191);
insert into MATERIAL (mid, mname, amount)
values (86758, 'Antibiotic Idwa', 59);
insert into MATERIAL (mid, mname, amount)
values (83186, 'Pills Ajrfks', 199);
insert into MATERIAL (mid, mname, amount)
values (84215, 'Antibiotic Bkfr', 107);
insert into MATERIAL (mid, mname, amount)
values (94698, 'Pills Etvpbc', 211);
insert into MATERIAL (mid, mname, amount)
values (63597, 'Pills Mlavlz', 226);
insert into MATERIAL (mid, mname, amount)
values (49529, 'Anestethic Cgji', 46);
insert into MATERIAL (mid, mname, amount)
values (89721, 'Anestethic Abxx', 233);
insert into MATERIAL (mid, mname, amount)
values (27219, 'Septanest Ajcyl', 99);
insert into MATERIAL (mid, mname, amount)
values (46665, 'Septanest Vphes', 243);
insert into MATERIAL (mid, mname, amount)
values (71862, 'Pills Ffhwfs', 125);
insert into MATERIAL (mid, mname, amount)
values (97128, 'Ointment Lwzyui', 167);
insert into MATERIAL (mid, mname, amount)
values (25522, 'Ointment Orvfil', 200);
insert into MATERIAL (mid, mname, amount)
values (76774, 'Pills Wtatpx', 3);
insert into MATERIAL (mid, mname, amount)
values (15869, 'Antibiotic Nvgj', 70);
insert into MATERIAL (mid, mname, amount)
values (23116, 'Ointment Yczfth', 56);
insert into MATERIAL (mid, mname, amount)
values (23628, 'Antibiotic Ynii', 50);
insert into MATERIAL (mid, mname, amount)
values (38771, 'Ointment Nyogrk', 123);
insert into MATERIAL (mid, mname, amount)
values (91329, 'Ointment Bzbycw', 207);
insert into MATERIAL (mid, mname, amount)
values (15988, 'Anestethic Qlka', 9);
insert into MATERIAL (mid, mname, amount)
values (11127, 'Anestethic Eazf', 211);
insert into MATERIAL (mid, mname, amount)
values (53354, 'Antibiotic Taxj', 168);
insert into MATERIAL (mid, mname, amount)
values (68732, 'Antibiotic Abud', 184);
insert into MATERIAL (mid, mname, amount)
values (46333, 'Pills Qtzqne', 212);
insert into MATERIAL (mid, mname, amount)
values (36935, 'Antibiotic Mtho', 116);
insert into MATERIAL (mid, mname, amount)
values (75611, 'Antibiotic Ccqn', 14);
insert into MATERIAL (mid, mname, amount)
values (15484, 'Pills Kwtxwh', 133);
insert into MATERIAL (mid, mname, amount)
values (13657, 'Septanest Ndher', 193);
insert into MATERIAL (mid, mname, amount)
values (26927, 'Septanest Dkthy', 163);
insert into MATERIAL (mid, mname, amount)
values (36778, 'Ointment Yttrch', 46);
insert into MATERIAL (mid, mname, amount)
values (86938, 'Pills Ugdnqz', 243);
insert into MATERIAL (mid, mname, amount)
values (46122, 'Septanest Ybrhx', 238);
insert into MATERIAL (mid, mname, amount)
values (97441, 'Septanest Owlmu', 211);
insert into MATERIAL (mid, mname, amount)
values (68248, 'Septanest Eavhj', 212);
insert into MATERIAL (mid, mname, amount)
values (34377, 'Septanest Ngdzh', 60);
insert into MATERIAL (mid, mname, amount)
values (16475, 'Pills Onglod', 61);
insert into MATERIAL (mid, mname, amount)
values (26499, 'Anestethic Hcdn', 116);
insert into MATERIAL (mid, mname, amount)
values (48388, 'Ointment Wcvqrw', 224);
insert into MATERIAL (mid, mname, amount)
values (93786, 'Anestethic Eapy', 178);
insert into MATERIAL (mid, mname, amount)
values (86698, 'Antibiotic', 226);
insert into MATERIAL (mid, mname, amount)
values (14726, 'Thermometers', 37);
insert into MATERIAL (mid, mname, amount)
values (72115, 'Disinfectant', 59);
insert into MATERIAL (mid, mname, amount)
values (12570, 'Septanest', 83);
insert into MATERIAL (mid, mname, amount)
values (11654, 'Cotton Swabs', 120);
insert into MATERIAL (mid, mname, amount)
values (24208, 'Bandages', 136);
insert into MATERIAL (mid, mname, amount)
values (61185, 'Gauze', 167);
insert into MATERIAL (mid, mname, amount)
values (14470, 'Pills', 168);
insert into MATERIAL (mid, mname, amount)
values (70154, 'Gloves', 54);
insert into MATERIAL (mid, mname, amount)
values (99078, 'Anesthetic', 190);
insert into MATERIAL (mid, mname, amount)
values (73385, 'Syringes', 136);
insert into MATERIAL (mid, mname, amount)
values (16596, 'Pills', 69);
insert into MATERIAL (mid, mname, amount)
values (93815, 'Anestethic Ukof', 117);
insert into MATERIAL (mid, mname, amount)
values (47358, 'Ointment Ikjyfy', 176);
insert into MATERIAL (mid, mname, amount)
values (27189, 'Antibiotic Nzsg', 210);
insert into MATERIAL (mid, mname, amount)
values (53715, 'Septanest Llses', 222);
insert into MATERIAL (mid, mname, amount)
values (28735, 'Antibiotic Yidl', 99);
insert into MATERIAL (mid, mname, amount)
values (97524, 'Septanest Zbnsv', 118);
insert into MATERIAL (mid, mname, amount)
values (92666, 'Antibiotic Hyru', 196);
insert into MATERIAL (mid, mname, amount)
values (64876, 'Antibiotic Ximn', 140);
commit;
prompt 200 records committed...
insert into MATERIAL (mid, mname, amount)
values (68545, 'Ointment Jpppkn', 207);
insert into MATERIAL (mid, mname, amount)
values (38529, 'Septanest Fluxb', 244);
insert into MATERIAL (mid, mname, amount)
values (81162, 'Ointment Uutppo', 63);
insert into MATERIAL (mid, mname, amount)
values (53257, 'Antibiotic Nycj', 4);
insert into MATERIAL (mid, mname, amount)
values (14131, 'Anestethic Qenv', 136);
insert into MATERIAL (mid, mname, amount)
values (93643, 'Anestethic Pqte', 98);
insert into MATERIAL (mid, mname, amount)
values (61271, 'Ointment Udfwoh', 41);
insert into MATERIAL (mid, mname, amount)
values (72479, 'Septanest Skzqm', 216);
insert into MATERIAL (mid, mname, amount)
values (32523, 'Pills Ysoxio', 248);
insert into MATERIAL (mid, mname, amount)
values (19776, 'Septanest Smxna', 59);
insert into MATERIAL (mid, mname, amount)
values (11997, 'Ointment Klsbvd', 88);
insert into MATERIAL (mid, mname, amount)
values (25633, 'Antibiotic Rvih', 90);
insert into MATERIAL (mid, mname, amount)
values (53999, 'Anestethic Qrti', 221);
insert into MATERIAL (mid, mname, amount)
values (61951, 'Septanest Kfvyg', 213);
insert into MATERIAL (mid, mname, amount)
values (81856, 'Ointment Qgwjjk', 7);
insert into MATERIAL (mid, mname, amount)
values (25392, 'Antibiotic Errn', 56);
insert into MATERIAL (mid, mname, amount)
values (11752, 'Septanest Gbfio', 142);
insert into MATERIAL (mid, mname, amount)
values (42637, 'Ointment Ppjadm', 153);
insert into MATERIAL (mid, mname, amount)
values (84617, 'Anestethic Prlj', 114);
insert into MATERIAL (mid, mname, amount)
values (43963, 'Pills Ifdohk', 118);
insert into MATERIAL (mid, mname, amount)
values (13655, 'Ointment Wjaaax', 89);
insert into MATERIAL (mid, mname, amount)
values (76277, 'Anestethic Vlyd', 169);
insert into MATERIAL (mid, mname, amount)
values (39168, 'Septanest Bfdcs', 236);
insert into MATERIAL (mid, mname, amount)
values (61695, 'Antibiotic Ufks', 50);
insert into MATERIAL (mid, mname, amount)
values (62838, 'Septanest Lzxau', 137);
insert into MATERIAL (mid, mname, amount)
values (96421, 'Anestethic Prca', 104);
insert into MATERIAL (mid, mname, amount)
values (75288, 'Ointment Irdnmr', 103);
insert into MATERIAL (mid, mname, amount)
values (13682, 'Anestethic Rgap', 144);
insert into MATERIAL (mid, mname, amount)
values (17776, 'Ointment Ddoald', 299);
insert into MATERIAL (mid, mname, amount)
values (66362, 'Ointment Tqyybg', 228);
insert into MATERIAL (mid, mname, amount)
values (49366, 'Antibiotic Ariz', 223);
insert into MATERIAL (mid, mname, amount)
values (84832, 'Pills Oynjzt', 127);
insert into MATERIAL (mid, mname, amount)
values (46698, 'Ointment Rogvzp', 113);
insert into MATERIAL (mid, mname, amount)
values (16683, 'Antibiotic Myuj', 12);
insert into MATERIAL (mid, mname, amount)
values (69235, 'Pills Hrzssu', 44);
insert into MATERIAL (mid, mname, amount)
values (51618, 'Septanest Vjaff', 186);
insert into MATERIAL (mid, mname, amount)
values (59168, 'Septanest Fmynx', 20);
insert into MATERIAL (mid, mname, amount)
values (15228, 'Antibiotic Qchd', 38);
insert into MATERIAL (mid, mname, amount)
values (14244, 'Ointment Btalqi', 98);
insert into MATERIAL (mid, mname, amount)
values (19857, 'Ointment Cfhsnu', 92);
insert into MATERIAL (mid, mname, amount)
values (22693, 'Septanest Xulkc', 195);
insert into MATERIAL (mid, mname, amount)
values (11844, 'Septanest Wvlrm', 59);
insert into MATERIAL (mid, mname, amount)
values (71452, 'Anestethic Wuyn', 234);
insert into MATERIAL (mid, mname, amount)
values (29554, 'Pills Hgmbsc', 230);
insert into MATERIAL (mid, mname, amount)
values (75587, 'Anestethic Fpih', 85);
insert into MATERIAL (mid, mname, amount)
values (14175, 'Septanest Huweg', 47);
insert into MATERIAL (mid, mname, amount)
values (12589, 'Pills Zebfva', 35);
insert into MATERIAL (mid, mname, amount)
values (95511, 'Pills Xojfck', 166);
insert into MATERIAL (mid, mname, amount)
values (12228, 'Antibiotic Gzer', 118);
insert into MATERIAL (mid, mname, amount)
values (58887, 'Ointment Quolsq', 146);
insert into MATERIAL (mid, mname, amount)
values (77556, 'Ointment Awggtn', 155);
insert into MATERIAL (mid, mname, amount)
values (69313, 'Pills Kjsmjo', 176);
insert into MATERIAL (mid, mname, amount)
values (99141, 'Pills Ndvoto', 59);
insert into MATERIAL (mid, mname, amount)
values (25128, 'Anestethic Wqwq', 232);
insert into MATERIAL (mid, mname, amount)
values (87588, 'Ointment Radkii', 61);
insert into MATERIAL (mid, mname, amount)
values (97963, 'Anestethic Unxi', 228);
insert into MATERIAL (mid, mname, amount)
values (59666, 'Septanest Dqumg', 122);
insert into MATERIAL (mid, mname, amount)
values (28318, 'Pills Lahrwv', 107);
insert into MATERIAL (mid, mname, amount)
values (64683, 'Anestethic Ngtq', 30);
insert into MATERIAL (mid, mname, amount)
values (94596, 'Ointment Pybbbs', 247);
insert into MATERIAL (mid, mname, amount)
values (22498, 'Anestethic Iabe', 70);
insert into MATERIAL (mid, mname, amount)
values (67121, 'Anestethic Zowp', 175);
insert into MATERIAL (mid, mname, amount)
values (29225, 'Antibiotic Ygyz', 4);
insert into MATERIAL (mid, mname, amount)
values (67598, 'Antibiotic Ckrp', 7);
insert into MATERIAL (mid, mname, amount)
values (61582, 'Pills Ulntgh', 100);
insert into MATERIAL (mid, mname, amount)
values (82444, 'Anestethic Snga', 250);
insert into MATERIAL (mid, mname, amount)
values (53126, 'Antibiotic Bhhc', 37);
insert into MATERIAL (mid, mname, amount)
values (63363, 'Antibiotic Psji', 100);
insert into MATERIAL (mid, mname, amount)
values (33316, 'Septanest Wvlys', 160);
insert into MATERIAL (mid, mname, amount)
values (63512, 'Septanest Nwrfp', 201);
insert into MATERIAL (mid, mname, amount)
values (19614, 'Anestethic Obvi', 76);
insert into MATERIAL (mid, mname, amount)
values (42862, 'Pills Sispeb', 232);
insert into MATERIAL (mid, mname, amount)
values (69521, 'Septanest Jvwsc', 24);
insert into MATERIAL (mid, mname, amount)
values (38921, 'Ointment Wbhppj', 229);
insert into MATERIAL (mid, mname, amount)
values (51927, 'Ointment Ikeukb', 149);
insert into MATERIAL (mid, mname, amount)
values (87956, 'Anestethic Dcrv', 133);
insert into MATERIAL (mid, mname, amount)
values (29738, 'Anestethic Vhvm', 150);
insert into MATERIAL (mid, mname, amount)
values (47597, 'Pills Ldyzcn', 99);
insert into MATERIAL (mid, mname, amount)
values (37596, 'Pills Zizmeu', 158);
insert into MATERIAL (mid, mname, amount)
values (97792, 'Pills Qzebbm', 232);
insert into MATERIAL (mid, mname, amount)
values (16331, 'Antibiotic Qnrr', 173);
insert into MATERIAL (mid, mname, amount)
values (88277, 'Anestethic Zfxg', 242);
insert into MATERIAL (mid, mname, amount)
values (41729, 'Pills Pmstzd', 119);
insert into MATERIAL (mid, mname, amount)
values (88563, 'Septanest Vvfwi', 3);
insert into MATERIAL (mid, mname, amount)
values (57612, 'Pills Tdfisa', 19);
insert into MATERIAL (mid, mname, amount)
values (92643, 'Pills Vbitqc', 179);
insert into MATERIAL (mid, mname, amount)
values (12353, 'Anestethic Vfmi', 212);
insert into MATERIAL (mid, mname, amount)
values (81575, 'Septanest Zzmgc', 243);
insert into MATERIAL (mid, mname, amount)
values (83229, 'Septanest Iquys', 88);
insert into MATERIAL (mid, mname, amount)
values (87251, 'Septanest Mktnj', 59);
insert into MATERIAL (mid, mname, amount)
values (17368, 'Antibiotic Qqui', 110);
insert into MATERIAL (mid, mname, amount)
values (71887, 'Antibiotic Llvm', 93);
insert into MATERIAL (mid, mname, amount)
values (61422, 'Antibiotic Vige', 52);
insert into MATERIAL (mid, mname, amount)
values (96936, 'Septanest Ujfze', 143);
insert into MATERIAL (mid, mname, amount)
values (98517, 'Antibiotic Kkkh', 43);
insert into MATERIAL (mid, mname, amount)
values (57726, 'Anestethic Yqux', 160);
insert into MATERIAL (mid, mname, amount)
values (78237, 'Septanest Uziez', 40);
insert into MATERIAL (mid, mname, amount)
values (64741, 'Pills Mfmyjw', 127);
insert into MATERIAL (mid, mname, amount)
values (86571, 'Antibiotic Larc', 210);
insert into MATERIAL (mid, mname, amount)
values (51142, 'Anestethic Qbnk', 187);
commit;
prompt 300 records committed...
insert into MATERIAL (mid, mname, amount)
values (13449, 'Ointment Fmctqu', 249);
insert into MATERIAL (mid, mname, amount)
values (96364, 'Anestethic Xsgu', 45);
insert into MATERIAL (mid, mname, amount)
values (74315, 'Pills Qjxgbd', 199);
insert into MATERIAL (mid, mname, amount)
values (32992, 'Septanest Ljztg', 5);
insert into MATERIAL (mid, mname, amount)
values (83936, 'Antibiotic Myjy', 5);
insert into MATERIAL (mid, mname, amount)
values (44631, 'Ointment Fpbfkd', 250);
insert into MATERIAL (mid, mname, amount)
values (91849, 'Septanest Oenyr', 90);
insert into MATERIAL (mid, mname, amount)
values (63651, 'Anestethic Numh', 89);
insert into MATERIAL (mid, mname, amount)
values (53673, 'Septanest Vugtw', 203);
insert into MATERIAL (mid, mname, amount)
values (95165, 'Septanest Ttoke', 78);
insert into MATERIAL (mid, mname, amount)
values (54674, 'Septanest Ogvbn', 13);
insert into MATERIAL (mid, mname, amount)
values (29138, 'Antibiotic Vsmt', 81);
insert into MATERIAL (mid, mname, amount)
values (56631, 'Ointment Aziqll', 169);
insert into MATERIAL (mid, mname, amount)
values (15199, 'Antibiotic Wcgq', 104);
insert into MATERIAL (mid, mname, amount)
values (94219, 'Anestethic Qrjk', 51);
insert into MATERIAL (mid, mname, amount)
values (41311, 'Anestethic Gxjv', 206);
insert into MATERIAL (mid, mname, amount)
values (68746, 'Anestethic Bbge', 47);
insert into MATERIAL (mid, mname, amount)
values (11323, 'Antibiotic Yeek', 182);
insert into MATERIAL (mid, mname, amount)
values (34646, 'Ointment Drlrcp', 232);
insert into MATERIAL (mid, mname, amount)
values (75214, 'Pills Axbsrh', 97);
insert into MATERIAL (mid, mname, amount)
values (62615, 'Antibiotic Jkxt', 137);
insert into MATERIAL (mid, mname, amount)
values (22792, 'Pills Qhjijs', 74);
insert into MATERIAL (mid, mname, amount)
values (46242, 'Ointment Adtpue', 216);
insert into MATERIAL (mid, mname, amount)
values (44583, 'Anestethic Egzt', 73);
insert into MATERIAL (mid, mname, amount)
values (93576, 'Pills Ofuxtn', 155);
insert into MATERIAL (mid, mname, amount)
values (31714, 'Antibiotic Jxvh', 237);
insert into MATERIAL (mid, mname, amount)
values (63993, 'Antibiotic Idnp', 36);
insert into MATERIAL (mid, mname, amount)
values (97823, 'Anestethic Yufm', 236);
insert into MATERIAL (mid, mname, amount)
values (55661, 'Anestethic Fqkj', 213);
insert into MATERIAL (mid, mname, amount)
values (33712, 'Anestethic Hckw', 175);
insert into MATERIAL (mid, mname, amount)
values (19976, 'Ointment Gfxbqe', 107);
insert into MATERIAL (mid, mname, amount)
values (67682, 'Antibiotic Yjxl', 93);
insert into MATERIAL (mid, mname, amount)
values (83539, 'Anestethic Bzps', 123);
insert into MATERIAL (mid, mname, amount)
values (29885, 'Septanest Yitro', 83);
insert into MATERIAL (mid, mname, amount)
values (16971, 'Septanest Vrdqv', 8);
insert into MATERIAL (mid, mname, amount)
values (28932, 'Ointment Fuouff', 173);
insert into MATERIAL (mid, mname, amount)
values (92816, 'Pills Mivdrc', 195);
insert into MATERIAL (mid, mname, amount)
values (18182, 'Anestethic Tnpn', 41);
insert into MATERIAL (mid, mname, amount)
values (26497, 'Anestethic Cjmk', 118);
insert into MATERIAL (mid, mname, amount)
values (25558, 'Anestethic Niaa', 219);
insert into MATERIAL (mid, mname, amount)
values (12188, 'Anestethic Iwnq', 4);
insert into MATERIAL (mid, mname, amount)
values (14789, 'Ointment Eljeqy', 116);
insert into MATERIAL (mid, mname, amount)
values (21275, 'Ointment Dwpums', 231);
insert into MATERIAL (mid, mname, amount)
values (88796, 'Pills Gvyrcn', 58);
insert into MATERIAL (mid, mname, amount)
values (37142, 'Septanest Liqhb', 182);
insert into MATERIAL (mid, mname, amount)
values (98712, 'Anestethic Lyeg', 7);
insert into MATERIAL (mid, mname, amount)
values (73532, 'Antibiotic Yoss', 121);
insert into MATERIAL (mid, mname, amount)
values (95514, 'Anestethic Owxt', 98);
insert into MATERIAL (mid, mname, amount)
values (44786, 'Ointment Cwrhma', 67);
insert into MATERIAL (mid, mname, amount)
values (45711, 'Ointment Virrzw', 214);
insert into MATERIAL (mid, mname, amount)
values (85784, 'Septanest Nawvc', 34);
insert into MATERIAL (mid, mname, amount)
values (11126, 'Anestethic Oiif', 189);
insert into MATERIAL (mid, mname, amount)
values (52425, 'Septanest Smmdh', 155);
insert into MATERIAL (mid, mname, amount)
values (44272, 'Septanest Eviux', 2);
insert into MATERIAL (mid, mname, amount)
values (36458, 'Antibiotic Yoms', 222);
insert into MATERIAL (mid, mname, amount)
values (75612, 'Septanest Jgqrt', 161);
insert into MATERIAL (mid, mname, amount)
values (69498, 'Pills Fsnzbo', 114);
insert into MATERIAL (mid, mname, amount)
values (64295, 'Septanest Zmmii', 241);
insert into MATERIAL (mid, mname, amount)
values (72459, 'Antibiotic Hqep', 123);
insert into MATERIAL (mid, mname, amount)
values (93941, 'Ointment Ljniao', 151);
insert into MATERIAL (mid, mname, amount)
values (38569, 'Septanest Fikbq', 63);
insert into MATERIAL (mid, mname, amount)
values (17584, 'Septanest Jlrvw', 38);
insert into MATERIAL (mid, mname, amount)
values (95721, 'Septanest Thobn', 152);
insert into MATERIAL (mid, mname, amount)
values (75759, 'Anestethic Urzx', 172);
insert into MATERIAL (mid, mname, amount)
values (55567, 'Antibiotic Mefv', 21);
insert into MATERIAL (mid, mname, amount)
values (37483, 'Septanest Hglww', 125);
insert into MATERIAL (mid, mname, amount)
values (26222, 'Antibiotic Uqsj', 112);
insert into MATERIAL (mid, mname, amount)
values (55873, 'Pills Yvxnii', 145);
insert into MATERIAL (mid, mname, amount)
values (91854, 'Ointment Lhrigi', 185);
insert into MATERIAL (mid, mname, amount)
values (43389, 'Anestethic Spxm', 61);
insert into MATERIAL (mid, mname, amount)
values (44175, 'Antibiotic Kuqx', 48);
insert into MATERIAL (mid, mname, amount)
values (16418, 'Pills Ucakkk', 225);
insert into MATERIAL (mid, mname, amount)
values (88214, 'Antibiotic Egwh', 36);
insert into MATERIAL (mid, mname, amount)
values (15953, 'Antibiotic Vmvv', 21);
insert into MATERIAL (mid, mname, amount)
values (45884, 'Anestethic Wfnu', 183);
insert into MATERIAL (mid, mname, amount)
values (52478, 'Anestethic Grqt', 29);
insert into MATERIAL (mid, mname, amount)
values (61678, 'Antibiotic Paxt', 246);
insert into MATERIAL (mid, mname, amount)
values (71615, 'Septanest Piyfz', 91);
insert into MATERIAL (mid, mname, amount)
values (42712, 'Anestethic Qeww', 130);
insert into MATERIAL (mid, mname, amount)
values (29767, 'Ointment Vynolg', 249);
insert into MATERIAL (mid, mname, amount)
values (50001, 'Gauze', 100);
insert into MATERIAL (mid, mname, amount)
values (50002, 'Bandages', 75);
insert into MATERIAL (mid, mname, amount)
values (50003, 'Syringes', 200);
insert into MATERIAL (mid, mname, amount)
values (50004, 'Scalpels', 50);
insert into MATERIAL (mid, mname, amount)
values (50005, 'Gloves', 300);
insert into MATERIAL (mid, mname, amount)
values (50006, 'Sutures', 125);
insert into MATERIAL (mid, mname, amount)
values (50007, 'Cotton Swabs', 400);
insert into MATERIAL (mid, mname, amount)
values (50008, 'Disinfectant', 150);
insert into MATERIAL (mid, mname, amount)
values (50009, 'Thermometers', 75);
insert into MATERIAL (mid, mname, amount)
values (50010, 'Stethoscopes', 25);
insert into MATERIAL (mid, mname, amount)
values (79172, 'Septanest', 67);
insert into MATERIAL (mid, mname, amount)
values (24511, 'Pills', 142);
insert into MATERIAL (mid, mname, amount)
values (17846, 'Septanest', 26);
insert into MATERIAL (mid, mname, amount)
values (25767, 'Septanest', 209);
insert into MATERIAL (mid, mname, amount)
values (94688, 'Antibiotic', 192);
insert into MATERIAL (mid, mname, amount)
values (24183, 'Septanest', 214);
insert into MATERIAL (mid, mname, amount)
values (82698, 'Ointment', 68);
insert into MATERIAL (mid, mname, amount)
values (84826, 'Ointment', 83);
insert into MATERIAL (mid, mname, amount)
values (44571, 'Septanest', 12);
insert into MATERIAL (mid, mname, amount)
values (22533, 'Septanest', 27);
commit;
prompt 400 records committed...
insert into MATERIAL (mid, mname, amount)
values (64341, 'Septanest', 106);
insert into MATERIAL (mid, mname, amount)
values (18288, 'Septanest', 81);
insert into MATERIAL (mid, mname, amount)
values (66187, 'Ointment', 211);
insert into MATERIAL (mid, mname, amount)
values (23616, 'Eskrvj', 98);
insert into MATERIAL (mid, mname, amount)
values (38187, 'Jiwzkx', 137);
insert into MATERIAL (mid, mname, amount)
values (49119, 'Geyiew', 46);
insert into MATERIAL (mid, mname, amount)
values (53977, 'Opuvnw', 71);
insert into MATERIAL (mid, mname, amount)
values (32816, 'Oiggzd', 68);
insert into MATERIAL (mid, mname, amount)
values (66817, 'Wgsrax', 156);
insert into MATERIAL (mid, mname, amount)
values (39792, 'Ananxr', 238);
insert into MATERIAL (mid, mname, amount)
values (79135, 'Yfoxcj', 46);
insert into MATERIAL (mid, mname, amount)
values (18661, 'Hebnsr', 163);
insert into MATERIAL (mid, mname, amount)
values (17889, 'Egafnl', 40);
insert into MATERIAL (mid, mname, amount)
values (75396, 'Cagmkc', 91);
insert into MATERIAL (mid, mname, amount)
values (46421, 'Wxpvdc', 12);
insert into MATERIAL (mid, mname, amount)
values (57723, 'Xsgjru', 29);
insert into MATERIAL (mid, mname, amount)
values (11462, 'Crrnew', 96);
insert into MATERIAL (mid, mname, amount)
values (51432, 'Jtthgp', 125);
insert into MATERIAL (mid, mname, amount)
values (85824, 'Evztwl', 143);
insert into MATERIAL (mid, mname, amount)
values (44572, 'Exbulu', 77);
insert into MATERIAL (mid, mname, amount)
values (25765, 'Keszqx', 196);
insert into MATERIAL (mid, mname, amount)
values (73858, 'Pills Nuknpt', 239);
insert into MATERIAL (mid, mname, amount)
values (51973, 'Anestethic Mcrq', 3);
insert into MATERIAL (mid, mname, amount)
values (91563, 'Antibiotic Ldix', 106);
insert into MATERIAL (mid, mname, amount)
values (77593, 'Antibiotic Orrh', 90);
insert into MATERIAL (mid, mname, amount)
values (81624, 'Ointment Fkevwa', 108);
insert into MATERIAL (mid, mname, amount)
values (55635, 'Ointment Fxwcsr', 189);
insert into MATERIAL (mid, mname, amount)
values (22677, 'Pills Fiouyv', 170);
insert into MATERIAL (mid, mname, amount)
values (99117, 'Ointment Cfuzwa', 192);
insert into MATERIAL (mid, mname, amount)
values (24568, 'Ointment Ncibgp', 59);
insert into MATERIAL (mid, mname, amount)
values (63222, 'Ointment Bojqar', 70);
insert into MATERIAL (mid, mname, amount)
values (66972, 'Anestethic Vaup', 216);
insert into MATERIAL (mid, mname, amount)
values (26199, 'Anestethic Lpfa', 221);
insert into MATERIAL (mid, mname, amount)
values (63677, 'Anestethic Lrrj', 245);
insert into MATERIAL (mid, mname, amount)
values (62152, 'Pills Nzwazu', 131);
insert into MATERIAL (mid, mname, amount)
values (61574, 'Ointment Jnadds', 196);
insert into MATERIAL (mid, mname, amount)
values (23585, 'Septanest Gdhfg', 36);
insert into MATERIAL (mid, mname, amount)
values (82597, 'Septanest Faqqo', 7);
insert into MATERIAL (mid, mname, amount)
values (32358, 'Anestethic Swft', 8);
insert into MATERIAL (mid, mname, amount)
values (68834, 'Ointment Qiklfe', 243);
insert into MATERIAL (mid, mname, amount)
values (64735, 'Anestethic Xkad', 68);
insert into MATERIAL (mid, mname, amount)
values (18938, 'Antibiotic Tajd', 176);
insert into MATERIAL (mid, mname, amount)
values (35459, 'Antibiotic Ptbw', 96);
insert into MATERIAL (mid, mname, amount)
values (37651, 'Anestethic Nzew', 89);
insert into MATERIAL (mid, mname, amount)
values (16538, 'Ointment Jleljh', 214);
insert into MATERIAL (mid, mname, amount)
values (86826, 'Pills Jrhiju', 83);
insert into MATERIAL (mid, mname, amount)
values (78514, 'Pills Cdakhz', 182);
insert into MATERIAL (mid, mname, amount)
values (98781, 'Pills Qngwzc', 129);
insert into MATERIAL (mid, mname, amount)
values (68771, 'Ointment Gwhsio', 117);
insert into MATERIAL (mid, mname, amount)
values (29442, 'Septanest Kqsdp', 55);
insert into MATERIAL (mid, mname, amount)
values (95625, 'Ointment Fozfai', 101);
commit;
prompt 451 records loaded
prompt Loading TREATMENT...
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 4465, 69548, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 361, 82736, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 2974, 36999, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 2349, 43562, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 1148, 29779, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 13072, 69989, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 13553, 45299, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 12520, 86448, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 5965, 55194, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 11913, 65894, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 761, 31856, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 2085, 51917, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 7022, 81291, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9567, 98519, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 11783, 23115, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 4228, 45919, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 5749, 92957, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 136, 77953, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 13404, 66237, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 4641, 48389, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 14426, 71824, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 4715, 26426, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 1317, 86193, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 6625, 13865, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 10672, 31498, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 6004, 61161, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 876, 68541, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 5232, 72641, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 6595, 48317, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 14697, 28613, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 6039, 22389, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 12521, 82416, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 3562, 57499, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 11874, 81556, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 4376, 11741, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 9774, 95589, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 8247, 21534, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 1103, 28279, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 281, 22218, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 4332, 49126, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 6247, 94664, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 8491, 55128, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 12640, 62348, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 633, 69323, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 12016, 41269, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 3283, 19138, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 3245, 57734, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 13998, 69888, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 7383, 73447, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 9950, 87763, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 7208, 75421, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 1710, 52724, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 12844, 64556, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 12540, 98431, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 2103, 91341, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 6651, 44897, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9771, 35753, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 10848, 39324, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 5835, 72284, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 10625, 92639, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 14143, 36176, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 10124, 93545, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 6525, 45115, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 1688, 69637, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 1350, 32573, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 12258, 48678, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 9385, 72427, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 11267, 67681, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 14423, 64624, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 4509, 22851, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 91, 14552, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 1353, 78488, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 2803, 99588, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 1546, 19964, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 14940, 67922, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 3540, 98297, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 11887, 74871, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 7188, 86759, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 859, 95638, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 3528, 26691, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 11738, 94421, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 14118, 29827, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 1233, 48123, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 11605, 48329, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 2915, 55853, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 9569, 73797, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 6714, 35821, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 12360, 18339, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 9548, 75664, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 3568, 86933, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 9909, 17936, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 13926, 22789, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 7078, 14355, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 10354, 36526, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 14253, 46961, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 2170, 41662, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 275, 69417, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 7041, 41861, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 5212, 43463, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 12620, 46755, 1);
commit;
prompt 100 records committed...
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 7421, 79892, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 1962, 61466, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 417, 97162, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 13434, 39569, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9295, 55856, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 5042, 11536, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 14941, 38646, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 14038, 56679, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 76, 47955, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 10210, 68228, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 5980, 14261, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 10489, 64213, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 11926, 61751, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 13914, 42874, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 14430, 81263, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 10283, 64193, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 3691, 85923, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 7849, 97218, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 6915, 59576, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 9284, 75819, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 1259, 76218, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 7314, 61278, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 2095, 75574, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 6512, 97845, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 13737, 51563, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 975, 92627, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 7224, 67274, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 11708, 92978, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 859, 91414, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 10565, 37659, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 12371, 58261, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 4319, 69687, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 6326, 41214, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 4231, 32426, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 9361, 96629, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 658, 54973, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 7388, 65132, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 9053, 65137, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 6231, 93326, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 1007, 78657, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 6517, 53955, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 9476, 75261, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 11745, 39411, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 10788, 23557, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 12652, 91757, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 14537, 89623, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 13081, 64274, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 4744, 59859, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 11778, 63961, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 7718, 43564, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 3479, 43229, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 5841, 79265, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 414, 76278, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 5324, 89395, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 723, 19389, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 5797, 77355, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 9829, 85796, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 4499, 43898, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 1112, 97898, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 11071, 78516, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 7691, 89835, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 9397, 63439, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 11639, 87911, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 8510, 75129, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 1155, 89365, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 13795, 82369, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 7844, 88828, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 7392, 23243, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 11308, 45358, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 1602, 73173, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 12398, 95197, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 4406, 71249, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 11242, 64259, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 517, 59848, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 14785, 91318, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 5868, 94324, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 13481, 14955, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 3604, 35345, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9386, 22378, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 6039, 87723, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 2827, 99444, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 10837, 25155, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 14356, 23348, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 3534, 33551, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 12479, 92566, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 12839, 64585, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 12208, 76939, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 7006, 19598, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 2135, 81758, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 11901, 68378, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 10887, 55476, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 14902, 64435, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 7841, 66853, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 14630, 79335, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 9255, 18323, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 2721, 16866, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 5522, 81239, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 9074, 17119, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 13467, 15973, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 14699, 87568, 5);
commit;
prompt 200 records committed...
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 10284, 53636, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 2721, 85642, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 260, 46923, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 12101, 48244, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 7131, 86775, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 11034, 18841, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 1145, 75494, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 11414, 58469, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 8213, 58861, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 11101, 68449, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 10501, 24741, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 5986, 81366, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 9759, 95395, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 3124, 55142, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 14751, 73772, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 2873, 36449, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 13910, 13622, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 5526, 33123, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 11068, 14675, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 11611, 71465, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 8305, 61725, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 1497, 22573, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 8549, 77463, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 554, 97684, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 7983, 65135, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 2218, 44524, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 218, 74348, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 5063, 43531, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 7168, 95993, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 1035, 52941, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 1773, 11355, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 11782, 95429, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 9681, 83316, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 13428, 87726, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 914, 53372, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 6639, 99975, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 6996, 29468, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 9650, 19434, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 14312, 26161, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 14925, 62824, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 11519, 67319, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 14531, 16754, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 11795, 58257, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 12080, 61916, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 14252, 62262, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 9141, 59883, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 2181, 55534, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 6397, 82913, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 4312, 71983, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 3989, 63726, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 14364, 26847, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 2900, 51324, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 8248, 42949, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 1821, 91954, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 5821, 14839, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 4366, 85577, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 4633, 43825, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 6154, 83652, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 2637, 73179, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 6101, 93262, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 9004, 58264, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 1179, 46956, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9718, 46212, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 5043, 36836, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9393, 85741, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 9172, 31183, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 12887, 55837, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 998, 31771, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 7807, 27147, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 13773, 87322, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 12511, 21241, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 3793, 51348, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 4856, 54551, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 3994, 83824, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9978, 55941, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 4053, 83715, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 7617, 17141, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 8840, 95253, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 6547, 25522, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 3624, 72198, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 10087, 72385, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 11109, 43414, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 3162, 22349, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 11029, 23699, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 3883, 96533, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 6455, 81992, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 8453, 49863, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 787, 11826, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 5907, 33742, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 14048, 16365, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 6100, 94996, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 3621, 58514, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 3670, 94371, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 13372, 23661, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 942, 35736, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 4955, 45421, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 6812, 86917, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 9698, 43548, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 12772, 18558, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 5604, 54149, 9);
commit;
prompt 300 records committed...
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 8341, 89842, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 924, 51682, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 10105, 12265, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 4273, 94556, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 6749, 89886, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 10961, 91977, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 4224, 41882, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 9106, 45394, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 4655, 27635, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 14668, 24245, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 4232, 61571, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 9823, 89622, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 8056, 89584, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 1753, 67264, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 1099, 25749, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 10200, 35145, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 9118, 91955, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 12119, 63454, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 2874, 17496, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 122, 54948, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 13953, 63453, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 8814, 35732, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 12448, 71531, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 4324, 38162, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 1145, 52387, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 11643, 76852, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 7436, 68654, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 4835, 82157, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 14500, 92415, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 6242, 87874, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 427, 85435, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 1313, 48196, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 14138, 43627, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 14288, 25514, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 7453, 41155, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 13758, 85517, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 10860, 81339, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 11600, 16211, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 10385, 35666, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 263, 75487, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 10708, 46326, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 12513, 76229, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 2754, 15866, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 10078, 56151, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 9102, 11153, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 4961, 34644, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 5669, 93974, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 5885, 77591, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 3520, 61469, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 12463, 69992, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 414, 76324, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 1528, 83436, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 2631, 55383, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 14032, 94471, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 2539, 63929, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 588, 81329, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 10357, 58882, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 11881, 56217, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 10338, 24957, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 10862, 63569, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 1628, 66786, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 12741, 57765, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 13801, 66121, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 9833, 22486, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 9608, 83735, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 14929, 34718, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 995, 92264, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 13162, 76614, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 14727, 78153, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 14991, 34794, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 2069, 57236, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 14991, 52125, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 3439, 65959, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 12207, 68714, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Extraction', 9928, 43285, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 4485, 35174, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 244, 63187, 6);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 7903, 87629, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 9080, 18675, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 12577, 42976, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Gum', 14817, 58267, 7);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Gum', 287, 55159, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 4040, 18985, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Braces', 2510, 22211, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 13602, 57256, 5);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 1855, 34368, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 9772, 56844, 3);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Braces', 9736, 52748, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Braces', 3416, 67698, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 14396, 14543, 2);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Rehabilitation', 'Teeth filling', 10420, 42172, 8);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 2328, 26551, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Extraction', 8835, 46517, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 6273, 32691, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Extraction', 3169, 36339, 1);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Teeth filling', 4483, 16258, 9);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Orthodontics', 'Teeth filling', 1850, 17632, 4);
insert into TREATMENT (ttype, description, price, tid, time)
values ('Aesthetic', 'Gum', 586, 34578, 2);
commit;
prompt 398 records loaded
prompt Loading MUSEDINT...
insert into MUSEDINT (tid, mid)
values (11153, 53212);
insert into MUSEDINT (tid, mid)
values (11153, 53235);
insert into MUSEDINT (tid, mid)
values (11153, 68732);
insert into MUSEDINT (tid, mid)
values (11355, 15953);
insert into MUSEDINT (tid, mid)
values (11355, 19246);
insert into MUSEDINT (tid, mid)
values (11355, 29554);
insert into MUSEDINT (tid, mid)
values (11536, 25813);
insert into MUSEDINT (tid, mid)
values (11536, 46122);
insert into MUSEDINT (tid, mid)
values (11741, 18661);
insert into MUSEDINT (tid, mid)
values (11741, 47428);
insert into MUSEDINT (tid, mid)
values (11741, 52478);
insert into MUSEDINT (tid, mid)
values (11741, 64741);
insert into MUSEDINT (tid, mid)
values (11741, 83539);
insert into MUSEDINT (tid, mid)
values (11826, 13682);
insert into MUSEDINT (tid, mid)
values (12265, 96421);
insert into MUSEDINT (tid, mid)
values (14261, 42712);
insert into MUSEDINT (tid, mid)
values (14261, 52478);
insert into MUSEDINT (tid, mid)
values (14261, 64876);
insert into MUSEDINT (tid, mid)
values (14355, 83983);
insert into MUSEDINT (tid, mid)
values (14543, 22693);
insert into MUSEDINT (tid, mid)
values (14675, 74877);
insert into MUSEDINT (tid, mid)
values (14839, 25633);
insert into MUSEDINT (tid, mid)
values (14839, 41133);
insert into MUSEDINT (tid, mid)
values (14839, 46242);
insert into MUSEDINT (tid, mid)
values (14839, 96364);
insert into MUSEDINT (tid, mid)
values (14955, 14244);
insert into MUSEDINT (tid, mid)
values (14955, 15953);
insert into MUSEDINT (tid, mid)
values (14955, 75759);
insert into MUSEDINT (tid, mid)
values (15866, 29138);
insert into MUSEDINT (tid, mid)
values (15866, 63597);
insert into MUSEDINT (tid, mid)
values (15973, 13657);
insert into MUSEDINT (tid, mid)
values (15973, 76277);
insert into MUSEDINT (tid, mid)
values (16211, 18288);
insert into MUSEDINT (tid, mid)
values (16211, 31714);
insert into MUSEDINT (tid, mid)
values (16211, 81856);
insert into MUSEDINT (tid, mid)
values (16258, 62838);
insert into MUSEDINT (tid, mid)
values (16365, 47597);
insert into MUSEDINT (tid, mid)
values (16754, 83128);
insert into MUSEDINT (tid, mid)
values (16866, 67121);
insert into MUSEDINT (tid, mid)
values (16866, 91563);
insert into MUSEDINT (tid, mid)
values (17119, 34865);
insert into MUSEDINT (tid, mid)
values (17119, 51927);
insert into MUSEDINT (tid, mid)
values (17119, 69498);
insert into MUSEDINT (tid, mid)
values (17141, 31773);
insert into MUSEDINT (tid, mid)
values (17141, 39792);
insert into MUSEDINT (tid, mid)
values (17141, 57726);
insert into MUSEDINT (tid, mid)
values (17496, 63222);
insert into MUSEDINT (tid, mid)
values (17496, 82698);
insert into MUSEDINT (tid, mid)
values (17632, 31773);
insert into MUSEDINT (tid, mid)
values (17632, 92816);
insert into MUSEDINT (tid, mid)
values (17936, 24534);
insert into MUSEDINT (tid, mid)
values (17936, 41133);
insert into MUSEDINT (tid, mid)
values (17936, 48388);
insert into MUSEDINT (tid, mid)
values (17936, 83212);
insert into MUSEDINT (tid, mid)
values (18323, 36313);
insert into MUSEDINT (tid, mid)
values (18323, 93576);
insert into MUSEDINT (tid, mid)
values (18339, 24183);
insert into MUSEDINT (tid, mid)
values (18339, 29336);
insert into MUSEDINT (tid, mid)
values (18339, 46698);
insert into MUSEDINT (tid, mid)
values (18558, 28379);
insert into MUSEDINT (tid, mid)
values (18558, 64442);
insert into MUSEDINT (tid, mid)
values (18675, 32358);
insert into MUSEDINT (tid, mid)
values (18675, 49119);
insert into MUSEDINT (tid, mid)
values (18675, 77986);
insert into MUSEDINT (tid, mid)
values (18675, 87251);
insert into MUSEDINT (tid, mid)
values (18675, 95721);
insert into MUSEDINT (tid, mid)
values (18841, 25522);
insert into MUSEDINT (tid, mid)
values (18841, 39168);
insert into MUSEDINT (tid, mid)
values (18841, 62838);
insert into MUSEDINT (tid, mid)
values (18841, 75587);
insert into MUSEDINT (tid, mid)
values (18985, 39792);
insert into MUSEDINT (tid, mid)
values (19389, 12188);
insert into MUSEDINT (tid, mid)
values (19389, 15958);
insert into MUSEDINT (tid, mid)
values (19389, 75759);
insert into MUSEDINT (tid, mid)
values (19964, 56794);
insert into MUSEDINT (tid, mid)
values (21241, 37596);
insert into MUSEDINT (tid, mid)
values (21241, 49899);
insert into MUSEDINT (tid, mid)
values (21241, 55635);
insert into MUSEDINT (tid, mid)
values (21241, 84826);
insert into MUSEDINT (tid, mid)
values (21534, 29442);
insert into MUSEDINT (tid, mid)
values (22211, 69521);
insert into MUSEDINT (tid, mid)
values (22211, 98781);
insert into MUSEDINT (tid, mid)
values (22218, 85824);
insert into MUSEDINT (tid, mid)
values (22349, 17889);
insert into MUSEDINT (tid, mid)
values (22349, 28735);
insert into MUSEDINT (tid, mid)
values (22378, 49367);
insert into MUSEDINT (tid, mid)
values (22389, 78819);
insert into MUSEDINT (tid, mid)
values (22389, 99117);
insert into MUSEDINT (tid, mid)
values (22486, 64442);
insert into MUSEDINT (tid, mid)
values (22789, 57726);
insert into MUSEDINT (tid, mid)
values (22789, 62152);
insert into MUSEDINT (tid, mid)
values (22851, 59978);
insert into MUSEDINT (tid, mid)
values (22851, 93576);
insert into MUSEDINT (tid, mid)
values (23115, 75629);
insert into MUSEDINT (tid, mid)
values (23243, 24124);
insert into MUSEDINT (tid, mid)
values (23243, 88796);
insert into MUSEDINT (tid, mid)
values (23348, 12353);
insert into MUSEDINT (tid, mid)
values (23348, 27219);
insert into MUSEDINT (tid, mid)
values (23348, 28735);
insert into MUSEDINT (tid, mid)
values (23348, 53715);
commit;
prompt 100 records committed...
insert into MUSEDINT (tid, mid)
values (23661, 16331);
insert into MUSEDINT (tid, mid)
values (24245, 27386);
insert into MUSEDINT (tid, mid)
values (24245, 29767);
insert into MUSEDINT (tid, mid)
values (24245, 68732);
insert into MUSEDINT (tid, mid)
values (24245, 85824);
insert into MUSEDINT (tid, mid)
values (24741, 36458);
insert into MUSEDINT (tid, mid)
values (24957, 42346);
insert into MUSEDINT (tid, mid)
values (24957, 63993);
insert into MUSEDINT (tid, mid)
values (25155, 23628);
insert into MUSEDINT (tid, mid)
values (25155, 29885);
insert into MUSEDINT (tid, mid)
values (25155, 68746);
insert into MUSEDINT (tid, mid)
values (25514, 16331);
insert into MUSEDINT (tid, mid)
values (25514, 33712);
insert into MUSEDINT (tid, mid)
values (25514, 50007);
insert into MUSEDINT (tid, mid)
values (25514, 53212);
insert into MUSEDINT (tid, mid)
values (25522, 15484);
insert into MUSEDINT (tid, mid)
values (25522, 66972);
insert into MUSEDINT (tid, mid)
values (25749, 46333);
insert into MUSEDINT (tid, mid)
values (26161, 86223);
insert into MUSEDINT (tid, mid)
values (26426, 23585);
insert into MUSEDINT (tid, mid)
values (26426, 43389);
insert into MUSEDINT (tid, mid)
values (26426, 49366);
insert into MUSEDINT (tid, mid)
values (26426, 97875);
insert into MUSEDINT (tid, mid)
values (26551, 49631);
insert into MUSEDINT (tid, mid)
values (26551, 55873);
insert into MUSEDINT (tid, mid)
values (26691, 24534);
insert into MUSEDINT (tid, mid)
values (26691, 62615);
insert into MUSEDINT (tid, mid)
values (26691, 83936);
insert into MUSEDINT (tid, mid)
values (26847, 92714);
insert into MUSEDINT (tid, mid)
values (26847, 96936);
insert into MUSEDINT (tid, mid)
values (27147, 11126);
insert into MUSEDINT (tid, mid)
values (27147, 36647);
insert into MUSEDINT (tid, mid)
values (27147, 63414);
insert into MUSEDINT (tid, mid)
values (27147, 73532);
insert into MUSEDINT (tid, mid)
values (27635, 25767);
insert into MUSEDINT (tid, mid)
values (28279, 11844);
insert into MUSEDINT (tid, mid)
values (28279, 68343);
insert into MUSEDINT (tid, mid)
values (29468, 12188);
insert into MUSEDINT (tid, mid)
values (29468, 74877);
insert into MUSEDINT (tid, mid)
values (29468, 88214);
insert into MUSEDINT (tid, mid)
values (29468, 93137);
insert into MUSEDINT (tid, mid)
values (29779, 23628);
insert into MUSEDINT (tid, mid)
values (29779, 33518);
insert into MUSEDINT (tid, mid)
values (29779, 56126);
insert into MUSEDINT (tid, mid)
values (29827, 25752);
insert into MUSEDINT (tid, mid)
values (31183, 24183);
insert into MUSEDINT (tid, mid)
values (31498, 11997);
insert into MUSEDINT (tid, mid)
values (31498, 56126);
insert into MUSEDINT (tid, mid)
values (31498, 98796);
insert into MUSEDINT (tid, mid)
values (31771, 21275);
insert into MUSEDINT (tid, mid)
values (31771, 38921);
insert into MUSEDINT (tid, mid)
values (31771, 51973);
insert into MUSEDINT (tid, mid)
values (31771, 99141);
insert into MUSEDINT (tid, mid)
values (31856, 34646);
insert into MUSEDINT (tid, mid)
values (31856, 72235);
insert into MUSEDINT (tid, mid)
values (32426, 11462);
insert into MUSEDINT (tid, mid)
values (32426, 51927);
insert into MUSEDINT (tid, mid)
values (32426, 71452);
insert into MUSEDINT (tid, mid)
values (32573, 23585);
insert into MUSEDINT (tid, mid)
values (32573, 47428);
insert into MUSEDINT (tid, mid)
values (32573, 68496);
insert into MUSEDINT (tid, mid)
values (32691, 56631);
insert into MUSEDINT (tid, mid)
values (33123, 14244);
insert into MUSEDINT (tid, mid)
values (33123, 44583);
insert into MUSEDINT (tid, mid)
values (33123, 46242);
insert into MUSEDINT (tid, mid)
values (33123, 50005);
insert into MUSEDINT (tid, mid)
values (33123, 56794);
insert into MUSEDINT (tid, mid)
values (33551, 15958);
insert into MUSEDINT (tid, mid)
values (33551, 27259);
insert into MUSEDINT (tid, mid)
values (33551, 34865);
insert into MUSEDINT (tid, mid)
values (33551, 42668);
insert into MUSEDINT (tid, mid)
values (33551, 49899);
insert into MUSEDINT (tid, mid)
values (33742, 26927);
insert into MUSEDINT (tid, mid)
values (33742, 27386);
insert into MUSEDINT (tid, mid)
values (33742, 32358);
insert into MUSEDINT (tid, mid)
values (33742, 50010);
insert into MUSEDINT (tid, mid)
values (33742, 72479);
insert into MUSEDINT (tid, mid)
values (33742, 78819);
insert into MUSEDINT (tid, mid)
values (33742, 88563);
insert into MUSEDINT (tid, mid)
values (34578, 41311);
insert into MUSEDINT (tid, mid)
values (34578, 44175);
insert into MUSEDINT (tid, mid)
values (34578, 69235);
insert into MUSEDINT (tid, mid)
values (34644, 44631);
insert into MUSEDINT (tid, mid)
values (34718, 32816);
insert into MUSEDINT (tid, mid)
values (34718, 94688);
insert into MUSEDINT (tid, mid)
values (34718, 97823);
insert into MUSEDINT (tid, mid)
values (34794, 68248);
insert into MUSEDINT (tid, mid)
values (35145, 27189);
insert into MUSEDINT (tid, mid)
values (35145, 87251);
insert into MUSEDINT (tid, mid)
values (35345, 11126);
insert into MUSEDINT (tid, mid)
values (35345, 24183);
insert into MUSEDINT (tid, mid)
values (35345, 55764);
insert into MUSEDINT (tid, mid)
values (35666, 17776);
insert into MUSEDINT (tid, mid)
values (35666, 36647);
insert into MUSEDINT (tid, mid)
values (35666, 57861);
insert into MUSEDINT (tid, mid)
values (35732, 29225);
insert into MUSEDINT (tid, mid)
values (35732, 44524);
insert into MUSEDINT (tid, mid)
values (35732, 68834);
insert into MUSEDINT (tid, mid)
values (35753, 64876);
insert into MUSEDINT (tid, mid)
values (35821, 11127);
commit;
prompt 200 records committed...
insert into MUSEDINT (tid, mid)
values (36176, 63993);
insert into MUSEDINT (tid, mid)
values (36176, 77556);
insert into MUSEDINT (tid, mid)
values (36526, 16418);
insert into MUSEDINT (tid, mid)
values (36836, 11126);
insert into MUSEDINT (tid, mid)
values (36836, 49899);
insert into MUSEDINT (tid, mid)
values (36999, 48693);
insert into MUSEDINT (tid, mid)
values (37659, 15199);
insert into MUSEDINT (tid, mid)
values (37659, 22792);
insert into MUSEDINT (tid, mid)
values (37659, 45884);
insert into MUSEDINT (tid, mid)
values (37659, 61582);
insert into MUSEDINT (tid, mid)
values (38162, 43389);
insert into MUSEDINT (tid, mid)
values (38162, 75523);
insert into MUSEDINT (tid, mid)
values (38646, 11752);
insert into MUSEDINT (tid, mid)
values (38646, 16418);
insert into MUSEDINT (tid, mid)
values (38646, 22693);
insert into MUSEDINT (tid, mid)
values (38646, 26412);
insert into MUSEDINT (tid, mid)
values (38646, 61574);
insert into MUSEDINT (tid, mid)
values (38646, 63363);
insert into MUSEDINT (tid, mid)
values (38646, 75523);
insert into MUSEDINT (tid, mid)
values (38646, 88796);
insert into MUSEDINT (tid, mid)
values (39324, 28318);
insert into MUSEDINT (tid, mid)
values (39324, 38569);
insert into MUSEDINT (tid, mid)
values (39324, 82597);
insert into MUSEDINT (tid, mid)
values (39324, 83983);
insert into MUSEDINT (tid, mid)
values (39569, 15988);
insert into MUSEDINT (tid, mid)
values (39569, 27189);
insert into MUSEDINT (tid, mid)
values (39569, 51432);
insert into MUSEDINT (tid, mid)
values (39569, 55567);
insert into MUSEDINT (tid, mid)
values (41155, 17776);
insert into MUSEDINT (tid, mid)
values (41155, 64683);
insert into MUSEDINT (tid, mid)
values (41155, 73532);
insert into MUSEDINT (tid, mid)
values (41214, 75587);
insert into MUSEDINT (tid, mid)
values (41269, 11462);
insert into MUSEDINT (tid, mid)
values (41269, 61678);
insert into MUSEDINT (tid, mid)
values (41662, 38187);
insert into MUSEDINT (tid, mid)
values (41861, 49484);
insert into MUSEDINT (tid, mid)
values (41861, 51857);
insert into MUSEDINT (tid, mid)
values (41861, 99141);
insert into MUSEDINT (tid, mid)
values (42172, 28735);
insert into MUSEDINT (tid, mid)
values (42172, 44631);
insert into MUSEDINT (tid, mid)
values (42172, 66972);
insert into MUSEDINT (tid, mid)
values (42874, 62511);
insert into MUSEDINT (tid, mid)
values (42949, 38921);
insert into MUSEDINT (tid, mid)
values (42976, 53977);
insert into MUSEDINT (tid, mid)
values (43229, 37483);
insert into MUSEDINT (tid, mid)
values (43229, 54227);
insert into MUSEDINT (tid, mid)
values (43229, 61678);
insert into MUSEDINT (tid, mid)
values (43229, 77986);
insert into MUSEDINT (tid, mid)
values (43285, 26441);
insert into MUSEDINT (tid, mid)
values (43285, 27995);
insert into MUSEDINT (tid, mid)
values (43414, 18182);
insert into MUSEDINT (tid, mid)
values (43414, 77986);
insert into MUSEDINT (tid, mid)
values (43463, 32832);
insert into MUSEDINT (tid, mid)
values (43463, 44141);
insert into MUSEDINT (tid, mid)
values (43463, 47428);
insert into MUSEDINT (tid, mid)
values (43531, 42346);
insert into MUSEDINT (tid, mid)
values (43548, 94688);
insert into MUSEDINT (tid, mid)
values (43562, 17776);
insert into MUSEDINT (tid, mid)
values (43562, 23628);
insert into MUSEDINT (tid, mid)
values (43562, 24183);
insert into MUSEDINT (tid, mid)
values (43562, 43963);
insert into MUSEDINT (tid, mid)
values (43562, 55764);
insert into MUSEDINT (tid, mid)
values (43564, 19776);
insert into MUSEDINT (tid, mid)
values (43564, 61271);
insert into MUSEDINT (tid, mid)
values (43627, 68746);
insert into MUSEDINT (tid, mid)
values (43627, 86938);
insert into MUSEDINT (tid, mid)
values (43825, 38529);
insert into MUSEDINT (tid, mid)
values (43825, 51773);
insert into MUSEDINT (tid, mid)
values (43825, 66187);
insert into MUSEDINT (tid, mid)
values (43825, 76774);
insert into MUSEDINT (tid, mid)
values (43898, 89721);
insert into MUSEDINT (tid, mid)
values (43898, 92666);
insert into MUSEDINT (tid, mid)
values (43898, 94688);
insert into MUSEDINT (tid, mid)
values (44524, 66972);
insert into MUSEDINT (tid, mid)
values (44897, 16418);
insert into MUSEDINT (tid, mid)
values (44897, 34263);
insert into MUSEDINT (tid, mid)
values (44897, 95165);
insert into MUSEDINT (tid, mid)
values (45115, 49367);
insert into MUSEDINT (tid, mid)
values (45115, 63512);
insert into MUSEDINT (tid, mid)
values (45115, 64683);
insert into MUSEDINT (tid, mid)
values (45299, 23116);
insert into MUSEDINT (tid, mid)
values (45299, 39792);
insert into MUSEDINT (tid, mid)
values (45299, 64295);
insert into MUSEDINT (tid, mid)
values (45358, 13655);
insert into MUSEDINT (tid, mid)
values (45358, 36458);
insert into MUSEDINT (tid, mid)
values (45358, 84215);
insert into MUSEDINT (tid, mid)
values (45358, 88489);
insert into MUSEDINT (tid, mid)
values (45358, 91563);
insert into MUSEDINT (tid, mid)
values (45394, 37596);
insert into MUSEDINT (tid, mid)
values (45421, 42637);
insert into MUSEDINT (tid, mid)
values (45421, 56794);
insert into MUSEDINT (tid, mid)
values (45421, 79344);
insert into MUSEDINT (tid, mid)
values (45421, 93815);
insert into MUSEDINT (tid, mid)
values (45919, 12228);
insert into MUSEDINT (tid, mid)
values (46212, 51181);
insert into MUSEDINT (tid, mid)
values (46212, 59978);
insert into MUSEDINT (tid, mid)
values (46212, 68834);
insert into MUSEDINT (tid, mid)
values (46212, 72235);
insert into MUSEDINT (tid, mid)
values (46212, 97792);
insert into MUSEDINT (tid, mid)
values (46326, 28379);
commit;
prompt 300 records committed...
insert into MUSEDINT (tid, mid)
values (46326, 32523);
insert into MUSEDINT (tid, mid)
values (46517, 72479);
insert into MUSEDINT (tid, mid)
values (46755, 44141);
insert into MUSEDINT (tid, mid)
values (46923, 50004);
insert into MUSEDINT (tid, mid)
values (46923, 81624);
insert into MUSEDINT (tid, mid)
values (46961, 26412);
insert into MUSEDINT (tid, mid)
values (46961, 75523);
insert into MUSEDINT (tid, mid)
values (47955, 15199);
insert into MUSEDINT (tid, mid)
values (47955, 47358);
insert into MUSEDINT (tid, mid)
values (47955, 99117);
insert into MUSEDINT (tid, mid)
values (48196, 86826);
insert into MUSEDINT (tid, mid)
values (48317, 24534);
insert into MUSEDINT (tid, mid)
values (48317, 94596);
insert into MUSEDINT (tid, mid)
values (48329, 75214);
insert into MUSEDINT (tid, mid)
values (48389, 29767);
insert into MUSEDINT (tid, mid)
values (48678, 50004);
insert into MUSEDINT (tid, mid)
values (48678, 53715);
insert into MUSEDINT (tid, mid)
values (48678, 97963);
insert into MUSEDINT (tid, mid)
values (49126, 25522);
insert into MUSEDINT (tid, mid)
values (49126, 50004);
insert into MUSEDINT (tid, mid)
values (49126, 61271);
insert into MUSEDINT (tid, mid)
values (49863, 72235);
insert into MUSEDINT (tid, mid)
values (49863, 72479);
insert into MUSEDINT (tid, mid)
values (51348, 66227);
insert into MUSEDINT (tid, mid)
values (51563, 50005);
insert into MUSEDINT (tid, mid)
values (51563, 98712);
insert into MUSEDINT (tid, mid)
values (51682, 35459);
insert into MUSEDINT (tid, mid)
values (51682, 75396);
insert into MUSEDINT (tid, mid)
values (51682, 99962);
insert into MUSEDINT (tid, mid)
values (51917, 47428);
insert into MUSEDINT (tid, mid)
values (51917, 85824);
insert into MUSEDINT (tid, mid)
values (52125, 29225);
insert into MUSEDINT (tid, mid)
values (52125, 69498);
insert into MUSEDINT (tid, mid)
values (52125, 88294);
insert into MUSEDINT (tid, mid)
values (52387, 38771);
insert into MUSEDINT (tid, mid)
values (52387, 75587);
insert into MUSEDINT (tid, mid)
values (52724, 71723);
insert into MUSEDINT (tid, mid)
values (52748, 25522);
insert into MUSEDINT (tid, mid)
values (52748, 68732);
insert into MUSEDINT (tid, mid)
values (52748, 93815);
insert into MUSEDINT (tid, mid)
values (52941, 24167);
insert into MUSEDINT (tid, mid)
values (52941, 37596);
insert into MUSEDINT (tid, mid)
values (52941, 50002);
insert into MUSEDINT (tid, mid)
values (52941, 83128);
insert into MUSEDINT (tid, mid)
values (52941, 83212);
insert into MUSEDINT (tid, mid)
values (53372, 32816);
insert into MUSEDINT (tid, mid)
values (53636, 61582);
insert into MUSEDINT (tid, mid)
values (53955, 71339);
insert into MUSEDINT (tid, mid)
values (53955, 91854);
insert into MUSEDINT (tid, mid)
values (54149, 22461);
insert into MUSEDINT (tid, mid)
values (54149, 23616);
insert into MUSEDINT (tid, mid)
values (54149, 38187);
insert into MUSEDINT (tid, mid)
values (54149, 50010);
insert into MUSEDINT (tid, mid)
values (54973, 19857);
insert into MUSEDINT (tid, mid)
values (55128, 34865);
insert into MUSEDINT (tid, mid)
values (55128, 66227);
insert into MUSEDINT (tid, mid)
values (55128, 98517);
insert into MUSEDINT (tid, mid)
values (55142, 15869);
insert into MUSEDINT (tid, mid)
values (55142, 91329);
insert into MUSEDINT (tid, mid)
values (55159, 49631);
insert into MUSEDINT (tid, mid)
values (55194, 68771);
insert into MUSEDINT (tid, mid)
values (55383, 64876);
insert into MUSEDINT (tid, mid)
values (55476, 53673);
insert into MUSEDINT (tid, mid)
values (55476, 63597);
insert into MUSEDINT (tid, mid)
values (55476, 84617);
insert into MUSEDINT (tid, mid)
values (55476, 93815);
insert into MUSEDINT (tid, mid)
values (55534, 63768);
insert into MUSEDINT (tid, mid)
values (55534, 81162);
insert into MUSEDINT (tid, mid)
values (55837, 15869);
insert into MUSEDINT (tid, mid)
values (55837, 74315);
insert into MUSEDINT (tid, mid)
values (55853, 22677);
insert into MUSEDINT (tid, mid)
values (55856, 11997);
insert into MUSEDINT (tid, mid)
values (55856, 16475);
insert into MUSEDINT (tid, mid)
values (55856, 87588);
insert into MUSEDINT (tid, mid)
values (55856, 94219);
insert into MUSEDINT (tid, mid)
values (55941, 19246);
insert into MUSEDINT (tid, mid)
values (55941, 98712);
insert into MUSEDINT (tid, mid)
values (56151, 27219);
insert into MUSEDINT (tid, mid)
values (56151, 59486);
insert into MUSEDINT (tid, mid)
values (56151, 64219);
insert into MUSEDINT (tid, mid)
values (56217, 13657);
insert into MUSEDINT (tid, mid)
values (56679, 75629);
insert into MUSEDINT (tid, mid)
values (56679, 75759);
insert into MUSEDINT (tid, mid)
values (57236, 18661);
insert into MUSEDINT (tid, mid)
values (57236, 24124);
insert into MUSEDINT (tid, mid)
values (57256, 64683);
insert into MUSEDINT (tid, mid)
values (57499, 50003);
insert into MUSEDINT (tid, mid)
values (57734, 56794);
insert into MUSEDINT (tid, mid)
values (57734, 88294);
insert into MUSEDINT (tid, mid)
values (57765, 29767);
insert into MUSEDINT (tid, mid)
values (58257, 15199);
insert into MUSEDINT (tid, mid)
values (58257, 27995);
insert into MUSEDINT (tid, mid)
values (58261, 29738);
insert into MUSEDINT (tid, mid)
values (58261, 33518);
insert into MUSEDINT (tid, mid)
values (58261, 46679);
insert into MUSEDINT (tid, mid)
values (58261, 84215);
insert into MUSEDINT (tid, mid)
values (58264, 15869);
insert into MUSEDINT (tid, mid)
values (58264, 32523);
insert into MUSEDINT (tid, mid)
values (58264, 37596);
insert into MUSEDINT (tid, mid)
values (58264, 57612);
commit;
prompt 400 records committed...
insert into MUSEDINT (tid, mid)
values (58264, 87588);
insert into MUSEDINT (tid, mid)
values (58264, 98712);
insert into MUSEDINT (tid, mid)
values (58267, 88563);
insert into MUSEDINT (tid, mid)
values (58469, 13655);
insert into MUSEDINT (tid, mid)
values (58469, 50010);
insert into MUSEDINT (tid, mid)
values (58469, 55873);
insert into MUSEDINT (tid, mid)
values (58514, 97524);
insert into MUSEDINT (tid, mid)
values (58861, 37596);
insert into MUSEDINT (tid, mid)
values (58861, 43963);
insert into MUSEDINT (tid, mid)
values (58861, 84617);
insert into MUSEDINT (tid, mid)
values (58882, 13449);
insert into MUSEDINT (tid, mid)
values (58882, 57861);
insert into MUSEDINT (tid, mid)
values (59576, 79135);
insert into MUSEDINT (tid, mid)
values (59576, 97441);
insert into MUSEDINT (tid, mid)
values (59848, 56184);
insert into MUSEDINT (tid, mid)
values (59859, 61951);
insert into MUSEDINT (tid, mid)
values (59859, 94698);
insert into MUSEDINT (tid, mid)
values (59859, 97217);
insert into MUSEDINT (tid, mid)
values (59883, 91563);
insert into MUSEDINT (tid, mid)
values (61161, 16418);
insert into MUSEDINT (tid, mid)
values (61161, 93566);
insert into MUSEDINT (tid, mid)
values (61161, 99141);
insert into MUSEDINT (tid, mid)
values (61278, 67682);
insert into MUSEDINT (tid, mid)
values (61278, 82918);
insert into MUSEDINT (tid, mid)
values (61278, 97217);
insert into MUSEDINT (tid, mid)
values (61466, 92816);
insert into MUSEDINT (tid, mid)
values (61469, 50008);
insert into MUSEDINT (tid, mid)
values (61469, 52425);
insert into MUSEDINT (tid, mid)
values (61571, 38921);
insert into MUSEDINT (tid, mid)
values (61571, 93815);
insert into MUSEDINT (tid, mid)
values (61725, 68545);
insert into MUSEDINT (tid, mid)
values (61725, 69521);
insert into MUSEDINT (tid, mid)
values (61725, 78237);
insert into MUSEDINT (tid, mid)
values (61725, 92816);
insert into MUSEDINT (tid, mid)
values (61751, 26927);
insert into MUSEDINT (tid, mid)
values (61751, 44888);
insert into MUSEDINT (tid, mid)
values (61751, 93643);
insert into MUSEDINT (tid, mid)
values (61751, 99117);
insert into MUSEDINT (tid, mid)
values (62262, 27219);
insert into MUSEDINT (tid, mid)
values (62262, 75629);
insert into MUSEDINT (tid, mid)
values (62348, 97792);
insert into MUSEDINT (tid, mid)
values (62824, 34263);
insert into MUSEDINT (tid, mid)
values (62824, 36876);
insert into MUSEDINT (tid, mid)
values (62824, 69498);
insert into MUSEDINT (tid, mid)
values (63187, 31714);
insert into MUSEDINT (tid, mid)
values (63187, 67121);
insert into MUSEDINT (tid, mid)
values (63439, 36935);
insert into MUSEDINT (tid, mid)
values (63453, 64219);
insert into MUSEDINT (tid, mid)
values (63454, 38569);
insert into MUSEDINT (tid, mid)
values (63454, 44261);
insert into MUSEDINT (tid, mid)
values (63454, 64735);
insert into MUSEDINT (tid, mid)
values (63569, 74929);
insert into MUSEDINT (tid, mid)
values (63726, 21275);
insert into MUSEDINT (tid, mid)
values (63726, 69235);
insert into MUSEDINT (tid, mid)
values (63929, 35459);
insert into MUSEDINT (tid, mid)
values (63929, 76277);
insert into MUSEDINT (tid, mid)
values (63961, 59486);
insert into MUSEDINT (tid, mid)
values (63961, 75612);
insert into MUSEDINT (tid, mid)
values (63961, 76774);
insert into MUSEDINT (tid, mid)
values (64193, 12999);
insert into MUSEDINT (tid, mid)
values (64193, 97659);
insert into MUSEDINT (tid, mid)
values (64213, 13682);
insert into MUSEDINT (tid, mid)
values (64274, 56126);
insert into MUSEDINT (tid, mid)
values (64274, 66187);
insert into MUSEDINT (tid, mid)
values (64435, 17368);
insert into MUSEDINT (tid, mid)
values (64435, 44888);
insert into MUSEDINT (tid, mid)
values (64435, 56873);
insert into MUSEDINT (tid, mid)
values (64435, 86571);
insert into MUSEDINT (tid, mid)
values (64556, 68496);
insert into MUSEDINT (tid, mid)
values (64624, 50006);
insert into MUSEDINT (tid, mid)
values (65132, 42712);
insert into MUSEDINT (tid, mid)
values (65132, 53354);
insert into MUSEDINT (tid, mid)
values (65132, 63677);
insert into MUSEDINT (tid, mid)
values (65135, 97875);
insert into MUSEDINT (tid, mid)
values (65137, 48693);
insert into MUSEDINT (tid, mid)
values (65137, 50007);
insert into MUSEDINT (tid, mid)
values (65137, 68834);
insert into MUSEDINT (tid, mid)
values (65894, 19776);
insert into MUSEDINT (tid, mid)
values (65894, 47254);
insert into MUSEDINT (tid, mid)
values (65894, 55764);
insert into MUSEDINT (tid, mid)
values (65959, 81624);
insert into MUSEDINT (tid, mid)
values (66121, 27219);
insert into MUSEDINT (tid, mid)
values (66121, 62838);
insert into MUSEDINT (tid, mid)
values (66786, 68545);
insert into MUSEDINT (tid, mid)
values (66786, 97524);
insert into MUSEDINT (tid, mid)
values (66853, 29738);
insert into MUSEDINT (tid, mid)
values (66853, 79534);
insert into MUSEDINT (tid, mid)
values (67264, 53999);
insert into MUSEDINT (tid, mid)
values (67698, 61271);
insert into MUSEDINT (tid, mid)
values (67698, 71862);
insert into MUSEDINT (tid, mid)
values (67698, 79135);
insert into MUSEDINT (tid, mid)
values (67922, 23116);
insert into MUSEDINT (tid, mid)
values (67922, 26497);
insert into MUSEDINT (tid, mid)
values (68228, 11997);
insert into MUSEDINT (tid, mid)
values (68228, 92858);
insert into MUSEDINT (tid, mid)
values (68378, 29767);
insert into MUSEDINT (tid, mid)
values (68449, 24511);
insert into MUSEDINT (tid, mid)
values (68449, 44261);
insert into MUSEDINT (tid, mid)
values (68541, 64442);
insert into MUSEDINT (tid, mid)
values (69323, 23116);
commit;
prompt 500 records committed...
insert into MUSEDINT (tid, mid)
values (69323, 44572);
insert into MUSEDINT (tid, mid)
values (69417, 26412);
insert into MUSEDINT (tid, mid)
values (69417, 45884);
insert into MUSEDINT (tid, mid)
values (69548, 24115);
insert into MUSEDINT (tid, mid)
values (69637, 36778);
insert into MUSEDINT (tid, mid)
values (69989, 63677);
insert into MUSEDINT (tid, mid)
values (69992, 25392);
insert into MUSEDINT (tid, mid)
values (69992, 48693);
insert into MUSEDINT (tid, mid)
values (69992, 83212);
insert into MUSEDINT (tid, mid)
values (71249, 29225);
insert into MUSEDINT (tid, mid)
values (71249, 98712);
insert into MUSEDINT (tid, mid)
values (71465, 63414);
insert into MUSEDINT (tid, mid)
values (71531, 58887);
insert into MUSEDINT (tid, mid)
values (71531, 89574);
insert into MUSEDINT (tid, mid)
values (71824, 33316);
insert into MUSEDINT (tid, mid)
values (71824, 92858);
insert into MUSEDINT (tid, mid)
values (71983, 32832);
insert into MUSEDINT (tid, mid)
values (72198, 17846);
insert into MUSEDINT (tid, mid)
values (72284, 51927);
insert into MUSEDINT (tid, mid)
values (72385, 55635);
insert into MUSEDINT (tid, mid)
values (72385, 84832);
insert into MUSEDINT (tid, mid)
values (72427, 25765);
insert into MUSEDINT (tid, mid)
values (72427, 50007);
insert into MUSEDINT (tid, mid)
values (72427, 66187);
insert into MUSEDINT (tid, mid)
values (72641, 53673);
insert into MUSEDINT (tid, mid)
values (72641, 82597);
insert into MUSEDINT (tid, mid)
values (73173, 11462);
insert into MUSEDINT (tid, mid)
values (73173, 38187);
insert into MUSEDINT (tid, mid)
values (73173, 61695);
insert into MUSEDINT (tid, mid)
values (73179, 15228);
insert into MUSEDINT (tid, mid)
values (73447, 42395);
insert into MUSEDINT (tid, mid)
values (73447, 51142);
insert into MUSEDINT (tid, mid)
values (73447, 53715);
insert into MUSEDINT (tid, mid)
values (73447, 84832);
insert into MUSEDINT (tid, mid)
values (73772, 66187);
insert into MUSEDINT (tid, mid)
values (73797, 72235);
insert into MUSEDINT (tid, mid)
values (74348, 41729);
insert into MUSEDINT (tid, mid)
values (74348, 86571);
insert into MUSEDINT (tid, mid)
values (74871, 18661);
insert into MUSEDINT (tid, mid)
values (74871, 26199);
insert into MUSEDINT (tid, mid)
values (74871, 53235);
insert into MUSEDINT (tid, mid)
values (74871, 74315);
insert into MUSEDINT (tid, mid)
values (74871, 84832);
insert into MUSEDINT (tid, mid)
values (75261, 15199);
insert into MUSEDINT (tid, mid)
values (75261, 46242);
insert into MUSEDINT (tid, mid)
values (75261, 50007);
insert into MUSEDINT (tid, mid)
values (75261, 53212);
insert into MUSEDINT (tid, mid)
values (75261, 53715);
insert into MUSEDINT (tid, mid)
values (75421, 29336);
insert into MUSEDINT (tid, mid)
values (75421, 33316);
insert into MUSEDINT (tid, mid)
values (75421, 42712);
insert into MUSEDINT (tid, mid)
values (75421, 43389);
insert into MUSEDINT (tid, mid)
values (75487, 50007);
insert into MUSEDINT (tid, mid)
values (75487, 57726);
insert into MUSEDINT (tid, mid)
values (75574, 27132);
insert into MUSEDINT (tid, mid)
values (75664, 50005);
insert into MUSEDINT (tid, mid)
values (75819, 12353);
insert into MUSEDINT (tid, mid)
values (75819, 84215);
insert into MUSEDINT (tid, mid)
values (76218, 16538);
insert into MUSEDINT (tid, mid)
values (76218, 19976);
insert into MUSEDINT (tid, mid)
values (76218, 42637);
insert into MUSEDINT (tid, mid)
values (76218, 69498);
insert into MUSEDINT (tid, mid)
values (76229, 32666);
insert into MUSEDINT (tid, mid)
values (76229, 75759);
insert into MUSEDINT (tid, mid)
values (76278, 54715);
insert into MUSEDINT (tid, mid)
values (76278, 79135);
insert into MUSEDINT (tid, mid)
values (76278, 83212);
insert into MUSEDINT (tid, mid)
values (76324, 15953);
insert into MUSEDINT (tid, mid)
values (76324, 22533);
insert into MUSEDINT (tid, mid)
values (76324, 86223);
insert into MUSEDINT (tid, mid)
values (76614, 64741);
insert into MUSEDINT (tid, mid)
values (76614, 93786);
insert into MUSEDINT (tid, mid)
values (76852, 19976);
insert into MUSEDINT (tid, mid)
values (76852, 44786);
insert into MUSEDINT (tid, mid)
values (76939, 15484);
insert into MUSEDINT (tid, mid)
values (76939, 18938);
insert into MUSEDINT (tid, mid)
values (76939, 59486);
insert into MUSEDINT (tid, mid)
values (76939, 61582);
insert into MUSEDINT (tid, mid)
values (76939, 79172);
insert into MUSEDINT (tid, mid)
values (76939, 99117);
insert into MUSEDINT (tid, mid)
values (77463, 25558);
insert into MUSEDINT (tid, mid)
values (77463, 97217);
insert into MUSEDINT (tid, mid)
values (77591, 12999);
insert into MUSEDINT (tid, mid)
values (77591, 64735);
insert into MUSEDINT (tid, mid)
values (78153, 18182);
insert into MUSEDINT (tid, mid)
values (78153, 36313);
insert into MUSEDINT (tid, mid)
values (78153, 51857);
insert into MUSEDINT (tid, mid)
values (78153, 63993);
insert into MUSEDINT (tid, mid)
values (78488, 63597);
insert into MUSEDINT (tid, mid)
values (78516, 18288);
insert into MUSEDINT (tid, mid)
values (78516, 24511);
insert into MUSEDINT (tid, mid)
values (78516, 29738);
insert into MUSEDINT (tid, mid)
values (78516, 36935);
insert into MUSEDINT (tid, mid)
values (78516, 37142);
insert into MUSEDINT (tid, mid)
values (78516, 45711);
insert into MUSEDINT (tid, mid)
values (78657, 22461);
insert into MUSEDINT (tid, mid)
values (78657, 83147);
insert into MUSEDINT (tid, mid)
values (79265, 25767);
insert into MUSEDINT (tid, mid)
values (79265, 32358);
insert into MUSEDINT (tid, mid)
values (79265, 33316);
commit;
prompt 600 records committed...
insert into MUSEDINT (tid, mid)
values (79265, 78237);
insert into MUSEDINT (tid, mid)
values (79265, 95625);
insert into MUSEDINT (tid, mid)
values (79335, 54715);
insert into MUSEDINT (tid, mid)
values (79892, 11997);
insert into MUSEDINT (tid, mid)
values (81239, 66227);
insert into MUSEDINT (tid, mid)
values (81239, 77556);
insert into MUSEDINT (tid, mid)
values (81239, 83539);
insert into MUSEDINT (tid, mid)
values (81263, 78514);
insert into MUSEDINT (tid, mid)
values (81263, 83229);
insert into MUSEDINT (tid, mid)
values (81291, 50001);
insert into MUSEDINT (tid, mid)
values (81329, 54715);
insert into MUSEDINT (tid, mid)
values (81329, 67682);
insert into MUSEDINT (tid, mid)
values (81339, 12353);
insert into MUSEDINT (tid, mid)
values (81339, 26222);
insert into MUSEDINT (tid, mid)
values (81339, 27219);
insert into MUSEDINT (tid, mid)
values (81339, 29122);
insert into MUSEDINT (tid, mid)
values (81339, 29138);
insert into MUSEDINT (tid, mid)
values (81366, 25392);
insert into MUSEDINT (tid, mid)
values (81366, 50004);
insert into MUSEDINT (tid, mid)
values (81366, 97875);
insert into MUSEDINT (tid, mid)
values (81556, 63651);
insert into MUSEDINT (tid, mid)
values (81556, 97441);
insert into MUSEDINT (tid, mid)
values (81758, 27259);
insert into MUSEDINT (tid, mid)
values (81758, 72235);
insert into MUSEDINT (tid, mid)
values (81992, 34646);
insert into MUSEDINT (tid, mid)
values (81992, 44175);
insert into MUSEDINT (tid, mid)
values (82157, 36647);
insert into MUSEDINT (tid, mid)
values (82157, 55661);
insert into MUSEDINT (tid, mid)
values (82157, 57368);
insert into MUSEDINT (tid, mid)
values (82416, 19857);
insert into MUSEDINT (tid, mid)
values (82416, 43389);
insert into MUSEDINT (tid, mid)
values (82416, 82665);
insert into MUSEDINT (tid, mid)
values (82736, 82444);
insert into MUSEDINT (tid, mid)
values (83316, 44583);
insert into MUSEDINT (tid, mid)
values (83316, 55764);
insert into MUSEDINT (tid, mid)
values (83436, 97128);
insert into MUSEDINT (tid, mid)
values (83652, 28379);
insert into MUSEDINT (tid, mid)
values (83652, 29442);
insert into MUSEDINT (tid, mid)
values (83652, 42712);
insert into MUSEDINT (tid, mid)
values (83715, 15869);
insert into MUSEDINT (tid, mid)
values (83715, 42346);
insert into MUSEDINT (tid, mid)
values (83715, 47254);
insert into MUSEDINT (tid, mid)
values (83715, 86561);
insert into MUSEDINT (tid, mid)
values (83735, 12353);
insert into MUSEDINT (tid, mid)
values (83735, 18298);
insert into MUSEDINT (tid, mid)
values (83735, 50003);
insert into MUSEDINT (tid, mid)
values (83735, 51857);
insert into MUSEDINT (tid, mid)
values (83735, 88489);
insert into MUSEDINT (tid, mid)
values (83824, 13449);
insert into MUSEDINT (tid, mid)
values (83824, 57368);
insert into MUSEDINT (tid, mid)
values (83824, 63597);
insert into MUSEDINT (tid, mid)
values (83824, 68834);
insert into MUSEDINT (tid, mid)
values (83824, 75288);
insert into MUSEDINT (tid, mid)
values (85435, 77646);
insert into MUSEDINT (tid, mid)
values (85517, 11871);
insert into MUSEDINT (tid, mid)
values (85517, 15484);
insert into MUSEDINT (tid, mid)
values (85517, 44175);
insert into MUSEDINT (tid, mid)
values (85577, 15958);
insert into MUSEDINT (tid, mid)
values (85642, 50010);
insert into MUSEDINT (tid, mid)
values (85642, 53235);
insert into MUSEDINT (tid, mid)
values (85642, 54715);
insert into MUSEDINT (tid, mid)
values (85741, 24183);
insert into MUSEDINT (tid, mid)
values (85741, 86223);
insert into MUSEDINT (tid, mid)
values (85796, 32358);
insert into MUSEDINT (tid, mid)
values (85796, 64219);
insert into MUSEDINT (tid, mid)
values (85923, 59486);
insert into MUSEDINT (tid, mid)
values (86193, 99962);
insert into MUSEDINT (tid, mid)
values (86448, 25811);
insert into MUSEDINT (tid, mid)
values (86448, 29442);
insert into MUSEDINT (tid, mid)
values (86448, 46333);
insert into MUSEDINT (tid, mid)
values (86448, 59841);
insert into MUSEDINT (tid, mid)
values (86759, 36935);
insert into MUSEDINT (tid, mid)
values (86759, 91329);
insert into MUSEDINT (tid, mid)
values (86775, 47254);
insert into MUSEDINT (tid, mid)
values (86933, 44141);
insert into MUSEDINT (tid, mid)
values (86933, 68343);
insert into MUSEDINT (tid, mid)
values (87568, 14131);
insert into MUSEDINT (tid, mid)
values (87568, 29411);
insert into MUSEDINT (tid, mid)
values (87568, 75759);
insert into MUSEDINT (tid, mid)
values (87629, 54227);
insert into MUSEDINT (tid, mid)
values (87629, 74929);
insert into MUSEDINT (tid, mid)
values (87629, 92543);
insert into MUSEDINT (tid, mid)
values (87723, 64442);
insert into MUSEDINT (tid, mid)
values (87726, 32358);
insert into MUSEDINT (tid, mid)
values (87726, 32832);
insert into MUSEDINT (tid, mid)
values (87726, 51773);
insert into MUSEDINT (tid, mid)
values (87726, 54815);
insert into MUSEDINT (tid, mid)
values (87726, 97792);
insert into MUSEDINT (tid, mid)
values (87874, 49899);
insert into MUSEDINT (tid, mid)
values (87874, 75629);
insert into MUSEDINT (tid, mid)
values (87911, 75523);
insert into MUSEDINT (tid, mid)
values (88828, 42862);
insert into MUSEDINT (tid, mid)
values (88828, 75214);
insert into MUSEDINT (tid, mid)
values (88828, 96364);
insert into MUSEDINT (tid, mid)
values (89365, 47254);
insert into MUSEDINT (tid, mid)
values (89365, 49119);
insert into MUSEDINT (tid, mid)
values (89365, 63222);
insert into MUSEDINT (tid, mid)
values (89395, 61678);
insert into MUSEDINT (tid, mid)
values (89584, 53354);
insert into MUSEDINT (tid, mid)
values (89584, 57726);
commit;
prompt 700 records committed...
insert into MUSEDINT (tid, mid)
values (89622, 75759);
insert into MUSEDINT (tid, mid)
values (89623, 22792);
insert into MUSEDINT (tid, mid)
values (89835, 72459);
insert into MUSEDINT (tid, mid)
values (89842, 17584);
insert into MUSEDINT (tid, mid)
values (89842, 33316);
insert into MUSEDINT (tid, mid)
values (89842, 73532);
insert into MUSEDINT (tid, mid)
values (89842, 88277);
insert into MUSEDINT (tid, mid)
values (89842, 89721);
insert into MUSEDINT (tid, mid)
values (89886, 44583);
insert into MUSEDINT (tid, mid)
values (89886, 64295);
insert into MUSEDINT (tid, mid)
values (91341, 15958);
insert into MUSEDINT (tid, mid)
values (91341, 17776);
insert into MUSEDINT (tid, mid)
values (91341, 24183);
insert into MUSEDINT (tid, mid)
values (91341, 26499);
insert into MUSEDINT (tid, mid)
values (91341, 99117);
insert into MUSEDINT (tid, mid)
values (91414, 59978);
insert into MUSEDINT (tid, mid)
values (91414, 71339);
insert into MUSEDINT (tid, mid)
values (91414, 74929);
insert into MUSEDINT (tid, mid)
values (91414, 98781);
insert into MUSEDINT (tid, mid)
values (91757, 61271);
insert into MUSEDINT (tid, mid)
values (91757, 87251);
insert into MUSEDINT (tid, mid)
values (91954, 78965);
insert into MUSEDINT (tid, mid)
values (91977, 53257);
insert into MUSEDINT (tid, mid)
values (91977, 81162);
insert into MUSEDINT (tid, mid)
values (91977, 87251);
insert into MUSEDINT (tid, mid)
values (92264, 32523);
insert into MUSEDINT (tid, mid)
values (92264, 97792);
insert into MUSEDINT (tid, mid)
values (92415, 96421);
insert into MUSEDINT (tid, mid)
values (92415, 99117);
insert into MUSEDINT (tid, mid)
values (92566, 66972);
insert into MUSEDINT (tid, mid)
values (92627, 19246);
insert into MUSEDINT (tid, mid)
values (92639, 19976);
insert into MUSEDINT (tid, mid)
values (92639, 75612);
insert into MUSEDINT (tid, mid)
values (92957, 66362);
insert into MUSEDINT (tid, mid)
values (92957, 97823);
insert into MUSEDINT (tid, mid)
values (92978, 14175);
insert into MUSEDINT (tid, mid)
values (92978, 16331);
insert into MUSEDINT (tid, mid)
values (92978, 66362);
insert into MUSEDINT (tid, mid)
values (92978, 79737);
insert into MUSEDINT (tid, mid)
values (93262, 16331);
insert into MUSEDINT (tid, mid)
values (93326, 43963);
insert into MUSEDINT (tid, mid)
values (93326, 68834);
insert into MUSEDINT (tid, mid)
values (93545, 27386);
insert into MUSEDINT (tid, mid)
values (93545, 28379);
insert into MUSEDINT (tid, mid)
values (93974, 91849);
insert into MUSEDINT (tid, mid)
values (93974, 94698);
insert into MUSEDINT (tid, mid)
values (94371, 15484);
insert into MUSEDINT (tid, mid)
values (94371, 72479);
insert into MUSEDINT (tid, mid)
values (94471, 27386);
insert into MUSEDINT (tid, mid)
values (94471, 33518);
insert into MUSEDINT (tid, mid)
values (94471, 63597);
insert into MUSEDINT (tid, mid)
values (94471, 82918);
insert into MUSEDINT (tid, mid)
values (94556, 63677);
insert into MUSEDINT (tid, mid)
values (94556, 78965);
insert into MUSEDINT (tid, mid)
values (94664, 11127);
insert into MUSEDINT (tid, mid)
values (94664, 75611);
insert into MUSEDINT (tid, mid)
values (94996, 17889);
insert into MUSEDINT (tid, mid)
values (94996, 43389);
insert into MUSEDINT (tid, mid)
values (95197, 54674);
insert into MUSEDINT (tid, mid)
values (95253, 93566);
insert into MUSEDINT (tid, mid)
values (95395, 46421);
insert into MUSEDINT (tid, mid)
values (95395, 62838);
insert into MUSEDINT (tid, mid)
values (95429, 19857);
insert into MUSEDINT (tid, mid)
values (95429, 33316);
insert into MUSEDINT (tid, mid)
values (95429, 83983);
insert into MUSEDINT (tid, mid)
values (95589, 43389);
insert into MUSEDINT (tid, mid)
values (95993, 41311);
insert into MUSEDINT (tid, mid)
values (95993, 66187);
insert into MUSEDINT (tid, mid)
values (95993, 71452);
insert into MUSEDINT (tid, mid)
values (95993, 81624);
insert into MUSEDINT (tid, mid)
values (96533, 23585);
insert into MUSEDINT (tid, mid)
values (96533, 50010);
insert into MUSEDINT (tid, mid)
values (96629, 22533);
insert into MUSEDINT (tid, mid)
values (96629, 52117);
insert into MUSEDINT (tid, mid)
values (96629, 91854);
insert into MUSEDINT (tid, mid)
values (96629, 92543);
insert into MUSEDINT (tid, mid)
values (97162, 38921);
insert into MUSEDINT (tid, mid)
values (97162, 55438);
insert into MUSEDINT (tid, mid)
values (97218, 98796);
insert into MUSEDINT (tid, mid)
values (97845, 49119);
insert into MUSEDINT (tid, mid)
values (97845, 63768);
insert into MUSEDINT (tid, mid)
values (97898, 18197);
insert into MUSEDINT (tid, mid)
values (97898, 49631);
insert into MUSEDINT (tid, mid)
values (97898, 97441);
insert into MUSEDINT (tid, mid)
values (98297, 34263);
insert into MUSEDINT (tid, mid)
values (98297, 43389);
insert into MUSEDINT (tid, mid)
values (98297, 94596);
insert into MUSEDINT (tid, mid)
values (98519, 95514);
insert into MUSEDINT (tid, mid)
values (99444, 26412);
insert into MUSEDINT (tid, mid)
values (99444, 36778);
insert into MUSEDINT (tid, mid)
values (99444, 54227);
insert into MUSEDINT (tid, mid)
values (99444, 71723);
insert into MUSEDINT (tid, mid)
values (99588, 56873);
insert into MUSEDINT (tid, mid)
values (99588, 63236);
insert into MUSEDINT (tid, mid)
values (99588, 98517);
insert into MUSEDINT (tid, mid)
values (99975, 42668);
insert into MUSEDINT (tid, mid)
values (99975, 97441);
commit;
prompt 797 records loaded
prompt Loading OFFICE...
insert into OFFICE (otype, sid)
values ('Counter', 13261);
insert into OFFICE (otype, sid)
values ('Counter', 10008);
insert into OFFICE (otype, sid)
values ('Customer Servic', 24626);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 18791);
insert into OFFICE (otype, sid)
values ('Customer Servic', 69880);
insert into OFFICE (otype, sid)
values ('IT', 66715);
insert into OFFICE (otype, sid)
values ('Customer Servic', 69221);
insert into OFFICE (otype, sid)
values ('Customer Servic', 48188);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 25190);
insert into OFFICE (otype, sid)
values ('IT', 35877);
insert into OFFICE (otype, sid)
values ('IT', 10010);
insert into OFFICE (otype, sid)
values ('Shift Manager', 45109);
insert into OFFICE (otype, sid)
values ('Shift Manager', 31448);
insert into OFFICE (otype, sid)
values ('IT', 63762);
insert into OFFICE (otype, sid)
values ('Counter', 83526);
insert into OFFICE (otype, sid)
values ('Customer Servic', 42122);
insert into OFFICE (otype, sid)
values ('Shift Manager', 31947);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 10003);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 63761);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 70250);
insert into OFFICE (otype, sid)
values ('IT', 95896);
insert into OFFICE (otype, sid)
values ('IT', 64076);
insert into OFFICE (otype, sid)
values ('Counter', 10770);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 11630);
insert into OFFICE (otype, sid)
values ('IT', 83689);
insert into OFFICE (otype, sid)
values ('Counter', 43573);
insert into OFFICE (otype, sid)
values ('Customer Servic', 78475);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 13243);
insert into OFFICE (otype, sid)
values ('IT', 12245);
insert into OFFICE (otype, sid)
values ('IT', 50112);
insert into OFFICE (otype, sid)
values ('Counter', 82258);
insert into OFFICE (otype, sid)
values ('Shift Manager', 11311);
insert into OFFICE (otype, sid)
values ('IT', 89219);
insert into OFFICE (otype, sid)
values ('Customer Servic', 67810);
insert into OFFICE (otype, sid)
values ('Shift Manager', 83250);
insert into OFFICE (otype, sid)
values ('Shift Manager', 21996);
insert into OFFICE (otype, sid)
values ('IT', 74091);
insert into OFFICE (otype, sid)
values ('Customer Servic', 72073);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 62317);
insert into OFFICE (otype, sid)
values ('Customer Servic', 68890);
insert into OFFICE (otype, sid)
values ('IT', 49355);
insert into OFFICE (otype, sid)
values ('IT', 47411);
insert into OFFICE (otype, sid)
values ('Counter', 51251);
insert into OFFICE (otype, sid)
values ('Customer Servic', 48224);
insert into OFFICE (otype, sid)
values ('Counter', 86538);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 13854);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 80248);
insert into OFFICE (otype, sid)
values ('Counter', 66915);
insert into OFFICE (otype, sid)
values ('Customer Servic', 16017);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 58938);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 99939);
insert into OFFICE (otype, sid)
values ('IT', 21312);
insert into OFFICE (otype, sid)
values ('IT', 80830);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 81184);
insert into OFFICE (otype, sid)
values ('Customer Servic', 18525);
insert into OFFICE (otype, sid)
values ('Counter', 95320);
insert into OFFICE (otype, sid)
values ('Shift Manager', 31979);
insert into OFFICE (otype, sid)
values ('IT', 89061);
insert into OFFICE (otype, sid)
values ('Customer Servic', 71870);
insert into OFFICE (otype, sid)
values ('Shift Manager', 34214);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 68549);
insert into OFFICE (otype, sid)
values ('Customer Servic', 14599);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 32593);
insert into OFFICE (otype, sid)
values ('IT', 57567);
insert into OFFICE (otype, sid)
values ('Customer Servic', 51125);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 35535);
insert into OFFICE (otype, sid)
values ('Customer Servic', 21395);
insert into OFFICE (otype, sid)
values ('Customer Servic', 40705);
insert into OFFICE (otype, sid)
values ('Shift Manager', 15536);
insert into OFFICE (otype, sid)
values ('Shift Manager', 55546);
insert into OFFICE (otype, sid)
values ('Shift Manager', 22236);
insert into OFFICE (otype, sid)
values ('Customer Servic', 17595);
insert into OFFICE (otype, sid)
values ('IT', 69468);
insert into OFFICE (otype, sid)
values ('Counter', 12053);
insert into OFFICE (otype, sid)
values ('Counter', 83271);
insert into OFFICE (otype, sid)
values ('Shift Manager', 56476);
insert into OFFICE (otype, sid)
values ('Shift Manager', 74548);
insert into OFFICE (otype, sid)
values ('IT', 70482);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 51524);
insert into OFFICE (otype, sid)
values ('IT', 64185);
insert into OFFICE (otype, sid)
values ('Customer Servic', 90152);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 41120);
insert into OFFICE (otype, sid)
values ('IT', 83831);
insert into OFFICE (otype, sid)
values ('Shift Manager', 17989);
insert into OFFICE (otype, sid)
values ('Customer Servic', 30696);
insert into OFFICE (otype, sid)
values ('IT', 74841);
insert into OFFICE (otype, sid)
values ('Shift Manager', 59839);
insert into OFFICE (otype, sid)
values ('Customer Servic', 98364);
insert into OFFICE (otype, sid)
values ('Counter', 96640);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 24608);
insert into OFFICE (otype, sid)
values ('Customer Servic', 17105);
insert into OFFICE (otype, sid)
values ('Counter', 91539);
insert into OFFICE (otype, sid)
values ('Customer Servic', 28053);
insert into OFFICE (otype, sid)
values ('Shift Manager', 23821);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 45223);
insert into OFFICE (otype, sid)
values ('Shift Manager', 53805);
insert into OFFICE (otype, sid)
values ('Shift Manager', 76380);
insert into OFFICE (otype, sid)
values ('IT', 27991);
insert into OFFICE (otype, sid)
values ('IT', 89350);
insert into OFFICE (otype, sid)
values ('Shift Manager', 22440);
commit;
prompt 100 records committed...
insert into OFFICE (otype, sid)
values ('Counter', 81284);
insert into OFFICE (otype, sid)
values ('Shift Manager', 15746);
insert into OFFICE (otype, sid)
values ('IT', 34609);
insert into OFFICE (otype, sid)
values ('Customer Servic', 15343);
insert into OFFICE (otype, sid)
values ('IT', 82187);
insert into OFFICE (otype, sid)
values ('Customer Servic', 20080);
insert into OFFICE (otype, sid)
values ('IT', 55295);
insert into OFFICE (otype, sid)
values ('IT', 93908);
insert into OFFICE (otype, sid)
values ('Customer Servic', 99681);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 61546);
insert into OFFICE (otype, sid)
values ('Customer Servic', 99769);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 61039);
insert into OFFICE (otype, sid)
values ('Counter', 19671);
insert into OFFICE (otype, sid)
values ('Counter', 27600);
insert into OFFICE (otype, sid)
values ('Shift Manager', 91660);
insert into OFFICE (otype, sid)
values ('Counter', 39306);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 61721);
insert into OFFICE (otype, sid)
values ('IT', 67343);
insert into OFFICE (otype, sid)
values ('Customer Servic', 91368);
insert into OFFICE (otype, sid)
values ('Customer Servic', 18401);
insert into OFFICE (otype, sid)
values ('IT', 65741);
insert into OFFICE (otype, sid)
values ('Shift Manager', 18863);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 95541);
insert into OFFICE (otype, sid)
values ('Customer Servic', 84940);
insert into OFFICE (otype, sid)
values ('Shift Manager', 66029);
insert into OFFICE (otype, sid)
values ('Counter', 55244);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 10005);
insert into OFFICE (otype, sid)
values ('IT', 58235);
insert into OFFICE (otype, sid)
values ('IT', 33143);
insert into OFFICE (otype, sid)
values ('IT', 16012);
insert into OFFICE (otype, sid)
values ('Counter', 54662);
insert into OFFICE (otype, sid)
values ('Customer Servic', 59791);
insert into OFFICE (otype, sid)
values ('IT', 57210);
insert into OFFICE (otype, sid)
values ('IT', 49666);
insert into OFFICE (otype, sid)
values ('Customer Servic', 51861);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 42991);
insert into OFFICE (otype, sid)
values ('Counter', 15962);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 97879);
insert into OFFICE (otype, sid)
values ('IT', 70610);
insert into OFFICE (otype, sid)
values ('Shift Manager', 25922);
insert into OFFICE (otype, sid)
values ('Counter', 90376);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 99778);
insert into OFFICE (otype, sid)
values ('Shift Manager', 26135);
insert into OFFICE (otype, sid)
values ('Customer Servic', 18773);
insert into OFFICE (otype, sid)
values ('Counter', 27637);
insert into OFFICE (otype, sid)
values ('IT', 98750);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 54266);
insert into OFFICE (otype, sid)
values ('Counter', 89885);
insert into OFFICE (otype, sid)
values ('Shift Manager', 15963);
insert into OFFICE (otype, sid)
values ('Counter', 79374);
insert into OFFICE (otype, sid)
values ('Counter', 12082);
insert into OFFICE (otype, sid)
values ('Counter', 37345);
insert into OFFICE (otype, sid)
values ('IT', 44433);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 16063);
insert into OFFICE (otype, sid)
values ('Customer Servic', 31151);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 33749);
insert into OFFICE (otype, sid)
values ('Shift Manager', 77955);
insert into OFFICE (otype, sid)
values ('Shift Manager', 37415);
insert into OFFICE (otype, sid)
values ('Counter', 10009);
insert into OFFICE (otype, sid)
values ('IT', 19936);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 92960);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 30379);
insert into OFFICE (otype, sid)
values ('IT', 45377);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 39663);
insert into OFFICE (otype, sid)
values ('Customer Servic', 62741);
insert into OFFICE (otype, sid)
values ('Counter', 23953);
insert into OFFICE (otype, sid)
values ('IT', 89337);
insert into OFFICE (otype, sid)
values ('Shift Manager', 92935);
insert into OFFICE (otype, sid)
values ('Counter', 83211);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 73025);
insert into OFFICE (otype, sid)
values ('Shift Manager', 81157);
insert into OFFICE (otype, sid)
values ('Counter', 88541);
insert into OFFICE (otype, sid)
values ('Customer Servic', 36012);
insert into OFFICE (otype, sid)
values ('IT', 66193);
insert into OFFICE (otype, sid)
values ('Customer Servic', 92716);
insert into OFFICE (otype, sid)
values ('Customer Servic', 19365);
insert into OFFICE (otype, sid)
values ('Customer Servic', 39365);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 99553);
insert into OFFICE (otype, sid)
values ('Customer Servic', 30063);
insert into OFFICE (otype, sid)
values ('Shift Manager', 72375);
insert into OFFICE (otype, sid)
values ('Counter', 44156);
insert into OFFICE (otype, sid)
values ('IT', 42679);
insert into OFFICE (otype, sid)
values ('Customer Servic', 21570);
insert into OFFICE (otype, sid)
values ('Customer Servic', 35553);
insert into OFFICE (otype, sid)
values ('IT', 46197);
insert into OFFICE (otype, sid)
values ('Customer Servic', 72497);
insert into OFFICE (otype, sid)
values ('Shift Manager', 28651);
insert into OFFICE (otype, sid)
values ('Shift Manager', 27715);
insert into OFFICE (otype, sid)
values ('IT', 26952);
insert into OFFICE (otype, sid)
values ('Shift Manager', 91865);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 19618);
insert into OFFICE (otype, sid)
values ('Customer Servic', 96641);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 96456);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 49506);
insert into OFFICE (otype, sid)
values ('Counter', 99475);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 19098);
insert into OFFICE (otype, sid)
values ('Shift Manager', 40849);
insert into OFFICE (otype, sid)
values ('Customer Servic', 49449);
insert into OFFICE (otype, sid)
values ('Shift Manager', 27277);
insert into OFFICE (otype, sid)
values ('Customer Servic', 34404);
commit;
prompt 200 records committed...
insert into OFFICE (otype, sid)
values ('IT', 91156);
insert into OFFICE (otype, sid)
values ('IT', 79591);
insert into OFFICE (otype, sid)
values ('IT', 32568);
insert into OFFICE (otype, sid)
values ('IT', 31845);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 40041);
insert into OFFICE (otype, sid)
values ('IT', 45148);
insert into OFFICE (otype, sid)
values ('IT', 94830);
insert into OFFICE (otype, sid)
values ('Customer Servic', 31696);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 68229);
insert into OFFICE (otype, sid)
values ('Shift Manager', 86842);
insert into OFFICE (otype, sid)
values ('Secretariat', 10011);
insert into OFFICE (otype, sid)
values ('Sales', 10012);
insert into OFFICE (otype, sid)
values ('Secretariat', 10013);
insert into OFFICE (otype, sid)
values ('Sales', 10014);
insert into OFFICE (otype, sid)
values ('Secretariat', 10015);
insert into OFFICE (otype, sid)
values ('Secretariat', 10016);
insert into OFFICE (otype, sid)
values ('Sales', 10017);
insert into OFFICE (otype, sid)
values ('Shift Manager', 10018);
insert into OFFICE (otype, sid)
values ('Shift Manager', 10019);
insert into OFFICE (otype, sid)
values ('Sales', 10020);
insert into OFFICE (otype, sid)
values ('Shift Manager', 12979);
insert into OFFICE (otype, sid)
values ('Sales', 68062);
insert into OFFICE (otype, sid)
values ('Customer Servic', 59041);
insert into OFFICE (otype, sid)
values ('Secretariat''', 73373);
insert into OFFICE (otype, sid)
values ('Shift Manager', 87171);
insert into OFFICE (otype, sid)
values ('Secretariat''', 78572);
insert into OFFICE (otype, sid)
values ('Secretariat''', 41224);
insert into OFFICE (otype, sid)
values ('Shift Manager', 86483);
insert into OFFICE (otype, sid)
values ('Sales', 57569);
insert into OFFICE (otype, sid)
values ('Secretariat''', 29872);
insert into OFFICE (otype, sid)
values ('Secretariat''', 25578);
insert into OFFICE (otype, sid)
values ('Customer Servic', 98375);
insert into OFFICE (otype, sid)
values ('Secretariat''', 26921);
insert into OFFICE (otype, sid)
values ('Shift Manager', 69582);
insert into OFFICE (otype, sid)
values ('Secretariat''', 38296);
insert into OFFICE (otype, sid)
values ('Shift Manager', 64636);
insert into OFFICE (otype, sid)
values ('Customer Servic', 45839);
insert into OFFICE (otype, sid)
values ('Counter', 34002);
insert into OFFICE (otype, sid)
values ('Secretariat''', 18802);
insert into OFFICE (otype, sid)
values ('Secretariat''', 55385);
insert into OFFICE (otype, sid)
values ('Secretariat''', 81894);
insert into OFFICE (otype, sid)
values ('IT', 49969);
insert into OFFICE (otype, sid)
values ('Counter', 51383);
insert into OFFICE (otype, sid)
values ('Shift Manager', 65613);
insert into OFFICE (otype, sid)
values ('Sales', 10334);
insert into OFFICE (otype, sid)
values ('Counter', 16712);
insert into OFFICE (otype, sid)
values ('Customer Servic', 99596);
insert into OFFICE (otype, sid)
values ('Secretariat''', 47970);
insert into OFFICE (otype, sid)
values ('Customer Servic', 29127);
insert into OFFICE (otype, sid)
values ('Secretariat''', 33360);
insert into OFFICE (otype, sid)
values ('IT', 83782);
insert into OFFICE (otype, sid)
values ('Counter', 47962);
insert into OFFICE (otype, sid)
values ('Counter', 74972);
insert into OFFICE (otype, sid)
values ('Sales', 32397);
insert into OFFICE (otype, sid)
values ('Shift Manager', 41470);
insert into OFFICE (otype, sid)
values ('Shift Manager', 29561);
insert into OFFICE (otype, sid)
values ('Sales', 68429);
insert into OFFICE (otype, sid)
values ('IT', 55269);
insert into OFFICE (otype, sid)
values ('Sales', 36074);
insert into OFFICE (otype, sid)
values ('IT', 10006);
insert into OFFICE (otype, sid)
values ('IT', 50598);
insert into OFFICE (otype, sid)
values ('Counter', 88762);
insert into OFFICE (otype, sid)
values ('Counter', 76589);
insert into OFFICE (otype, sid)
values ('IT', 24963);
insert into OFFICE (otype, sid)
values ('Shift Manager', 81875);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 60334);
insert into OFFICE (otype, sid)
values ('Shift Manager', 65725);
insert into OFFICE (otype, sid)
values ('IT', 88875);
insert into OFFICE (otype, sid)
values ('IT', 30610);
insert into OFFICE (otype, sid)
values ('Customer Servic', 74331);
insert into OFFICE (otype, sid)
values ('Sales Secretari', 76479);
insert into OFFICE (otype, sid)
values ('Shift Manager', 10007);
insert into OFFICE (otype, sid)
values ('Counter', 84092);
insert into OFFICE (otype, sid)
values ('Shift Manager', 48212);
insert into OFFICE (otype, sid)
values ('Counter', 47027);
insert into OFFICE (otype, sid)
values ('Counter', 34941);
insert into OFFICE (otype, sid)
values ('Customer Servic', 73586);
insert into OFFICE (otype, sid)
values ('Customer Servic', 43915);
commit;
prompt 278 records loaded
prompt Loading TEETH_APPOINTMENT...
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-03-2026', 'dd-mm-yyyy'), 52254, 86842, 230);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-03-2026', 'dd-mm-yyyy'), 59864, 76380, 150);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-03-2026', 'dd-mm-yyyy'), 38929, 10007, 910);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-03-2029', 'dd-mm-yyyy'), 84576, 68229, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-03-2028', 'dd-mm-yyyy'), 83531, 88571, 816);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-06-2027', 'dd-mm-yyyy'), 84988, 66193, 119);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-07-2027', 'dd-mm-yyyy'), 33732, 61546, 349);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-06-2024', 'dd-mm-yyyy'), 95217, 43915, 495);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-07-2025', 'dd-mm-yyyy'), 25556, 69296, 351);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-01-2025', 'dd-mm-yyyy'), 27367, 11630, 599);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-03-2026', 'dd-mm-yyyy'), 62316, 56476, 889);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-03-2026', 'dd-mm-yyyy'), 21575, 53998, 778);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-04-2029', 'dd-mm-yyyy'), 54755, 33532, 20005);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-01-2027', 'dd-mm-yyyy'), 19548, 63284, 262);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-09-2027', 'dd-mm-yyyy'), 44623, 84092, 131);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-06-2028', 'dd-mm-yyyy'), 56368, 87909, 351);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-05-2027', 'dd-mm-yyyy'), 45389, 56476, 714);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-12-2026', 'dd-mm-yyyy'), 94296, 47507, 597);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('26-03-2029', 'dd-mm-yyyy'), 53498, 57567, 468);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-07-2027', 'dd-mm-yyyy'), 45686, 12082, 218);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-03-2026', 'dd-mm-yyyy'), 45835, 43702, 392);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-06-2028', 'dd-mm-yyyy'), 52137, 96750, 835);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-10-2024', 'dd-mm-yyyy'), 46912, 18401, 874);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-06-2024', 'dd-mm-yyyy'), 52596, 64185, 392);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-10-2027', 'dd-mm-yyyy'), 61651, 68062, 418);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-03-2026', 'dd-mm-yyyy'), 84117, 13794, 309);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('22-10-2026', 'dd-mm-yyyy'), 37869, 31845, 778);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-01-2024', 'dd-mm-yyyy'), 71125, 68062, 676);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('29-11-2027', 'dd-mm-yyyy'), 76411, 48188, 488);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-12-2026', 'dd-mm-yyyy'), 13121, 68229, 764);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-06-2024', 'dd-mm-yyyy'), 97618, 95541, 714);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-11-2028', 'dd-mm-yyyy'), 96463, 15746, 709);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-11-2029', 'dd-mm-yyyy'), 42735, 10013, 639);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-12-2025', 'dd-mm-yyyy'), 29134, 31151, 625);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-04-2027', 'dd-mm-yyyy'), 43913, 79819, 901);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('23-09-2025', 'dd-mm-yyyy'), 69466, 10014, 219);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-02-2025', 'dd-mm-yyyy'), 72115, 71959, 943);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-01-2028', 'dd-mm-yyyy'), 22834, 82443, 708);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-08-2029', 'dd-mm-yyyy'), 67984, 10014, 698);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-04-2026', 'dd-mm-yyyy'), 52292, 84940, 855);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-07-2028', 'dd-mm-yyyy'), 66364, 45148, 775);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('29-08-2028', 'dd-mm-yyyy'), 91912, 10017, 660);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-12-2025', 'dd-mm-yyyy'), 13831, 26135, 995);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-03-2025', 'dd-mm-yyyy'), 69165, 10008, 709);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-12-2026', 'dd-mm-yyyy'), 17911, 63284, 798);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-04-2026', 'dd-mm-yyyy'), 34243, 69468, 362);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-03-2028', 'dd-mm-yyyy'), 76248, 33794, 878);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('10-02-2029', 'dd-mm-yyyy'), 25854, 51672, 934);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('04-09-2026', 'dd-mm-yyyy'), 38338, 84301, 199);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-06-2026', 'dd-mm-yyyy'), 68789, 32397, 991);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-03-2028', 'dd-mm-yyyy'), 51562, 12082, 151);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-04-2027', 'dd-mm-yyyy'), 43748, 44156, 418);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-12-2025', 'dd-mm-yyyy'), 62759, 56476, 769);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('04-06-2029', 'dd-mm-yyyy'), 92499, 69296, 322);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('10-07-2027', 'dd-mm-yyyy'), 74655, 12082, 274);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-01-2028', 'dd-mm-yyyy'), 72625, 26135, 874);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-12-2026', 'dd-mm-yyyy'), 72766, 96640, 457);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-05-2024', 'dd-mm-yyyy'), 21632, 64185, 20008);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-09-2025', 'dd-mm-yyyy'), 82123, 64760, 715);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-04-2028', 'dd-mm-yyyy'), 87144, 63961, 839);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-05-2029', 'dd-mm-yyyy'), 41847, 96640, 700);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-03-2025', 'dd-mm-yyyy'), 84414, 21996, 569);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-01-2026', 'dd-mm-yyyy'), 48827, 80248, 774);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-02-2026', 'dd-mm-yyyy'), 81152, 52116, 884);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-02-2025', 'dd-mm-yyyy'), 52545, 27192, 943);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-11-2028', 'dd-mm-yyyy'), 28354, 74841, 336);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('22-09-2029', 'dd-mm-yyyy'), 31743, 41224, 572);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-03-2026', 'dd-mm-yyyy'), 57217, 15963, 20006);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-08-2027', 'dd-mm-yyyy'), 49749, 35535, 610);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-11-2026', 'dd-mm-yyyy'), 24577, 89219, 293);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('26-09-2029', 'dd-mm-yyyy'), 65711, 11630, 848);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-02-2028', 'dd-mm-yyyy'), 36544, 10005, 572);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-07-2024', 'dd-mm-yyyy'), 38161, 50112, 567);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-12-2029', 'dd-mm-yyyy'), 37782, 45148, 647);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-12-2028', 'dd-mm-yyyy'), 58994, 24608, 599);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-04-2026', 'dd-mm-yyyy'), 55163, 86842, 20005);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-12-2024', 'dd-mm-yyyy'), 19487, 68062, 743);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('14-04-2025', 'dd-mm-yyyy'), 17373, 63036, 877);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-01-2028', 'dd-mm-yyyy'), 66593, 91368, 181);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-01-2028', 'dd-mm-yyyy'), 24984, 69880, 556);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-01-2024', 'dd-mm-yyyy'), 31688, 64760, 901);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-02-2025', 'dd-mm-yyyy'), 42917, 72820, 20003);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-07-2025', 'dd-mm-yyyy'), 45659, 10652, 20002);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-06-2029', 'dd-mm-yyyy'), 88298, 81894, 281);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-09-2026', 'dd-mm-yyyy'), 13713, 99681, 717);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-08-2024', 'dd-mm-yyyy'), 21367, 51672, 219);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('04-11-2029', 'dd-mm-yyyy'), 83564, 43702, 469);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-08-2027', 'dd-mm-yyyy'), 92316, 76380, 833);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-11-2029', 'dd-mm-yyyy'), 53947, 95541, 459);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-07-2025', 'dd-mm-yyyy'), 71381, 87909, 872);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('14-03-2029', 'dd-mm-yyyy'), 96657, 33794, 448);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-03-2026', 'dd-mm-yyyy'), 47365, 35535, 328);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-02-2028', 'dd-mm-yyyy'), 24399, 64076, 328);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-08-2024', 'dd-mm-yyyy'), 34639, 10002, 20006);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-08-2027', 'dd-mm-yyyy'), 12567, 10009, 828);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-11-2029', 'dd-mm-yyyy'), 29966, 68549, 820);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-12-2025', 'dd-mm-yyyy'), 71127, 88571, 409);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-07-2025', 'dd-mm-yyyy'), 66549, 37004, 777);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-02-2027', 'dd-mm-yyyy'), 56515, 50112, 473);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-03-2026', 'dd-mm-yyyy'), 53336, 10012, 129);
commit;
prompt 100 records committed...
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-09-2025', 'dd-mm-yyyy'), 88626, 27379, 569);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-08-2026', 'dd-mm-yyyy'), 49621, 69880, 685);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-06-2027', 'dd-mm-yyyy'), 19338, 44135, 745);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-07-2027', 'dd-mm-yyyy'), 61435, 15343, 914);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-08-2027', 'dd-mm-yyyy'), 53332, 18401, 504);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-02-2027', 'dd-mm-yyyy'), 81399, 10002, 562);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-01-2026', 'dd-mm-yyyy'), 76595, 37345, 136);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('26-01-2029', 'dd-mm-yyyy'), 59487, 74091, 736);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('10-08-2029', 'dd-mm-yyyy'), 18422, 71959, 713);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-04-2027', 'dd-mm-yyyy'), 93665, 51524, 562);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-07-2024', 'dd-mm-yyyy'), 36944, 55149, 717);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-10-2026', 'dd-mm-yyyy'), 62424, 10013, 946);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-08-2027', 'dd-mm-yyyy'), 91818, 80830, 647);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-12-2027', 'dd-mm-yyyy'), 32922, 76380, 201);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-03-2028', 'dd-mm-yyyy'), 37512, 10002, 647);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-07-2029', 'dd-mm-yyyy'), 24947, 50112, 660);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('22-04-2027', 'dd-mm-yyyy'), 84937, 12082, 389);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-12-2024', 'dd-mm-yyyy'), 31448, 56476, 314);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-01-2028', 'dd-mm-yyyy'), 16195, 52769, 654);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-02-2029', 'dd-mm-yyyy'), 39257, 69468, 890);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('10-04-2026', 'dd-mm-yyyy'), 46594, 10007, 930);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-12-2026', 'dd-mm-yyyy'), 17698, 96640, 20007);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-02-2025', 'dd-mm-yyyy'), 43552, 69221, 488);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('23-01-2024', 'dd-mm-yyyy'), 66745, 64076, 468);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-11-2025', 'dd-mm-yyyy'), 82439, 83782, 324);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-05-2025', 'dd-mm-yyyy'), 45949, 26135, 885);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-04-2024', 'dd-mm-yyyy'), 14235, 80248, 624);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-10-2025', 'dd-mm-yyyy'), 46981, 49355, 20008);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-06-2025', 'dd-mm-yyyy'), 36499, 32397, 941);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('10-08-2024', 'dd-mm-yyyy'), 79234, 10011, 743);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-03-2028', 'dd-mm-yyyy'), 39953, 99681, 391);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-06-2028', 'dd-mm-yyyy'), 97666, 72479, 975);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-12-2027', 'dd-mm-yyyy'), 37495, 35535, 584);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-10-2029', 'dd-mm-yyyy'), 26699, 22236, 653);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-04-2025', 'dd-mm-yyyy'), 47288, 10009, 899);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-05-2027', 'dd-mm-yyyy'), 83316, 13261, 829);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-06-2028', 'dd-mm-yyyy'), 49699, 39663, 327);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('10-06-2024', 'dd-mm-yyyy'), 39876, 10001, 20001);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-07-2024', 'dd-mm-yyyy'), 59788, 79374, 930);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-07-2025', 'dd-mm-yyyy'), 57917, 10006, 20006);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-07-2026', 'dd-mm-yyyy'), 57987, 10007, 20006);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-07-2027', 'dd-mm-yyyy'), 36965, 66193, 20006);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-07-2025', 'dd-mm-yyyy'), 30093, 95541, 20006);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99860, 43931, 727);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99861, 43931, 727);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99862, 38187, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99863, 38187, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-07-2024', 'dd-mm-yyyy'), 59693, 39663, 130);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-07-2027', 'dd-mm-yyyy'), 59991, 39663, 119);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-07-2027', 'dd-mm-yyyy'), 84989, 39663, 20009);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99864, 38187, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-12-2025', 'dd-mm-yyyy'), 99865, 38187, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-02-2025', 'dd-mm-yyyy'), 99866, 38187, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-02-2025', 'dd-mm-yyyy'), 99867, 38187, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-02-2025', 'dd-mm-yyyy'), 99868, 38187, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-02-2025', 'dd-mm-yyyy'), 99869, 38187, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-02-2025', 'dd-mm-yyyy'), 99870, 38187, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-09-2027', 'dd-mm-yyyy'), 85315, 99769, 897);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-12-2024', 'dd-mm-yyyy'), 51477, 89337, 371);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-11-2025', 'dd-mm-yyyy'), 92754, 39306, 588);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-05-2028', 'dd-mm-yyyy'), 24385, 51524, 809);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('29-09-2029', 'dd-mm-yyyy'), 17326, 38187, 374);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-04-2026', 'dd-mm-yyyy'), 39425, 86842, 669);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-07-2027', 'dd-mm-yyyy'), 26926, 10004, 518);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-12-2026', 'dd-mm-yyyy'), 17642, 72820, 842);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-10-2028', 'dd-mm-yyyy'), 98965, 48188, 653);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-04-2025', 'dd-mm-yyyy'), 57934, 98364, 941);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-09-2024', 'dd-mm-yyyy'), 28113, 10004, 727);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-02-2029', 'dd-mm-yyyy'), 77442, 41224, 572);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-03-2027', 'dd-mm-yyyy'), 43637, 84940, 662);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-05-2026', 'dd-mm-yyyy'), 76744, 90716, 833);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-01-2029', 'dd-mm-yyyy'), 65772, 15357, 828);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-03-2029', 'dd-mm-yyyy'), 37345, 17595, 747);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-02-2025', 'dd-mm-yyyy'), 36749, 87909, 144);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('04-12-2028', 'dd-mm-yyyy'), 34262, 69468, 153);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-04-2026', 'dd-mm-yyyy'), 44782, 87909, 219);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-05-2028', 'dd-mm-yyyy'), 63768, 84092, 760);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-07-2026', 'dd-mm-yyyy'), 83776, 68229, 577);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-12-2026', 'dd-mm-yyyy'), 11395, 61546, 901);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-09-2029', 'dd-mm-yyyy'), 53751, 49666, 903);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-09-2028', 'dd-mm-yyyy'), 37748, 62435, 208);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-06-2027', 'dd-mm-yyyy'), 69154, 15746, 328);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-06-2027', 'dd-mm-yyyy'), 66449, 13227, 812);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-08-2026', 'dd-mm-yyyy'), 41656, 10005, 201);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-01-2027', 'dd-mm-yyyy'), 66771, 86483, 871);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-06-2027', 'dd-mm-yyyy'), 11626, 98364, 609);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-03-2026', 'dd-mm-yyyy'), 52874, 89337, 648);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-04-2026', 'dd-mm-yyyy'), 54365, 26135, 674);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-01-2027', 'dd-mm-yyyy'), 54965, 28053, 208);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-03-2024', 'dd-mm-yyyy'), 32867, 54635, 399);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-10-2025', 'dd-mm-yyyy'), 84952, 45674, 470);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-07-2029', 'dd-mm-yyyy'), 42733, 74548, 162);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-05-2027', 'dd-mm-yyyy'), 78212, 79859, 618);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-12-2024', 'dd-mm-yyyy'), 18621, 10014, 572);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-10-2029', 'dd-mm-yyyy'), 27341, 68062, 783);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-05-2029', 'dd-mm-yyyy'), 13927, 84092, 109);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-04-2027', 'dd-mm-yyyy'), 61472, 63961, 984);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-01-2029', 'dd-mm-yyyy'), 78759, 52116, 743);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('10-07-2024', 'dd-mm-yyyy'), 28593, 27715, 553);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-04-2028', 'dd-mm-yyyy'), 65252, 63284, 799);
commit;
prompt 200 records committed...
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-04-2027', 'dd-mm-yyyy'), 28734, 25578, 705);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-02-2027', 'dd-mm-yyyy'), 91955, 12082, 715);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-11-2026', 'dd-mm-yyyy'), 37772, 92442, 567);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-03-2028', 'dd-mm-yyyy'), 37638, 35130, 218);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-07-2027', 'dd-mm-yyyy'), 98235, 83782, 110);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-06-2029', 'dd-mm-yyyy'), 69782, 39663, 221);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-03-2026', 'dd-mm-yyyy'), 44833, 10001, 408);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-07-2027', 'dd-mm-yyyy'), 82615, 44156, 689);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-11-2026', 'dd-mm-yyyy'), 26331, 24656, 778);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-11-2029', 'dd-mm-yyyy'), 82256, 41224, 502);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-04-2024', 'dd-mm-yyyy'), 73638, 46150, 309);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-08-2026', 'dd-mm-yyyy'), 53981, 55269, 633);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-03-2029', 'dd-mm-yyyy'), 36928, 18525, 552);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-03-2024', 'dd-mm-yyyy'), 78657, 68229, 698);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-05-2027', 'dd-mm-yyyy'), 44265, 19936, 747);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-05-2024', 'dd-mm-yyyy'), 79322, 52769, 307);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-11-2027', 'dd-mm-yyyy'), 41561, 10004, 832);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-07-2026', 'dd-mm-yyyy'), 68462, 31947, 984);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-05-2025', 'dd-mm-yyyy'), 78169, 21570, 262);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('29-12-2025', 'dd-mm-yyyy'), 65466, 89337, 250);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-10-2024', 'dd-mm-yyyy'), 59588, 67810, 324);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-10-2025', 'dd-mm-yyyy'), 14242, 64076, 562);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-06-2025', 'dd-mm-yyyy'), 86627, 61696, 652);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-07-2027', 'dd-mm-yyyy'), 61521, 84092, 292);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-10-2025', 'dd-mm-yyyy'), 19776, 10652, 698);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-03-2027', 'dd-mm-yyyy'), 73524, 26135, 879);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-11-2025', 'dd-mm-yyyy'), 14115, 10004, 584);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('23-12-2024', 'dd-mm-yyyy'), 31496, 43915, 328);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('14-06-2024', 'dd-mm-yyyy'), 49211, 41224, 743);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-04-2027', 'dd-mm-yyyy'), 97122, 80248, 144);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-07-2026', 'dd-mm-yyyy'), 72942, 64760, 471);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-01-2029', 'dd-mm-yyyy'), 42978, 50906, 117);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('26-11-2027', 'dd-mm-yyyy'), 26256, 61435, 242);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-02-2026', 'dd-mm-yyyy'), 48557, 25578, 585);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('29-09-2027', 'dd-mm-yyyy'), 89616, 80830, 569);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-01-2027', 'dd-mm-yyyy'), 58911, 79374, 610);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-08-2029', 'dd-mm-yyyy'), 67992, 51672, 978);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-05-2027', 'dd-mm-yyyy'), 13184, 63284, 433);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-01-2029', 'dd-mm-yyyy'), 54111, 15343, 556);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-01-2029', 'dd-mm-yyyy'), 79599, 50112, 412);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-01-2024', 'dd-mm-yyyy'), 12617, 95320, 902);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-12-2026', 'dd-mm-yyyy'), 49174, 54635, 568);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-11-2028', 'dd-mm-yyyy'), 64847, 21996, 152);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-10-2029', 'dd-mm-yyyy'), 13358, 38296, 751);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-12-2027', 'dd-mm-yyyy'), 32614, 68549, 586);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-11-2025', 'dd-mm-yyyy'), 59883, 10652, 338);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-05-2024', 'dd-mm-yyyy'), 31554, 91539, 513);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-07-2025', 'dd-mm-yyyy'), 37223, 32568, 562);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('29-11-2029', 'dd-mm-yyyy'), 93742, 61546, 437);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-10-2025', 'dd-mm-yyyy'), 53587, 37004, 220);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-10-2029', 'dd-mm-yyyy'), 44887, 25922, 293);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-07-2025', 'dd-mm-yyyy'), 68242, 39663, 856);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('23-06-2024', 'dd-mm-yyyy'), 24676, 99939, 584);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-07-2024', 'dd-mm-yyyy'), 11912, 54635, 207);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-07-2028', 'dd-mm-yyyy'), 14715, 64185, 709);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-01-2027', 'dd-mm-yyyy'), 62834, 70748, 877);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('10-04-2028', 'dd-mm-yyyy'), 22473, 68229, 559);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-08-2027', 'dd-mm-yyyy'), 99385, 11630, 543);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-04-2024', 'dd-mm-yyyy'), 92587, 55149, 941);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-11-2028', 'dd-mm-yyyy'), 25798, 10008, 409);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('04-04-2027', 'dd-mm-yyyy'), 66527, 55149, 855);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-11-2024', 'dd-mm-yyyy'), 23284, 55149, 350);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-12-2028', 'dd-mm-yyyy'), 86555, 64185, 220);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-01-2028', 'dd-mm-yyyy'), 33634, 25922, 206);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-09-2028', 'dd-mm-yyyy'), 18374, 34609, 776);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-10-2029', 'dd-mm-yyyy'), 81684, 31151, 556);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-11-2029', 'dd-mm-yyyy'), 71253, 69880, 152);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-08-2026', 'dd-mm-yyyy'), 35294, 35130, 379);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-09-2024', 'dd-mm-yyyy'), 65753, 24608, 885);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-08-2029', 'dd-mm-yyyy'), 45349, 51524, 799);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-11-2026', 'dd-mm-yyyy'), 68537, 79374, 855);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-05-2024', 'dd-mm-yyyy'), 99859, 19365, 799);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('22-02-2026', 'dd-mm-yyyy'), 48474, 63761, 362);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-10-2027', 'dd-mm-yyyy'), 29118, 13794, 764);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-11-2026', 'dd-mm-yyyy'), 94999, 21996, 890);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-11-2024', 'dd-mm-yyyy'), 36345, 31696, 303);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('23-09-2026', 'dd-mm-yyyy'), 85326, 25922, 392);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-03-2025', 'dd-mm-yyyy'), 25893, 84301, 759);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('26-05-2025', 'dd-mm-yyyy'), 12777, 54635, 20003);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('14-09-2029', 'dd-mm-yyyy'), 36381, 10006, 293);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-09-2024', 'dd-mm-yyyy'), 23487, 22236, 984);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-01-2025', 'dd-mm-yyyy'), 79857, 51672, 140);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-03-2027', 'dd-mm-yyyy'), 34432, 10012, 104);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-08-2027', 'dd-mm-yyyy'), 85761, 34941, 362);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('26-02-2025', 'dd-mm-yyyy'), 82511, 46150, 690);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('26-12-2029', 'dd-mm-yyyy'), 48971, 90668, 980);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-05-2023', 'dd-mm-yyyy'), 30001, 10001, 20001);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-05-2023', 'dd-mm-yyyy'), 30002, 10006, 20002);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-05-2023', 'dd-mm-yyyy'), 30003, 10006, 20003);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('04-05-2023', 'dd-mm-yyyy'), 30004, 10001, 20004);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-05-2023', 'dd-mm-yyyy'), 30005, 10005, 20005);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-05-2023', 'dd-mm-yyyy'), 30006, 10006, 20006);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-03-2028', 'dd-mm-yyyy'), 71834, 19936, 501);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-12-2026', 'dd-mm-yyyy'), 25165, 57567, 829);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-07-2025', 'dd-mm-yyyy'), 39772, 76380, 434);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-04-2025', 'dd-mm-yyyy'), 73199, 79819, 783);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-08-2025', 'dd-mm-yyyy'), 96566, 79374, 601);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-05-2028', 'dd-mm-yyyy'), 44578, 10002, 736);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-09-2028', 'dd-mm-yyyy'), 38457, 74548, 803);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-06-2026', 'dd-mm-yyyy'), 35792, 54635, 178);
commit;
prompt 300 records committed...
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-06-2029', 'dd-mm-yyyy'), 29532, 10652, 475);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-10-2029', 'dd-mm-yyyy'), 54399, 63961, 799);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-09-2025', 'dd-mm-yyyy'), 31716, 10009, 874);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-11-2028', 'dd-mm-yyyy'), 22848, 27379, 567);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-11-2026', 'dd-mm-yyyy'), 62227, 63036, 513);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-02-2027', 'dd-mm-yyyy'), 97354, 21570, 736);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-07-2026', 'dd-mm-yyyy'), 37916, 51524, 903);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-09-2025', 'dd-mm-yyyy'), 64388, 86483, 302);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('27-05-2029', 'dd-mm-yyyy'), 74732, 11630, 391);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-11-2025', 'dd-mm-yyyy'), 24137, 27192, 941);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-09-2029', 'dd-mm-yyyy'), 39616, 31845, 633);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-12-2025', 'dd-mm-yyyy'), 17979, 99769, 552);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('22-10-2025', 'dd-mm-yyyy'), 99822, 61696, 198);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-07-2029', 'dd-mm-yyyy'), 16437, 10013, 839);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-11-2028', 'dd-mm-yyyy'), 66153, 86483, 778);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-07-2024', 'dd-mm-yyyy'), 96149, 10007, 259);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-07-2029', 'dd-mm-yyyy'), 55657, 39306, 250);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-06-2027', 'dd-mm-yyyy'), 55127, 69468, 568);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-06-2024', 'dd-mm-yyyy'), 43974, 84092, 800);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-03-2026', 'dd-mm-yyyy'), 35517, 22236, 259);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-11-2024', 'dd-mm-yyyy'), 26182, 10014, 293);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-09-2024', 'dd-mm-yyyy'), 65183, 96750, 890);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('23-07-2029', 'dd-mm-yyyy'), 86786, 21570, 309);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-07-2027', 'dd-mm-yyyy'), 18689, 48188, 168);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-01-2027', 'dd-mm-yyyy'), 32565, 45148, 314);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-05-2024', 'dd-mm-yyyy'), 96369, 43931, 839);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-05-2028', 'dd-mm-yyyy'), 33315, 15963, 150);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('10-11-2028', 'dd-mm-yyyy'), 41673, 54635, 446);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-12-2027', 'dd-mm-yyyy'), 36919, 64076, 674);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('04-03-2027', 'dd-mm-yyyy'), 82921, 48188, 914);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-10-2029', 'dd-mm-yyyy'), 19137, 18525, 633);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-07-2028', 'dd-mm-yyyy'), 87984, 88571, 371);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-07-2026', 'dd-mm-yyyy'), 97935, 98364, 104);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-11-2025', 'dd-mm-yyyy'), 34968, 21570, 683);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-08-2025', 'dd-mm-yyyy'), 43457, 10003, 356);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-08-2028', 'dd-mm-yyyy'), 84957, 72820, 20006);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-05-2028', 'dd-mm-yyyy'), 82652, 10016, 542);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-12-2028', 'dd-mm-yyyy'), 15747, 49666, 292);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-05-2026', 'dd-mm-yyyy'), 71739, 68062, 242);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-01-2029', 'dd-mm-yyyy'), 45388, 15383, 488);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-02-2028', 'dd-mm-yyyy'), 58778, 88571, 349);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-11-2024', 'dd-mm-yyyy'), 59549, 99778, 820);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-08-2025', 'dd-mm-yyyy'), 78559, 43702, 564);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-08-2027', 'dd-mm-yyyy'), 55324, 86483, 374);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('24-01-2027', 'dd-mm-yyyy'), 71465, 51672, 201);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-10-2029', 'dd-mm-yyyy'), 98797, 11630, 377);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-07-2029', 'dd-mm-yyyy'), 37461, 81284, 805);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-12-2025', 'dd-mm-yyyy'), 32826, 44135, 356);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('23-06-2027', 'dd-mm-yyyy'), 31819, 39663, 20008);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-09-2027', 'dd-mm-yyyy'), 96672, 10003, 593);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('14-05-2027', 'dd-mm-yyyy'), 41915, 67810, 20001);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-08-2029', 'dd-mm-yyyy'), 49689, 20080, 799);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-05-2026', 'dd-mm-yyyy'), 73262, 25991, 314);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-07-2024', 'dd-mm-yyyy'), 36165, 66193, 20006);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-01-2027', 'dd-mm-yyyy'), 59117, 10005, 399);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-10-2029', 'dd-mm-yyyy'), 35487, 21570, 104);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-09-2027', 'dd-mm-yyyy'), 17687, 99939, 568);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-02-2024', 'dd-mm-yyyy'), 11426, 74841, 266);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-06-2025', 'dd-mm-yyyy'), 98428, 25922, 448);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-10-2027', 'dd-mm-yyyy'), 83194, 31696, 198);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-04-2024', 'dd-mm-yyyy'), 29724, 86483, 755);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-11-2027', 'dd-mm-yyyy'), 44426, 79374, 399);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-03-2026', 'dd-mm-yyyy'), 59923, 91368, 20009);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-07-2028', 'dd-mm-yyyy'), 21759, 11630, 989);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-07-2027', 'dd-mm-yyyy'), 51688, 33794, 303);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-06-2029', 'dd-mm-yyyy'), 71895, 99769, 572);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-10-2027', 'dd-mm-yyyy'), 96628, 91368, 543);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('04-11-2028', 'dd-mm-yyyy'), 55427, 98364, 399);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-01-2026', 'dd-mm-yyyy'), 56328, 18802, 708);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('06-12-2025', 'dd-mm-yyyy'), 64612, 33532, 654);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('26-08-2029', 'dd-mm-yyyy'), 62629, 37415, 350);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-06-2029', 'dd-mm-yyyy'), 31299, 10008, 777);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('01-01-2027', 'dd-mm-yyyy'), 96736, 39663, 994);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-07-2024', 'dd-mm-yyyy'), 88645, 64076, 412);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-12-2025', 'dd-mm-yyyy'), 42873, 70748, 408);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-12-2028', 'dd-mm-yyyy'), 26335, 24656, 686);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('04-08-2026', 'dd-mm-yyyy'), 57292, 39663, 559);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-03-2024', 'dd-mm-yyyy'), 57853, 40041, 387);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-10-2029', 'dd-mm-yyyy'), 35784, 57567, 839);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('08-09-2029', 'dd-mm-yyyy'), 17117, 21570, 274);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-10-2027', 'dd-mm-yyyy'), 61135, 38187, 785);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-01-2027', 'dd-mm-yyyy'), 56388, 10007, 725);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-12-2026', 'dd-mm-yyyy'), 24777, 15383, 971);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-01-2025', 'dd-mm-yyyy'), 85669, 64185, 328);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-02-2026', 'dd-mm-yyyy'), 38729, 47507, 195);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-07-2028', 'dd-mm-yyyy'), 37647, 25578, 446);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-08-2029', 'dd-mm-yyyy'), 59736, 25578, 559);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-02-2029', 'dd-mm-yyyy'), 19974, 62435, 195);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-06-2029', 'dd-mm-yyyy'), 93442, 50112, 204);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-06-2027', 'dd-mm-yyyy'), 13944, 33794, 774);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-12-2027', 'dd-mm-yyyy'), 53274, 15343, 213);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('03-11-2029', 'dd-mm-yyyy'), 97579, 81284, 391);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-07-2028', 'dd-mm-yyyy'), 89358, 72820, 349);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('29-11-2026', 'dd-mm-yyyy'), 38952, 12082, 543);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('02-04-2026', 'dd-mm-yyyy'), 78281, 61546, 698);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-03-2026', 'dd-mm-yyyy'), 76832, 91539, 980);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('05-05-2028', 'dd-mm-yyyy'), 98548, 61435, 501);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('10-11-2024', 'dd-mm-yyyy'), 16511, 55546, 618);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('30-11-2026', 'dd-mm-yyyy'), 98371, 15383, 586);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-02-2024', 'dd-mm-yyyy'), 97927, 81894, 553);
commit;
prompt 400 records committed...
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('29-07-2025', 'dd-mm-yyyy'), 52192, 20080, 314);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('07-02-2026', 'dd-mm-yyyy'), 44344, 99939, 373);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-01-2024', 'dd-mm-yyyy'), 25675, 10017, 152);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-04-2024', 'dd-mm-yyyy'), 39472, 69468, 639);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('15-10-2026', 'dd-mm-yyyy'), 69358, 51524, 336);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-04-2024', 'dd-mm-yyyy'), 74361, 96640, 481);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-08-2027', 'dd-mm-yyyy'), 63995, 48188, 616);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-04-2028', 'dd-mm-yyyy'), 85644, 99939, 408);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('16-05-2024', 'dd-mm-yyyy'), 11416, 22236, 833);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('18-11-2025', 'dd-mm-yyyy'), 44484, 27379, 855);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('21-06-2027', 'dd-mm-yyyy'), 65632, 15383, 885);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('13-08-2027', 'dd-mm-yyyy'), 86376, 63284, 513);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('20-08-2025', 'dd-mm-yyyy'), 42728, 31151, 842);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-03-2026', 'dd-mm-yyyy'), 38616, 43931, 660);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('12-12-2024', 'dd-mm-yyyy'), 39837, 17595, 975);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('04-09-2025', 'dd-mm-yyyy'), 55791, 21996, 572);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('25-04-2028', 'dd-mm-yyyy'), 51446, 37415, 556);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('31-01-2029', 'dd-mm-yyyy'), 34362, 89337, 134);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('11-02-2027', 'dd-mm-yyyy'), 89217, 87909, 309);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-05-2025', 'dd-mm-yyyy'), 99138, 61546, 726);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('09-03-2026', 'dd-mm-yyyy'), 31948, 99939, 379);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('19-08-2026', 'dd-mm-yyyy'), 93739, 99681, 759);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('17-12-2026', 'dd-mm-yyyy'), 94727, 21996, 471);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-11-2026', 'dd-mm-yyyy'), 73721, 35535, 838);
insert into TEETH_APPOINTMENT (adate, appointmentid, sid, child_id)
values (to_date('28-07-2028', 'dd-mm-yyyy'), 16719, 82443, 332);
commit;
prompt 425 records loaded
prompt Loading OMAKEA...
insert into OMAKEA (appointmentid, sid)
values (11395, 41224);
insert into OMAKEA (appointmentid, sid)
values (11416, 83782);
insert into OMAKEA (appointmentid, sid)
values (11912, 55269);
insert into OMAKEA (appointmentid, sid)
values (12777, 12979);
insert into OMAKEA (appointmentid, sid)
values (13121, 10018);
insert into OMAKEA (appointmentid, sid)
values (13121, 65613);
insert into OMAKEA (appointmentid, sid)
values (13184, 32397);
insert into OMAKEA (appointmentid, sid)
values (13713, 98375);
insert into OMAKEA (appointmentid, sid)
values (13831, 10018);
insert into OMAKEA (appointmentid, sid)
values (13927, 47970);
insert into OMAKEA (appointmentid, sid)
values (13944, 36074);
insert into OMAKEA (appointmentid, sid)
values (14115, 10018);
insert into OMAKEA (appointmentid, sid)
values (14235, 10334);
insert into OMAKEA (appointmentid, sid)
values (14235, 50598);
insert into OMAKEA (appointmentid, sid)
values (14235, 74972);
insert into OMAKEA (appointmentid, sid)
values (14235, 87171);
insert into OMAKEA (appointmentid, sid)
values (14715, 69582);
insert into OMAKEA (appointmentid, sid)
values (15747, 87171);
insert into OMAKEA (appointmentid, sid)
values (16195, 10015);
insert into OMAKEA (appointmentid, sid)
values (16437, 10011);
insert into OMAKEA (appointmentid, sid)
values (16511, 10020);
insert into OMAKEA (appointmentid, sid)
values (17642, 83782);
insert into OMAKEA (appointmentid, sid)
values (18374, 10334);
insert into OMAKEA (appointmentid, sid)
values (18374, 57569);
insert into OMAKEA (appointmentid, sid)
values (18422, 10012);
insert into OMAKEA (appointmentid, sid)
values (18422, 33360);
insert into OMAKEA (appointmentid, sid)
values (18621, 29127);
insert into OMAKEA (appointmentid, sid)
values (18621, 64636);
insert into OMAKEA (appointmentid, sid)
values (19338, 78572);
insert into OMAKEA (appointmentid, sid)
values (19338, 98375);
insert into OMAKEA (appointmentid, sid)
values (19487, 16712);
insert into OMAKEA (appointmentid, sid)
values (19548, 50598);
insert into OMAKEA (appointmentid, sid)
values (21632, 34002);
insert into OMAKEA (appointmentid, sid)
values (21759, 83782);
insert into OMAKEA (appointmentid, sid)
values (22473, 10017);
insert into OMAKEA (appointmentid, sid)
values (22473, 29561);
insert into OMAKEA (appointmentid, sid)
values (22473, 47970);
insert into OMAKEA (appointmentid, sid)
values (22834, 16712);
insert into OMAKEA (appointmentid, sid)
values (22834, 87171);
insert into OMAKEA (appointmentid, sid)
values (22848, 59041);
insert into OMAKEA (appointmentid, sid)
values (23284, 10011);
insert into OMAKEA (appointmentid, sid)
values (23284, 32397);
insert into OMAKEA (appointmentid, sid)
values (23284, 41224);
insert into OMAKEA (appointmentid, sid)
values (23284, 98375);
insert into OMAKEA (appointmentid, sid)
values (23487, 65613);
insert into OMAKEA (appointmentid, sid)
values (24137, 10017);
insert into OMAKEA (appointmentid, sid)
values (24137, 47970);
insert into OMAKEA (appointmentid, sid)
values (24137, 88762);
insert into OMAKEA (appointmentid, sid)
values (24385, 59041);
insert into OMAKEA (appointmentid, sid)
values (24399, 29872);
insert into OMAKEA (appointmentid, sid)
values (24676, 50598);
insert into OMAKEA (appointmentid, sid)
values (24676, 64636);
insert into OMAKEA (appointmentid, sid)
values (24777, 10014);
insert into OMAKEA (appointmentid, sid)
values (24777, 10015);
insert into OMAKEA (appointmentid, sid)
values (24947, 41224);
insert into OMAKEA (appointmentid, sid)
values (24984, 29872);
insert into OMAKEA (appointmentid, sid)
values (24984, 68429);
insert into OMAKEA (appointmentid, sid)
values (25165, 10011);
insert into OMAKEA (appointmentid, sid)
values (25165, 10016);
insert into OMAKEA (appointmentid, sid)
values (25165, 41224);
insert into OMAKEA (appointmentid, sid)
values (25556, 55385);
insert into OMAKEA (appointmentid, sid)
values (25556, 87171);
insert into OMAKEA (appointmentid, sid)
values (25854, 47970);
insert into OMAKEA (appointmentid, sid)
values (25854, 83782);
insert into OMAKEA (appointmentid, sid)
values (25893, 16712);
insert into OMAKEA (appointmentid, sid)
values (25893, 73373);
insert into OMAKEA (appointmentid, sid)
values (26256, 38296);
insert into OMAKEA (appointmentid, sid)
values (26331, 10334);
insert into OMAKEA (appointmentid, sid)
values (26331, 33360);
insert into OMAKEA (appointmentid, sid)
values (26335, 49969);
insert into OMAKEA (appointmentid, sid)
values (26335, 88762);
insert into OMAKEA (appointmentid, sid)
values (26699, 36074);
insert into OMAKEA (appointmentid, sid)
values (26699, 41470);
insert into OMAKEA (appointmentid, sid)
values (26926, 47970);
insert into OMAKEA (appointmentid, sid)
values (26926, 81894);
insert into OMAKEA (appointmentid, sid)
values (27341, 29872);
insert into OMAKEA (appointmentid, sid)
values (27341, 69582);
insert into OMAKEA (appointmentid, sid)
values (28113, 18802);
insert into OMAKEA (appointmentid, sid)
values (28593, 10006);
insert into OMAKEA (appointmentid, sid)
values (28734, 68429);
insert into OMAKEA (appointmentid, sid)
values (28734, 98375);
insert into OMAKEA (appointmentid, sid)
values (28734, 99596);
insert into OMAKEA (appointmentid, sid)
values (29134, 69582);
insert into OMAKEA (appointmentid, sid)
values (29532, 12979);
insert into OMAKEA (appointmentid, sid)
values (29724, 26921);
insert into OMAKEA (appointmentid, sid)
values (29966, 59041);
insert into OMAKEA (appointmentid, sid)
values (29966, 69582);
insert into OMAKEA (appointmentid, sid)
values (30001, 47962);
insert into OMAKEA (appointmentid, sid)
values (30001, 86483);
insert into OMAKEA (appointmentid, sid)
values (30002, 10018);
insert into OMAKEA (appointmentid, sid)
values (30002, 45839);
insert into OMAKEA (appointmentid, sid)
values (30002, 68062);
insert into OMAKEA (appointmentid, sid)
values (30003, 18802);
insert into OMAKEA (appointmentid, sid)
values (30003, 29127);
insert into OMAKEA (appointmentid, sid)
values (30003, 57569);
insert into OMAKEA (appointmentid, sid)
values (30003, 78572);
insert into OMAKEA (appointmentid, sid)
values (30003, 86483);
insert into OMAKEA (appointmentid, sid)
values (30004, 10012);
insert into OMAKEA (appointmentid, sid)
values (30005, 10014);
insert into OMAKEA (appointmentid, sid)
values (30005, 10017);
commit;
prompt 100 records committed...
insert into OMAKEA (appointmentid, sid)
values (30005, 99596);
insert into OMAKEA (appointmentid, sid)
values (30006, 10334);
insert into OMAKEA (appointmentid, sid)
values (30006, 18802);
insert into OMAKEA (appointmentid, sid)
values (30006, 51383);
insert into OMAKEA (appointmentid, sid)
values (30006, 73373);
insert into OMAKEA (appointmentid, sid)
values (30006, 81894);
insert into OMAKEA (appointmentid, sid)
values (31299, 12979);
insert into OMAKEA (appointmentid, sid)
values (31299, 41470);
insert into OMAKEA (appointmentid, sid)
values (31299, 81894);
insert into OMAKEA (appointmentid, sid)
values (31554, 50598);
insert into OMAKEA (appointmentid, sid)
values (31554, 55385);
insert into OMAKEA (appointmentid, sid)
values (31554, 68429);
insert into OMAKEA (appointmentid, sid)
values (31688, 74972);
insert into OMAKEA (appointmentid, sid)
values (31716, 41470);
insert into OMAKEA (appointmentid, sid)
values (31716, 81894);
insert into OMAKEA (appointmentid, sid)
values (31743, 47962);
insert into OMAKEA (appointmentid, sid)
values (31743, 59041);
insert into OMAKEA (appointmentid, sid)
values (31819, 55385);
insert into OMAKEA (appointmentid, sid)
values (31819, 59041);
insert into OMAKEA (appointmentid, sid)
values (32867, 74972);
insert into OMAKEA (appointmentid, sid)
values (33634, 41224);
insert into OMAKEA (appointmentid, sid)
values (33634, 49969);
insert into OMAKEA (appointmentid, sid)
values (33732, 33360);
insert into OMAKEA (appointmentid, sid)
values (34243, 10018);
insert into OMAKEA (appointmentid, sid)
values (34243, 83782);
insert into OMAKEA (appointmentid, sid)
values (34362, 10018);
insert into OMAKEA (appointmentid, sid)
values (34362, 64636);
insert into OMAKEA (appointmentid, sid)
values (34432, 73373);
insert into OMAKEA (appointmentid, sid)
values (34968, 74972);
insert into OMAKEA (appointmentid, sid)
values (35792, 74972);
insert into OMAKEA (appointmentid, sid)
values (36345, 10020);
insert into OMAKEA (appointmentid, sid)
values (36345, 29872);
insert into OMAKEA (appointmentid, sid)
values (36544, 10018);
insert into OMAKEA (appointmentid, sid)
values (36544, 12979);
insert into OMAKEA (appointmentid, sid)
values (36544, 59041);
insert into OMAKEA (appointmentid, sid)
values (36749, 86483);
insert into OMAKEA (appointmentid, sid)
values (36919, 33360);
insert into OMAKEA (appointmentid, sid)
values (36928, 18802);
insert into OMAKEA (appointmentid, sid)
values (36928, 81894);
insert into OMAKEA (appointmentid, sid)
values (36944, 10020);
insert into OMAKEA (appointmentid, sid)
values (36944, 50598);
insert into OMAKEA (appointmentid, sid)
values (37223, 10018);
insert into OMAKEA (appointmentid, sid)
values (37223, 41224);
insert into OMAKEA (appointmentid, sid)
values (37461, 57569);
insert into OMAKEA (appointmentid, sid)
values (37461, 99596);
insert into OMAKEA (appointmentid, sid)
values (37512, 10012);
insert into OMAKEA (appointmentid, sid)
values (37512, 81894);
insert into OMAKEA (appointmentid, sid)
values (37638, 74972);
insert into OMAKEA (appointmentid, sid)
values (37647, 29127);
insert into OMAKEA (appointmentid, sid)
values (37647, 33360);
insert into OMAKEA (appointmentid, sid)
values (37782, 29872);
insert into OMAKEA (appointmentid, sid)
values (37782, 32397);
insert into OMAKEA (appointmentid, sid)
values (37869, 88762);
insert into OMAKEA (appointmentid, sid)
values (38338, 10017);
insert into OMAKEA (appointmentid, sid)
values (38338, 29872);
insert into OMAKEA (appointmentid, sid)
values (38616, 29561);
insert into OMAKEA (appointmentid, sid)
values (38729, 29127);
insert into OMAKEA (appointmentid, sid)
values (38729, 47970);
insert into OMAKEA (appointmentid, sid)
values (39257, 10015);
insert into OMAKEA (appointmentid, sid)
values (39257, 33360);
insert into OMAKEA (appointmentid, sid)
values (39425, 10017);
insert into OMAKEA (appointmentid, sid)
values (39425, 81894);
insert into OMAKEA (appointmentid, sid)
values (39616, 34002);
insert into OMAKEA (appointmentid, sid)
values (39772, 87171);
insert into OMAKEA (appointmentid, sid)
values (39837, 99596);
insert into OMAKEA (appointmentid, sid)
values (41561, 32397);
insert into OMAKEA (appointmentid, sid)
values (41656, 10017);
insert into OMAKEA (appointmentid, sid)
values (41847, 57569);
insert into OMAKEA (appointmentid, sid)
values (41915, 10006);
insert into OMAKEA (appointmentid, sid)
values (41915, 10013);
insert into OMAKEA (appointmentid, sid)
values (41915, 10015);
insert into OMAKEA (appointmentid, sid)
values (42733, 10013);
insert into OMAKEA (appointmentid, sid)
values (42873, 10017);
insert into OMAKEA (appointmentid, sid)
values (42917, 55385);
insert into OMAKEA (appointmentid, sid)
values (43457, 41470);
insert into OMAKEA (appointmentid, sid)
values (43457, 49969);
insert into OMAKEA (appointmentid, sid)
values (44265, 64636);
insert into OMAKEA (appointmentid, sid)
values (44265, 74972);
insert into OMAKEA (appointmentid, sid)
values (44426, 18802);
insert into OMAKEA (appointmentid, sid)
values (44484, 32397);
insert into OMAKEA (appointmentid, sid)
values (44578, 10015);
insert into OMAKEA (appointmentid, sid)
values (44578, 78572);
insert into OMAKEA (appointmentid, sid)
values (44623, 12979);
insert into OMAKEA (appointmentid, sid)
values (44623, 59041);
insert into OMAKEA (appointmentid, sid)
values (44623, 68429);
insert into OMAKEA (appointmentid, sid)
values (44833, 10014);
insert into OMAKEA (appointmentid, sid)
values (45388, 59041);
insert into OMAKEA (appointmentid, sid)
values (45388, 74972);
insert into OMAKEA (appointmentid, sid)
values (45388, 88762);
insert into OMAKEA (appointmentid, sid)
values (45389, 10006);
insert into OMAKEA (appointmentid, sid)
values (45389, 51383);
insert into OMAKEA (appointmentid, sid)
values (45659, 10018);
insert into OMAKEA (appointmentid, sid)
values (45686, 10013);
insert into OMAKEA (appointmentid, sid)
values (45835, 10018);
insert into OMAKEA (appointmentid, sid)
values (46594, 41224);
insert into OMAKEA (appointmentid, sid)
values (46912, 83782);
insert into OMAKEA (appointmentid, sid)
values (47288, 68429);
insert into OMAKEA (appointmentid, sid)
values (47365, 29872);
insert into OMAKEA (appointmentid, sid)
values (47365, 87171);
insert into OMAKEA (appointmentid, sid)
values (48474, 10014);
commit;
prompt 200 records committed...
insert into OMAKEA (appointmentid, sid)
values (48557, 10334);
insert into OMAKEA (appointmentid, sid)
values (48827, 29127);
insert into OMAKEA (appointmentid, sid)
values (48827, 81894);
insert into OMAKEA (appointmentid, sid)
values (48971, 64636);
insert into OMAKEA (appointmentid, sid)
values (48971, 65613);
insert into OMAKEA (appointmentid, sid)
values (48971, 68062);
insert into OMAKEA (appointmentid, sid)
values (49174, 10006);
insert into OMAKEA (appointmentid, sid)
values (49174, 29127);
insert into OMAKEA (appointmentid, sid)
values (49174, 68429);
insert into OMAKEA (appointmentid, sid)
values (49211, 73373);
insert into OMAKEA (appointmentid, sid)
values (49211, 81894);
insert into OMAKEA (appointmentid, sid)
values (49689, 10018);
insert into OMAKEA (appointmentid, sid)
values (49689, 29127);
insert into OMAKEA (appointmentid, sid)
values (49689, 38296);
insert into OMAKEA (appointmentid, sid)
values (49699, 10020);
insert into OMAKEA (appointmentid, sid)
values (49749, 32397);
insert into OMAKEA (appointmentid, sid)
values (51688, 18802);
insert into OMAKEA (appointmentid, sid)
values (51688, 29872);
insert into OMAKEA (appointmentid, sid)
values (51688, 88762);
insert into OMAKEA (appointmentid, sid)
values (52192, 12979);
insert into OMAKEA (appointmentid, sid)
values (52192, 47962);
insert into OMAKEA (appointmentid, sid)
values (52192, 64636);
insert into OMAKEA (appointmentid, sid)
values (52254, 29561);
insert into OMAKEA (appointmentid, sid)
values (52254, 45839);
insert into OMAKEA (appointmentid, sid)
values (52254, 88762);
insert into OMAKEA (appointmentid, sid)
values (52545, 68429);
insert into OMAKEA (appointmentid, sid)
values (52545, 69582);
insert into OMAKEA (appointmentid, sid)
values (52874, 10018);
insert into OMAKEA (appointmentid, sid)
values (53274, 10017);
insert into OMAKEA (appointmentid, sid)
values (53498, 10011);
insert into OMAKEA (appointmentid, sid)
values (53587, 38296);
insert into OMAKEA (appointmentid, sid)
values (53587, 86483);
insert into OMAKEA (appointmentid, sid)
values (53947, 10006);
insert into OMAKEA (appointmentid, sid)
values (53981, 10014);
insert into OMAKEA (appointmentid, sid)
values (54399, 47970);
insert into OMAKEA (appointmentid, sid)
values (54755, 55269);
insert into OMAKEA (appointmentid, sid)
values (54755, 57569);
insert into OMAKEA (appointmentid, sid)
values (54965, 10017);
insert into OMAKEA (appointmentid, sid)
values (55163, 55385);
insert into OMAKEA (appointmentid, sid)
values (55163, 83782);
insert into OMAKEA (appointmentid, sid)
values (55427, 68429);
insert into OMAKEA (appointmentid, sid)
values (55657, 33360);
insert into OMAKEA (appointmentid, sid)
values (56515, 10014);
insert into OMAKEA (appointmentid, sid)
values (56515, 29872);
insert into OMAKEA (appointmentid, sid)
values (57292, 10016);
insert into OMAKEA (appointmentid, sid)
values (57853, 12979);
insert into OMAKEA (appointmentid, sid)
values (58994, 81894);
insert into OMAKEA (appointmentid, sid)
values (59117, 16712);
insert into OMAKEA (appointmentid, sid)
values (59117, 68062);
insert into OMAKEA (appointmentid, sid)
values (59487, 55385);
insert into OMAKEA (appointmentid, sid)
values (59549, 34002);
insert into OMAKEA (appointmentid, sid)
values (59549, 74972);
insert into OMAKEA (appointmentid, sid)
values (59588, 49969);
insert into OMAKEA (appointmentid, sid)
values (59736, 29561);
insert into OMAKEA (appointmentid, sid)
values (59736, 68429);
insert into OMAKEA (appointmentid, sid)
values (59864, 10014);
insert into OMAKEA (appointmentid, sid)
values (59864, 10019);
insert into OMAKEA (appointmentid, sid)
values (59883, 16712);
insert into OMAKEA (appointmentid, sid)
values (59883, 41224);
insert into OMAKEA (appointmentid, sid)
values (59923, 64636);
insert into OMAKEA (appointmentid, sid)
values (61435, 10012);
insert into OMAKEA (appointmentid, sid)
values (61435, 25578);
insert into OMAKEA (appointmentid, sid)
values (61472, 26921);
insert into OMAKEA (appointmentid, sid)
values (61472, 78572);
insert into OMAKEA (appointmentid, sid)
values (61521, 10017);
insert into OMAKEA (appointmentid, sid)
values (61521, 12979);
insert into OMAKEA (appointmentid, sid)
values (61521, 47970);
insert into OMAKEA (appointmentid, sid)
values (61651, 83782);
insert into OMAKEA (appointmentid, sid)
values (62227, 10019);
insert into OMAKEA (appointmentid, sid)
values (62227, 25578);
insert into OMAKEA (appointmentid, sid)
values (62227, 55269);
insert into OMAKEA (appointmentid, sid)
values (62316, 55269);
insert into OMAKEA (appointmentid, sid)
values (62629, 10019);
insert into OMAKEA (appointmentid, sid)
values (62629, 29561);
insert into OMAKEA (appointmentid, sid)
values (63768, 59041);
insert into OMAKEA (appointmentid, sid)
values (63768, 78572);
insert into OMAKEA (appointmentid, sid)
values (63995, 18802);
insert into OMAKEA (appointmentid, sid)
values (63995, 41470);
insert into OMAKEA (appointmentid, sid)
values (64612, 10006);
insert into OMAKEA (appointmentid, sid)
values (64612, 41224);
insert into OMAKEA (appointmentid, sid)
values (64612, 51383);
insert into OMAKEA (appointmentid, sid)
values (65183, 10013);
insert into OMAKEA (appointmentid, sid)
values (65252, 68062);
insert into OMAKEA (appointmentid, sid)
values (65252, 86483);
insert into OMAKEA (appointmentid, sid)
values (65466, 59041);
insert into OMAKEA (appointmentid, sid)
values (65632, 10015);
insert into OMAKEA (appointmentid, sid)
values (65632, 12979);
insert into OMAKEA (appointmentid, sid)
values (65711, 68062);
insert into OMAKEA (appointmentid, sid)
values (65753, 10012);
insert into OMAKEA (appointmentid, sid)
values (66153, 10006);
insert into OMAKEA (appointmentid, sid)
values (66364, 10016);
insert into OMAKEA (appointmentid, sid)
values (66364, 68062);
insert into OMAKEA (appointmentid, sid)
values (66449, 10013);
insert into OMAKEA (appointmentid, sid)
values (66449, 38296);
insert into OMAKEA (appointmentid, sid)
values (66549, 10012);
insert into OMAKEA (appointmentid, sid)
values (66549, 47970);
insert into OMAKEA (appointmentid, sid)
values (67984, 33360);
insert into OMAKEA (appointmentid, sid)
values (67984, 99596);
insert into OMAKEA (appointmentid, sid)
values (67992, 26921);
insert into OMAKEA (appointmentid, sid)
values (67992, 29561);
commit;
prompt 300 records committed...
insert into OMAKEA (appointmentid, sid)
values (67992, 45839);
insert into OMAKEA (appointmentid, sid)
values (68242, 10016);
insert into OMAKEA (appointmentid, sid)
values (69154, 65613);
insert into OMAKEA (appointmentid, sid)
values (69358, 83782);
insert into OMAKEA (appointmentid, sid)
values (69466, 74972);
insert into OMAKEA (appointmentid, sid)
values (71381, 29127);
insert into OMAKEA (appointmentid, sid)
values (71465, 10014);
insert into OMAKEA (appointmentid, sid)
values (71465, 74972);
insert into OMAKEA (appointmentid, sid)
values (71465, 86483);
insert into OMAKEA (appointmentid, sid)
values (71834, 16712);
insert into OMAKEA (appointmentid, sid)
values (72625, 12979);
insert into OMAKEA (appointmentid, sid)
values (72625, 55269);
insert into OMAKEA (appointmentid, sid)
values (72942, 10016);
insert into OMAKEA (appointmentid, sid)
values (72942, 69582);
insert into OMAKEA (appointmentid, sid)
values (72942, 98375);
insert into OMAKEA (appointmentid, sid)
values (73199, 51383);
insert into OMAKEA (appointmentid, sid)
values (74655, 10013);
insert into OMAKEA (appointmentid, sid)
values (74655, 98375);
insert into OMAKEA (appointmentid, sid)
values (74732, 10011);
insert into OMAKEA (appointmentid, sid)
values (76248, 33360);
insert into OMAKEA (appointmentid, sid)
values (76248, 36074);
insert into OMAKEA (appointmentid, sid)
values (76248, 81894);
insert into OMAKEA (appointmentid, sid)
values (76411, 69582);
insert into OMAKEA (appointmentid, sid)
values (76595, 36074);
insert into OMAKEA (appointmentid, sid)
values (76595, 73373);
insert into OMAKEA (appointmentid, sid)
values (76744, 25578);
insert into OMAKEA (appointmentid, sid)
values (76744, 41224);
insert into OMAKEA (appointmentid, sid)
values (76832, 10011);
insert into OMAKEA (appointmentid, sid)
values (76832, 45839);
insert into OMAKEA (appointmentid, sid)
values (78169, 50598);
insert into OMAKEA (appointmentid, sid)
values (78281, 74972);
insert into OMAKEA (appointmentid, sid)
values (78559, 50598);
insert into OMAKEA (appointmentid, sid)
values (78559, 55269);
insert into OMAKEA (appointmentid, sid)
values (78559, 88762);
insert into OMAKEA (appointmentid, sid)
values (79322, 73373);
insert into OMAKEA (appointmentid, sid)
values (79322, 78572);
insert into OMAKEA (appointmentid, sid)
values (79599, 57569);
insert into OMAKEA (appointmentid, sid)
values (79599, 69582);
insert into OMAKEA (appointmentid, sid)
values (79599, 98375);
insert into OMAKEA (appointmentid, sid)
values (79857, 10013);
insert into OMAKEA (appointmentid, sid)
values (79857, 10016);
insert into OMAKEA (appointmentid, sid)
values (82123, 10016);
insert into OMAKEA (appointmentid, sid)
values (82439, 10012);
insert into OMAKEA (appointmentid, sid)
values (82439, 10020);
insert into OMAKEA (appointmentid, sid)
values (82511, 55269);
insert into OMAKEA (appointmentid, sid)
values (82921, 10017);
insert into OMAKEA (appointmentid, sid)
values (82921, 29872);
insert into OMAKEA (appointmentid, sid)
values (83194, 64636);
insert into OMAKEA (appointmentid, sid)
values (83316, 29561);
insert into OMAKEA (appointmentid, sid)
values (83564, 41470);
insert into OMAKEA (appointmentid, sid)
values (83564, 55385);
insert into OMAKEA (appointmentid, sid)
values (84414, 10016);
insert into OMAKEA (appointmentid, sid)
values (84952, 10016);
insert into OMAKEA (appointmentid, sid)
values (84957, 10015);
insert into OMAKEA (appointmentid, sid)
values (84957, 51383);
insert into OMAKEA (appointmentid, sid)
values (85326, 33360);
insert into OMAKEA (appointmentid, sid)
values (85644, 10013);
insert into OMAKEA (appointmentid, sid)
values (85669, 49969);
insert into OMAKEA (appointmentid, sid)
values (85669, 98375);
insert into OMAKEA (appointmentid, sid)
values (86376, 32397);
insert into OMAKEA (appointmentid, sid)
values (86627, 36074);
insert into OMAKEA (appointmentid, sid)
values (86786, 26921);
insert into OMAKEA (appointmentid, sid)
values (86786, 47962);
insert into OMAKEA (appointmentid, sid)
values (87144, 57569);
insert into OMAKEA (appointmentid, sid)
values (87984, 10011);
insert into OMAKEA (appointmentid, sid)
values (88298, 10020);
insert into OMAKEA (appointmentid, sid)
values (88298, 29127);
insert into OMAKEA (appointmentid, sid)
values (88645, 10011);
insert into OMAKEA (appointmentid, sid)
values (88645, 10016);
insert into OMAKEA (appointmentid, sid)
values (88645, 18802);
insert into OMAKEA (appointmentid, sid)
values (89358, 47962);
insert into OMAKEA (appointmentid, sid)
values (89358, 55269);
insert into OMAKEA (appointmentid, sid)
values (91955, 25578);
insert into OMAKEA (appointmentid, sid)
values (92316, 47970);
insert into OMAKEA (appointmentid, sid)
values (92316, 81894);
insert into OMAKEA (appointmentid, sid)
values (92499, 10017);
insert into OMAKEA (appointmentid, sid)
values (92587, 69582);
insert into OMAKEA (appointmentid, sid)
values (92754, 98375);
insert into OMAKEA (appointmentid, sid)
values (93665, 25578);
insert into OMAKEA (appointmentid, sid)
values (93739, 32397);
insert into OMAKEA (appointmentid, sid)
values (94296, 68062);
insert into OMAKEA (appointmentid, sid)
values (94727, 10334);
insert into OMAKEA (appointmentid, sid)
values (95217, 69582);
insert into OMAKEA (appointmentid, sid)
values (96566, 10334);
insert into OMAKEA (appointmentid, sid)
values (96566, 18802);
insert into OMAKEA (appointmentid, sid)
values (96566, 73373);
insert into OMAKEA (appointmentid, sid)
values (96566, 99596);
insert into OMAKEA (appointmentid, sid)
values (96672, 10017);
insert into OMAKEA (appointmentid, sid)
values (96672, 32397);
insert into OMAKEA (appointmentid, sid)
values (97122, 10012);
insert into OMAKEA (appointmentid, sid)
values (97122, 41224);
insert into OMAKEA (appointmentid, sid)
values (97354, 10019);
insert into OMAKEA (appointmentid, sid)
values (97579, 10017);
insert into OMAKEA (appointmentid, sid)
values (97579, 51383);
insert into OMAKEA (appointmentid, sid)
values (97666, 45839);
insert into OMAKEA (appointmentid, sid)
values (97666, 81894);
insert into OMAKEA (appointmentid, sid)
values (98235, 69582);
insert into OMAKEA (appointmentid, sid)
values (98371, 10013);
insert into OMAKEA (appointmentid, sid)
values (98371, 10019);
insert into OMAKEA (appointmentid, sid)
values (98371, 38296);
commit;
prompt 400 records committed...
insert into OMAKEA (appointmentid, sid)
values (98428, 45839);
insert into OMAKEA (appointmentid, sid)
values (98428, 55269);
insert into OMAKEA (appointmentid, sid)
values (98548, 10014);
insert into OMAKEA (appointmentid, sid)
values (98548, 16712);
insert into OMAKEA (appointmentid, sid)
values (98548, 50598);
insert into OMAKEA (appointmentid, sid)
values (98797, 87171);
insert into OMAKEA (appointmentid, sid)
values (98965, 29127);
insert into OMAKEA (appointmentid, sid)
values (99138, 51383);
insert into OMAKEA (appointmentid, sid)
values (99822, 10016);
commit;
prompt 409 records loaded
prompt Loading PAYMENT...
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88186, 296, to_date('18-10-2025', 'dd-mm-yyyy'), 37869);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (91237, 2193, to_date('18-06-2024', 'dd-mm-yyyy'), 35784);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (77746, 2259, to_date('30-12-2029', 'dd-mm-yyyy'), 45388);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55778, 1132, to_date('04-01-2024', 'dd-mm-yyyy'), 43748);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85115, 834, to_date('13-09-2025', 'dd-mm-yyyy'), 65753);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (78463, 2034, to_date('11-11-2026', 'dd-mm-yyyy'), 44344);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40001, 100, to_date('01-05-2023', 'dd-mm-yyyy'), 30001);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40002, 151, to_date('02-05-2023', 'dd-mm-yyyy'), 30002);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40003, 75, to_date('03-05-2023', 'dd-mm-yyyy'), 30003);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40004, 200, to_date('04-05-2023', 'dd-mm-yyyy'), 30004);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40005, 126, to_date('05-05-2023', 'dd-mm-yyyy'), 30005);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (40006, 176, to_date('06-05-2023', 'dd-mm-yyyy'), 30006);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (64674, 2131, to_date('27-08-2025', 'dd-mm-yyyy'), 83564);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48632, 2042, to_date('13-04-2026', 'dd-mm-yyyy'), 34432);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (77195, 586, to_date('06-07-2025', 'dd-mm-yyyy'), 66153);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (18447, 1631, to_date('05-01-2028', 'dd-mm-yyyy'), 32826);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99119, 1817, to_date('31-08-2029', 'dd-mm-yyyy'), 85315);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (45981, 798, to_date('06-09-2024', 'dd-mm-yyyy'), 54111);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72412, 556, to_date('10-11-2026', 'dd-mm-yyyy'), 30003);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69791, 750, to_date('26-03-2028', 'dd-mm-yyyy'), 30002);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (75485, 1853, to_date('04-02-2027', 'dd-mm-yyyy'), 65252);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41888, 1970, to_date('18-05-2029', 'dd-mm-yyyy'), 61135);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (44216, 1442, to_date('12-06-2029', 'dd-mm-yyyy'), 15747);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93818, 571, to_date('01-08-2025', 'dd-mm-yyyy'), 14715);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14888, 985, to_date('08-04-2025', 'dd-mm-yyyy'), 16437);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58316, 221, to_date('18-04-2026', 'dd-mm-yyyy'), 57292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (95454, 2226, to_date('04-07-2027', 'dd-mm-yyyy'), 76832);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49713, 174, to_date('12-06-2025', 'dd-mm-yyyy'), 49699);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69477, 1070, to_date('22-01-2024', 'dd-mm-yyyy'), 76744);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99222, 348, to_date('19-06-2028', 'dd-mm-yyyy'), 72942);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19487, 685, to_date('22-02-2027', 'dd-mm-yyyy'), 69154);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (97299, 2180, to_date('25-06-2028', 'dd-mm-yyyy'), 59923);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35972, 1477, to_date('17-09-2025', 'dd-mm-yyyy'), 84937);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15939, 2217, to_date('13-03-2028', 'dd-mm-yyyy'), 37495);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (45575, 1530, to_date('10-02-2027', 'dd-mm-yyyy'), 82256);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (95683, 1955, to_date('02-07-2027', 'dd-mm-yyyy'), 74361);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (86862, 1752, to_date('09-09-2026', 'dd-mm-yyyy'), 30002);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82612, 1233, to_date('05-02-2029', 'dd-mm-yyyy'), 27367);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (79483, 1607, to_date('02-06-2025', 'dd-mm-yyyy'), 37638);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73147, 1020, to_date('24-02-2026', 'dd-mm-yyyy'), 84957);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48277, 1917, to_date('16-07-2029', 'dd-mm-yyyy'), 84414);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69529, 1507, to_date('15-11-2025', 'dd-mm-yyyy'), 78657);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (75556, 591, to_date('01-03-2026', 'dd-mm-yyyy'), 53274);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41167, 197, to_date('09-03-2025', 'dd-mm-yyyy'), 42978);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (86562, 2475, to_date('29-11-2024', 'dd-mm-yyyy'), 84576);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (25196, 1749, to_date('26-04-2028', 'dd-mm-yyyy'), 28734);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11126, 985, to_date('17-07-2027', 'dd-mm-yyyy'), 76832);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (91169, 1962, to_date('13-06-2028', 'dd-mm-yyyy'), 47288);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85647, 2054, to_date('22-07-2027', 'dd-mm-yyyy'), 41656);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67266, 2323, to_date('27-04-2025', 'dd-mm-yyyy'), 99385);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15977, 1068, to_date('04-11-2027', 'dd-mm-yyyy'), 54365);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11432, 1041, to_date('15-11-2024', 'dd-mm-yyyy'), 69358);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (26731, 2110, to_date('18-04-2028', 'dd-mm-yyyy'), 65753);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73836, 543, to_date('13-11-2026', 'dd-mm-yyyy'), 42917);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (26844, 1947, to_date('11-06-2025', 'dd-mm-yyyy'), 38338);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82843, 863, to_date('30-06-2024', 'dd-mm-yyyy'), 39837);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (47186, 2226, to_date('24-01-2024', 'dd-mm-yyyy'), 13927);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36662, 2430, to_date('13-01-2028', 'dd-mm-yyyy'), 26335);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55376, 507, to_date('27-10-2024', 'dd-mm-yyyy'), 78169);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (59354, 1811, to_date('09-06-2028', 'dd-mm-yyyy'), 32922);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (76395, 2462, to_date('20-11-2029', 'dd-mm-yyyy'), 86376);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66864, 1552, to_date('28-12-2026', 'dd-mm-yyyy'), 65753);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36549, 1159, to_date('21-07-2024', 'dd-mm-yyyy'), 54365);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15176, 1218, to_date('30-11-2028', 'dd-mm-yyyy'), 73262);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (71392, 1006, to_date('16-11-2024', 'dd-mm-yyyy'), 65183);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56651, 183, to_date('01-01-2025', 'dd-mm-yyyy'), 82256);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69676, 1742, to_date('18-04-2029', 'dd-mm-yyyy'), 42733);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55664, 421, to_date('30-03-2027', 'dd-mm-yyyy'), 83316);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58241, 1225, to_date('31-03-2024', 'dd-mm-yyyy'), 94296);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (22885, 2249, to_date('07-06-2026', 'dd-mm-yyyy'), 23284);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (29236, 573, to_date('21-10-2025', 'dd-mm-yyyy'), 25854);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (47881, 2411, to_date('28-10-2027', 'dd-mm-yyyy'), 14242);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34332, 2259, to_date('19-04-2025', 'dd-mm-yyyy'), 37748);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98379, 1575, to_date('23-09-2026', 'dd-mm-yyyy'), 66449);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (94973, 1146, to_date('08-12-2024', 'dd-mm-yyyy'), 76248);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98654, 2425, to_date('26-02-2026', 'dd-mm-yyyy'), 52292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (86571, 1380, to_date('07-06-2025', 'dd-mm-yyyy'), 55163);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99438, 693, to_date('08-06-2024', 'dd-mm-yyyy'), 24577);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (68928, 380, to_date('19-08-2025', 'dd-mm-yyyy'), 30005);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (24531, 2060, to_date('02-11-2026', 'dd-mm-yyyy'), 94727);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (27548, 1033, to_date('20-02-2028', 'dd-mm-yyyy'), 42873);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (38228, 1435, to_date('14-03-2027', 'dd-mm-yyyy'), 72942);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (78642, 376, to_date('06-12-2026', 'dd-mm-yyyy'), 56328);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11751, 2210, to_date('20-07-2025', 'dd-mm-yyyy'), 58911);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (26716, 1795, to_date('30-12-2024', 'dd-mm-yyyy'), 69358);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88625, 235, to_date('30-09-2027', 'dd-mm-yyyy'), 37647);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (77587, 1359, to_date('18-12-2027', 'dd-mm-yyyy'), 98548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (74463, 723, to_date('29-01-2027', 'dd-mm-yyyy'), 38457);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34526, 2367, to_date('11-09-2025', 'dd-mm-yyyy'), 45388);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (43688, 2231, to_date('28-11-2027', 'dd-mm-yyyy'), 34639);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93494, 1682, to_date('16-12-2027', 'dd-mm-yyyy'), 67992);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58579, 1801, to_date('18-04-2027', 'dd-mm-yyyy'), 62424);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39613, 1927, to_date('02-01-2028', 'dd-mm-yyyy'), 59864);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73548, 2460, to_date('10-08-2026', 'dd-mm-yyyy'), 55427);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (86512, 174, to_date('25-03-2026', 'dd-mm-yyyy'), 99859);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (59685, 1897, to_date('01-03-2025', 'dd-mm-yyyy'), 47365);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (51173, 2484, to_date('14-10-2029', 'dd-mm-yyyy'), 36944);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (51696, 2315, to_date('08-11-2025', 'dd-mm-yyyy'), 72942);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (33213, 845, to_date('13-03-2028', 'dd-mm-yyyy'), 36345);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99184, 1465, to_date('02-10-2028', 'dd-mm-yyyy'), 45389);
commit;
prompt 100 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36149, 1820, to_date('01-01-2029', 'dd-mm-yyyy'), 69466);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (28964, 2490, to_date('05-10-2024', 'dd-mm-yyyy'), 97122);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (53997, 1129, to_date('14-05-2027', 'dd-mm-yyyy'), 13831);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (64931, 263, to_date('20-03-2025', 'dd-mm-yyyy'), 71739);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (95355, 546, to_date('16-09-2029', 'dd-mm-yyyy'), 18374);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (16327, 631, to_date('12-07-2025', 'dd-mm-yyyy'), 92587);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (33931, 1289, to_date('03-05-2029', 'dd-mm-yyyy'), 74732);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (54474, 2052, to_date('20-10-2028', 'dd-mm-yyyy'), 18374);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (52417, 2104, to_date('20-01-2024', 'dd-mm-yyyy'), 72625);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (54221, 736, to_date('16-06-2027', 'dd-mm-yyyy'), 89358);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (61278, 2064, to_date('20-10-2027', 'dd-mm-yyyy'), 21632);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14942, 492, to_date('08-11-2026', 'dd-mm-yyyy'), 82439);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96427, 1006, to_date('10-04-2028', 'dd-mm-yyyy'), 19974);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73931, 1408, to_date('05-12-2026', 'dd-mm-yyyy'), 76744);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12257, 2322, to_date('20-07-2028', 'dd-mm-yyyy'), 76248);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35955, 299, to_date('22-10-2027', 'dd-mm-yyyy'), 84937);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (33847, 1648, to_date('17-09-2028', 'dd-mm-yyyy'), 65183);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (71758, 548, to_date('07-06-2029', 'dd-mm-yyyy'), 98965);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35795, 1407, to_date('20-06-2025', 'dd-mm-yyyy'), 52292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39895, 791, to_date('12-03-2025', 'dd-mm-yyyy'), 65711);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39253, 1849, to_date('16-10-2029', 'dd-mm-yyyy'), 97354);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (57321, 2414, to_date('18-07-2025', 'dd-mm-yyyy'), 56368);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72612, 1491, to_date('11-07-2024', 'dd-mm-yyyy'), 29532);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87556, 586, to_date('21-08-2027', 'dd-mm-yyyy'), 37461);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (68386, 2258, to_date('13-01-2024', 'dd-mm-yyyy'), 65753);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82321, 1161, to_date('08-12-2026', 'dd-mm-yyyy'), 21632);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82367, 522, to_date('18-10-2025', 'dd-mm-yyyy'), 74361);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81772, 2307, to_date('09-11-2028', 'dd-mm-yyyy'), 45659);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88378, 1649, to_date('23-01-2028', 'dd-mm-yyyy'), 51446);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (51131, 2002, to_date('16-05-2024', 'dd-mm-yyyy'), 78759);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87137, 1630, to_date('11-06-2029', 'dd-mm-yyyy'), 30003);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99937, 825, to_date('30-08-2025', 'dd-mm-yyyy'), 35487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (52623, 1627, to_date('30-07-2028', 'dd-mm-yyyy'), 32614);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23724, 2398, to_date('17-09-2029', 'dd-mm-yyyy'), 41656);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93861, 1365, to_date('21-09-2029', 'dd-mm-yyyy'), 62424);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73531, 2070, to_date('17-12-2029', 'dd-mm-yyyy'), 59736);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83833, 1921, to_date('23-05-2024', 'dd-mm-yyyy'), 78657);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35426, 1465, to_date('28-11-2027', 'dd-mm-yyyy'), 29134);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23686, 1461, to_date('26-12-2026', 'dd-mm-yyyy'), 29724);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (61479, 1868, to_date('01-10-2026', 'dd-mm-yyyy'), 79234);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15146, 387, to_date('26-05-2026', 'dd-mm-yyyy'), 19487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23566, 2320, to_date('01-01-2025', 'dd-mm-yyyy'), 25893);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41649, 1775, to_date('04-09-2027', 'dd-mm-yyyy'), 25854);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (92476, 2402, to_date('15-02-2028', 'dd-mm-yyyy'), 82123);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (53368, 2413, to_date('05-08-2027', 'dd-mm-yyyy'), 29118);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (44659, 331, to_date('21-02-2024', 'dd-mm-yyyy'), 74732);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (57689, 293, to_date('30-04-2026', 'dd-mm-yyyy'), 82615);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15211, 453, to_date('09-04-2025', 'dd-mm-yyyy'), 28113);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17981, 2108, to_date('21-01-2027', 'dd-mm-yyyy'), 28734);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93998, 1924, to_date('21-07-2025', 'dd-mm-yyyy'), 18374);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (38443, 179, to_date('01-08-2029', 'dd-mm-yyyy'), 59864);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17126, 1509, to_date('20-06-2024', 'dd-mm-yyyy'), 11912);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72979, 1112, to_date('20-12-2029', 'dd-mm-yyyy'), 35784);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (95552, 1070, to_date('27-07-2026', 'dd-mm-yyyy'), 73524);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34944, 374, to_date('28-02-2026', 'dd-mm-yyyy'), 98548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87256, 957, to_date('04-02-2029', 'dd-mm-yyyy'), 98965);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (27291, 1543, to_date('09-08-2029', 'dd-mm-yyyy'), 72115);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35984, 447, to_date('11-08-2027', 'dd-mm-yyyy'), 11426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96662, 294, to_date('18-11-2028', 'dd-mm-yyyy'), 52545);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (52338, 538, to_date('13-08-2027', 'dd-mm-yyyy'), 41673);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35873, 1294, to_date('30-04-2025', 'dd-mm-yyyy'), 91912);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98737, 2035, to_date('09-03-2026', 'dd-mm-yyyy'), 64612);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (84214, 2187, to_date('29-08-2026', 'dd-mm-yyyy'), 82921);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66268, 1294, to_date('03-08-2029', 'dd-mm-yyyy'), 13184);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56655, 1087, to_date('07-08-2028', 'dd-mm-yyyy'), 30002);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67328, 2414, to_date('28-11-2028', 'dd-mm-yyyy'), 17117);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12591, 1723, to_date('02-07-2026', 'dd-mm-yyyy'), 64612);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (37244, 1221, to_date('04-09-2029', 'dd-mm-yyyy'), 38729);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (42118, 2122, to_date('22-12-2026', 'dd-mm-yyyy'), 24984);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15553, 2167, to_date('26-06-2027', 'dd-mm-yyyy'), 29966);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96733, 2104, to_date('05-07-2029', 'dd-mm-yyyy'), 74361);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (61447, 2316, to_date('16-08-2025', 'dd-mm-yyyy'), 38729);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (38453, 1372, to_date('06-02-2026', 'dd-mm-yyyy'), 36928);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56311, 1182, to_date('14-09-2028', 'dd-mm-yyyy'), 59923);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48396, 2306, to_date('15-11-2024', 'dd-mm-yyyy'), 14115);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41818, 1178, to_date('10-04-2024', 'dd-mm-yyyy'), 59736);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41836, 993, to_date('19-09-2025', 'dd-mm-yyyy'), 38457);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72289, 997, to_date('16-06-2024', 'dd-mm-yyyy'), 43637);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (57821, 1783, to_date('21-11-2025', 'dd-mm-yyyy'), 44782);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (84381, 760, to_date('27-07-2029', 'dd-mm-yyyy'), 34432);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93129, 1266, to_date('29-08-2025', 'dd-mm-yyyy'), 11395);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (74421, 2453, to_date('26-09-2027', 'dd-mm-yyyy'), 35517);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (22495, 469, to_date('07-12-2027', 'dd-mm-yyyy'), 97354);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (43997, 966, to_date('13-07-2024', 'dd-mm-yyyy'), 17911);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (16832, 597, to_date('10-11-2025', 'dd-mm-yyyy'), 19338);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15347, 991, to_date('08-08-2024', 'dd-mm-yyyy'), 52254);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (99294, 1123, to_date('25-06-2026', 'dd-mm-yyyy'), 72625);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (92445, 1004, to_date('16-04-2025', 'dd-mm-yyyy'), 38161);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56318, 224, to_date('04-05-2026', 'dd-mm-yyyy'), 52292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55583, 759, to_date('30-03-2028', 'dd-mm-yyyy'), 95217);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69789, 2281, to_date('08-02-2029', 'dd-mm-yyyy'), 96463);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83491, 1732, to_date('24-01-2027', 'dd-mm-yyyy'), 96628);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23832, 1859, to_date('19-03-2027', 'dd-mm-yyyy'), 31554);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34752, 504, to_date('30-11-2024', 'dd-mm-yyyy'), 99859);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56617, 606, to_date('20-06-2025', 'dd-mm-yyyy'), 83776);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72752, 961, to_date('29-02-2028', 'dd-mm-yyyy'), 39953);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82199, 641, to_date('10-09-2028', 'dd-mm-yyyy'), 36345);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93433, 627, to_date('24-12-2027', 'dd-mm-yyyy'), 68537);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (31273, 292, to_date('30-04-2029', 'dd-mm-yyyy'), 74732);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67157, 506, to_date('28-12-2029', 'dd-mm-yyyy'), 65252);
commit;
prompt 200 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11865, 1590, to_date('29-01-2025', 'dd-mm-yyyy'), 83316);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (71671, 829, to_date('20-11-2029', 'dd-mm-yyyy'), 62227);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15426, 1306, to_date('13-07-2024', 'dd-mm-yyyy'), 24577);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (94532, 1484, to_date('18-01-2025', 'dd-mm-yyyy'), 44426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34582, 798, to_date('10-10-2028', 'dd-mm-yyyy'), 16719);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87447, 2466, to_date('08-03-2026', 'dd-mm-yyyy'), 96369);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (27992, 1745, to_date('11-01-2025', 'dd-mm-yyyy'), 45389);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72294, 1962, to_date('06-12-2026', 'dd-mm-yyyy'), 86555);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19384, 1890, to_date('08-04-2028', 'dd-mm-yyyy'), 33315);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (21373, 1494, to_date('05-07-2027', 'dd-mm-yyyy'), 42728);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (63725, 181, to_date('08-11-2026', 'dd-mm-yyyy'), 34639);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (22161, 1661, to_date('27-04-2028', 'dd-mm-yyyy'), 79322);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49118, 1914, to_date('23-02-2024', 'dd-mm-yyyy'), 77442);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (89989, 223, to_date('06-08-2029', 'dd-mm-yyyy'), 35517);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36815, 366, to_date('21-02-2026', 'dd-mm-yyyy'), 34262);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85596, 1954, to_date('01-01-2025', 'dd-mm-yyyy'), 54399);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72713, 746, to_date('01-02-2029', 'dd-mm-yyyy'), 17979);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41461, 266, to_date('11-04-2025', 'dd-mm-yyyy'), 53332);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (32437, 1828, to_date('11-02-2025', 'dd-mm-yyyy'), 25675);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (71187, 1167, to_date('07-11-2027', 'dd-mm-yyyy'), 16511);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98595, 1093, to_date('11-11-2025', 'dd-mm-yyyy'), 65772);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12812, 187, to_date('21-06-2028', 'dd-mm-yyyy'), 58911);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14394, 2222, to_date('05-02-2026', 'dd-mm-yyyy'), 73199);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (38863, 1629, to_date('30-10-2026', 'dd-mm-yyyy'), 84414);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14928, 1434, to_date('05-05-2027', 'dd-mm-yyyy'), 24984);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81879, 201, to_date('10-03-2026', 'dd-mm-yyyy'), 53751);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55313, 2031, to_date('01-07-2025', 'dd-mm-yyyy'), 94296);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (47571, 268, to_date('02-01-2027', 'dd-mm-yyyy'), 11426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (91841, 730, to_date('24-06-2028', 'dd-mm-yyyy'), 28354);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72129, 2180, to_date('18-07-2026', 'dd-mm-yyyy'), 98548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11551, 2215, to_date('29-10-2025', 'dd-mm-yyyy'), 66153);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (27924, 368, to_date('11-07-2024', 'dd-mm-yyyy'), 30003);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34169, 766, to_date('02-05-2024', 'dd-mm-yyyy'), 54111);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82664, 240, to_date('26-09-2028', 'dd-mm-yyyy'), 25854);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (21528, 1861, to_date('07-09-2029', 'dd-mm-yyyy'), 11426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (24515, 2165, to_date('25-08-2024', 'dd-mm-yyyy'), 69154);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73135, 1456, to_date('21-01-2028', 'dd-mm-yyyy'), 14242);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67723, 1911, to_date('23-01-2029', 'dd-mm-yyyy'), 83531);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19733, 534, to_date('06-10-2027', 'dd-mm-yyyy'), 17117);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56416, 493, to_date('18-09-2029', 'dd-mm-yyyy'), 37512);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83428, 841, to_date('17-11-2028', 'dd-mm-yyyy'), 59736);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11296, 2264, to_date('30-11-2026', 'dd-mm-yyyy'), 42873);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15449, 628, to_date('07-11-2028', 'dd-mm-yyyy'), 13927);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (42694, 1246, to_date('27-02-2027', 'dd-mm-yyyy'), 46912);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81812, 2141, to_date('22-02-2028', 'dd-mm-yyyy'), 30004);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48569, 379, to_date('08-10-2024', 'dd-mm-yyyy'), 76411);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34568, 310, to_date('02-11-2029', 'dd-mm-yyyy'), 29532);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (76795, 212, to_date('06-07-2025', 'dd-mm-yyyy'), 21575);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23558, 1999, to_date('11-04-2027', 'dd-mm-yyyy'), 93742);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (43187, 1688, to_date('19-03-2028', 'dd-mm-yyyy'), 49699);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (62627, 579, to_date('09-09-2027', 'dd-mm-yyyy'), 92316);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (57366, 1888, to_date('25-05-2024', 'dd-mm-yyyy'), 82652);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (94825, 2239, to_date('20-10-2027', 'dd-mm-yyyy'), 89616);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (29916, 1522, to_date('30-11-2027', 'dd-mm-yyyy'), 64612);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (93459, 558, to_date('24-06-2025', 'dd-mm-yyyy'), 59588);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48598, 668, to_date('16-07-2026', 'dd-mm-yyyy'), 73721);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49397, 460, to_date('02-05-2025', 'dd-mm-yyyy'), 38616);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (29162, 1567, to_date('19-08-2029', 'dd-mm-yyyy'), 94727);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (13174, 2199, to_date('16-05-2026', 'dd-mm-yyyy'), 78281);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (37582, 2005, to_date('27-09-2025', 'dd-mm-yyyy'), 61435);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (35835, 1794, to_date('03-08-2027', 'dd-mm-yyyy'), 56515);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36256, 460, to_date('25-03-2024', 'dd-mm-yyyy'), 59487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (75718, 879, to_date('16-08-2027', 'dd-mm-yyyy'), 16437);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56928, 1246, to_date('29-11-2024', 'dd-mm-yyyy'), 68537);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (63784, 2442, to_date('12-05-2024', 'dd-mm-yyyy'), 96672);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82587, 843, to_date('30-08-2029', 'dd-mm-yyyy'), 48971);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (45895, 1857, to_date('01-08-2026', 'dd-mm-yyyy'), 17642);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72553, 2448, to_date('19-01-2024', 'dd-mm-yyyy'), 87984);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (97359, 1437, to_date('23-07-2029', 'dd-mm-yyyy'), 96566);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (37328, 2308, to_date('20-12-2024', 'dd-mm-yyyy'), 98548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55543, 1465, to_date('12-09-2026', 'dd-mm-yyyy'), 57217);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17421, 1915, to_date('03-04-2026', 'dd-mm-yyyy'), 61521);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (21271, 640, to_date('02-03-2027', 'dd-mm-yyyy'), 18621);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (94623, 1397, to_date('19-04-2028', 'dd-mm-yyyy'), 21759);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48576, 1215, to_date('04-07-2025', 'dd-mm-yyyy'), 43552);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (15756, 2306, to_date('13-09-2025', 'dd-mm-yyyy'), 96149);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (68514, 2388, to_date('09-04-2025', 'dd-mm-yyyy'), 98428);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14935, 1009, to_date('16-11-2024', 'dd-mm-yyyy'), 44623);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (46339, 743, to_date('22-08-2026', 'dd-mm-yyyy'), 45835);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (59368, 882, to_date('05-09-2025', 'dd-mm-yyyy'), 45686);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88362, 2445, to_date('19-01-2026', 'dd-mm-yyyy'), 37772);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55971, 994, to_date('13-01-2027', 'dd-mm-yyyy'), 18621);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (42529, 167, to_date('28-10-2027', 'dd-mm-yyyy'), 68462);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72747, 1256, to_date('24-07-2026', 'dd-mm-yyyy'), 37916);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17253, 1752, to_date('12-10-2025', 'dd-mm-yyyy'), 89217);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58768, 503, to_date('12-03-2026', 'dd-mm-yyyy'), 79857);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66941, 2431, to_date('16-11-2026', 'dd-mm-yyyy'), 29966);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55553, 1643, to_date('24-10-2025', 'dd-mm-yyyy'), 39837);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (52753, 1729, to_date('28-10-2026', 'dd-mm-yyyy'), 53336);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73486, 340, to_date('12-11-2028', 'dd-mm-yyyy'), 88626);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81876, 1551, to_date('18-09-2027', 'dd-mm-yyyy'), 19548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (71678, 1912, to_date('30-12-2029', 'dd-mm-yyyy'), 88298);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (26254, 1922, to_date('23-08-2025', 'dd-mm-yyyy'), 25165);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (18724, 612, to_date('31-08-2026', 'dd-mm-yyyy'), 31688);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85591, 1428, to_date('04-05-2028', 'dd-mm-yyyy'), 59588);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88925, 1231, to_date('08-10-2024', 'dd-mm-yyyy'), 82123);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (37785, 2356, to_date('15-10-2024', 'dd-mm-yyyy'), 74732);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11215, 727, to_date('15-04-2026', 'dd-mm-yyyy'), 35294);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (42631, 1736, to_date('10-11-2026', 'dd-mm-yyyy'), 11426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81431, 424, to_date('17-11-2028', 'dd-mm-yyyy'), 64612);
commit;
prompt 300 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49929, 1181, to_date('01-12-2026', 'dd-mm-yyyy'), 46594);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (31191, 1747, to_date('13-07-2025', 'dd-mm-yyyy'), 17687);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96125, 277, to_date('19-06-2027', 'dd-mm-yyyy'), 66549);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (86299, 1966, to_date('03-03-2028', 'dd-mm-yyyy'), 47365);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67648, 1726, to_date('04-10-2028', 'dd-mm-yyyy'), 41847);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (24517, 1684, to_date('16-04-2025', 'dd-mm-yyyy'), 31716);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12261, 2382, to_date('11-06-2028', 'dd-mm-yyyy'), 17698);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (45529, 582, to_date('30-07-2029', 'dd-mm-yyyy'), 93739);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (33779, 746, to_date('27-02-2027', 'dd-mm-yyyy'), 78169);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17359, 205, to_date('18-07-2029', 'dd-mm-yyyy'), 96657);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14372, 2106, to_date('06-03-2028', 'dd-mm-yyyy'), 69782);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66462, 2054, to_date('18-02-2025', 'dd-mm-yyyy'), 33732);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (14887, 174, to_date('13-01-2025', 'dd-mm-yyyy'), 97666);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (17116, 978, to_date('15-05-2027', 'dd-mm-yyyy'), 11426);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (24297, 1034, to_date('22-02-2025', 'dd-mm-yyyy'), 30001);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98684, 2063, to_date('18-12-2027', 'dd-mm-yyyy'), 35294);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58463, 2424, to_date('03-06-2025', 'dd-mm-yyyy'), 37916);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41244, 2274, to_date('09-12-2028', 'dd-mm-yyyy'), 72942);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (56933, 1229, to_date('30-11-2029', 'dd-mm-yyyy'), 31688);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11621, 292, to_date('12-04-2024', 'dd-mm-yyyy'), 39953);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83341, 979, to_date('05-06-2025', 'dd-mm-yyyy'), 39472);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83725, 1664, to_date('09-07-2029', 'dd-mm-yyyy'), 19487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12682, 529, to_date('24-02-2029', 'dd-mm-yyyy'), 54755);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (21784, 429, to_date('26-05-2027', 'dd-mm-yyyy'), 52292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (25775, 1557, to_date('08-04-2028', 'dd-mm-yyyy'), 58994);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58669, 724, to_date('21-06-2027', 'dd-mm-yyyy'), 55791);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (83912, 1951, to_date('10-08-2027', 'dd-mm-yyyy'), 11395);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85988, 763, to_date('22-09-2029', 'dd-mm-yyyy'), 31948);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72155, 950, to_date('29-03-2025', 'dd-mm-yyyy'), 65252);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12691, 333, to_date('27-03-2024', 'dd-mm-yyyy'), 32565);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (51589, 1938, to_date('19-02-2024', 'dd-mm-yyyy'), 52192);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (21991, 1234, to_date('05-10-2026', 'dd-mm-yyyy'), 66593);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (69997, 1128, to_date('01-10-2025', 'dd-mm-yyyy'), 33634);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (28934, 669, to_date('15-05-2024', 'dd-mm-yyyy'), 78212);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96535, 2111, to_date('06-09-2029', 'dd-mm-yyyy'), 16511);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34518, 1086, to_date('03-02-2029', 'dd-mm-yyyy'), 54399);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (43574, 2189, to_date('14-04-2027', 'dd-mm-yyyy'), 28113);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39944, 1216, to_date('06-07-2029', 'dd-mm-yyyy'), 45349);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (59397, 2219, to_date('14-04-2025', 'dd-mm-yyyy'), 71465);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12751, 1215, to_date('31-05-2026', 'dd-mm-yyyy'), 21367);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (28763, 2356, to_date('05-06-2027', 'dd-mm-yyyy'), 36499);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11598, 756, to_date('24-05-2026', 'dd-mm-yyyy'), 13184);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82461, 2488, to_date('29-01-2028', 'dd-mm-yyyy'), 66364);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67868, 1819, to_date('01-07-2029', 'dd-mm-yyyy'), 31448);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (58291, 330, to_date('10-11-2029', 'dd-mm-yyyy'), 53947);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (53546, 2079, to_date('03-11-2028', 'dd-mm-yyyy'), 95217);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (31645, 1269, to_date('13-04-2025', 'dd-mm-yyyy'), 22834);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (48762, 2399, to_date('23-03-2028', 'dd-mm-yyyy'), 37772);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (89528, 2345, to_date('09-05-2026', 'dd-mm-yyyy'), 93442);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39217, 221, to_date('11-10-2029', 'dd-mm-yyyy'), 25798);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (16279, 2096, to_date('21-03-2028', 'dd-mm-yyyy'), 41561);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (57945, 1757, to_date('25-07-2027', 'dd-mm-yyyy'), 45686);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (12923, 1276, to_date('20-03-2025', 'dd-mm-yyyy'), 31688);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36466, 1924, to_date('21-04-2024', 'dd-mm-yyyy'), 82652);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19894, 349, to_date('28-07-2029', 'dd-mm-yyyy'), 26335);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66359, 1139, to_date('01-02-2029', 'dd-mm-yyyy'), 59487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11896, 538, to_date('16-01-2025', 'dd-mm-yyyy'), 96149);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87783, 283, to_date('28-05-2027', 'dd-mm-yyyy'), 65711);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (67639, 1015, to_date('05-05-2025', 'dd-mm-yyyy'), 37461);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (27649, 2452, to_date('19-02-2029', 'dd-mm-yyyy'), 16719);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34635, 553, to_date('14-01-2024', 'dd-mm-yyyy'), 33634);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (95349, 618, to_date('25-04-2029', 'dd-mm-yyyy'), 66527);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (82458, 1721, to_date('07-09-2025', 'dd-mm-yyyy'), 14115);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (23892, 1866, to_date('11-02-2027', 'dd-mm-yyyy'), 82123);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (76836, 357, to_date('24-12-2026', 'dd-mm-yyyy'), 42873);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (84423, 2068, to_date('23-08-2028', 'dd-mm-yyyy'), 54399);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (39842, 2470, to_date('12-05-2028', 'dd-mm-yyyy'), 26926);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (65777, 432, to_date('03-08-2028', 'dd-mm-yyyy'), 44484);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (22839, 1168, to_date('29-08-2027', 'dd-mm-yyyy'), 16437);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (47524, 2295, to_date('30-10-2027', 'dd-mm-yyyy'), 26256);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (84258, 607, to_date('14-09-2025', 'dd-mm-yyyy'), 30004);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36526, 754, to_date('19-01-2027', 'dd-mm-yyyy'), 37782);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (29569, 2330, to_date('16-12-2025', 'dd-mm-yyyy'), 12567);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (76733, 617, to_date('26-05-2026', 'dd-mm-yyyy'), 13358);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (44265, 1003, to_date('22-02-2028', 'dd-mm-yyyy'), 69466);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (43947, 2387, to_date('27-01-2025', 'dd-mm-yyyy'), 56328);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (22698, 1314, to_date('09-11-2027', 'dd-mm-yyyy'), 23487);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (73144, 354, to_date('24-12-2026', 'dd-mm-yyyy'), 28593);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (63494, 1955, to_date('14-03-2028', 'dd-mm-yyyy'), 37647);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (55733, 1839, to_date('30-04-2028', 'dd-mm-yyyy'), 71253);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (77665, 770, to_date('01-06-2027', 'dd-mm-yyyy'), 37647);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (36312, 1778, to_date('15-04-2029', 'dd-mm-yyyy'), 36345);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (96395, 2240, to_date('28-06-2024', 'dd-mm-yyyy'), 76411);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (79165, 1970, to_date('01-08-2027', 'dd-mm-yyyy'), 98548);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (97975, 1475, to_date('20-10-2024', 'dd-mm-yyyy'), 61521);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88982, 2112, to_date('20-02-2024', 'dd-mm-yyyy'), 55163);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (18964, 1108, to_date('24-09-2027', 'dd-mm-yyyy'), 84414);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (25397, 242, to_date('10-09-2028', 'dd-mm-yyyy'), 19974);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (98338, 2333, to_date('12-04-2026', 'dd-mm-yyyy'), 21367);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (37382, 232, to_date('07-06-2029', 'dd-mm-yyyy'), 76595);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (25392, 641, to_date('18-09-2024', 'dd-mm-yyyy'), 44833);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (87386, 472, to_date('11-08-2028', 'dd-mm-yyyy'), 44344);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (94834, 373, to_date('10-03-2026', 'dd-mm-yyyy'), 96369);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (84339, 1368, to_date('03-03-2024', 'dd-mm-yyyy'), 37512);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (66258, 1047, to_date('08-05-2026', 'dd-mm-yyyy'), 49749);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85648, 1077, to_date('20-05-2027', 'dd-mm-yyyy'), 84117);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (88714, 157, to_date('23-12-2024', 'dd-mm-yyyy'), 41673);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (97995, 650, to_date('13-06-2026', 'dd-mm-yyyy'), 25556);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49627, 660, to_date('14-08-2025', 'dd-mm-yyyy'), 14715);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (72982, 2125, to_date('24-02-2028', 'dd-mm-yyyy'), 85761);
commit;
prompt 400 records committed...
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (42742, 2019, to_date('11-03-2029', 'dd-mm-yyyy'), 72625);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (74682, 1912, to_date('14-06-2027', 'dd-mm-yyyy'), 78759);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (64391, 641, to_date('13-08-2027', 'dd-mm-yyyy'), 30006);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (45226, 639, to_date('21-02-2025', 'dd-mm-yyyy'), 56328);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (49553, 2072, to_date('15-06-2027', 'dd-mm-yyyy'), 44578);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (64731, 1239, to_date('17-06-2027', 'dd-mm-yyyy'), 39472);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34755, 281, to_date('06-07-2025', 'dd-mm-yyyy'), 29134);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19583, 2344, to_date('11-09-2027', 'dd-mm-yyyy'), 57292);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (41351, 1607, to_date('29-06-2026', 'dd-mm-yyyy'), 92587);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (33596, 1070, to_date('05-11-2029', 'dd-mm-yyyy'), 53947);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (19255, 1696, to_date('01-08-2024', 'dd-mm-yyyy'), 32614);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (79675, 515, to_date('22-03-2024', 'dd-mm-yyyy'), 24676);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (81344, 2393, to_date('16-02-2027', 'dd-mm-yyyy'), 76411);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (89675, 795, to_date('29-01-2029', 'dd-mm-yyyy'), 57934);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (74612, 430, to_date('14-03-2024', 'dd-mm-yyyy'), 69782);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (31115, 1834, to_date('29-03-2024', 'dd-mm-yyyy'), 14242);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (46391, 1974, to_date('09-04-2024', 'dd-mm-yyyy'), 61521);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (18813, 1457, to_date('21-09-2028', 'dd-mm-yyyy'), 38729);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (85672, 1906, to_date('25-10-2029', 'dd-mm-yyyy'), 13831);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (34929, 530, to_date('12-05-2028', 'dd-mm-yyyy'), 66549);
insert into PAYMENT (id, totalprice, pdate, appointmentid)
values (11282, 722, to_date('07-12-2024', 'dd-mm-yyyy'), 28354);
commit;
prompt 421 records loaded
prompt Loading TPREFORMEDINA...
insert into TPREFORMEDINA (tid, appointmentid)
values (11153, 42728);
insert into TPREFORMEDINA (tid, appointmentid)
values (11355, 49699);
insert into TPREFORMEDINA (tid, appointmentid)
values (11536, 32614);
insert into TPREFORMEDINA (tid, appointmentid)
values (12265, 71125);
insert into TPREFORMEDINA (tid, appointmentid)
values (12265, 85669);
insert into TPREFORMEDINA (tid, appointmentid)
values (13622, 13713);
insert into TPREFORMEDINA (tid, appointmentid)
values (13622, 37916);
insert into TPREFORMEDINA (tid, appointmentid)
values (13622, 72942);
insert into TPREFORMEDINA (tid, appointmentid)
values (14355, 44623);
insert into TPREFORMEDINA (tid, appointmentid)
values (14355, 55791);
insert into TPREFORMEDINA (tid, appointmentid)
values (14543, 62759);
insert into TPREFORMEDINA (tid, appointmentid)
values (14543, 78281);
insert into TPREFORMEDINA (tid, appointmentid)
values (14552, 21759);
insert into TPREFORMEDINA (tid, appointmentid)
values (14552, 88645);
insert into TPREFORMEDINA (tid, appointmentid)
values (14675, 11416);
insert into TPREFORMEDINA (tid, appointmentid)
values (14675, 69782);
insert into TPREFORMEDINA (tid, appointmentid)
values (14839, 36944);
insert into TPREFORMEDINA (tid, appointmentid)
values (15866, 44887);
insert into TPREFORMEDINA (tid, appointmentid)
values (15973, 13944);
insert into TPREFORMEDINA (tid, appointmentid)
values (15973, 86627);
insert into TPREFORMEDINA (tid, appointmentid)
values (16211, 19137);
insert into TPREFORMEDINA (tid, appointmentid)
values (16211, 61435);
insert into TPREFORMEDINA (tid, appointmentid)
values (16365, 38729);
insert into TPREFORMEDINA (tid, appointmentid)
values (16754, 64388);
insert into TPREFORMEDINA (tid, appointmentid)
values (17119, 44623);
insert into TPREFORMEDINA (tid, appointmentid)
values (17141, 86786);
insert into TPREFORMEDINA (tid, appointmentid)
values (18323, 65711);
insert into TPREFORMEDINA (tid, appointmentid)
values (18675, 83194);
insert into TPREFORMEDINA (tid, appointmentid)
values (18841, 49699);
insert into TPREFORMEDINA (tid, appointmentid)
values (19389, 84414);
insert into TPREFORMEDINA (tid, appointmentid)
values (19434, 53274);
insert into TPREFORMEDINA (tid, appointmentid)
values (21241, 13184);
insert into TPREFORMEDINA (tid, appointmentid)
values (21241, 39772);
insert into TPREFORMEDINA (tid, appointmentid)
values (21241, 45659);
insert into TPREFORMEDINA (tid, appointmentid)
values (21534, 24399);
insert into TPREFORMEDINA (tid, appointmentid)
values (21534, 43457);
insert into TPREFORMEDINA (tid, appointmentid)
values (21534, 61521);
insert into TPREFORMEDINA (tid, appointmentid)
values (22218, 74655);
insert into TPREFORMEDINA (tid, appointmentid)
values (22349, 59588);
insert into TPREFORMEDINA (tid, appointmentid)
values (22349, 97666);
insert into TPREFORMEDINA (tid, appointmentid)
values (22389, 84957);
insert into TPREFORMEDINA (tid, appointmentid)
values (23348, 41561);
insert into TPREFORMEDINA (tid, appointmentid)
values (23348, 66449);
insert into TPREFORMEDINA (tid, appointmentid)
values (23661, 66527);
insert into TPREFORMEDINA (tid, appointmentid)
values (25155, 94296);
insert into TPREFORMEDINA (tid, appointmentid)
values (25522, 25893);
insert into TPREFORMEDINA (tid, appointmentid)
values (25522, 45389);
insert into TPREFORMEDINA (tid, appointmentid)
values (26426, 43637);
insert into TPREFORMEDINA (tid, appointmentid)
values (26551, 19776);
insert into TPREFORMEDINA (tid, appointmentid)
values (26691, 36345);
insert into TPREFORMEDINA (tid, appointmentid)
values (26847, 56328);
insert into TPREFORMEDINA (tid, appointmentid)
values (26847, 89616);
insert into TPREFORMEDINA (tid, appointmentid)
values (27147, 13184);
insert into TPREFORMEDINA (tid, appointmentid)
values (27147, 39616);
insert into TPREFORMEDINA (tid, appointmentid)
values (27635, 87144);
insert into TPREFORMEDINA (tid, appointmentid)
values (29468, 73262);
insert into TPREFORMEDINA (tid, appointmentid)
values (31183, 68242);
insert into TPREFORMEDINA (tid, appointmentid)
values (31183, 76595);
insert into TPREFORMEDINA (tid, appointmentid)
values (31498, 25854);
insert into TPREFORMEDINA (tid, appointmentid)
values (32426, 16511);
insert into TPREFORMEDINA (tid, appointmentid)
values (32691, 26926);
insert into TPREFORMEDINA (tid, appointmentid)
values (32691, 43748);
insert into TPREFORMEDINA (tid, appointmentid)
values (32691, 53498);
insert into TPREFORMEDINA (tid, appointmentid)
values (32691, 72766);
insert into TPREFORMEDINA (tid, appointmentid)
values (32691, 92587);
insert into TPREFORMEDINA (tid, appointmentid)
values (33551, 55791);
insert into TPREFORMEDINA (tid, appointmentid)
values (33551, 65252);
insert into TPREFORMEDINA (tid, appointmentid)
values (33551, 66549);
insert into TPREFORMEDINA (tid, appointmentid)
values (33742, 27367);
insert into TPREFORMEDINA (tid, appointmentid)
values (34578, 72766);
insert into TPREFORMEDINA (tid, appointmentid)
values (34644, 21759);
insert into TPREFORMEDINA (tid, appointmentid)
values (34718, 38161);
insert into TPREFORMEDINA (tid, appointmentid)
values (34794, 73638);
insert into TPREFORMEDINA (tid, appointmentid)
values (35145, 17373);
insert into TPREFORMEDINA (tid, appointmentid)
values (35145, 41673);
insert into TPREFORMEDINA (tid, appointmentid)
values (35145, 59588);
insert into TPREFORMEDINA (tid, appointmentid)
values (35174, 82439);
insert into TPREFORMEDINA (tid, appointmentid)
values (35345, 13184);
insert into TPREFORMEDINA (tid, appointmentid)
values (35666, 14235);
insert into TPREFORMEDINA (tid, appointmentid)
values (35666, 26331);
insert into TPREFORMEDINA (tid, appointmentid)
values (35666, 71125);
insert into TPREFORMEDINA (tid, appointmentid)
values (35732, 67992);
insert into TPREFORMEDINA (tid, appointmentid)
values (35736, 22834);
insert into TPREFORMEDINA (tid, appointmentid)
values (35753, 14715);
insert into TPREFORMEDINA (tid, appointmentid)
values (35821, 58994);
insert into TPREFORMEDINA (tid, appointmentid)
values (35821, 93442);
insert into TPREFORMEDINA (tid, appointmentid)
values (36176, 41561);
insert into TPREFORMEDINA (tid, appointmentid)
values (36526, 73638);
insert into TPREFORMEDINA (tid, appointmentid)
values (36836, 55791);
insert into TPREFORMEDINA (tid, appointmentid)
values (36999, 97354);
insert into TPREFORMEDINA (tid, appointmentid)
values (38646, 65252);
insert into TPREFORMEDINA (tid, appointmentid)
values (38646, 98965);
insert into TPREFORMEDINA (tid, appointmentid)
values (39411, 17642);
insert into TPREFORMEDINA (tid, appointmentid)
values (39411, 55163);
insert into TPREFORMEDINA (tid, appointmentid)
values (39569, 13831);
insert into TPREFORMEDINA (tid, appointmentid)
values (41662, 96628);
insert into TPREFORMEDINA (tid, appointmentid)
values (41861, 35784);
insert into TPREFORMEDINA (tid, appointmentid)
values (42949, 69358);
insert into TPREFORMEDINA (tid, appointmentid)
values (43229, 98548);
insert into TPREFORMEDINA (tid, appointmentid)
values (43285, 76595);
commit;
prompt 100 records committed...
insert into TPREFORMEDINA (tid, appointmentid)
values (43414, 41673);
insert into TPREFORMEDINA (tid, appointmentid)
values (43463, 53274);
insert into TPREFORMEDINA (tid, appointmentid)
values (43548, 39772);
insert into TPREFORMEDINA (tid, appointmentid)
values (43548, 59883);
insert into TPREFORMEDINA (tid, appointmentid)
values (43562, 66364);
insert into TPREFORMEDINA (tid, appointmentid)
values (43562, 68789);
insert into TPREFORMEDINA (tid, appointmentid)
values (43564, 12777);
insert into TPREFORMEDINA (tid, appointmentid)
values (43564, 31299);
insert into TPREFORMEDINA (tid, appointmentid)
values (43627, 44344);
insert into TPREFORMEDINA (tid, appointmentid)
values (44524, 68537);
insert into TPREFORMEDINA (tid, appointmentid)
values (45115, 88645);
insert into TPREFORMEDINA (tid, appointmentid)
values (45358, 17373);
insert into TPREFORMEDINA (tid, appointmentid)
values (45394, 42733);
insert into TPREFORMEDINA (tid, appointmentid)
values (45421, 25675);
insert into TPREFORMEDINA (tid, appointmentid)
values (45421, 97935);
insert into TPREFORMEDINA (tid, appointmentid)
values (46212, 16719);
insert into TPREFORMEDINA (tid, appointmentid)
values (46212, 17979);
insert into TPREFORMEDINA (tid, appointmentid)
values (46326, 39616);
insert into TPREFORMEDINA (tid, appointmentid)
values (46326, 91818);
insert into TPREFORMEDINA (tid, appointmentid)
values (46517, 49621);
insert into TPREFORMEDINA (tid, appointmentid)
values (46755, 43457);
insert into TPREFORMEDINA (tid, appointmentid)
values (46923, 36928);
insert into TPREFORMEDINA (tid, appointmentid)
values (46956, 43637);
insert into TPREFORMEDINA (tid, appointmentid)
values (47955, 65772);
insert into TPREFORMEDINA (tid, appointmentid)
values (48123, 67992);
insert into TPREFORMEDINA (tid, appointmentid)
values (48329, 32614);
insert into TPREFORMEDINA (tid, appointmentid)
values (48329, 44887);
insert into TPREFORMEDINA (tid, appointmentid)
values (48389, 65711);
insert into TPREFORMEDINA (tid, appointmentid)
values (48389, 68537);
insert into TPREFORMEDINA (tid, appointmentid)
values (49126, 21367);
insert into TPREFORMEDINA (tid, appointmentid)
values (49126, 32565);
insert into TPREFORMEDINA (tid, appointmentid)
values (51563, 16437);
insert into TPREFORMEDINA (tid, appointmentid)
values (51682, 68462);
insert into TPREFORMEDINA (tid, appointmentid)
values (51917, 49174);
insert into TPREFORMEDINA (tid, appointmentid)
values (51917, 97579);
insert into TPREFORMEDINA (tid, appointmentid)
values (52125, 33634);
insert into TPREFORMEDINA (tid, appointmentid)
values (52748, 55427);
insert into TPREFORMEDINA (tid, appointmentid)
values (52941, 13927);
insert into TPREFORMEDINA (tid, appointmentid)
values (52941, 97927);
insert into TPREFORMEDINA (tid, appointmentid)
values (53636, 76248);
insert into TPREFORMEDINA (tid, appointmentid)
values (53636, 96736);
insert into TPREFORMEDINA (tid, appointmentid)
values (54149, 34968);
insert into TPREFORMEDINA (tid, appointmentid)
values (54551, 19548);
insert into TPREFORMEDINA (tid, appointmentid)
values (54948, 14242);
insert into TPREFORMEDINA (tid, appointmentid)
values (54948, 45389);
insert into TPREFORMEDINA (tid, appointmentid)
values (54973, 58911);
insert into TPREFORMEDINA (tid, appointmentid)
values (54973, 96463);
insert into TPREFORMEDINA (tid, appointmentid)
values (55128, 26256);
insert into TPREFORMEDINA (tid, appointmentid)
values (55383, 17979);
insert into TPREFORMEDINA (tid, appointmentid)
values (55383, 39257);
insert into TPREFORMEDINA (tid, appointmentid)
values (55476, 37223);
insert into TPREFORMEDINA (tid, appointmentid)
values (55476, 56368);
insert into TPREFORMEDINA (tid, appointmentid)
values (55534, 12567);
insert into TPREFORMEDINA (tid, appointmentid)
values (55534, 56388);
insert into TPREFORMEDINA (tid, appointmentid)
values (55856, 91912);
insert into TPREFORMEDINA (tid, appointmentid)
values (56151, 49621);
insert into TPREFORMEDINA (tid, appointmentid)
values (56217, 17117);
insert into TPREFORMEDINA (tid, appointmentid)
values (56217, 72766);
insert into TPREFORMEDINA (tid, appointmentid)
values (56679, 59487);
insert into TPREFORMEDINA (tid, appointmentid)
values (56844, 18689);
insert into TPREFORMEDINA (tid, appointmentid)
values (57236, 24676);
insert into TPREFORMEDINA (tid, appointmentid)
values (57236, 42733);
insert into TPREFORMEDINA (tid, appointmentid)
values (57236, 69466);
insert into TPREFORMEDINA (tid, appointmentid)
values (57236, 93742);
insert into TPREFORMEDINA (tid, appointmentid)
values (57256, 43457);
insert into TPREFORMEDINA (tid, appointmentid)
values (57256, 69165);
insert into TPREFORMEDINA (tid, appointmentid)
values (57734, 82615);
insert into TPREFORMEDINA (tid, appointmentid)
values (57765, 47288);
insert into TPREFORMEDINA (tid, appointmentid)
values (58257, 49689);
insert into TPREFORMEDINA (tid, appointmentid)
values (58257, 91955);
insert into TPREFORMEDINA (tid, appointmentid)
values (58261, 16719);
insert into TPREFORMEDINA (tid, appointmentid)
values (58264, 25798);
insert into TPREFORMEDINA (tid, appointmentid)
values (58264, 37495);
insert into TPREFORMEDINA (tid, appointmentid)
values (58264, 65753);
insert into TPREFORMEDINA (tid, appointmentid)
values (58861, 96149);
insert into TPREFORMEDINA (tid, appointmentid)
values (58882, 13927);
insert into TPREFORMEDINA (tid, appointmentid)
values (58882, 44623);
insert into TPREFORMEDINA (tid, appointmentid)
values (59576, 14715);
insert into TPREFORMEDINA (tid, appointmentid)
values (59576, 24984);
insert into TPREFORMEDINA (tid, appointmentid)
values (59848, 55324);
insert into TPREFORMEDINA (tid, appointmentid)
values (59883, 95217);
insert into TPREFORMEDINA (tid, appointmentid)
values (61278, 29966);
insert into TPREFORMEDINA (tid, appointmentid)
values (61278, 57934);
insert into TPREFORMEDINA (tid, appointmentid)
values (61278, 95217);
insert into TPREFORMEDINA (tid, appointmentid)
values (61469, 44887);
insert into TPREFORMEDINA (tid, appointmentid)
values (61469, 65772);
insert into TPREFORMEDINA (tid, appointmentid)
values (61469, 93442);
insert into TPREFORMEDINA (tid, appointmentid)
values (61571, 72625);
insert into TPREFORMEDINA (tid, appointmentid)
values (61725, 49174);
insert into TPREFORMEDINA (tid, appointmentid)
values (61751, 43748);
insert into TPREFORMEDINA (tid, appointmentid)
values (61751, 74732);
insert into TPREFORMEDINA (tid, appointmentid)
values (61751, 79234);
insert into TPREFORMEDINA (tid, appointmentid)
values (61916, 19338);
insert into TPREFORMEDINA (tid, appointmentid)
values (61916, 31496);
insert into TPREFORMEDINA (tid, appointmentid)
values (61916, 37916);
insert into TPREFORMEDINA (tid, appointmentid)
values (62262, 53751);
insert into TPREFORMEDINA (tid, appointmentid)
values (62262, 61521);
insert into TPREFORMEDINA (tid, appointmentid)
values (62824, 63768);
insert into TPREFORMEDINA (tid, appointmentid)
values (63454, 33732);
insert into TPREFORMEDINA (tid, appointmentid)
values (63929, 59487);
commit;
prompt 200 records committed...
insert into TPREFORMEDINA (tid, appointmentid)
values (64193, 41561);
insert into TPREFORMEDINA (tid, appointmentid)
values (64193, 73262);
insert into TPREFORMEDINA (tid, appointmentid)
values (64213, 42735);
insert into TPREFORMEDINA (tid, appointmentid)
values (64213, 69782);
insert into TPREFORMEDINA (tid, appointmentid)
values (64213, 97927);
insert into TPREFORMEDINA (tid, appointmentid)
values (64259, 12777);
insert into TPREFORMEDINA (tid, appointmentid)
values (64435, 34639);
insert into TPREFORMEDINA (tid, appointmentid)
values (64435, 87984);
insert into TPREFORMEDINA (tid, appointmentid)
values (64435, 89217);
insert into TPREFORMEDINA (tid, appointmentid)
values (64556, 65466);
insert into TPREFORMEDINA (tid, appointmentid)
values (64585, 48557);
insert into TPREFORMEDINA (tid, appointmentid)
values (64585, 58994);
insert into TPREFORMEDINA (tid, appointmentid)
values (65135, 29532);
insert into TPREFORMEDINA (tid, appointmentid)
values (65135, 69165);
insert into TPREFORMEDINA (tid, appointmentid)
values (65135, 93739);
insert into TPREFORMEDINA (tid, appointmentid)
values (65894, 26335);
insert into TPREFORMEDINA (tid, appointmentid)
values (65959, 14235);
insert into TPREFORMEDINA (tid, appointmentid)
values (65959, 98371);
insert into TPREFORMEDINA (tid, appointmentid)
values (66121, 35487);
insert into TPREFORMEDINA (tid, appointmentid)
values (66121, 43913);
insert into TPREFORMEDINA (tid, appointmentid)
values (66237, 43637);
insert into TPREFORMEDINA (tid, appointmentid)
values (66237, 85761);
insert into TPREFORMEDINA (tid, appointmentid)
values (66786, 13184);
insert into TPREFORMEDINA (tid, appointmentid)
values (66786, 62834);
insert into TPREFORMEDINA (tid, appointmentid)
values (66853, 69466);
insert into TPREFORMEDINA (tid, appointmentid)
values (67264, 24984);
insert into TPREFORMEDINA (tid, appointmentid)
values (67274, 91955);
insert into TPREFORMEDINA (tid, appointmentid)
values (67319, 27341);
insert into TPREFORMEDINA (tid, appointmentid)
values (67922, 25854);
insert into TPREFORMEDINA (tid, appointmentid)
values (68228, 62629);
insert into TPREFORMEDINA (tid, appointmentid)
values (68378, 16511);
insert into TPREFORMEDINA (tid, appointmentid)
values (68378, 35784);
insert into TPREFORMEDINA (tid, appointmentid)
values (68378, 78212);
insert into TPREFORMEDINA (tid, appointmentid)
values (68449, 96672);
insert into TPREFORMEDINA (tid, appointmentid)
values (68541, 89358);
insert into TPREFORMEDINA (tid, appointmentid)
values (68541, 93739);
insert into TPREFORMEDINA (tid, appointmentid)
values (68654, 45389);
insert into TPREFORMEDINA (tid, appointmentid)
values (68714, 29134);
insert into TPREFORMEDINA (tid, appointmentid)
values (69323, 78281);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 73199);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 99862);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 99863);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 99864);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 99865);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 99866);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 99867);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 99868);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 99869);
insert into TPREFORMEDINA (tid, appointmentid)
values (69548, 99870);
insert into TPREFORMEDINA (tid, appointmentid)
values (69888, 59883);
insert into TPREFORMEDINA (tid, appointmentid)
values (69888, 73638);
insert into TPREFORMEDINA (tid, appointmentid)
values (71249, 98428);
insert into TPREFORMEDINA (tid, appointmentid)
values (71465, 65252);
insert into TPREFORMEDINA (tid, appointmentid)
values (71531, 96672);
insert into TPREFORMEDINA (tid, appointmentid)
values (72385, 59883);
insert into TPREFORMEDINA (tid, appointmentid)
values (73179, 25675);
insert into TPREFORMEDINA (tid, appointmentid)
values (73179, 25798);
insert into TPREFORMEDINA (tid, appointmentid)
values (73179, 37748);
insert into TPREFORMEDINA (tid, appointmentid)
values (73447, 23487);
insert into TPREFORMEDINA (tid, appointmentid)
values (73772, 82439);
insert into TPREFORMEDINA (tid, appointmentid)
values (73797, 45949);
insert into TPREFORMEDINA (tid, appointmentid)
values (75129, 73638);
insert into TPREFORMEDINA (tid, appointmentid)
values (75421, 71253);
insert into TPREFORMEDINA (tid, appointmentid)
values (75421, 99385);
insert into TPREFORMEDINA (tid, appointmentid)
values (75487, 43637);
insert into TPREFORMEDINA (tid, appointmentid)
values (75494, 51446);
insert into TPREFORMEDINA (tid, appointmentid)
values (75819, 14242);
insert into TPREFORMEDINA (tid, appointmentid)
values (75819, 22834);
insert into TPREFORMEDINA (tid, appointmentid)
values (76218, 13927);
insert into TPREFORMEDINA (tid, appointmentid)
values (76218, 65183);
insert into TPREFORMEDINA (tid, appointmentid)
values (76218, 68462);
insert into TPREFORMEDINA (tid, appointmentid)
values (76278, 37772);
insert into TPREFORMEDINA (tid, appointmentid)
values (76324, 99822);
insert into TPREFORMEDINA (tid, appointmentid)
values (76614, 61435);
insert into TPREFORMEDINA (tid, appointmentid)
values (76614, 69782);
insert into TPREFORMEDINA (tid, appointmentid)
values (76939, 83776);
insert into TPREFORMEDINA (tid, appointmentid)
values (77355, 22473);
insert into TPREFORMEDINA (tid, appointmentid)
values (77355, 41847);
insert into TPREFORMEDINA (tid, appointmentid)
values (77355, 64612);
insert into TPREFORMEDINA (tid, appointmentid)
values (77591, 25854);
insert into TPREFORMEDINA (tid, appointmentid)
values (78153, 21367);
insert into TPREFORMEDINA (tid, appointmentid)
values (78516, 16719);
insert into TPREFORMEDINA (tid, appointmentid)
values (79265, 25854);
insert into TPREFORMEDINA (tid, appointmentid)
values (79265, 44484);
insert into TPREFORMEDINA (tid, appointmentid)
values (79265, 78559);
insert into TPREFORMEDINA (tid, appointmentid)
values (79892, 57853);
insert into TPREFORMEDINA (tid, appointmentid)
values (79892, 72942);
insert into TPREFORMEDINA (tid, appointmentid)
values (81239, 33315);
insert into TPREFORMEDINA (tid, appointmentid)
values (81239, 78212);
insert into TPREFORMEDINA (tid, appointmentid)
values (81263, 18422);
insert into TPREFORMEDINA (tid, appointmentid)
values (81263, 64388);
insert into TPREFORMEDINA (tid, appointmentid)
values (81291, 17642);
insert into TPREFORMEDINA (tid, appointmentid)
values (81329, 83531);
insert into TPREFORMEDINA (tid, appointmentid)
values (81329, 83564);
insert into TPREFORMEDINA (tid, appointmentid)
values (81339, 31448);
insert into TPREFORMEDINA (tid, appointmentid)
values (81366, 97122);
insert into TPREFORMEDINA (tid, appointmentid)
values (81758, 92754);
insert into TPREFORMEDINA (tid, appointmentid)
values (82157, 19338);
insert into TPREFORMEDINA (tid, appointmentid)
values (82369, 73199);
insert into TPREFORMEDINA (tid, appointmentid)
values (82416, 30003);
commit;
prompt 300 records committed...
insert into TPREFORMEDINA (tid, appointmentid)
values (83436, 36749);
insert into TPREFORMEDINA (tid, appointmentid)
values (83436, 65632);
insert into TPREFORMEDINA (tid, appointmentid)
values (83652, 31716);
insert into TPREFORMEDINA (tid, appointmentid)
values (83652, 99385);
insert into TPREFORMEDINA (tid, appointmentid)
values (83735, 36944);
insert into TPREFORMEDINA (tid, appointmentid)
values (83735, 44578);
insert into TPREFORMEDINA (tid, appointmentid)
values (83735, 86786);
insert into TPREFORMEDINA (tid, appointmentid)
values (83824, 32565);
insert into TPREFORMEDINA (tid, appointmentid)
values (85577, 14235);
insert into TPREFORMEDINA (tid, appointmentid)
values (85577, 28354);
insert into TPREFORMEDINA (tid, appointmentid)
values (85642, 69782);
insert into TPREFORMEDINA (tid, appointmentid)
values (85923, 59117);
insert into TPREFORMEDINA (tid, appointmentid)
values (85923, 98371);
insert into TPREFORMEDINA (tid, appointmentid)
values (86193, 13121);
insert into TPREFORMEDINA (tid, appointmentid)
values (86193, 39837);
insert into TPREFORMEDINA (tid, appointmentid)
values (86193, 59487);
insert into TPREFORMEDINA (tid, appointmentid)
values (86759, 51688);
insert into TPREFORMEDINA (tid, appointmentid)
values (86775, 30006);
insert into TPREFORMEDINA (tid, appointmentid)
values (86933, 83776);
insert into TPREFORMEDINA (tid, appointmentid)
values (87322, 29532);
insert into TPREFORMEDINA (tid, appointmentid)
values (87568, 34639);
insert into TPREFORMEDINA (tid, appointmentid)
values (87763, 39953);
insert into TPREFORMEDINA (tid, appointmentid)
values (87763, 54965);
insert into TPREFORMEDINA (tid, appointmentid)
values (87763, 86376);
insert into TPREFORMEDINA (tid, appointmentid)
values (87874, 34432);
insert into TPREFORMEDINA (tid, appointmentid)
values (87874, 57853);
insert into TPREFORMEDINA (tid, appointmentid)
values (89584, 37638);
insert into TPREFORMEDINA (tid, appointmentid)
values (89584, 91912);
insert into TPREFORMEDINA (tid, appointmentid)
values (89622, 64847);
insert into TPREFORMEDINA (tid, appointmentid)
values (89623, 37647);
insert into TPREFORMEDINA (tid, appointmentid)
values (89623, 89616);
insert into TPREFORMEDINA (tid, appointmentid)
values (89623, 96149);
insert into TPREFORMEDINA (tid, appointmentid)
values (89835, 36165);
insert into TPREFORMEDINA (tid, appointmentid)
values (89835, 61521);
insert into TPREFORMEDINA (tid, appointmentid)
values (89835, 76411);
insert into TPREFORMEDINA (tid, appointmentid)
values (89842, 83194);
insert into TPREFORMEDINA (tid, appointmentid)
values (89842, 94999);
insert into TPREFORMEDINA (tid, appointmentid)
values (89886, 51562);
insert into TPREFORMEDINA (tid, appointmentid)
values (89886, 66745);
insert into TPREFORMEDINA (tid, appointmentid)
values (91318, 66153);
insert into TPREFORMEDINA (tid, appointmentid)
values (91318, 78657);
insert into TPREFORMEDINA (tid, appointmentid)
values (91341, 64847);
insert into TPREFORMEDINA (tid, appointmentid)
values (91757, 18621);
insert into TPREFORMEDINA (tid, appointmentid)
values (91955, 31299);
insert into TPREFORMEDINA (tid, appointmentid)
values (92627, 32614);
insert into TPREFORMEDINA (tid, appointmentid)
values (92627, 42728);
insert into TPREFORMEDINA (tid, appointmentid)
values (92627, 76595);
insert into TPREFORMEDINA (tid, appointmentid)
values (92639, 92587);
insert into TPREFORMEDINA (tid, appointmentid)
values (92957, 37223);
insert into TPREFORMEDINA (tid, appointmentid)
values (92957, 73638);
insert into TPREFORMEDINA (tid, appointmentid)
values (92978, 91955);
insert into TPREFORMEDINA (tid, appointmentid)
values (92978, 94296);
insert into TPREFORMEDINA (tid, appointmentid)
values (92978, 96657);
insert into TPREFORMEDINA (tid, appointmentid)
values (93262, 44265);
insert into TPREFORMEDINA (tid, appointmentid)
values (93545, 30002);
insert into TPREFORMEDINA (tid, appointmentid)
values (93545, 31299);
insert into TPREFORMEDINA (tid, appointmentid)
values (93974, 28354);
insert into TPREFORMEDINA (tid, appointmentid)
values (94324, 56328);
insert into TPREFORMEDINA (tid, appointmentid)
values (94324, 92499);
insert into TPREFORMEDINA (tid, appointmentid)
values (94371, 42978);
insert into TPREFORMEDINA (tid, appointmentid)
values (94421, 45349);
insert into TPREFORMEDINA (tid, appointmentid)
values (94421, 78169);
insert into TPREFORMEDINA (tid, appointmentid)
values (94471, 48827);
insert into TPREFORMEDINA (tid, appointmentid)
values (94471, 81399);
insert into TPREFORMEDINA (tid, appointmentid)
values (94556, 35487);
insert into TPREFORMEDINA (tid, appointmentid)
values (94556, 65252);
insert into TPREFORMEDINA (tid, appointmentid)
values (94664, 48827);
insert into TPREFORMEDINA (tid, appointmentid)
values (94664, 72115);
insert into TPREFORMEDINA (tid, appointmentid)
values (94996, 35487);
insert into TPREFORMEDINA (tid, appointmentid)
values (95197, 55324);
insert into TPREFORMEDINA (tid, appointmentid)
values (95197, 96657);
insert into TPREFORMEDINA (tid, appointmentid)
values (95395, 55657);
insert into TPREFORMEDINA (tid, appointmentid)
values (95395, 83776);
insert into TPREFORMEDINA (tid, appointmentid)
values (95589, 23487);
insert into TPREFORMEDINA (tid, appointmentid)
values (95589, 32922);
insert into TPREFORMEDINA (tid, appointmentid)
values (95589, 54399);
insert into TPREFORMEDINA (tid, appointmentid)
values (95589, 68537);
insert into TPREFORMEDINA (tid, appointmentid)
values (95638, 46594);
insert into TPREFORMEDINA (tid, appointmentid)
values (95638, 49621);
insert into TPREFORMEDINA (tid, appointmentid)
values (95638, 67992);
insert into TPREFORMEDINA (tid, appointmentid)
values (95993, 69782);
insert into TPREFORMEDINA (tid, appointmentid)
values (96533, 54965);
insert into TPREFORMEDINA (tid, appointmentid)
values (96629, 78169);
insert into TPREFORMEDINA (tid, appointmentid)
values (96629, 99822);
insert into TPREFORMEDINA (tid, appointmentid)
values (97162, 28734);
insert into TPREFORMEDINA (tid, appointmentid)
values (97845, 51688);
insert into TPREFORMEDINA (tid, appointmentid)
values (97898, 31496);
commit;
prompt 387 records loaded
prompt Enabling foreign key constraints for DOCTOR...
alter table DOCTOR enable constraint SYS_C007716;
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
prompt Enabling foreign key constraints for MUSEDINT...
alter table MUSEDINT enable constraint SYS_C007750;
alter table MUSEDINT enable constraint SYS_C007751;
prompt Enabling foreign key constraints for OFFICE...
alter table OFFICE enable constraint SYS_C007755;
prompt Enabling foreign key constraints for TEETH_APPOINTMENT...
alter table TEETH_APPOINTMENT enable constraint FK_APPOINTMENT_CHILD_ID;
alter table TEETH_APPOINTMENT enable constraint SYS_C007733;
prompt Enabling foreign key constraints for OMAKEA...
alter table OMAKEA enable constraint SYS_C007759;
alter table OMAKEA enable constraint SYS_C007760;
prompt Enabling foreign key constraints for PAYMENT...
alter table PAYMENT enable constraint SYS_C007766;
prompt Enabling foreign key constraints for TPREFORMEDINA...
alter table TPREFORMEDINA enable constraint SYS_C007770;
alter table TPREFORMEDINA enable constraint SYS_C007771;
prompt Enabling triggers for CHILD...
alter table CHILD enable all triggers;
prompt Enabling triggers for STAFF...
alter table STAFF enable all triggers;
prompt Enabling triggers for DOCTOR...
alter table DOCTOR enable all triggers;
prompt Enabling triggers for GUARDIAN...
alter table GUARDIAN enable all triggers;
prompt Enabling triggers for GUARDIAN_OF...
alter table GUARDIAN_OF enable all triggers;
prompt Enabling triggers for INJECTION_APPOINTMENT...
alter table INJECTION_APPOINTMENT enable all triggers;
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
prompt Enabling triggers for MATERIAL...
alter table MATERIAL enable all triggers;
prompt Enabling triggers for TREATMENT...
alter table TREATMENT enable all triggers;
prompt Enabling triggers for MUSEDINT...
alter table MUSEDINT enable all triggers;
prompt Enabling triggers for OFFICE...
alter table OFFICE enable all triggers;
prompt Enabling triggers for TEETH_APPOINTMENT...
alter table TEETH_APPOINTMENT enable all triggers;
prompt Enabling triggers for OMAKEA...
alter table OMAKEA enable all triggers;
prompt Enabling triggers for PAYMENT...
alter table PAYMENT enable all triggers;
prompt Enabling triggers for TPREFORMEDINA...
alter table TPREFORMEDINA enable all triggers;
set feedback on
set define on
prompt Done.
