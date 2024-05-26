-- Inserting data into injection table
INSERT INTO injection (injection_id, name, disease, dosage) VALUES (301, 'Flu', 'Inf', 5);
INSERT INTO injection (injection_id, name, disease, dosage) VALUES (302, 'Hep', 'Hep', 1);
INSERT INTO injection (injection_id, name, disease, dosage) VALUES (303, 'Tet', 'Tet', 0.5);
INSERT INTO injection (injection_id, name, disease, dosage) VALUES (304, 'MMR', 'Mea', 0.5);
INSERT INTO injection (injection_id, name, disease, dosage) VALUES (305, 'Pol', 'Pol', 0.5);
INSERT INTO injection (injection_id, name, disease, dosage) VALUES (306, 'Chi', 'Var', 1);
INSERT INTO injection (injection_id, name, disease, dosage) VALUES (307, 'HPV', 'Hum', 0.5);
INSERT INTO injection (injection_id, name, disease, dosage) VALUES (308, 'Cov', 'Cor', 0.3);
INSERT INTO injection (injection_id, name, disease, dosage) VALUES (309, 'Rab', 'Rab', 1);
INSERT INTO injection (injection_id, name, disease, dosage) VALUES (310, 'Yel', 'Yel', 0.5);

-- Inserting data into stock table
INSERT INTO stock (stock_id, shelf_id, amount) VALUES (401, 1, 100);
INSERT INTO stock (stock_id, shelf_id, amount) VALUES (402, 1, 200);
INSERT INTO stock (stock_id, shelf_id, amount) VALUES (403, 2, 150);
INSERT INTO stock (stock_id, shelf_id, amount) VALUES (404, 2, 250);
INSERT INTO stock (stock_id, shelf_id, amount) VALUES (405, 3, 300);
INSERT INTO stock (stock_id, shelf_id, amount) VALUES (406, 3, 350);
INSERT INTO stock (stock_id, shelf_id, amount) VALUES (407, 4, 400);
INSERT INTO stock (stock_id, shelf_id, amount) VALUES (408, 4, 450);
INSERT INTO stock (stock_id, shelf_id, amount) VALUES (409, 5, 500);
INSERT INTO stock (stock_id, shelf_id, amount) VALUES (410, 5, 550);

-- Inserting data into guardian table
INSERT INTO guardian (guardian_id, name, birth_date) VALUES (501, 'Joh', TO_DATE('1980-01-01', 'YYYY-MM-DD'));
INSERT INTO guardian (guardian_id, name, birth_date) VALUES (502, 'Jan', TO_DATE('1982-02-02', 'YYYY-MM-DD'));
INSERT INTO guardian (guardian_id, name, birth_date) VALUES (503, 'Mar', TO_DATE('1984-03-03', 'YYYY-MM-DD'));
INSERT INTO guardian (guardian_id, name, birth_date) VALUES (504, 'Jam', TO_DATE('1986-04-04', 'YYYY-MM-DD'));
INSERT INTO guardian (guardian_id, name, birth_date) VALUES (505, 'Pat', TO_DATE('1988-05-05', 'YYYY-MM-DD'));
INSERT INTO guardian (guardian_id, name, birth_date) VALUES (506, 'Rob', TO_DATE('1990-06-06', 'YYYY-MM-DD'));
INSERT INTO guardian (guardian_id, name, birth_date) VALUES (507, 'Lin', TO_DATE('1992-07-07', 'YYYY-MM-DD'));
INSERT INTO guardian (guardian_id, name, birth_date) VALUES (508, 'Mic', TO_DATE('1994-08-08', 'YYYY-MM-DD'));
INSERT INTO guardian (guardian_id, name, birth_date) VALUES (509, 'Bar', TO_DATE('1996-09-09', 'YYYY-MM-DD'));
INSERT INTO guardian (guardian_id, name, birth_date) VALUES (510, 'Wil', TO_DATE('1998-10-10', 'YYYY-MM-DD'));

