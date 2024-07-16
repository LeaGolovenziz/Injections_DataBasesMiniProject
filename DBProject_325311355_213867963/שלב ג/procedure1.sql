CREATE OR REPLACE PROCEDURE add_appointment(
    p_app_id NUMBER,
    p_app_date DATE, 
    p_hour VARCHAR2, 
    p_room NUMBER, 
    p_child_id NUMBER,
    p_nurse_id NUMBER,
    p_injection_id NUMBER
) IS
    v_count NUMBER;
    v_amount NUMBER;
    message VARCHAR2(100);
    Room_already_booked EXCEPTION;
    PRAGMA EXCEPTION_INIT(Room_already_booked, -20000);
    Appointment_id_already_exists EXCEPTION;
    PRAGMA EXCEPTION_INIT(Appointment_id_already_exists, -20001);
    Nurse_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(Nurse_not_found, -20002);
    Nurse_already_busy EXCEPTION;
    PRAGMA EXCEPTION_INIT(Nurse_already_busy, -20003);
    Injection_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(Injection_not_found, -20004);
    Injection_out_of_stock EXCEPTION;
    PRAGMA EXCEPTION_INIT(Injection_out_of_stock, -20005);
BEGIN
    -- Check if appointment_id already exists
    SELECT COUNT(*)
    INTO v_count
    FROM appointment
    WHERE appointment_id = p_app_id;
    
    IF v_count != 0 THEN
        message := 'Appointment id ' || p_app_id || ' already exists.';
        RAISE Appointment_id_already_exists;
    END IF;
    
    -- Check if the room is already booked for the given date and hour
    SELECT COUNT(*)
    INTO v_count
    FROM appointment
    WHERE app_date = p_app_date AND hour = p_hour AND room = p_room;

    IF v_count != 0 THEN
       message := 'Room ' || p_room || ' is already booked.';
       RAISE Room_already_booked;
    END IF;

    -- Check if nurse exists
    SELECT COUNT(*)
    INTO v_count
    FROM nurse
    WHERE nurse_id = p_nurse_id;

    IF v_count = 0 THEN
        message := 'Nurse id ' || p_nurse_id || ' not found.';
        RAISE Nurse_not_found;
    END IF;

    -- Check if nurse is already busy at the given date and hour
    SELECT COUNT(*)
    INTO v_count
    FROM injected_by ib
    JOIN appointment a ON ib.appointment_id = a.appointment_id
    WHERE a.app_date = p_app_date AND a.hour = p_hour AND ib.nurse_id = p_nurse_id;

    IF v_count != 0 THEN
        message := 'Nurse id ' || p_nurse_id || ' is already busy at this time.';
        RAISE Nurse_already_busy;
    END IF;

    -- Check if injection_id exists and is in stock
    SELECT COUNT(*)
    INTO v_count
    FROM in_stock
    WHERE injection_id = p_injection_id;

    IF v_count = 0 THEN
        message := 'Injection id ' || p_injection_id || ' not found.';
        RAISE Injection_not_found;
    END IF;

    SELECT s.amount
    INTO v_amount
    FROM stock s
    JOIN in_stock c ON s.stock_id = c.stock_id
    WHERE c.injection_id = p_injection_id;

    IF v_amount <= 0 THEN
        message := 'Injection id ' || p_injection_id || ' is out of stock.';
        RAISE Injection_out_of_stock;
    END IF;
     
    -- Insert into appointment table
    INSERT INTO appointment (appointment_id, app_date, hour, room)
    VALUES (p_app_id, p_app_date, p_hour, p_room);
    
    -- Insert into injected_to table
    INSERT INTO injected_to (appointment_id, child_id)
    VALUES (p_app_id, p_child_id);

    -- Insert into injected_by table
    INSERT INTO injected_by (appointment_id, nurse_id)
    VALUES (p_app_id, p_nurse_id);

    -- Insert into injected table
    INSERT INTO injected (appointment_id, stock_id)
    VALUES (p_app_id, (SELECT stock_id FROM in_stock WHERE injection_id = p_injection_id));
    
    -- Update stock amount
    UPDATE stock
    SET amount = amount - 1
    WHERE stock_id = (SELECT stock_id FROM in_stock WHERE injection_id = p_injection_id);
        
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Appointment added.');      

EXCEPTION
    WHEN Room_already_booked THEN
        RAISE_APPLICATION_ERROR(-20000, message);
    WHEN Appointment_id_already_exists THEN
        RAISE_APPLICATION_ERROR(-20001, message);
    WHEN Nurse_not_found THEN
        RAISE_APPLICATION_ERROR(-20002, message);
    WHEN Nurse_already_busy THEN
        RAISE_APPLICATION_ERROR(-20003, message);
    WHEN Injection_not_found THEN
        RAISE_APPLICATION_ERROR(-20004, message);
    WHEN Injection_out_of_stock THEN
        RAISE_APPLICATION_ERROR(-20005, message);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END add_appointment;
