CREATE OR REPLACE FUNCTION get_child_vaccinations(its_child_id NUMBER)
RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT i.name, i.disease, a.app_date
    FROM injection i
    JOIN in_stock ins ON i.injection_id = ins.injection_id
    JOIN injected inj ON ins.stock_id = inj.stock_id
    JOIN appointment a ON inj.appointment_id = a.appointment_id
    JOIN injected_to it ON a.appointment_id = it.appointment_id
    WHERE a.app_date < sysdate AND  it.child_id = its_child_id;
    RETURN v_cursor;
END;
