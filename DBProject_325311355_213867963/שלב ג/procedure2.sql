CREATE OR REPLACE PROCEDURE show_vaccination_schedule(its_child_id NUMBER) IS
    its_child_age NUMBER;
    v_vaccinations SYS_REFCURSOR;
    v_name injection.name%TYPE;
    v_disease injection.disease%TYPE;
    v_app_date appointment.app_date%TYPE;
    
    CURSOR c_vaccinations IS
        SELECT name, disease, age_injection
       FROM injection
       ORDER BY age_injection;
        
    v_inj_rec c_vaccinations%ROWTYPE;
BEGIN
    its_child_age:= calculate_child_age(its_child_id);

    v_vaccinations := get_child_vaccinations(its_child_id);
    
    DBMS_OUTPUT.PUT_LINE('injection that the child recived:');
    LOOP
        FETCH v_vaccinations INTO v_name, v_disease, v_app_date;
        EXIT WHEN v_vaccinations%NOTFOUND;
        DBMS_OUTPUT.PUT('injection_name: ' || v_name);
        DBMS_OUTPUT.PUT_LINE(', disease: ' || v_disease || ', date: ' || v_app_date);
    END LOOP;
    CLOSE v_vaccinations;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('injections the child need to get:');
    OPEN c_vaccinations;
    LOOP
        FETCH c_vaccinations INTO v_inj_rec;
        EXIT WHEN c_vaccinations%NOTFOUND;
        IF v_inj_rec.age_injection >= its_child_age THEN
            DBMS_OUTPUT.PUT_LINE('injection name: ' || v_inj_rec.name || ', disease: ' || v_inj_rec.disease || ', age required: ' || v_inj_rec.age_injection);
        END IF;
    END LOOP;
    CLOSE c_vaccinations;
END;
