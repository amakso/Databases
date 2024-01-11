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
    username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
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
    belongs_to VARCHAR(36) DEFAULT 'unknown' NOT NULL,
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
    status ENUM('active','completed','rejected'),
    appl_date DATE NOT NULL,
    cancel_date DATE NOT NULL,
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
    evaluator1 VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    evaluator2 VARCHAR(30) DEFAULT 'unknown' NOT NULL,
	grade1 TINYINT(4) UNSIGNED DEFAULT '0' NOT NULL,
    grade2 TINYINT(4) UNSIGNED DEFAULT '0' NOT NULL,
    job_id INT(11) NOT NULL,
    ev_status ENUM('active','completed'),
    PRIMARY KEY(id),
    CONSTRAINT EVLNAMEE FOREIGN KEY (evaluator1) REFERENCES evaluator(username) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVLNAMEEE FOREIGN KEY (evaluator2) REFERENCES evaluator(username) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT JIDDD FOREIGN KEY (job_id) REFERENCES job(id) 
	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVID FOREIGN KEY (id) REFERENCES promotion_appl(appl_id) 
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

    -- Calculate the days before the job starts
    SET days_before_start = DATEDIFF((SELECT start_date FROM job WHERE id = NEW.job_id), NEW.appl_date);

    -- Check if the application is within the allowed timeframe
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
BEGIN
    DECLARE eval1_grade FLOAT;
    DECLARE eval2_grade FLOAT;

    -- Get the grade from the first evaluator
    SELECT grade INTO eval1_grade
    FROM appl_eval
    WHERE evaluator1 = evaluator_username_param
        AND emp_username = employee_username_param
        AND job_id = job_id_param;

    -- Get the grade from the second evaluator
    SELECT grade INTO eval2_grade
    FROM appl_eval
    WHERE evaluator2 = evaluator_username_param
        AND emp_username = employee_username_param
        AND job_id = job_id_param;

    -- Calculate the evaluation grade
    IF eval1_grade IS NULL THEN
        -- If the first evaluator hasn't provided a grade
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
            ) + eval2_grade
        ) / 2;
    ELSEIF eval2_grade IS NULL THEN
        -- If the second evaluator hasn't provided a grade
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
        -- If both evaluators have provided grades
        SET evaluation_grade_param = (eval1_grade + eval2_grade) / 2;
    END IF;
END;
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE generate_job_report(
    IN job_id_param INT
)
BEGIN
    DECLARE winner_username VARCHAR(30);

    SELECT employee_username
    INTO winner_username
    FROM (
        SELECT employee_username,
               AVG(evaluator_grade) AS avg_grade
        FROM job
        WHERE id = job_id_param
              AND status = 'completed'
        GROUP BY employee_username
        ORDER BY avg_grade DESC
        LIMIT 1
    ) AS result;
    
    SELECT winner_username AS job_winner;
END;
//

DELIMITER ;

SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE has_degree ADD FOREIGN KEY (cand_usrname) REFERENCES employee(username);


    
    
    
	
	