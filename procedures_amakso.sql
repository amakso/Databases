use eval;

DELIMITER //

CREATE PROCEDURE rand_times()
BEGIN
  DECLARE i INT DEFAULT 1;
  
  loop_insert: LOOP
    IF i > 600 THEN
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
CREATE PROCEDURE proccessapp(
    IN emp_username VARCHAR(30),
    IN job_id INT,
    IN action CHAR(1)
)
BEGIN
    DECLARE eval1 VARCHAR(30);
    DECLARE eval2 VARCHAR(30);

    -- Get evaluators for the job from the same company
    SELECT e1.username, e2.username
    INTO eval1, eval2
    FROM evaluator e1, evaluator e2, job j, etaireia et
    WHERE j.id = job_id
        AND j.evaluator = e1.username
        AND e1.firm = et.AFM
        AND e2.firm = et.AFM
        AND e2.username != e1.username;

    IF action = 'i' THEN
        -- Insert application
        INSERT INTO applies(cand_usrname, job_id)
        VALUES (emp_username, job_id);

        -- Check if evaluators are missing and assign from the same company
        INSERT IGNORE INTO appl_eval(evaluator1, evaluator2, job_id, ev_status)
        VALUES (eval1, eval2, job_id, 'active');
        
        SELECT COUNT(*) INTO @count
        FROM applies
        WHERE cand_usrname = emp_username AND job_id = job_id;
        
        IF @count > 0 THEN
            SELECT 'Application submitted successfully.' AS result;
        ELSE
            SELECT 'Error submitting application.' AS result;
        END IF;

    ELSEIF action = 'c' THEN
        -- Cancel application
        DELETE FROM applies
        WHERE cand_usrname = emp_username AND job_id = job_id;

        SELECT 'Application canceled successfully.' AS result;
        
    ELSEIF action = 'a' THEN
        -- Activate canceled application
        UPDATE appl_eval
        SET ev_status = 'active'
        WHERE job_id = job_id
            AND evaluator1 = eval1
            AND evaluator2 = eval2;

        SELECT 'Application activated successfully.' AS result;

    ELSE
        SELECT 'Invalid action.' AS result;
        
    END IF;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE gradeapp(IN min INT, IN max INT)
BEGIN
    SELECT employ, id_job
    FROM istor_aitiseis
    WHERE bathmos BETWEEN min AND max;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE byeval(IN evaluator_username VARCHAR(30))
BEGIN
    SELECT employ, id_job
    FROM istor_aitiseis
    WHERE usereval1 = evaluator_username OR usereval2 = evaluator_username;
END //

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
    
    SELECT grade INTO eval1_grade
    FROM appl_eval
    WHERE evaluator1 = evaluator_username_param
        AND emp_username = employee_username_param
        AND job_id = job_id_param;
    
    SELECT grade INTO eval2_grade
    FROM appl_eval
    WHERE evaluator2 = evaluator_username_param
        AND emp_username = employee_username_param
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
            ) + eval2_grade
        ) / 2;
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
