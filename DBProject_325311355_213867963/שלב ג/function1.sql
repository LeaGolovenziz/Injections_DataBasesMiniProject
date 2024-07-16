CREATE OR REPLACE FUNCTION calculate_child_age(p_child_id NUMBER) RETURN NUMBER IS
    v_birth_date DATE;
    v_age NUMBER;
    CURSOR c_child IS
        SELECT birth_date
        FROM child
        WHERE child_id = p_child_id;
BEGIN
    OPEN c_child;
    FETCH c_child INTO v_birth_date;
    CLOSE c_child;

    IF v_birth_date IS NULL THEN
        RETURN NULL;
    ELSE
        v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, v_birth_date) / 12);
        RETURN v_age;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN NULL;
END calculate_child_age;