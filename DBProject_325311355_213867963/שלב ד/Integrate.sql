rename appointment to injection_appointment

rename appointment to teeth_appointment


select count(*) from child;
select count(*) from patient;

ALTER TABLE child
MODIFY (name VARCHAR2(30));

insert into child c select p.cid, p.cname, null from patient p
where p.cid not in (select child_id from child);

DECLARE
    v_start_date DATE := TO_DATE('01-01-2017', 'DD-MM-YYYY');
    v_end_date DATE := TO_DATE('31-12-2023', 'DD-MM-YYYY');
BEGIN
    UPDATE child
    SET birth_date = TRUNC(
                        v_start_date + DBMS_RANDOM.VALUE(0, v_end_date - v_start_date)
                    )
    WHERE birth_date IS NULL;
    COMMIT;
END;

ALTER TABLE child
MODIFY (birth_date NOT NULL);

select * from child;

ALTER TABLE teeth_appointment
ADD (CHILD_ID NUMBER(5));

UPDATE teeth_appointment
SET CHILD_ID = CID;

SELECT CID, CHILD_ID
FROM teeth_appointment;

ALTER TABLE teeth_appointment
ADD CONSTRAINT FK_APPOINTMENT_CHILD_ID FOREIGN KEY (CHILD_ID)
REFERENCES CHILD (CHILD_ID);


ALTER TABLE teeth_appointment
DROP COLUMN cid;

select * from teeth_appointment;

DROP TABLE Patient;
