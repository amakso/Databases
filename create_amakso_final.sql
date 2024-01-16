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

CREATE TABLE DBA (
username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
start_date DATE NOT NULL,
end_date DATE,
entry_log VARCHAR(30) NOT NULL,
PRIMARY KEY(username),
CONSTRAINT dbauser FOREIGN KEY(username) REFERENCES user(username)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT logdba FOREIGN KEY(entry_log) REFERENCES log(id)
ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB;
