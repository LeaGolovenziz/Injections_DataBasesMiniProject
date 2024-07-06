
BEGIN
    DECLARE
        v_child_age NUMBER;
        v_child_id NUMBER := &v_child_id;
        v_nurse_id NUMBER := &v_nurse_id;
        v_injection_id NUMBER := &v_injection_id;
        v_app_id NUMBER;
        v_app_date DATE := TO_DATE(&date, 'DD-MM-YYYY');
        v_hour VARCHAR2(10) := '&v_hour';
        v_room NUMBER := &v_room;
    BEGIN
        -- Calculate the child age
        v_child_age := calculate_child_age(v_child_id);
        DBMS_OUTPUT.PUT_LINE('Child age: ' || v_child_age);

        -- Adding an appointment only if the child is younger than 18
        IF v_child_age < 18 THEN
            -- Generate a new appointment ID
            SELECT NVL(MAX(appointment_id), 0) + 1 INTO v_app_id FROM appointment;
            
            -- Add the appointment
            add_appointment(v_app_id, v_app_date, v_hour, v_room, v_child_id, v_nurse_id, v_injection_id);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Child is too old for vaccination.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
END;