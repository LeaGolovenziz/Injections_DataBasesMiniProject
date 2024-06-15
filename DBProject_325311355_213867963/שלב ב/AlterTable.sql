
UPDATE appointment
SET room = ROUND(room);

UPDATE appointment
SET app_date = ADD_MONTHS(app_date, 4);

--non parameters 
-- select 

--all children with their guardian
SELECT c.name AS child_name, c.child_id, c.birth_date AS child_birth_date, g.name AS guardian_name, g.guardian_id AS guardian_id
FROM child c
JOIN guardian_of o ON c.child_id = o.child_id
JOIN guardian g ON o.guardian_id = g.guardian_id
ORDER BY c.name;

--all nurses that have appointments today
SELECT n.name AS nurse_name, n.nurse_id, a.app_date, a.hour, a.room
FROM nurse n
JOIN injected_by ib ON n.nurse_id = ib.nurse_id
JOIN appointment a ON ib.appointment_id = a.appointment_id
WHERE a.app_date = TRUNC(SYSDATE)
ORDER BY a.hour;


SELECT n.name AS nurse_name, 
       n.nurse_id, 
       COUNT(*) AS appointment_count
FROM nurse n
JOIN injected_by ib ON n.nurse_id = ib.nurse_id
JOIN appointment a ON ib.appointment_id = a.appointment_id
WHERE a.app_date = TRUNC(SYSDATE)
GROUP BY n.nurse_id, n.name;

--all appointments of all children
SELECT 
    c.name AS child_name, 
    c.child_id,
    EXTRACT(DAY FROM a.app_date) AS app_day,
    EXTRACT(MONTH FROM a.app_date) AS app_month,
    EXTRACT(YEAR FROM a.app_date) AS app_year,
    a.hour, 
    a.room
FROM 
    child c
JOIN 
    injected_to it ON c.child_id = it.child_id
JOIN 
    appointment a ON it.appointment_id = a.appointment_id
ORDER BY 
    c.name, a.app_date, a.hour;


SELECT i.name AS injection_name, i.injection_id, s.shelf_id, s.amount
FROM injection i
JOIN in_stock ist ON i.injection_id = ist.injection_id
JOIN stock s ON ist.stock_id = s.stock_id
ORDER BY s.amount DESC;

--delete

DELETE FROM guardian
WHERE guardian_id NOT IN (
    SELECT guardian_id FROM guardian_of
);

DELETE FROM nurse
WHERE nurse_id NOT IN (
    SELECT nurse_id FROM injected_by
);

--update
UPDATE stock
SET amount = amount - 1
WHERE stock_id IN (
    SELECT s.stock_id
    FROM stock s
    JOIN injected i  ON s.stock_id = i.stock_id
    JOIN appointment a ON i.appointment_id = a.appointment_id
    WHERE TRUNC(a.app_date) = TRUNC(SYSDATE)
);

UPDATE appointment
SET app_date = ADD_MONTHS(app_date, 1)
WHERE appointment_id IN (
    SELECT i.appointment_id
    FROM injected i
    JOIN stock s ON i.stock_id = s.stock_id
    JOIN appointment a ON i.appointment_id = a.appointment_id
    WHERE s.amount = 0
);

--parameters 
SELECT child_name, child_id FROM child;

SELECT a.appointment_id, a.app_date, a.hour, a.room
FROM appointment a
JOIN injected_to it ON a.appointment_id = it.appointment_id
JOIN child c ON it.child_id = c.child_id
WHERE c.child_id = &<name="id" type="INTEGER"  list="select child_id from child" restricted="yes">;


SELECT n.name AS nurse_name, a.app_date, a.hour, a.room
FROM nurse n
JOIN injected_by ib ON n.nurse_id = ib.nurse_id
JOIN appointment a ON ib.appointment_id = a.appointment_id
WHERE a.app_date = TO_DATE(&app_date, 'DD/MM/YYYY')
ORDER BY a.hour;

SELECT c.name AS child_name, c.birth_date, g.name AS guardian_name
FROM child c
JOIN guardian_of go ON c.child_id = go.child_id
JOIN guardian g ON go.guardian_id = g.guardian_id
WHERE EXTRACT(YEAR FROM c.birth_date) = &year
ORDER BY c.birth_date;

SELECT amount
FROM stock
WHERE stock_id = (
    SELECT stock_id
    FROM in_stock
    WHERE injection_id = &<name="injection_id" type="INTEGER"  list="select injection_id from injection" restricted="yes">
);

--constrain
ALTER TABLE appointment
MODIFY room DEFAULT 100;

ALTER TABLE stock
ADD CONSTRAINT chk_stock_amount CHECK (amount >= 0);

ALTER TABLE injection
ADD CONSTRAINT chk_dosage_positive CHECK (dosage > 0);






