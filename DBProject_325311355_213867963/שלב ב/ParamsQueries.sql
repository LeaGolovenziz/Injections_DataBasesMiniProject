--parameters 
SELECT a.appointment_id, a.app_date, a.hour, a.room
FROM appointment a
JOIN injected_to it ON a.appointment_id = it.appointment_id
JOIN child c ON it.child_id = c.child_id
WHERE c.child_id = &<name="id" type="INTEGER"  list="select child_id from child" restricted="yes">;


SELECT n.name AS nurse_name, a.app_date, a.hour, a.room
FROM nurse n
JOIN injected_by ib ON n.nurse_id = ib.nurse_id
JOIN appointment a ON ib.appointment_id = a.appointment_id
WHERE a.app_date = TO_DATE(&<name="date" default="'27/11/2023'" required=true>, 'DD/MM/YYYY')
ORDER BY a.hour;

SELECT c.name AS child_name, c.birth_date, g.name AS guardian_name
FROM child c
JOIN guardian_of go ON c.child_id = go.child_id
JOIN guardian g ON go.guardian_id = g.guardian_id
WHERE EXTRACT(YEAR FROM c.birth_date) = &<name="year" default="2023" required=true>
ORDER BY c.birth_date;

SELECT amount
FROM stock
WHERE stock_id = (
    SELECT stock_id
    FROM in_stock
    WHERE injection_id = &<name="injection_id" type="INTEGER"  list="select injection_id from injection" restricted="yes">
);



