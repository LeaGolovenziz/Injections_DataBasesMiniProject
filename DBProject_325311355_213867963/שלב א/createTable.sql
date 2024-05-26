CREATE TABLE injection
(
    injection_id NUMBER PRIMARY KEY,
    name VARCHAR2(3) NOT NULL,
    disease VARCHAR2(3) NOT NULL,
    dosage NUMBER NOT NULL
);

CREATE TABLE stock
(
    stock_id NUMBER PRIMARY KEY,
    shelf_id NUMBER NOT NULL,
    amount NUMBER NOT NULL
);

CREATE TABLE guardian
(
    guardian_id NUMBER PRIMARY KEY,
    name VARCHAR2(3) NOT NULL,
    birth_date DATE
);

CREATE TABLE child
(
    child_id NUMBER PRIMARY KEY,
    name VARCHAR2(3) NOT NULL,
    birth_date DATE
);

CREATE TABLE nurse
(
    nurse_id NUMBER PRIMARY KEY,
    name VARCHAR2(3) NOT NULL,
    birth_date DATE
);

CREATE TABLE appointment
(
    appointment_id NUMBER PRIMARY KEY,
    app_date DATE,
    hour VARCHAR2(10) NOT NULL,
    room NUMBER NOT NULL
);

CREATE TABLE in_stock
(
    injection_id NUMBER PRIMARY KEY,
    stock_id NUMBER NOT NULL,
    FOREIGN KEY (injection_id) REFERENCES injection (injection_id),
    FOREIGN KEY (stock_id) REFERENCES stock (stock_id)
);

CREATE TABLE injected_by
(
    appointment_id NUMBER PRIMARY KEY,
    nurse_id NUMBER NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES appointment (appointment_id),
    FOREIGN KEY (nurse_id) REFERENCES nurse (nurse_id)
);

CREATE TABLE injected_to
(
    appointment_id NUMBER PRIMARY KEY,
    child_id NUMBER NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES appointment (appointment_id),
    FOREIGN KEY (child_id) REFERENCES child (child_id)
);

CREATE TABLE guardian_of
(
    child_id NUMBER PRIMARY KEY,
    guardian_id NUMBER NOT NULL,
    FOREIGN KEY (child_id) REFERENCES child (child_id),
    FOREIGN KEY (guardian_id) REFERENCES guardian (guardian_id)
);
