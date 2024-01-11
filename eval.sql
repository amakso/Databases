drop database eval;
create database eval;
use eval;

SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE `applies` (
  `cand_usrname` varchar(30) NOT NULL DEFAULT 'unknown',
  `job_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applies`
--

INSERT INTO `applies` (`cand_usrname`, `job_id`) VALUES
('evangelia10', 1),
('giannakis123', 2),
('giorgos12', 3),
('marios21', 4),
('mhtsos69', 5),
('xaralampos23', 6);

-- --------------------------------------------------------

--
-- Table structure for table `degree`
--

CREATE TABLE `degree` (
  `titlos` varchar(150) NOT NULL DEFAULT 'unknown',
  `idryma` varchar(150) NOT NULL DEFAULT 'unknown',
  `bathmida` enum('BSc','MSc','PhD') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `degree`
--

INSERT INTO `degree` (`titlos`, `idryma`, `bathmida`) VALUES
('CEID Integrated Masters', 'University of Patras', 'MSc'),
('Computer Game Progamming Bachelor', 'Lulea University', 'BSc'),
('Computer Science Bachelor', 'Uppsala University', 'BSc'),
('Graphic Design Bachelor', 'Jonkoping University', 'BSc'),
('Marketing Management Master', 'Oxford University', 'MSc'),
('Physiotherapy Masters', 'Michigan University', 'MSc');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `username` varchar(30) NOT NULL DEFAULT 'unknown',
  `bio` text DEFAULT NULL,
  `sistatikes` varchar(35) NOT NULL DEFAULT 'unknown',
  `certificates` varchar(35) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`username`, `bio`, `sistatikes`, `certificates`) VALUES
('evangelia10', '10 xronia proiphresia', 'none', 'none'),
('giannakis123', '2 xronia proiphresia', 'none', 'none'),
('giorgos12', '6 xronia proiphresia', 'none', 'none'),
('marios21', '10 xronia proiphresia', 'none', 'none'),
('mhtsos69', '10 xronia proiphresia', 'none', 'none'),
('xaralampos23', '10 xronia proiphresia', 'none', 'none');

-- --------------------------------------------------------

--
-- Table structure for table `etaireia`
--

CREATE TABLE `etaireia` (
  `AFM` char(9) NOT NULL DEFAULT 'unknown',
  `DOY` varchar(30) NOT NULL DEFAULT 'unknown',
  `name` varchar(35) NOT NULL DEFAULT 'unknown',
  `tel` varchar(10) NOT NULL DEFAULT 'unknown',
  `street` varchar(15) NOT NULL DEFAULT 'unknown',
  `num` int(11) NOT NULL DEFAULT 0,
  `city` varchar(45) NOT NULL DEFAULT 'unknown',
  `country` varchar(15) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `etaireia`
--

INSERT INTO `etaireia` (`AFM`, `DOY`, `name`, `tel`, `street`, `num`, `city`, `country`) VALUES
('617294658', 'A', 'McDonalds', '2116537109', 'Brazilias', 47, 'Athens', 'Greece'),
('625385619', 'C', 'BurgerKing', '2128754321', 'Porou', 69, 'Athens', 'Greece'),
('734251759', 'B', 'KFC', '2147764302', 'Ermou', 1, 'Athens', 'Greece');

-- --------------------------------------------------------

--
-- Table structure for table `evaluator`
--

CREATE TABLE `evaluator` (
  `username` varchar(30) NOT NULL DEFAULT 'unknown',
  `exp_years` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `firm` char(9) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluator`
--

INSERT INTO `evaluator` (`username`, `exp_years`, `firm`) VALUES
('ab', 10, '625385619'),
('antwnakious', 24, '73425175'),
('elenoula13', 31, '617294658'),
('faker', 5, '625385619'),
('katerinakixx', 1, '617294658'),
('panos100', 3, '73425175');

-- --------------------------------------------------------

--
-- Table structure for table `has_degree`
--

CREATE TABLE `has_degree` (
  `degr_title` varchar(150) NOT NULL DEFAULT 'unknown',
  `degr_idryma` varchar(140) NOT NULL DEFAULT 'unknown',
  `cand_usrname` varchar(30) NOT NULL DEFAULT 'unknown',
  `etos` year(4) NOT NULL,
  `grade` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `has_degree`
--

INSERT INTO `has_degree` (`degr_title`, `degr_idryma`, `cand_usrname`, `etos`, `grade`) VALUES
('CEID Integrated Masters', 'University of Patras', 'giorgos12', '2028', 5),
('Computer Game Progamming Bachelor', 'Lulea University', 'evangelia10', '2010', 9.8),
('Computer Science Bachelor', 'Uppsala University', 'mhtsos69', '2001', 9.7),
('Graphic Design Bachelor', 'Jonkoping University', 'giannakis123', '2012', 8);

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE `job` (
  `id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `salary` float NOT NULL,
  `position` varchar(60) NOT NULL DEFAULT 'unknown',
  `edra` varchar(60) NOT NULL DEFAULT 'unknown',
  `evaluator` varchar(30) NOT NULL DEFAULT 'unknown',
  `announce_date` datetime NOT NULL DEFAULT current_timestamp(),
  `submission_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job`
--

INSERT INTO `job` (`id`, `start_date`, `salary`, `position`, `edra`, `evaluator`, `announce_date`, `submission_date`) VALUES
(1, '2023-01-13', 9000, 'patty flipper', 'Brazilias 47', 'katerinakixx', '2022-12-13 10:30:00', '2023-02-13'),
(2, '2023-01-08', 9000, 'cashier', 'Ermou 1', 'faker', '2022-12-08 08:00:00', '2023-02-08'),
(3, '2020-01-08', 9500, 'lantza', 'Porou 69', 'antwnakious', '2019-12-08 18:32:01', '2020-02-08'),
(4, '2014-12-01', 9700, 'mageiras', 'Ermou 1', 'ab', '2014-11-01 19:22:11', '2015-01-01'),
(5, '2023-01-10', 8100, 'lantza', 'Brazilias 47', 'panos100', '2022-12-10 21:09:56', '2023-02-10'),
(6, '2023-01-12', 9000, 'psistis', 'Porou 69', 'elenoula13', '2022-12-12 03:11:11', '2023-02-12'),
(7, '2021-01-08', 12000, 'manager', 'Brazilias 47', 'katerinakixx', '2020-12-08 09:32:09', '2021-02-08'),
(8, '2019-09-21', 12000, 'manager', 'Porou 69', 'elenoula13', '2019-08-21 08:59:58', '2019-10-21');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `candid` varchar(30) NOT NULL DEFAULT 'unknown',
  `lang` set('EN','FR','SP','GE','CH','GR') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`candid`, `lang`) VALUES
('giorgos12', 'EN,GR'),
('marios21', 'EN,GR'),
('mhtsos69', 'EN,GR'),
('xaralampos23', 'EN,GR');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `candid` varchar(30) NOT NULL DEFAULT 'unknown',
  `num` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `descr` text DEFAULT NULL,
  `url` varchar(60) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`candid`, `num`, `descr`, `url`) VALUES
('evangelia10', 1, 'Cashier management', 'https://www.traganoskabouras.com/cashier_management'),
('giannakis123', 2, 'cleaning', 'https://www.traganoskabouras.com/cleaning'),
('giorgos12', 3, 'cooking', 'https://www.traganoskabouras.com/cooking'),
('marios21', 4, 'Food Analysis', 'https://www.traganoskabouras.com/food_anal'),
('mhtsos69', 5, 'frying', 'https://www.traganoskabouras.com/frying'),
('mhtsos69', 6, 'serving', 'https://www.traganoskabouras.com/serving'),
('xaralampos23', 7, 'cooking', 'https://www.traganoskabouras.com/cooking');

-- --------------------------------------------------------

--
-- Table structure for table `requires`
--

CREATE TABLE `requires` (
  `job_id` int(11) NOT NULL,
  `subject_title` varchar(36) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `requires`
--

INSERT INTO `requires` (`job_id`, `subject_title`) VALUES
(1, 'Cashier management'),
(2, 'cleaning'),
(3, 'cooking'),
(4, 'Food Analysis'),
(5, 'frying'),
(6, 'HR management'),
(7, 'management'),
(8, 'Serving');

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `title` varchar(36) NOT NULL DEFAULT 'unknown',
  `descr` tinytext DEFAULT NULL,
  `belongs_to` varchar(36) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`title`, `descr`, `belongs_to`) VALUES
('Cashier management', 'learn how to use cash register', 'unknown'),
('cleaning', 'learn how to clean properly', 'unknown'),
('cooking', 'learn how to cook', 'unknown'),
('Food Analysis', 'Learn how to differnciate good from bad', 'unknown'),
('frying', 'learn how to fry', 'unknown'),
('HR management', 'HR employee management', 'unknown'),
('management', 'managing employees', 'unknown'),
('Serving', 'proper serving', 'unknown');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `username` varchar(30) NOT NULL DEFAULT 'unknown',
  `password` varchar(20) NOT NULL DEFAULT 'unknown',
  `name` varchar(25) NOT NULL DEFAULT 'unknown',
  `lastname` varchar(35) NOT NULL DEFAULT 'unknown',
  `reg_date` datetime NOT NULL DEFAULT current_timestamp(),
  `email` varchar(30) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `password`, `name`, `lastname`, `reg_date`, `email`) VALUES
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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applies`
--
ALTER TABLE `applies`
  ADD PRIMARY KEY (`cand_usrname`,`job_id`),
  ADD KEY `JID` (`job_id`);

--
-- Indexes for table `degree`
--
ALTER TABLE `degree`
  ADD PRIMARY KEY (`titlos`,`idryma`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `etaireia`
--
ALTER TABLE `etaireia`
  ADD PRIMARY KEY (`AFM`);

--
-- Indexes for table `evaluator`
--
ALTER TABLE `evaluator`
  ADD PRIMARY KEY (`username`),
  ADD KEY `EVLFRM` (`firm`);

--
-- Indexes for table `has_degree`
--
ALTER TABLE `has_degree`
  ADD PRIMARY KEY (`degr_title`,`degr_idryma`,`cand_usrname`),
  ADD KEY `EUNAMEEE` (`cand_usrname`);

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`id`),
  ADD KEY `EVLNAME` (`evaluator`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`candid`,`lang`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`candid`,`num`);

--
-- Indexes for table `requires`
--
ALTER TABLE `requires`
  ADD PRIMARY KEY (`subject_title`,`job_id`),
  ADD KEY `JIDD` (`job_id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`title`),
  ADD KEY `TITLEBT` (`belongs_to`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applies`
--
ALTER TABLE `applies`
  ADD CONSTRAINT `EUNAMEEEE` FOREIGN KEY (`cand_usrname`) REFERENCES `employee` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `JID` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `USNAME` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `evaluator`
--
ALTER TABLE `evaluator`
  ADD CONSTRAINT `EVLFRM` FOREIGN KEY (`firm`) REFERENCES `etaireia` (`AFM`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `UNAME` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `has_degree`
--
ALTER TABLE `has_degree`
  ADD CONSTRAINT `DEGTLID` FOREIGN KEY (`degr_title`,`degr_idryma`) REFERENCES `degree` (`titlos`, `idryma`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EUNAMEEE` FOREIGN KEY (`cand_usrname`) REFERENCES `employee` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `job`
--
ALTER TABLE `job`
  ADD CONSTRAINT `EVLNAME` FOREIGN KEY (`evaluator`) REFERENCES `evaluator` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `languages`
--
ALTER TABLE `languages`
  ADD CONSTRAINT `EUNAME` FOREIGN KEY (`candid`) REFERENCES `employee` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `EUNAMEE` FOREIGN KEY (`candid`) REFERENCES `employee` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requires`
--
ALTER TABLE `requires`
  ADD CONSTRAINT `JIDD` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `STTL` FOREIGN KEY (`subject_title`) REFERENCES `subject` (`title`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subject`
--
ALTER TABLE `subject`
  ADD CONSTRAINT `TITLEBT` FOREIGN KEY (`belongs_to`) REFERENCES `subject` (`title`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;
