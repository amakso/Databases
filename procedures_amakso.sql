use eval;

CREATE INDEX INDX_bathmos ON istor_aitiseis(bathmos);
CREATE INDEX INDX_byeval ON istor_aitiseis(usereval1, usereval2);

DELIMITER //

CREATE PROCEDURE rand_times()
BEGIN
  DECLARE i INT DEFAULT 1;
  
  loop_insert: LOOP
    IF i > 6000 THEN
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

    SELECT username
    INTO eval1
    FROM evaluator
    order by rand()
    limit 1;
    
    select username into eval2 from evaluator where username <> eval1 order by rand() limit 1;

    IF action = 'i' THEN
        
        INSERT INTO applies(cand_usrname, job_id, status)
        VALUES (emp_username, job_id, 'active');
        
        IF EXISTS(SELECT 1 FROM applies WHERE cand_usrname = emp_username AND job_id = job_id) THEN
            SELECT 'Application submitted successfully.' AS result;
        ELSE
            SELECT 'Error submitting application.' AS result;
        END IF;

    ELSEIF action = 'c' THEN
        
        IF EXISTS (SELECT 1 FROM applies WHERE cand_usrname = emp_username AND job_id = job_id AND status = 'active') THEN
            UPDATE applies
            SET status = 'inactive'
            WHERE cand_usrname = emp_username AND applies.job_id = job_id;
            SELECT 'Job application canceled successfully.' AS message;
        ELSE
            SELECT 'Error: No active application found for the specified employee and job.' AS message;
        END IF;
        
    ELSEIF action = 'a' THEN
		IF EXISTS (SELECT 1 FROM applies WHERE cand_usrname = emp_username AND job_id = job_id AND status = 'inactive') THEN
            UPDATE applies
            SET status = 'active'
            WHERE cand_usrname = emp_username AND applies.job_id = job_id;
            SELECT 'Job application activated successfully.' AS message;
        ELSE
            SELECT 'Error: No inactive application found for the specified employee and job.' AS message;
        END IF;
    END IF;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE gradeapp(IN min INT, IN max INT)
BEGIN
    SELECT employ, id_job, bathmos
    FROM istor_aitiseis
    WHERE bathmos BETWEEN min AND max;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE gradeappind(IN min INT, IN max INT)
BEGIN
    SELECT employ, id_job, bathmos
    FROM istor_aitiseis use index(INDX_bathmos)
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
delimiter // 
CREATE PROCEDURE byevalind(IN evaluator_username VARCHAR(30))
BEGIN
    SELECT employ, id_job
    FROM istor_aitiseis use index(INDX_byeval)
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
