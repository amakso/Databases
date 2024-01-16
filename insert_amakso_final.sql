INSERT INTO `applies` (`cand_usrname`, `job_id`) VALUES
('evangelia10', 1),
('giannakis123', 2),
('giorgos12', 3),
('marios21', 4),
('mhtsos69', 5),
('xaralampos23', 6);

INSERT INTO `degree` (`titlos`, `idryma`, `bathmida`) VALUES
('CEID Integrated Masters', 'University of Patras', 'MSc'),
('Computer Game Progamming Bachelor', 'Lulea University', 'BSc'),
('Computer Science Bachelor', 'Uppsala University', 'BSc'),
('Graphic Design Bachelor', 'Jonkoping University', 'BSc'),
('Marketing Management Master', 'Oxford University', 'MSc'),
('Physiotherapy Masters', 'Michigan University', 'MSc');

INSERT INTO `employee` (`username`, `bio`, `sistatikes`, `certificates`) VALUES
('evangelia10', '10 xronia proiphresia', 'none', 'none'),
('giannakis123', '2 xronia proiphresia', 'none', 'none'),
('giorgos12', '6 xronia proiphresia', 'none', 'none'),
('marios21', '10 xronia proiphresia', 'none', 'none'),
('mhtsos69', '10 xronia proiphresia', 'none', 'none'),
('xaralampos23', '10 xronia proiphresia', 'none', 'none');

INSERT INTO `etaireia` (`AFM`, `DOY`, `name`, `tel`, `street`, `num`, `city`, `country`) VALUES
('617294658', 'A', 'McDonalds', '2116537109', 'Brazilias', 47, 'Athens', 'Greece'),
('625385619', 'C', 'BurgerKing', '2128754321', 'Porou', 69, 'Athens', 'Greece'),
('734251759', 'B', 'KFC', '2147764302', 'Ermou', 1, 'Athens', 'Greece');

INSERT INTO `evaluator` (`username`, `exp_years`, `firm`) VALUES
('ab', 10, '625385619'),
('antwnakious', 24, '73425175'),
('elenoula13', 31, '617294658'),
('faker', 5, '625385619'),
('katerinakixx', 1, '617294658'),
('panos100', 3, '73425175');

INSERT INTO `has_degree` (`degr_title`, `degr_idryma`, `cand_usrname`, `etos`, `grade`) VALUES
('CEID Integrated Masters', 'University of Patras', 'giorgos12', '2028', 5),
('Computer Game Progamming Bachelor', 'Lulea University', 'evangelia10', '2010', 9.8),
('Computer Science Bachelor', 'Uppsala University', 'mhtsos69', '2001', 9.7),
('Graphic Design Bachelor', 'Jonkoping University', 'giannakis123', '2012', 8);

INSERT INTO `job` (`id`, `start_date`, `salary`, `position`, `edra`, `evaluator`, `announce_date`, `submission_date`) VALUES
(1, '2023-01-13', 9000, 'patty flipper', 'Brazilias 47', 'katerinakixx', '2022-12-13 10:30:00', '2023-02-13'),
(2, '2023-01-08', 9000, 'cashier', 'Ermou 1', 'faker', '2022-12-08 08:00:00', '2023-02-08'),
(3, '2020-01-08', 9500, 'lantza', 'Porou 69', 'antwnakious', '2019-12-08 18:32:01', '2020-02-08'),
(4, '2014-12-01', 9700, 'mageiras', 'Ermou 1', 'ab', '2014-11-01 19:22:11', '2015-01-01'),
(5, '2023-01-10', 8100, 'lantza', 'Brazilias 47', 'panos100', '2022-12-10 21:09:56', '2023-02-10'),
(6, '2023-01-12', 9000, 'psistis', 'Porou 69', 'elenoula13', '2022-12-12 03:11:11', '2023-02-12'),
(7, '2021-01-08', 12000, 'manager', 'Brazilias 47', 'katerinakixx', '2020-12-08 09:32:09', '2021-02-08'),
(8, '2019-09-21', 12000, 'manager', 'Porou 69', 'elenoula13', '2019-08-21 08:59:58', '2019-10-21');

INSERT INTO `languages` (`candid`, `lang`) VALUES
('giorgos12', 'EN,GR'),
('marios21', 'EN,GR'),
('mhtsos69', 'EN,GR'),
('xaralampos23', 'EN,GR');

INSERT INTO `project` (`candid`, `num`, `descr`, `url`) VALUES
('evangelia10', 1, 'Cashier management', 'https://www.traganoskabouras.com/cashier_management'),
('giannakis123', 2, 'cleaning', 'https://www.traganoskabouras.com/cleaning'),
('giorgos12', 3, 'cooking', 'https://www.traganoskabouras.com/cooking'),
('marios21', 4, 'Food Analysis', 'https://www.traganoskabouras.com/food_anal'),
('mhtsos69', 5, 'frying', 'https://www.traganoskabouras.com/frying'),
('mhtsos69', 6, 'serving', 'https://www.traganoskabouras.com/serving'),
('xaralampos23', 7, 'cooking', 'https://www.traganoskabouras.com/cooking');

INSERT INTO `requires` (`job_id`, `subject_title`) VALUES
(1, 'Cashier management'),
(2, 'cleaning'),
(3, 'cooking'),
(4, 'Food Analysis'),
(5, 'frying'),
(6, 'HR management'),
(7, 'management'),
(8, 'Serving');

INSERT INTO `subject` (`title`, `descr`, `belongs_to`) VALUES
('Cashier management', 'learn how to use cash register', 'unknown'),
('cleaning', 'learn how to clean properly', 'unknown'),
('cooking', 'learn how to cook', 'unknown'),
('Food Analysis', 'Learn how to differnciate good from bad', 'unknown'),
('frying', 'learn how to fry', 'unknown'),
('HR management', 'HR employee management', 'unknown'),
('management', 'managing employees', 'unknown'),
('Serving', 'proper serving', 'unknown');

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

CALL Randomtimesistor();
