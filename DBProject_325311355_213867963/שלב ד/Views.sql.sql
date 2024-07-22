CREATE OR REPLACE VIEW TEETH_APPOINTMENT_DETAILS AS
SELECT
    a.appointmentid,
    a.adate AS appointment_date, 
    c.name AS child_name,
    c.child_id,
    s.sname AS doctor_name,
    s.sid AS doctor_id,
    d.specialties AS doctor_specialties,
    t.ttype AS treatment_type,
    t.description AS treatment_description
FROM
    TEETH_APPOINTMENT a
JOIN CHILD C ON a.child_id = c.child_id
JOIN DOCTOR d ON a.sid = d.sid
JOIN STAFF s ON d.sid = s.sid
JOIN TPREFORMEDINA tp ON a.appointmentid = tp.appointmentid
JOIN TREATMENT t ON tp.tid = t.tid
;

--Get the number of appointments per doctor, grouped by their specialties
SELECT 
    s.sname AS doctor_name,
    d.specialties AS doctor_specialties,
    COUNT(a.appointmentid) AS total_appointments
FROM 
    TEETH_APPOINTMENT_DETAILS a
JOIN 
    DOCTOR d ON a.doctor_id = d.sid
JOIN 
    STAFF s ON d.sid = s.sid
GROUP BY 
    s.sname, d.specialties
ORDER BY 
    total_appointments DESC;


--Get the details of appointments for a specific child along with the total number of appointments they have had
SELECT 
    a.appointmentid,
    a.appointment_date,
    a.child_name,
    a.doctor_name,
    a.doctor_specialties,
    a.treatment_type,
    a.treatment_description,
    (SELECT COUNT(*) 
     FROM TEETH_APPOINTMENT_DETAILS 
     WHERE child_id = a.child_id) AS total_appointments
FROM 
    TEETH_APPOINTMENT_DETAILS a
WHERE 
    a.child_id = &childId;



--Get the appointment details for children who have received a specific injection more than once
 SELECT 
    a.appointment_id,
    a.app_date,
    a.hour,
    a.room,
    n.name AS nurse_name,
    c.name AS child_name,
    g.name AS guardian_name,
    i.name AS injection_name,
    i.dosage,
    s.amount AS stock_amount
FROM 
    INJECTION_APPOINTMENTS_DETAILS a
JOIN injected_to it ON a.appointment_id = it.appointment_id
JOIN child c ON it.child_id = c.child_id
JOIN guardian_of go ON c.child_id = go.child_id
JOIN guardian g ON go.guardian_id = g.guardian_id
JOIN injected_by ib ON a.appointment_id = ib.appointment_id
JOIN nurse n ON ib.nurse_id = n.nurse_id
JOIN in_stock ins ON a.injection_id = ins.injection_id
JOIN injection i ON ins.injection_id = i.injection_id
JOIN stock s ON ins.stock_id = s.stock_id
WHERE 
    c.child_id IN (
        SELECT 
            it.child_id
        FROM 
            injected_to it
        JOIN injected ing ON it.appointment_id = ing.appointment_id
        JOIN in_stock ins ON ing.stock_id = ins.stock_id
        JOIN  stock st ON ing.stock_id = st.stock_id
        WHERE 
            i.injection_id = &injId
        GROUP BY 
            it.child_id
        HAVING 
            COUNT(*) > 1
    )
ORDER BY 
    a.app_date DESC;


--Get the details of all appointments in a specific room, including the total number of appointments held in that room
SELECT 
    a.appointment_id,
    a.app_date,
    a.hour,
    a.room,
    n.name AS nurse_name,
    c.name AS child_name,
    g.name AS guardian_name,
    i.name AS injection_name,
    i.dosage,
    s.amount AS stock_amount,
    (SELECT COUNT(*) 
     FROM INJECTION_APPOINTMENTS_DETAILS 
     WHERE room = a.room) AS total_appointments_in_room
FROM 
    INJECTION_APPOINTMENTS_DETAILS a
JOIN injected_by ib ON a.appointment_id = ib.appointment_id
JOIN nurse n ON ib.nurse_id = n.nurse_id
JOIN injected_to it ON a.appointment_id = it.appointment_id
JOIN child c ON it.child_id = c.child_id
JOIN guardian_of go ON c.child_id = go.child_id
JOIN guardian g ON go.guardian_id = g.guardian_id
JOIN injected inj ON a.appointment_id = inj.appointment_id
JOIN stock s ON inj.stock_id = s.stock_id
JOIN in_stock ins ON s.stock_id = ins.stock_id
JOIN injection i ON ins.injection_id = i.injection_id
WHERE 
    a.room = &roomNumber
ORDER BY 
    a.app_date DESC;