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

CREATE PROCEDURE ProcessApplication(
    IN employee_username VARCHAR(30),
    IN job_id INT,
    IN action_char CHAR(1)
)
BEGIN
    DECLARE evaluator1 VARCHAR(30);
    DECLARE evaluator2 VARCHAR(30);

    -- Βρίσκουμε τους αξιολογητές για τη συγκεκριμένη θέση
    SELECT e1.username, e2.username
    INTO evaluator1, evaluator2
    FROM job j
    INNER JOIN evaluator e1 ON j.evaluator = e1.username
    INNER JOIN evaluator e2 ON j.evaluator <> e1.username AND j.evaluator = e2.username
    WHERE j.id = job_id;

    IF action_char = 'i' THEN
        -- Δημιουργούμε την αίτηση, ελέγχοντας αν έχουν συμπληρωθεί οι αξιολογητές
        INSERT INTO applies (cand_usrname, job_id)
        VALUES (employee_username, job_id);

        UPDATE job
        SET evaluator = CASE WHEN evaluator1 IS NULL THEN NULL ELSE evaluator1 END
        WHERE id = job_id;

        UPDATE job
        SET evaluator = CASE WHEN evaluator2 IS NULL THEN NULL ELSE evaluator2 END
        WHERE id = job_id;

    ELSEIF action_char = 'c' THEN
        -- Ακύρωση αίτησης, αν υπάρχει
        DELETE FROM applies
        WHERE cand_usrname = employee_username AND job_id = job_id;

    ELSEIF action_char = 'a' THEN
        -- Ενεργοποίηση ακυρωμένης αίτησης, αν υπάρχει
        UPDATE applies
        SET active = 1
        WHERE cand_usrname = employee_username AND job_id = job_id;

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