-- Inserting data into child table
INSERT INTO child (child_id, name, birth_date) VALUES (601, 'Ali', TO_DATE('2010-01-01', 'YYYY-MM-DD'));
INSERT INTO child (child_id, name, birth_date) VALUES (602, 'Bob', TO_DATE('2011-02-02', 'YYYY-MM-DD'));
INSERT INTO child (child_id, name, birth_date) VALUES (603, 'Cha', TO_DATE('2012-03-03', 'YYYY-MM-DD'));
INSERT INTO child (child_id, name, birth_date) VALUES (604, 'Dav', TO_DATE('2013-04-04', 'YYYY-MM-DD'));
INSERT INTO child (child_id, name, birth_date) VALUES (605, 'Eve', TO_DATE('2014-05-05', 'YYYY-MM-DD'));
INSERT INTO child (child_id, name, birth_date) VALUES (606, 'Fra', TO_DATE('2015-06-06', 'YYYY-MM-DD'));
INSERT INTO child (child_id, name, birth_date) VALUES (607, 'Gra', TO_DATE('2016-07-07', 'YYYY-MM-DD'));
INSERT INTO child (child_id, name, birth_date) VALUES (608, 'Han', TO_DATE('2017-08-08', 'YYYY-MM-DD'));
INSERT INTO child (child_id, name, birth_date) VALUES (609, 'Isa', TO_DATE('2018-09-09', 'YYYY-MM-DD'));
INSERT INTO child (child_id, name, birth_date) VALUES (610, 'Jac', TO_DATE('2019-10-10', 'YYYY-MM-DD'));

-- Inserting data into nurse table
INSERT INTO nurse (nurse_id, name, birth_date) VALUES (701, 'Nur', TO_DATE('1970-01-01', 'YYYY-MM-DD'));
INSERT INTO nurse (nurse_id, name, birth_date) VALUES (702, 'Gra', TO_DATE('1972-02-02', 'YYYY-MM-DD'));
INSERT INTO nurse (nurse_id, name, birth_date) VALUES (703, 'Fai', TO_DATE('1974-03-03', 'YYYY-MM-DD'));
INSERT INTO nurse (nurse_id, name, birth_date) VALUES (704, 'Hop', TO_DATE('1976-04-04', 'YYYY-MM-DD'));
INSERT INTO nurse (nurse_id, name, birth_date) VALUES (705, 'Pat', TO_DATE('1978-05-05', 'YYYY-MM-DD'));
INSERT INTO nurse (nurse_id, name, birth_date) VALUES (706, 'Cha', TO_DATE('1980-06-06', 'YYYY-MM-DD'));
INSERT INTO nurse (nurse_id, name, birth_date) VALUES (707, 'Pru', TO_DATE('1982-07-07', 'YYYY-MM-DD'));
INSERT INTO nurse (nurse_id, name, birth_date) VALUES (708, 'Mer', TO_DATE('1984-08-08', 'YYYY-MM-DD'));
INSERT INTO nurse (nurse_id, name, birth_date) VALUES (709, 'Tem', TO_DATE('1986-09-09', 'YYYY-MM-DD'));
INSERT INTO nurse (nurse_id, name, birth_date) VALUES (710, 'Cha', TO_DATE('1988-10-10', 'YYYY-MM-DD'));

-- Inserting data into appointment table
INSERT INTO appointment (appointment_id, app_date, hour, room) VALUES (801, TO_DATE('2024-06-01', 'YYYY-MM-DD'), '09:00', 101);
INSERT INTO appointment (appointment_id, app_date, hour, room) VALUES (802, TO_DATE('2024-06-02', 'YYYY-MM-DD'), '10:00', 102);
INSERT INTO appointment (appointment_id, app_date, hour, room) VALUES (803, TO_DATE('2024-06-03', 'YYYY-MM-DD'), '11:00', 103);
INSERT INTO appointment (appointment_id, app_date, hour, room) VALUES (804, TO_DATE('2024-06-04', 'YYYY-MM-DD'), '12:00', 104);
INSERT INTO appointment (appointment_id, app_date, hour, room) VALUES (805, TO_DATE('2024-06-05', 'YYYY-MM-DD'), '13:00', 105);
INSERT INTO appointment (appointment_id, app_date, hour, room) VALUES (806, TO_DATE('2024-06-06', 'YYYY-MM-DD'), '14:00', 106);
INSERT INTO appointment (appointment_id, app_date, hour, room) VALUES (807, TO_DATE('2024-06-07', 'YYYY-MM-DD'), '15:00', 107);
INSERT INTO appointment (appointment_id, app_date, hour, room) VALUES (808, TO_DATE('2024-06-08', 'YYYY-MM-DD'), '16:00', 108);
INSERT INTO appointment (appointment_id, app_date, hour, room) VALUES (809, TO_DATE('2024-06-09', 'YYYY-MM-DD'), '17:00', 109);
INSERT INTO appointment (appointment_id, app_date, hour, room) VALUES (810, TO_DATE('2024-06-10', 'YYYY-MM-DD'), '18:00', 110);

