--non parameters 
-- select 

--all children that have guardian with their guardians
SELECT c.name AS child_name, c.child_id, c.birth_date AS child_birth_date, g.name AS guardian_name, g.guardian_id AS guardian_id
FROM child c
JOIN guardian_of o ON c.child_id = o.child_id
JOIN guardian g ON o.guardian_id = g.guardian_id
WHERE c.child_id IN (
    SELECT child_id FROM guardian_of
)
ORDER BY c.name;

--all nurses that have appointments today and have experiance of more than x appointments (now x=0)
SELECT n.name AS nurse_name, n.nurse_id, a.app_date, a.hour, a.room
FROM nurse n
JOIN injected_by ib ON n.nurse_id = ib.nurse_id
JOIN appointment a ON ib.appointment_id = a.appointment_id
WHERE a.app_date = TRUNC(SYSDATE) and 0< (
    SELECT COUNT(v.nurse_id)
    FROM nurse v
    WHERE v.nurse_id = n.nurse_id
    GROUP BY v.nurse_id
)
ORDER BY a.hour;

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

-- all injections.for every injection in stock also amout and shelf.
SELECT i.name AS injection_name, i.injection_id, s.shelf_id, s.amount
FROM injection i
LEFT OUTER JOIN in_stock ist ON i.injection_id = ist.injection_id
LEFT OUTER JOIN stock s ON ist.stock_id = s.stock_id
ORDER BY s.amount DESC;


--delete

--delete all guardians that are not related to a child
DELETE FROM guardian
WHERE guardian_id NOT IN (
    SELECT guardian_id FROM guardian_of
);


--delete all nurses that didnt injected in the last 3 years
DELETE FROM nurse
SELECT *
FROM nurse
WHERE nurse_id NOT IN (
    SELECT i.nurse_id 
    FROM injected_by i
    JOIN appointment a ON i.appointment_id = a.appointment_id
    WHERE a.app_date >= ADD_MONTHS(SYSDATE, -36)
);

--decrease the amount of every injection that injected today (if it was injected x times then decrease x times)
UPDATE stock
SET amount = amount - 1
WHERE stock_id IN (
    SELECT s.stock_id
    FROM stock s
    JOIN injected i  ON s.stock_id = i.stock_id
    JOIN appointment a ON i.appointment_id = a.appointment_id
    WHERE TRUNC(a.app_date) = TRUNC(SYSDATE)
);

--push by 1 month every appointment that the injection scheduals in this appontment have amount = 0 in stock
UPDATE appointment
SET app_date = ADD_MONTHS(app_date, 1)
WHERE appointment_id IN (
    SELECT i.appointment_id
    FROM injected i
    JOIN stock s ON i.stock_id = s.stock_id
    JOIN appointment a ON i.appointment_id = a.appointment_id
    WHERE s.amount = 0 and TRUNC(a.app_date) >= TRUNC(SYSDATE)
);

