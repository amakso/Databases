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