-- Inserting data into in_stock table
INSERT INTO in_stock (in_stock_id, injection_id, stock_id) VALUES (901, 301, 401);
INSERT INTO in_stock (in_stock_id, injection_id, stock_id) VALUES (902, 302, 402);
INSERT INTO in_stock (in_stock_id, injection_id, stock_id) VALUES (903, 303, 403);
INSERT INTO in_stock (in_stock_id, injection_id, stock_id) VALUES (904, 304, 404);
INSERT INTO in_stock (in_stock_id, injection_id, stock_id) VALUES (905, 305, 405);
INSERT INTO in_stock (in_stock_id, injection_id, stock_id) VALUES (906, 306, 406);
INSERT INTO in_stock (in_stock_id, injection_id, stock_id) VALUES (907, 307, 407);
INSERT INTO in_stock (in_stock_id, injection_id, stock_id) VALUES (908, 308, 408);
INSERT INTO in_stock (in_stock_id, injection_id, stock_id) VALUES (909, 309, 409);
INSERT INTO in_stock (in_stock_id, injection_id, stock_id) VALUES (910, 310, 410);

-- Inserting data into injected_by table
INSERT INTO injected_by (injected_by_id, appointment_id, nurse_id) VALUES (1001, 801, 701);
INSERT INTO injected_by (injected_by_id, appointment_id, nurse_id) VALUES (1002, 802, 702);
INSERT INTO injected_by (injected_by_id, appointment_id, nurse_id) VALUES (1003, 803, 703);
INSERT INTO injected_by (injected_by_id, appointment_id, nurse_id) VALUES (1004, 804, 704);
INSERT INTO injected_by (injected_by_id, appointment_id, nurse_id) VALUES (1005, 805, 705);
INSERT INTO injected_by (injected_by_id, appointment_id, nurse_id) VALUES (1006, 806, 706);
INSERT INTO injected_by (injected_by_id, appointment_id, nurse_id) VALUES (1007, 807, 707);
INSERT INTO injected_by (injected_by_id, appointment_id, nurse_id) VALUES (1008, 808, 708);
INSERT INTO injected_by (injected_by_id, appointment_id, nurse_id) VALUES (1009, 809, 709);
INSERT INTO injected_by (injected_by_id, appointment_id, nurse_id) VALUES (1010, 810, 710);

-- Inserting data into injected_to table
INSERT INTO injected_to (injected_to_id, appointment_id, child_id) VALUES (1101, 801, 601);
INSERT INTO injected_to (injected_to_id, appointment_id, child_id) VALUES (1102, 802, 602);
INSERT INTO injected_to (injected_to_id, appointment_id, child_id) VALUES (1103, 803, 603);
INSERT INTO injected_to (injected_to_id, appointment_id, child_id) VALUES (1104, 804, 604);
INSERT INTO injected_to (injected_to_id, appointment_id, child_id) VALUES (1105, 805, 605);
INSERT INTO injected_to (injected_to_id, appointment_id, child_id) VALUES (1106, 806, 606);
INSERT INTO injected_to (injected_to_id, appointment_id, child_id) VALUES (1107, 807, 607);
INSERT INTO injected_to (injected_to_id, appointment_id, child_id) VALUES (1108, 808, 608);
INSERT INTO injected_to (injected_to_id, appointment_id, child_id) VALUES (1109, 809, 609);
INSERT INTO injected_to (injected_to_id, appointment_id, child_id) VALUES (1110, 810, 610);

-- Inserting data into guardian_of table
INSERT INTO guardian_of (guardian_of_id, child_id, guardian_id) VALUES (1201, 601, 501);
INSERT INTO guardian_of (guardian_of_id, child_id, guardian_id) VALUES (1202, 602, 502);
INSERT INTO guardian_of (guardian_of_id, child_id, guardian_id) VALUES (1203, 603, 503);
INSERT INTO guardian_of (guardian_of_id, child_id, guardian_id) VALUES (1204, 604, 504);
INSERT INTO guardian_of (guardian_of_id, child_id, guardian_id) VALUES (1205, 605, 505);
INSERT INTO guardian_of (guardian_of_id, child_id, guardian_id) VALUES (1206, 606, 506);
INSERT INTO guardian_of (guardian_of_id, child_id, guardian_id) VALUES (1207, 607, 507);
INSERT INTO guardian_of (guardian_of_id, child_id, guardian_id) VALUES (1208, 608, 508);
INSERT INTO guardian_of (guardian_of_id, child_id, guardian_id) VALUES (1209, 609, 509);
INSERT INTO guardian_of (guardian_of_id, child_id, guardian_id) VALUES (1210, 610, 510);


