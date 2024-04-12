use eval;

DELIMITER //

CREATE TRIGGER log_job_insert
AFTER INSERT ON job
FOR EACH ROW
BEGIN
    INSERT INTO logs (username, action, date_time)
    VALUES (USER(), 'Insert job', NOW());
END;
//

CREATE TRIGGER log_job_update
AFTER UPDATE ON job
FOR EACH ROW
BEGIN
    INSERT INTO logs (username, action, date_time)
    VALUES (USER(), 'Update job', NOW());
END;
//

CREATE TRIGGER log_job_delete
AFTER DELETE ON job
FOR EACH ROW
BEGIN
    INSERT INTO logs (username, action, date_time)
    VALUES (USER(), 'Delete job', NOW());
END;
//
CREATE TRIGGER log_user_insert
AFTER INSERT ON user
FOR EACH ROW
BEGIN
    INSERT INTO logs (username, action, date_time)
    VALUES (USER(), 'Insert user', NOW());
END;
//

CREATE TRIGGER log_user_update
AFTER UPDATE ON user
FOR EACH ROW
BEGIN
    INSERT INTO logs (username, action, date_time)
    VALUES (USER(), 'Update user', NOW());
END;
//

CREATE TRIGGER log_user_delete
AFTER DELETE ON user
FOR EACH ROW
BEGIN
    INSERT INTO logs (username, action, date_time)
    VALUES (USER(), 'Delete user', NOW());
END;
//

CREATE TRIGGER log_degree_insert
AFTER INSERT ON degree
FOR EACH ROW
BEGIN
    INSERT INTO logs (username, action, date_time)
    VALUES (USER(), 'Insert degree', NOW());
END;
//

CREATE TRIGGER log_degree_update
AFTER UPDATE ON degree
FOR EACH ROW
BEGIN
    INSERT INTO logs (username, action, date_time)
    VALUES (USER(), 'Update degree', NOW());
END;
//

CREATE TRIGGER log_degree_delete
AFTER DELETE ON degree
FOR EACH ROW
BEGIN
    INSERT INTO logs (username, action, date_time)
    VALUES (USER(), 'Delete degree', NOW());
END;
//
DELIMITER ;

DELIMITER //

CREATE TRIGGER max3apps
BEFORE INSERT ON promotion_appl FOR EACH ROW
BEGIN
    DECLARE active_requests INT;
    SELECT COUNT(*) INTO active_requests
    FROM promotion_appl
    WHERE emp_username = NEW.emp_username AND status = 'active';

    IF active_requests >= 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ο εργαζόμενος έχει ήδη τρεις ενεργές αιτήσεις';
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER max10interval
BEFORE UPDATE ON promotion_appl FOR EACH ROW
BEGIN
    DECLARE start_date DATE;
    
    SELECT start_date INTO start_date
    FROM job
    WHERE id = NEW.job_id;

    IF NEW.status = 'canceled' AND start_date <= DATE_ADD(NEW.cancel_date, INTERVAL 10 DAY) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Δεν επιτρέπεται η ακύρωση αίτησης λιγότερο από 10 μέρες πριν την έναρξη της θέσης';
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER max15DaysBeforeStart
BEFORE INSERT ON promotion_appl FOR EACH ROW
BEGIN
    DECLARE days_before_start INT;

    SET days_before_start = DATEDIFF((SELECT start_date FROM job WHERE id = NEW.job_id), NEW.appl_date);

    IF days_before_start < 15 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Μη επιτρεπτή η υποβολή αίτησης εκτός του επιτρεπτού χρονικού πλαισίου';
    END IF;
END;
//

DELIMITER ;