drop database eval;
create database eval;
use eval;
 
 
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
evaluator1 VARCHAR(30) DEFAULT 'unknown',
    announce_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    submission_date DATE NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT EVLNAME FOREIGN KEY (evaluator) REFERENCES evaluator(username) 
ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVLSNAME FOREIGN KEY (evaluator1) REFERENCES evaluator(username) 
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
    status ENUM('active','inactive') DEFAULT 'active',
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
 
CREATE TABLE IF NOT EXISTS istor_aitiseis (
usereval1 varchar(30) NOT NULL DEFAULT 'unknown',
usereval2 varchar(30) NOT NULL DEFAULT 'unknown',
employ varchar(30) NOT NULL DEFAULT 'unknown',
id_job int(11) NOT NULL,
katastasi varchar(20) DEFAULT 'complete' not null,
bathmos int(11) NOT NULL,
PRIMARY KEY(usereval1, usereval2, employ, id_job),
CONSTRAINT evempw FOREIGN KEY (usereval1) REFERENCES evaluator(username)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT evemp FOREIGN KEY (usereval2) REFERENCES evaluator(username)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT empait FOREIGN KEY (employ) REFERENCES employee(username)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT idait FOREIGN KEY (id_job) REFERENCES job(id)
ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;
 
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL,
    action VARCHAR(50) NOT NULL,
    date_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
) ENGINE=InnoDB;
 
