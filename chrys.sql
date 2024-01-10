CREATE TABLE promotion_appl(
	appl_id INT(11) NOT NULL AUTO_INCREMENT,
    status ENUM('active','finished','rejected'),
    appl_date DATE NOT NULL,
    cancel_date DATE NOT NULL,
    job_id INT(11) NOT NULL,
    emp_username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY(appl_id),
    CONSTRAINT EMPNAME FOREIGN KEY (emp_username) REFERENCES employee(username) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT JIDD FOREIGN KEY (job_id) REFERENCES job(id) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE appl_eval(
	id INT(11) NOT NULL AUTO_INCREMENT,
    evaluator1 VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    evaluator2 VARCHAR(30) DEFAULT 'unknown' NOT NULL,
	grade1 TINYINT(4) UNSIGNED DEFAULT '0' NOT NULL,
    grade2 TINYINT(4) UNSIGNED DEFAULT '0' NOT NULL,
    job_id INT(11) NOT NULL,
    state ENUM('active','finished'),
    PRIMARY KEY(id),
    CONSTRAINT EVLNAMEE FOREIGN KEY (evaluator1) REFERENCES evaluator(username) 
	ON UPDATE CASCADE ON DELETE CASCADE
    CONSTRAINT EVLNAMEEE FOREIGN KEY (evaluator2) REFERENCES evaluator(username) 
	ON UPDATE CASCADE ON DELETE CASCADE
    CONSTRAINT JIDDD FOREIGN KEY (job_id) REFERENCES job(id) 
	ON UPDATE CASCADE ON DELETE CASCADE
    CONSTRAINT EVID FOREIGN KEY (id) REFERENCES promotion_appl(appl_id) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

DELIMITER //

CREATE TRIGGER max3
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
    IF NEW.status = 'canceled' AND NEW.job.start_date <= DATE_ADD(NEW.cancel_date, 10) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Δεν επιτρέπεται η ακύρωση αίτησης λιγότερο από 10 μέρες πριν την έναρξη της θέσης';
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER max15DaysBeforeStart
BEFORE INSERT ON applies FOR EACH ROW
BEGIN
    DECLARE days_before_start INT;

    SET days_before_start = DATEDIFF(NEW.appl_date, (SELECT start_date FROM job WHERE id = NEW.job_id));

    IF days_before_start < 0 OR days_before_start > 15 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Μη επιτρεπτή η υποβολή αίτησης εκτός του επιτρεπτού χρονικού πλαισίου';
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE check_evaluation(
    IN evaluator_username_param VARCHAR(30),
    IN employee_username_param VARCHAR(30),
    IN job_id_param INT,
    OUT evaluation_grade_param FLOAT
)
DELIMITER //

CREATE PROCEDURE check_evaluation(
    IN evaluator1_username_param VARCHAR(30),
    IN evaluator2_username_param VARCHAR(30),
    IN employee_username_param VARCHAR(30),
    IN job_id_param INT,
    OUT evaluation_grade_param FLOAT
)
BEGIN
    DECLARE eval1_grade FLOAT;
    DECLARE eval2_grade FLOAT;

    SELECT grade INTO eval1_grade
    FROM evaluation
    WHERE evaluator_username = evaluator1_username_param
        AND cand_usrname = employee_username_param
        AND job_id = job_id_param;

    SELECT grade INTO eval2_grade
    FROM evaluation
    WHERE evaluator_username = evaluator2_username_param
        AND cand_usrname = employee_username_param
        AND job_id = job_id_param;

    IF eval1_grade IS NULL THEN
        SET evaluation_grade_param = (
            IFNULL(
                (SUM(
                    CASE 
                        WHEN education.bathmida = 'BSc' THEN 1
                        WHEN education.bathmida = 'MSc' THEN 2
                        WHEN education.bathmida = 'PhD' THEN 3
                        ELSE 0
                    END
                ) + IF(languages.candid IS NOT NULL, 1, 0) + IF(project.candid IS NOT NULL, 1, 0)) / 3,
                0
            )
        + eval2_grade) / 2;
    ELSEIF eval2_grade IS NULL THEN
        SET evaluation_grade_param = (eval1_grade +
            IFNULL(
                (SUM(
                    CASE 
                        WHEN education.bathmida = 'BSc' THEN 1
                        WHEN education.bathmida = 'MSc' THEN 2
                        WHEN education.bathmida = 'PhD' THEN 3
                        ELSE 0
                    END
                ) + IF(languages.candid IS NOT NULL, 1, 0) + IF(project.candid IS NOT NULL, 1, 0)) / 3,
                0
            )
        ) / 2;
    ELSE
        SET evaluation_grade_param = (eval1_grade + eval2_grade) / 2;
    END IF;
END;
//

DELIMITER ;
