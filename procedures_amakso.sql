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

    -- Get evaluators for the specified job
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
                UPDATE job SET evaluator1 = (SELECT username FROM evaluator WHERE firm = (SELECT firm FROM employee WHERE username = employee_username)) WHERE id = job_id;
            END IF;

            IF evaluator2_username = 'unknown' THEN
                UPDATE job SET evaluator2 = (SELECT username FROM evaluator WHERE firm = (SELECT firm FROM employee WHERE username = employee_username)) WHERE id = job_id;
            END IF;

            SELECT 'successful creation.' AS message;
        ELSE
            SELECT 'application exists.' AS message;
        END IF;

    ELSEIF action = 'c' THEN
        -- Cancel application if it exists
        IF application_exists > 0 THEN
            DELETE FROM applies WHERE cand_usrname = employee_username AND job_id = job_id;
            SELECT 'application canceled' AS message;
        ELSE
            SELECT 'no application to cancel' AS message;
        END IF;

    ELSEIF action = 'a' THEN
        IF application_exists > 0 THEN
            SELECT 'application activated successfully.' AS message;
        ELSE
            SELECT 'no canceled application to activate.' AS message;
        END IF;
    ELSE
        SELECT 'dwse a,c or a' AS message;
    END IF;

END //

DELIMITER ;


