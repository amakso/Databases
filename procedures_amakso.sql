use eval;

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

