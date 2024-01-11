CREATE TABLE IF NOT EXISTS `applies` (
  `cand_usrname` varchar(30) NOT NULL DEFAULT 'unknown',
  `job_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `degree` (
  `titlos` varchar(150) NOT NULL DEFAULT 'unknown',
  `idryma` varchar(150) NOT NULL DEFAULT 'unknown',
  `bathmida` enum('BSc','MSc','PhD') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `employee` (
  `username` varchar(30) NOT NULL DEFAULT 'unknown',
  `bio` text DEFAULT NULL,
  `sistatikes` varchar(35) NOT NULL DEFAULT 'unknown',
  `certificates` varchar(35) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `etaireia` (
  `AFM` char(9) NOT NULL DEFAULT 'unknown',
  `DOY` varchar(30) NOT NULL DEFAULT 'unknown',
  `name` varchar(35) NOT NULL DEFAULT 'unknown',
  `tel` varchar(10) NOT NULL DEFAULT 'unknown',
  `street` varchar(15) NOT NULL DEFAULT 'unknown',
  `num` int(11) NOT NULL DEFAULT 0,
  `city` varchar(45) NOT NULL DEFAULT 'unknown',
  `country` varchar(15) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `evaluator` (
  `username` varchar(30) NOT NULL DEFAULT 'unknown',
  `exp_years` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `firm` char(9) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `has_degree` (
  `degr_title` varchar(150) NOT NULL DEFAULT 'unknown',
  `degr_idryma` varchar(140) NOT NULL DEFAULT 'unknown',
  `cand_usrname` varchar(30) NOT NULL DEFAULT 'unknown',
  `etos` year(4) NOT NULL,
  `grade` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `job` (
  `id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `salary` float NOT NULL,
  `position` varchar(60) NOT NULL DEFAULT 'unknown',
  `edra` varchar(60) NOT NULL DEFAULT 'unknown',
  `evaluator` varchar(30) NOT NULL DEFAULT 'unknown',
  `announce_date` datetime NOT NULL DEFAULT current_timestamp(),
  `submission_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `languages` (
  `candid` varchar(30) NOT NULL DEFAULT 'unknown',
  `lang` set('EN','FR','SP','GE','CH','GR') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `project` (
  `candid` varchar(30) NOT NULL DEFAULT 'unknown',
  `num` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `descr` text DEFAULT NULL,
  `url` varchar(60) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `requires` (
  `job_id` int(11) NOT NULL,
  `subject_title` varchar(36) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `subject` (
  `title` varchar(36) NOT NULL DEFAULT 'unknown',
  `descr` tinytext DEFAULT NULL,
  `belongs_to` varchar(36) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(30) NOT NULL DEFAULT 'unknown',
  `password` varchar(20) NOT NULL DEFAULT 'unknown',
  `name` varchar(25) NOT NULL DEFAULT 'unknown',
  `lastname` varchar(35) NOT NULL DEFAULT 'unknown',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp(),
  `email` varchar(30) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