CREATE TABLE DBA (
username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
start_date DATE NOT NULL,
end_date DATE,
entry_log INT NOT NULL,
PRIMARY KEY(username),
CONSTRAINT dbauser FOREIGN KEY(username) REFERENCES user(username)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT logdba FOREIGN KEY(entry_log) REFERENCES logs(id)
ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;
 
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
 
ALTER TABLE has_degree ADD FOREIGN KEY (cand_usrname) REFERENCES employee(username);
 
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
    DECLARE sd DATE;
    DECLARE diff_days INT;
    
    SELECT start_date INTO sd
    FROM job
    WHERE id = OLD.job_id;
    
    SET diff_days = DATEDIFF(sd, NEW.cancel_date);
    
    IF NEW.status = 'canceled' AND diff_days < 10 THEN
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
 
CREATE PROCEDURE Randomtimesistor()
BEGIN
  DECLARE i INT DEFAULT 1;
  
  loop_insert: LOOP
    IF i > 60000 THEN
      LEAVE loop_insert;
    END IF;
    
    INSERT IGNORE INTO istor_aitiseis
      (usereval1, usereval2, employ, id_job, katastasi, bathmos)
    SELECT 
       (SELECT username FROM evaluator ORDER BY RAND() LIMIT 1),
       (SELECT username FROM evaluator ORDER BY RAND() LIMIT 1),
       (SELECT username FROM employee ORDER BY RAND() LIMIT 1),
       (SELECT id FROM job ORDER BY RAND() LIMIT 1),
       'complete',
       FLOOR(1 + RAND() * 20);
    
    SET i = i + 1;
  END LOOP;
END //
 
DELIMITER ;
 
DELIMITER //

CREATE PROCEDURE manage_application(
    IN employee_username VARCHAR(30),
    IN job_id INT(11),
    IN action CHAR(1)
)
BEGIN
    DECLARE evaluator1_username VARCHAR(30);
    DECLARE evaluator2_username VARCHAR(30);
    DECLARE application_exists INT;

    SELECT evaluator INTO evaluator1_username
    FROM job
    WHERE id = job_id;
    
     SELECT evaluator INTO evaluator2_username
    FROM job
    WHERE id = job_id;

    SELECT COUNT(*) INTO application_exists
    FROM applies
    WHERE cand_usrname = employee_username AND job_id = job_id;

    IF action = 'i' THEN
        IF application_exists = 0 THEN
            INSERT INTO applies (cand_usrname, job_id)
            VALUES (employee_username, job_id);
            
            IF evaluator1_username = 'unknown' THEN
                UPDATE job SET evaluator = (SELECT username FROM evaluator WHERE firm = (SELECT firm FROM employee WHERE username = employee_username)) WHERE id = job_id;
            END IF;

            IF evaluator2_username = 'unknown' THEN
                UPDATE job SET evaluator1 = (SELECT username FROM evaluator WHERE firm = (SELECT firm FROM employee WHERE username = employee_username)) WHERE id = job_id;
            END IF;

            SELECT 'successful creation.' AS message;
        ELSE
            SELECT 'application exists.' AS message;
        END IF;

    ELSEIF action = 'c' THEN
        IF application_exists > 0 THEN
            UPDATE applies SET status = 'inactive' WHERE cand_usrname = employee_username AND job_id = job_id;
            SELECT 'application canceled' AS message;
        ELSE
            SELECT 'no application to cancel' AS message;
        END IF;

    ELSEIF action = 'a' THEN
        IF application_exists > 0 THEN
            UPDATE applies SET status = 'active' WHERE cand_usrname = employee_username AND job_id = job_id;
        ELSE
            SELECT 'no canceled application to activate.' AS message;
        END IF;
    ELSE
        SELECT 'dwse a,c or a' AS message;
    END IF;

END //

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
 
    SELECT 
    CASE 
        WHEN evaluator1 = evaluator_username_param THEN grade1
        WHEN evaluator2 = evaluator_username_param THEN grade2
        ELSE NULL 
    END INTO eval_grade
FROM appl_eval
WHERE (evaluator1 = evaluator_username_param OR evaluator2 = evaluator_username_param)
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
    DECLARE employee_username_param VARCHAR(255); 
    DECLARE max_evaluation_score FLOAT DEFAULT 0; 
    DECLARE max_evaluation_username VARCHAR(255); 
    
    DECLARE gCursor CURSOR FOR
        SELECT appl_eval.emp_username, appl_eval.grade1, appl_eval.grade2
        FROM appl_eval
        JOIN promotion_appl ON appl_eval.emp_username = promotion_appl.emp_username
        WHERE appl_eval.job_id = p_job_id
        ORDER BY promotion_appl.appl_date ASC;
    
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

INSERT INTO user VALUES 
('messi10', 'password1', 'Lionel', 'Messi', '2016-04-23 12:30:00', 'lionel.messi@gmail.com'),
('ronaldo7', 'password2', 'Cristiano', 'Ronaldo', '2015-08-15 15:45:00', 'cristiano.ronaldo@gmail.com'),
('neymarjr11', 'password3', 'Neymar', 'Jr.', '2017-02-10 10:15:00', 'neymar.jr@gmail.com'),
('modric10', 'password4', 'Luka', 'Modric', '2016-11-28 09:20:00', 'luka.modric@gmail.com'),
('salah11', 'password5', 'Mohamed', 'Salah', '2018-05-03 14:00:00', 'mohamed.salah@gmail.com'),
('kane9', 'password6', 'Harry', 'Kane', '2015-10-19 08:45:00', 'harry.kane@gmail.com'),
('mbappe7', 'password7', 'Kylian', 'Mbappe', '2019-03-12 11:10:00', 'kylian.mbappe@gmail.com'),
('kroos8', 'password8', 'Toni', 'Kroos', '2017-07-25 13:20:00', 'toni.kroos@gmail.com'),
('debruyne17', 'password9', 'Kevin', 'De Bruyne', '2015-12-08 16:30:00', 'kevin.debruyne@gmail.com'),
('lewandowski9', 'password10', 'Robert', 'Lewandowski', '2020-01-05 17:15:00', 'robert.lewandowski@gmail.com'),
('hazard10', 'password11', 'Eden', 'Hazard', '2018-09-30 18:45:00', 'eden.hazard@gmail.com'),
('pogba6', 'password12', 'Paul', 'Pogba', '2016-06-14 21:00:00', 'paul.pogba@gmail.com'),
('ab', 'ival09o2', 'ab', 'basilopoulos', '2021-01-01 00:00:00', 'abbasilopoulos@gmail.com'),
('antwnakious', 'pasjhsda', 'antwnis', 'lamprou', '2019-09-14 00:00:00', 'antwnakious@hotmail.com'),
('elenoula13', 'abcde2fgh', 'eleni', 'konstantinidou', '2023-01-02 00:00:00', 'elenik@gmail.com'),
('evangelia10', 'evg3almid', 'evangelia', 'michailidou', '2023-01-06 00:00:00', 'emichailidou@gmail.com'),
('faker', 'password1', 'xaralampo', 'peristrofopoulos', '2001-01-13 10:30:43', 'faker@yahoo.gr'),
('giannakis123', 'nrt5pqzk1', 'giannis', 'papadopoulos', '2023-01-01 00:00:00', 'gpapa@gmail.com'),
('giorgos12', 'ayay45u4', 'giorgos', 'papadopoulos', '2020-01-01 00:00:00', 'giorgos12@gmail.com'),
('katerinakixx', 'p4wertyu', 'aikaterini', 'georgiou', '2023-01-04 00:00:00', 'ageorgiou@gmail.com'),
('marios21', 'fsetf', 'marios', 'papantwnhs', '2014-11-24 00:00:00', 'marios21@hotmail.com'),
('mhtsos69', 'xdy7jk9r', 'dimitris', 'vasileiou', '2023-01-03 00:00:00', 'dvasileiou@gmail.com'),
('panos100', 'opaa190a12', 'panos', 'papadopoulos', '2015-05-08 00:00:00', 'panospapa@gmail.com'),
('xaralampos23', 'klmnopqr', 'xaralambos', 'kyriakou', '2023-01-05 00:00:00', 'xkyriakou@gmail.com');
 
INSERT INTO etaireia VALUES 
('278291092', 'A', 'Manchester United', '2610123456', 'Amerikhs', 23, 'Patras', 'Greece'),
('864267923', 'B', 'FC Bayern', '2610789123', 'Mezonos', 45, 'Patras', 'Greece'),
('456789012', 'C', 'Real Madrid', '2610345678', 'Agiou Nikolaou', 12, 'Patras', 'Greece'),
('617294658', 'A', 'McDonalds', '2116537109', 'Brazilias', 47, 'Athens', 'Greece'),
('625385619', 'C', 'BurgerKing', '2128754321', 'Porou', 69, 'Athens', 'Greece'),
('734251759', 'B', 'KFC', '2147764302', 'Ermou', 1, 'Athens', 'Greece');
 
INSERT INTO evaluator VALUES 
('messi10', 15, '278291092'), 
('ronaldo7', 20, '864267923'), 
('neymarjr11', 5, '456789012'), 
('modric10', 10, '278291092'), 
('salah11', 8, '864267923'), 
('kane9', 12, '456789012'),
('ab', 10, '625385619'),
('antwnakious', 24, '734251759'),
('elenoula13', 31, '617294658'),
('faker', 5, '625385619'),
('katerinakixx', 1, '617294658'),
('panos100', 3, '734251759');
 
INSERT INTO job VALUES 
(NULL, '2016-03-15', 35000, 'Head Coach', 'Amerikhs 23, Patras, Greece','messi10', null,'2016-03-01 08:00:00', '2016-04-01'),
(NULL, '2017-08-22', 25000, 'Physiotherapist', 'Mezonos 45, Patras, Greece','ronaldo7', NULL, '2017-08-15 10:30:00', '2017-09-15'),
(NULL, '2019-05-10', 30000, 'Marketing Manager', 'Agiou Nikolaou 12, Patras, Greece','neymarjr11',NULL, '2019-05-01 12:15:00', '2019-06-01'),
(NULL, '2016-11-28', 38000, 'Head of Scouting', 'Amerikhs 23, Patras, Greece','modric10', NULL, '2016-11-15 14:45:00', '2016-12-15'),
(NULL, '2018-06-05', 32000, 'Team Psychologist', 'Mezonos 45, Patras, Greece','salah11', NULL, '2018-05-30 17:30:00', '2018-07-01'),
(NULL, '2015-10-19', 27000, 'Scout', 'Agiou Nikolaou 12, Patras, Greece','kane9', NULL, '2015-10-01 20:00:00', '2015-11-01'),
(NULL, '2020-02-15', 20000, 'Fitness Coach', 'Amerikhs 23, Patras, Greece','messi10', NULL, '2020-02-01 09:30:00', '2020-03-01'),
(NULL, '2017-12-08', 30000, 'Sports Analyst', 'Mezonos 45, Patras, Greece','ronaldo7', NULL, '2017-11-30 11:15:00', '2018-01-01'),
(NULL, '2023-01-13', 9000, 'patty flipper', 'Brazilias 47', 'katerinakixx',NULL, '2022-12-13 10:30:00', '2023-02-13'),
(NULL, '2023-01-08', 9000, 'cashier', 'Ermou 1', 'faker', NULL,'2022-12-08 08:00:00', '2023-02-08'),
(NULL, '2020-01-08', 9500, 'lantza', 'Porou 69', 'antwnakious',NULL ,'2019-12-08 18:32:01', '2020-02-08'),
(NULL, '2014-12-01', 9700, 'mageiras', 'Ermou 1', 'ab',NULL ,'2014-11-01 19:22:11', '2015-01-01'),
(NULL, '2023-01-10', 8100, 'lantza', 'Brazilias 47', 'panos100', NULL,'2022-12-10 21:09:56', '2023-02-10'),
(NULL, '2023-01-12', 9000, 'psistis', 'Porou 69', 'elenoula13', NULL,'2022-12-12 03:11:11', '2023-02-12'),
(NULL, '2021-01-08', 12000, 'manager', 'Brazilias 47', 'katerinakixx',NULL ,'2020-12-08 09:32:09', '2021-02-08'),
(NULL, '2019-09-21', 12000, 'manager', 'Porou 69', 'elenoula13', NULL, '2019-08-21 08:59:58', '2019-10-21');
 
 
INSERT INTO employee VALUES 
('mbappe7', 'Young and talented forward with speed and technical skills. World Cup winner with France.', 'L.o.R from Didier Deschamps.', 'UEFA Pro License'),
('kroos8', 'Midfield maestro known for passing accuracy. Key player for Real Madrid and Germany.', 'L.o.R from Zinedine Zidane.', 'UEFA Pro License'),
('debruyne17', 'Versatile midfielder with excellent vision. A key figure for Manchester City and Belgium.', 'L.o.R from Pep Guardiola.', 'UEFA Pro License'),
('lewandowski9', 'Prolific striker, goal-scoring machine. A leader for Bayern Munich and Poland national team.', 'L.o.R from Hansi Flick.', 'UEFA Pro License'),
('hazard10', 'Skillful winger with flair. Played for Chelsea and Real Madrid. Known for his dribbling.', 'L.o.R from Carlo Ancelotti.', 'UEFA Pro License'),
('pogba6', 'Dynamic midfielder with physical presence. A World Cup winner with France.', 'L.o.R from Didier Deschamps.', 'UEFA Pro License'),
('evangelia10', '10 xronia proiphresia', 'none', 'none'),
('giannakis123', '2 xronia proiphresia', 'none', 'none'),
('giorgos12', '6 xronia proiphresia', 'none', 'none'),
('marios21', '10 xronia proiphresia', 'none', 'none'),
('mhtsos69', '10 xronia proiphresia', 'none', 'none'),
('xaralampos23', '10 xronia proiphresia', 'none', 'none');
 
INSERT INTO applies VALUES 
('mbappe7', 1,null), 
('kroos8', 2,null),
('debruyne17', 3,null), 
('lewandowski9', 4,null),  
('hazard10', 5,null), 
('pogba6', 6,null),
('evangelia10', 1,null),
('giannakis123', 2,null),
('giorgos12', 3,null),
('marios21', 4,null),
('mhtsos69', 5,null),
('xaralampos23', 6,null);
 
INSERT INTO degree VALUES 
('Computer Science Bachelor', 'Stanford University', 'BSc'),
('Marketing Management Master', 'Harvard University', 'MSc'),
('Sports Psychology PhD', 'University of Manchester', 'PhD'),
('Graphic Design Bachelor', 'Paris-Sorbonne University', 'BSc'),
('Language Studies Master', 'University of Barcelona', 'MSc'),
('Data Analysis PhD', 'ETH Zurich', 'PhD'),
('CEID Integrated Masters', 'University of Patras', 'MSc'),
('Computer Game Progamming Bachelor', 'Lulea University', 'BSc'),
('Computer Science Bachelor', 'Uppsala University', 'BSc'),
('Graphic Design Bachelor', 'Jonkoping University', 'BSc'),
('Marketing Management Master', 'Oxford University', 'MSc'),
('Physiotherapy Masters', 'Michigan University', 'MSc');
 
INSERT INTO has_degree VALUES 
('Computer Science Bachelor', 'Stanford University', 'mbappe7', 2010, 8.2),
('Marketing Management Master', 'Harvard University', 'kroos8', 2015, 8.1),
('Sports Psychology PhD', 'University of Manchester', 'pogba6', 2005, 9.0),
('Language Studies Master', 'University of Barcelona', 'lewandowski9', 2018, 6.9),
('CEID Integrated Masters', 'University of Patras', 'giorgos12', '2028', 5),
('Computer Game Progamming Bachelor', 'Lulea University', 'evangelia10', '2010', 9.8),
('Computer Science Bachelor', 'Uppsala University', 'mhtsos69', '2001', 9.7),
('Graphic Design Bachelor', 'Jonkoping University', 'giannakis123', '2012', 8);
 
INSERT INTO languages VALUES 
('mbappe7', 'FR,EN'),  
('kroos8', 'GE,EN'),
('debruyne17', 'EN,FR,GE'),  
('pogba6', 'FR,EN,SP'),
('lewandowski9', 'GE,SP'),
('hazard10', 'FR,EN,SP'),
('giorgos12', 'EN,GR'),
('marios21', 'EN,GR,GE'),
('mhtsos69', 'EN,GR'),
('xaralampos23', 'EN,GR'),
('evangelia10', 'GR,EN,SP'),
('giannakis123', 'GR,EN,FR');
 
INSERT INTO project VALUES 
('mbappe7', 1, 'Injury Prevention Course', 'https://www.iman.com/injury_prevention'),
('kroos8', 2, 'Marketing Campaign', 'https://www.iman.com/marketing_campaign'),
('debruyne17', 3, 'Scouting South America', 'https://www.iman.com/scouting_sa'),
('lewandowski9', 4, 'Data Analysis Project', 'https://www.iman.com/data_analysis'),
('kroos8', 5, 'Graphic Design Project', 'https://www.iman.com/graphic_design'),
('pogba6', 6, 'Tactics Integration', 'https://www.iman.com/tactics_integration'),
('hazard10', 7, 'Football Coaching Program', 'https://www.iman.com/coaching_program'),
('evangelia10', 8, 'Cashier management', 'https://www.traganoskabouras.com/cashier_management'),
('giannakis123', 9, 'cleaning', 'https://www.traganoskabouras.com/cleaning'),
('giorgos12', 10, 'cooking', 'https://www.traganoskabouras.com/cooking'),
('marios21', 11, 'Food Analysis', 'https://www.traganoskabouras.com/food_anal'),
('mhtsos69', 12, 'frying', 'https://www.traganoskabouras.com/frying'),
('mhtsos69', 13, 'serving', 'https://www.traganoskabouras.com/serving'),
('xaralampos23', 14, 'cooking', 'https://www.traganoskabouras.com/cooking');
 
INSERT INTO subject VALUES 
('Coaching', 'Skills and techniques for coaching sports teams.', null),
('Physiotherapy', 'Physical therapy and rehabilitation techniques.', null),
('Marketing Management', 'Management principles applied to marketing.', null),
('Scouting', 'Techniques for player scouting and talent identification.', null),
('Sports Psychology', 'Psychological principles in sports and athletics.', null),
('Languages', 'Study of various languages and their structures.', null),
('Fitness Coaching', 'Training methods for physical fitness improvement.', null),
('Sports Analysis', 'Analysis and interpretation of sports performance data.', null),
('Cashier management', 'learn how to use cash register', null),
('cleaning', 'learn how to clean properly', null),
('cooking', 'learn how to cook', null),
('Food Analysis', 'Learn how to differenciate good from bad', null),
('frying', 'learn how to fry', null),
('HR management', 'HR employee management', null),
('management', 'managing employees', null),
('Serving', 'proper serving', null);
 
INSERT INTO requires VALUES 
(1, 'Coaching'),  
(2, 'Physiotherapy'),  
(3, 'Marketing Management'),  
(4, 'Scouting'),  
(5, 'Sports Psychology'),  
(6, 'Scouting'), 
(7, 'Fitness Coaching'),  
(8, 'Sports Analysis'),
(1, 'Cashier management'),
(2, 'cleaning'),
(3, 'cooking'),
(4, 'Food Analysis'),
(5, 'frying'),
(6, 'HR management'),
(7, 'management'),
(8, 'Serving');
 
INSERT INTO promotion_appl VALUES
(NULL, 'active', '2017-10-20', NULL, 8, 'mbappe7'),
(NULL, 'active', '2017-06-15', NULL, 2, 'evangelia10'),
(NULL, 'active', '2016-08-27', NULL, 4, 'debruyne17'),
(NULL, 'active', '2016-07-07', NULL, 4, 'giannakis123'),
(NULL, 'active', '2022-12-27', NULL, 9, 'lewandowski9'),
(NULL, 'active', '2016-05-01', NULL, 4, 'mhtsos69'),
(NULL, 'active', '2017-04-11', NULL, 2, 'hazard10'),
(NULL, 'active', '2016-08-03', NULL, 4, 'giorgos12'),
(NULL, 'active', '2019-02-19', NULL, 7, 'xaralampos23'),
(NULL, 'active', '2015-12-30', NULL, 1, 'kroos8'),
(NULL, 'active', '2022-12-26', NULL, 9, 'pogba6'),
(NULL, 'active', '2017-08-05', NULL, 2, 'marios21'),
(NULL, 'active', '2014-09-25', NULL, 12, 'marios21'),
(NULL, 'active', '2018-02-11', NULL, 5, 'marios21'),
(NULL, 'canceled', '2013-12-09', '2014-01-08', 5, 'debruyne17'),
(NULL, 'canceled', '2014-07-18', '2014-12-05', 6, 'mhtsos69'),
(NULL, 'canceled', '2013-03-22', '2013-08-01', 6, 'hazard10'),
(NULL, 'canceled', '2011-10-05', '2011-12-25', 1, 'kroos8'),
(NULL, 'canceled', '2016-04-30', '2016-09-14', 10, 'mbappe7');

INSERT INTO appl_eval VALUES
(NULL, 'kane9', NULL, 17, NULL, 8, 'active', 'mbappe7'),
(NULL, 'messi10', 'ronaldo7', 8, 10, 2, 'active', 'evangelia10'),
(NULL, 'neymarjr11', NULL, 8, NULL, 4, 'active', 'debruyne17'),
(NULL, 'salah11', 'neymarjr11', 7, 6, 4, 'active', 'giannakis123'),
(NULL, 'ab', 'modric10', 14, 14, 9, 'active', 'lewandowski9'),
(NULL, NULL, NULL, NULL, NULL, 4, 'active', 'mhtsos69'),
(NULL, NULL, 'faker', NULL, 16, 2, 'active', 'hazard10'),
(NULL, 'panos100', 'katerinakixx', 8, 8, 4, 'active', 'giorgos12'),
(NULL, NULL, 'faker', NULL, 13, 7, 'active', 'xaralampos23'),
(NULL, 'ab', 'antwnakious', 15, 11, 1, 'active', 'kroos8'),
(NULL, 'elenoula13', 'messi10', 10, 18, 9, 'active', 'pogba6'),
(NULL, NULL, NULL, NULL, NULL, 2, 'active', 'marios21');





