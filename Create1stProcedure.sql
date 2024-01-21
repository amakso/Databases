DROP DATABASE erecruit2023;
CREATE DATABASE erecruit2023;
USE erecruit2023;

CREATE TABLE user(
    username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    password VARCHAR(20) DEFAULT 'unknown' NOT NULL,
    name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
    lastname VARCHAR(35) DEFAULT 'unknown' NOT NULL,
    reg_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    email VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY(username)
) ENGINE=InnoDB;

CREATE TABLE etaireia(
    AFM CHAR(9) DEFAULT 'unknown' NOT NULL,
    DOY VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    name VARCHAR(35) DEFAULT 'unknown' NOT NULL,
    tel VARCHAR(10) DEFAULT 'unknown' NOT NULL,
    street VARCHAR(15) DEFAULT 'unknown' NOT NULL,
    num INT(11) DEFAULT '0' NOT NULL,
    city VARCHAR(45) DEFAULT 'unknown' NOT NULL,
    country VARCHAR(15) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY(AFM)
) ENGINE=InnoDB;

CREATE TABLE evaluator(
    username VARCHAR(30) DEFAULT 'unknown',
    exp_years TINYINT(4) UNSIGNED DEFAULT '0' NOT NULL,
    firm CHAR(9) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY(username),
    CONSTRAINT EVLFRM FOREIGN KEY (firm) REFERENCES etaireia(AFM) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT UNAME FOREIGN KEY (username) REFERENCES user(username) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE job(
	id INT(11) NOT NULL AUTO_INCREMENT,
    start_date DATE NOT NULL,
    salary FLOAT NOT NULL,
    position VARCHAR(60) DEFAULT 'unknown' NOT NULL,
    edra VARCHAR(60) DEFAULT 'unknown' NOT NULL,
    evaluator VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    announce_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    submission_date DATE NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT EVLNAME FOREIGN KEY (evaluator) REFERENCES evaluator(username) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;
    
CREATE TABLE employee(
	username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    bio TEXT,
    sistatikes VARCHAR(35) DEFAULT 'unknown' NOT NULL,
    certificates VARCHAR(35) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY(username),
    CONSTRAINT USNAME FOREIGN KEY (username) REFERENCES user(username) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;
     
CREATE TABLE applies(
	cand_usrname VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    job_id INT(11) NOT NULL,
    PRIMARY KEY(cand_usrname, job_id),
    CONSTRAINT EUNAMEEEE FOREIGN KEY (cand_usrname) REFERENCES employee(username) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT JID FOREIGN KEY (job_id) REFERENCES job(id) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE subject(
	title VARCHAR(36) DEFAULT 'unknown' NOT NULL,
    descr TINYTEXT,
    belongs_to VARCHAR(36) DEFAULT 'unknown',
    PRIMARY KEY(title),
	CONSTRAINT TITLEBT FOREIGN KEY (belongs_to) REFERENCES subject(title) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;    

CREATE TABLE requires(
	job_id INT(11) NOT NULL,
    subject_title VARCHAR(36) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY(subject_title, job_id),
	CONSTRAINT JIDD FOREIGN KEY (job_id) REFERENCES job(id) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT STTL FOREIGN KEY (subject_title) REFERENCES subject(title) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE languages(
	candid VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    lang SET('EN','FR','SP','GE','CH','GR'),
    PRIMARY KEY(candid, lang),
	CONSTRAINT EUNAME FOREIGN KEY (candid) REFERENCES employee(username) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE project(
	candid VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    num TINYINT(4) UNSIGNED DEFAULT '0' NOT NULL,
    descr TEXT,
    url VARCHAR(60) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY(candid, num),
	CONSTRAINT EUNAMEE FOREIGN KEY (candid) REFERENCES employee(username) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE degree(
	titlos VARCHAR(150) DEFAULT 'unknown' NOT NULL,
    idryma VARCHAR(150) DEFAULT 'unknown' NOT NULL,
    bathmida ENUM('BSc','MSc','PhD'),
    PRIMARY KEY(titlos, idryma)
) ENGINE=InnoDB;

CREATE TABLE has_degree(
	degr_title VARCHAR(150) DEFAULT 'unknown' NOT NULL,
    degr_idryma VARCHAR(140) DEFAULT 'unknown' NOT NULL,
    cand_usrname VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    etos YEAR(4) NOT NULL,
	grade FLOAT,
    PRIMARY KEY(degr_title, degr_idryma, cand_usrname),
	CONSTRAINT EUNAMEEE FOREIGN KEY (cand_usrname) REFERENCES employee(username) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT DEGTLID FOREIGN KEY (degr_title, degr_idryma) REFERENCES degree(titlos, idryma) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE promotion_appl(
	appl_id INT(11) NOT NULL AUTO_INCREMENT,
    status ENUM('active','completed','canceled'),
    appl_date DATE NOT NULL,
    cancel_date DATE,
    job_id INT(11) NOT NULL,
    emp_username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY(appl_id),
    CONSTRAINT EMPNAME FOREIGN KEY (emp_username) REFERENCES employee(username) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT JIDDDD FOREIGN KEY (job_id) REFERENCES job(id) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE appl_eval(
	id INT(11) NOT NULL AUTO_INCREMENT,
    evaluator1 VARCHAR(30) DEFAULT 'unknown',
    evaluator2 VARCHAR(30) DEFAULT 'unknown',
	grade1 TINYINT(4) UNSIGNED DEFAULT '0',
    grade2 TINYINT(4) UNSIGNED DEFAULT '0',
    job_id INT(11) NOT NULL,
    ev_status ENUM('active','completed'),
    emp_username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT EVLNAMEE FOREIGN KEY (evaluator1) REFERENCES evaluator(username) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVLNAMEEE FOREIGN KEY (evaluator2) REFERENCES evaluator(username) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT JIDDD FOREIGN KEY (job_id) REFERENCES job(id) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVID FOREIGN KEY (id) REFERENCES promotion_appl(appl_id) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EMP FOREIGN KEY (emp_username) REFERENCES promotion_appl(emp_username) 
	ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

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

DELIMITER //

CREATE PROCEDURE check_evaluation(
    IN evaluator_username_param VARCHAR(30),
    IN employee_username_param VARCHAR(30),
    IN job_id_param INT,
    OUT evaluation_grade_param FLOAT,
    OUT has_evaluation_flag BOOLEAN
)
BEGIN
    DECLARE eval_grade FLOAT;
    DECLARE aggregate_result FLOAT;
    DECLARE V1 INT;
    DECLARE V2 INT;
    DECLARE V3 INT;
    DECLARE V4 INT;
    DECLARE V5 INT;

    SELECT grade1 INTO eval_grade
    FROM appl_eval
    WHERE evaluator1 = evaluator_username_param
        AND emp_username = employee_username_param
        AND job_id = job_id_param;

    SET has_evaluation_flag = (eval_grade IS NOT NULL);

    IF has_evaluation_flag THEN
        SET evaluation_grade_param = eval_grade;
    ELSE
        SELECT 
            COUNT(CASE WHEN degree.bathmida = 'BSc' THEN 1 END),
            COUNT(CASE WHEN degree.bathmida = 'MSc' THEN 1 END),
            COUNT(CASE WHEN degree.bathmida = 'PhD' THEN 1 END)
        INTO V1, V2, V3
        FROM employee 
        LEFT JOIN has_degree ON employee.username = has_degree.cand_usrname
        LEFT JOIN degree ON has_degree.degr_title = degree.titlos AND has_degree.degr_idryma = degree.idryma
        WHERE employee.username = employee_username_param
        GROUP BY employee.username;

        SELECT LENGTH(lang) - LENGTH(REPLACE(lang, ',', '')) + 1 INTO V4 FROM languages WHERE candid = employee_username_param;

        SELECT COUNT(project.candid) INTO V5
        FROM employee 
        LEFT JOIN project ON employee.username = project.candid
        WHERE employee.username = employee_username_param
        GROUP BY employee.username;

        SET aggregate_result = V1 + V2*2 + V3*3 + V4 + V5;    
        SET evaluation_grade_param = aggregate_result;
    END IF;
END;
//
DELIMITER ;

SET SESSION sql_mode = '';

DELIMITER //
CREATE PROCEDURE gcurs(
    IN p_job_id INT,
    OUT max_evaluation_username_p VARCHAR(60),
    OUT max_evaluation_score_p INT
)
BEGIN
    DECLARE aggregate_result FLOAT;
    DECLARE V1 INT;
    DECLARE V2 INT;
    DECLARE V3 INT;
    DECLARE V4 INT;
    DECLARE V5 INT;
    DECLARE g1 INT;
    DECLARE g2 INT;
    DECLARE finishedFlag INT;
    DECLARE employee_username_param VARCHAR(255); -- Add a variable to store the username
    DECLARE max_evaluation_score FLOAT DEFAULT 0; -- Add a variable to store the max evaluation score
    DECLARE max_evaluation_username VARCHAR(255); -- Add a variable to store the username with the max score
    
    DECLARE gCursor CURSOR FOR
        SELECT emp_username, grade1, grade2 FROM appl_eval WHERE job_id = p_job_id;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag = 1;
    OPEN gCursor;
    SET finishedFlag = 0;
    
    REPEAT
        FETCH gCursor INTO employee_username_param, g1, g2;
        IF (finishedFlag = 0) THEN
            SELECT 
                COUNT(CASE WHEN degree.bathmida = 'BSc' THEN 1 END),
                COUNT(CASE WHEN degree.bathmida = 'MSc' THEN 1 END),
                COUNT(CASE WHEN degree.bathmida = 'PhD' THEN 1 END)
            INTO V1, V2, V3
            FROM employee 
            LEFT JOIN has_degree ON employee.username = has_degree.cand_usrname
            LEFT JOIN degree ON has_degree.degr_title = degree.titlos AND has_degree.degr_idryma = degree.idryma
            WHERE employee.username = employee_username_param
            GROUP BY employee.username;

            SELECT LENGTH(lang) - LENGTH(REPLACE(lang, ',', '')) + 1 INTO V4 FROM languages WHERE candid = employee_username_param;

            SELECT COUNT(project.candid) INTO V5
            FROM employee 
            LEFT JOIN project ON employee.username = project.candid
            WHERE employee.username = employee_username_param
            GROUP BY employee.username;

            SET aggregate_result = V1 + V2*2 + V3*3 + V4 + V5;
            
            SELECT 
                AVG(
				CASE
					WHEN g1 IS NOT NULL AND g2 IS NOT NULL THEN (g1 + g2) /2
					WHEN g1 IS NOT NULL AND g2 IS NULL THEN (g1 + aggregate_result) /2
					WHEN g2 IS NOT NULL AND g1 IS NULL THEN (g2 + aggregate_result) /2
					ELSE aggregate_result
				END
                ) INTO aggregate_result
            FROM appl_eval
            WHERE emp_username = employee_username_param AND job_id = p_job_id
            GROUP BY emp_username;

            IF aggregate_result > max_evaluation_score THEN
                SET max_evaluation_score = aggregate_result;
                SET max_evaluation_username = employee_username_param;
            END IF;
        END IF;
    UNTIL (finishedFlag = 1)
    END REPEAT;
    CLOSE gCursor; 
    SET max_evaluation_score_p = max_evaluation_score;
    SET max_evaluation_username_p = max_evaluation_username;
     
END //
DELIMITER ;

ALTER TABLE has_degree ADD FOREIGN KEY (cand_usrname) REFERENCES employee(username);