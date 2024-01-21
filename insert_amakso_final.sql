INSERT INTO user VALUES 
('messi10', 'password1', 'Lionel', 'Messi', '2016-04-23 12:30:00', 'lionel.messi@gmail.com'),
('ronaldo7', 'password2', 'Cristiano', 'Ronaldo', '2015-08-15 15:45:00', 'cristiano.ronaldo@gmail.com'),
('neymarjr11', 'password3', 'Neymar', 'Jr.', '2017-02-10 10:15:00', 'neymar.jr@gmail.com'),
('modric10', 'password4', 'Luka', 'Modric', '2016-11-28 09:20:00', 'luka.modric@gmail.com'),
('salah11', 'password5', 'Mohamed', 'Salah', '2018-05-03 14:00:00', 'mohamed.salah@gmail.com'),
('kane9', 'password6', 'Harry', 'Kane', '2015-10-19 08:45:00', 'harry.kane@gmail.com'),
('mbappe7', 'password7', 'Kylian', 'Mbappe', '2019-03-12 11:10:00', 'kylian.mbappe@gmail.com'),
('kroos8', 'password8', 'Toni', 'Kroos', '2017-07-25 13:20:00', 'toni.kroos@gmail.com'),
('debruyne17', 'password9', 'Kevin', 'De Bruyne', '2015-12-08 16:30:00', 'kevin.debruyne@gmail.com'),
('lewandowski9', 'password10', 'Robert', 'Lewandowski', '2020-01-05 17:15:00', 'robert.lewandowski@gmail.com'),
('hazard10', 'password11', 'Eden', 'Hazard', '2018-09-30 18:45:00', 'eden.hazard@gmail.com'),
('pogba6', 'password12', 'Paul', 'Pogba', '2016-06-14 21:00:00', 'paul.pogba@gmail.com'),
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

INSERT INTO etaireia VALUES 
('278291092', 'A', 'Manchester United', '2610123456', 'Amerikhs', 23, 'Patras', 'Greece'),
('864267923', 'B', 'FC Bayern', '2610789123', 'Mezonos', 45, 'Patras', 'Greece'),
('456789012', 'C', 'Real Madrid', '2610345678', 'Agiou Nikolaou', 12, 'Patras', 'Greece'),
('617294658', 'A', 'McDonalds', '2116537109', 'Brazilias', 47, 'Athens', 'Greece'),
('625385619', 'C', 'BurgerKing', '2128754321', 'Porou', 69, 'Athens', 'Greece'),
('734251759', 'B', 'KFC', '2147764302', 'Ermou', 1, 'Athens', 'Greece');

INSERT INTO evaluator VALUES 
('messi10', 15, '278291092'), 
('ronaldo7', 20, '864267923'), 
('neymarjr11', 5, '456789012'), 
('modric10', 10, '278291092'), 
('salah11', 8, '864267923'), 
('kane9', 12, '456789012'),
('ab', 10, '625385619'),
('antwnakious', 24, '734251759'),
('elenoula13', 31, '617294658'),
('faker', 5, '625385619'),
('katerinakixx', 1, '617294658'),
('panos100', 3, '734251759');

INSERT INTO job VALUES 
(NULL, '2016-03-15', 35000, 'Head Coach', 'Amerikhs 23, Patras, Greece', 'messi10','faker' ,'2016-03-01 08:00:00', '2016-04-01'),
(NULL, '2017-08-22', 25000, 'Physiotherapist', 'Mezonos 45, Patras, Greece', 'ronaldo7','katerinakixx', '2017-08-15 10:30:00', '2017-09-15'),
(NULL, '2019-05-10', 30000, 'Marketing Manager', 'Agiou Nikolaou 12, Patras, Greece', 'elenoula13','neymarjr11', '2019-05-01 12:15:00', '2019-06-01'),
(NULL, '2016-11-28', 38000, 'Head of Scouting', 'Amerikhs 23, Patras, Greece', 'modric10', 'elenoula13','2016-11-15 14:45:00', '2016-12-15'),
(NULL, '2018-06-05', 32000, 'Team Psychologist', 'Mezonos 45, Patras, Greece', 'salah11', 'kane9','2018-05-30 17:30:00', '2018-07-01'),
(NULL, '2015-10-19', 27000, 'Scout', 'Agiou Nikolaou 12, Patras, Greece', 'kane9', 'ronaldo7','2015-10-01 20:00:00', '2015-11-01'),
(NULL, '2020-02-15', 20000, 'Fitness Coach', 'Amerikhs 23, Patras, Greece', 'messi10', 'antwnakious','2020-02-01 09:30:00', '2020-03-01'),
(NULL, '2017-12-08', 30000, 'Sports Analyst', 'Mezonos 45, Patras, Greece', 'ronaldo7','faker' ,'2017-11-30 11:15:00', '2018-01-01'),
(NULL, '2023-01-13', 9000, 'patty flipper', 'Brazilias 47', 'katerinakixx', 'faker','2022-12-13 10:30:00', '2023-02-13'),
(NULL, '2023-01-08', 9000, 'cashier', 'Ermou 1', 'faker', 'panos100','2022-12-08 08:00:00', '2023-02-08'),
(NULL, '2020-01-08', 9500, 'lantza', 'Porou 69', 'antwnakious','messi10' ,'2019-12-08 18:32:01', '2020-02-08'),
(NULL, '2014-12-01', 9700, 'mageiras', 'Ermou 1', 'ab','salah11','2014-11-01 19:22:11', '2015-01-01'),
(NULL, '2023-01-10', 8100, 'lantza', 'Brazilias 47', 'panos100', 'katerinakixx','2022-12-10 21:09:56', '2023-02-10'),
(NULL, '2023-01-12', 9000, 'psistis', 'Porou 69', 'elenoula13','faker' ,'2022-12-12 03:11:11', '2023-02-12'),
(NULL, '2021-01-08', 12000, 'manager', 'Brazilias 47', 'katerinakixx','kane9' ,'2020-12-08 09:32:09', '2021-02-08'),
(NULL, '2019-09-21', 12000, 'manager', 'Porou 69', 'elenoula13','panos100' ,'2019-08-21 08:59:58', '2019-10-21');

INSERT INTO employee VALUES 
('mbappe7', 'Young and talented forward with speed and technical skills. World Cup winner with France.', 'L.o.R from Didier Deschamps.', 'UEFA Pro License'),
('kroos8', 'Midfield maestro known for passing accuracy. Key player for Real Madrid and Germany.', 'L.o.R from Zinedine Zidane.', 'UEFA Pro License'),
('debruyne17', 'Versatile midfielder with excellent vision. A key figure for Manchester City and Belgium.', 'L.o.R from Pep Guardiola.', 'UEFA Pro License'),
('lewandowski9', 'Prolific striker, goal-scoring machine. A leader for Bayern Munich and Poland national team.', 'L.o.R from Hansi Flick.', 'UEFA Pro License'),
('hazard10', 'Skillful winger with flair. Played for Chelsea and Real Madrid. Known for his dribbling.', 'L.o.R from Carlo Ancelotti.', 'UEFA Pro License'),
('pogba6', 'Dynamic midfielder with physical presence. A World Cup winner with France.', 'L.o.R from Didier Deschamps.', 'UEFA Pro License'),
('evangelia10', '10 xronia proiphresia', 'none', 'none'),
('giannakis123', '2 xronia proiphresia', 'none', 'none'),
('giorgos12', '6 xronia proiphresia', 'none', 'none'),
('marios21', '10 xronia proiphresia', 'none', 'none'),
('mhtsos69', '10 xronia proiphresia', 'none', 'none'),
('xaralampos23', '10 xronia proiphresia', 'none', 'none');

INSERT INTO applies VALUES 
('mbappe7', 1, 'active'), 
('kroos8', 2,'active'),
('debruyne17', 3,'active'), 
('lewandowski9', 4,'active'),  
('hazard10', 5,'active'), 
('pogba6', 6,'active'),
('evangelia10', 1,'active'),
('giannakis123', 2,'active'),
('giorgos12', 3,'active'),
('marios21', 4,'active'),
('mhtsos69', 5,'active'),
('xaralampos23', 6,'active');

INSERT INTO degree VALUES 
('Computer Science Bachelor', 'Stanford University', 'BSc'),
('Marketing Management Master', 'Harvard University', 'MSc'),
('Sports Psychology PhD', 'University of Manchester', 'PhD'),
('Graphic Design Bachelor', 'Paris-Sorbonne University', 'BSc'),
('Language Studies Master', 'University of Barcelona', 'MSc'),
('Data Analysis PhD', 'ETH Zurich', 'PhD'),
('CEID Integrated Masters', 'University of Patras', 'MSc'),
('Computer Game Progamming Bachelor', 'Lulea University', 'BSc'),
('Computer Science Bachelor', 'Uppsala University', 'BSc'),
('Graphic Design Bachelor', 'Jonkoping University', 'BSc'),
('Marketing Management Master', 'Oxford University', 'MSc'),
('Physiotherapy Masters', 'Michigan University', 'MSc');

INSERT INTO has_degree VALUES 
('Computer Science Bachelor', 'Stanford University', 'mbappe7', 2010, 8.2),
('Marketing Management Master', 'Harvard University', 'kroos8', 2015, 8.1),
('Sports Psychology PhD', 'University of Manchester', 'pogba6', 2005, 9.0),
('Language Studies Master', 'University of Barcelona', 'hazard10', 2018, 6.9),
('CEID Integrated Masters', 'University of Patras', 'giorgos12', '2028', 5),
('Computer Game Progamming Bachelor', 'Lulea University', 'evangelia10', '2010', 9.8),
('Computer Science Bachelor', 'Uppsala University', 'mhtsos69', '2001', 9.7),
('Graphic Design Bachelor', 'Jonkoping University', 'giannakis123', '2012', 8);

INSERT INTO languages VALUES 
('mbappe7', 'FR,EN'),  
('kroos8', 'GE,EN'),
('debruyne17', 'EN,FR,GE'),  
('pogba6', 'FR,EN,SP'),
('giorgos12', 'EN,GR'),
('marios21', 'EN,GR'),
('mhtsos69', 'EN,GR'),
('xaralampos23', 'EN,GR');

INSERT INTO project VALUES 
('mbappe7', 1, 'Injury Prevention Course', 'https://www.iman.com/injury_prevention'),
('kroos8', 2, 'Marketing Campaign', 'https://www.iman.com/marketing_campaign'),
('debruyne17', 3, 'Scouting South America', 'https://www.iman.com/scouting_sa'),
('lewandowski9', 4, 'Data Analysis Project', 'https://www.iman.com/data_analysis'),
('kroos8', 5, 'Graphic Design Project', 'https://www.iman.com/graphic_design'),
('pogba6', 6, 'Tactics Integration', 'https://www.iman.com/tactics_integration'),
('hazard10', 7, 'Football Coaching Program', 'https://www.iman.com/coaching_program'),
('evangelia10', 1, 'Cashier management', 'https://www.traganoskabouras.com/cashier_management'),
('giannakis123', 2, 'cleaning', 'https://www.traganoskabouras.com/cleaning'),
('giorgos12', 3, 'cooking', 'https://www.traganoskabouras.com/cooking'),
('marios21', 4, 'Food Analysis', 'https://www.traganoskabouras.com/food_anal'),
('mhtsos69', 5, 'frying', 'https://www.traganoskabouras.com/frying'),
('mhtsos69', 6, 'serving', 'https://www.traganoskabouras.com/serving'),
('xaralampos23', 7, 'cooking', 'https://www.traganoskabouras.com/cooking');

INSERT INTO subject VALUES 
('Coaching', 'Skills and techniques for coaching sports teams.', null),
('Physiotherapy', 'Physical therapy and rehabilitation techniques.', null),
('Marketing Management', 'Management principles applied to marketing.', null),
('Scouting', 'Techniques for player scouting and talent identification.', null),
('Sports Psychology', 'Psychological principles in sports and athletics.', null),
('Languages', 'Study of various languages and their structures.', null),
('Fitness Coaching', 'Training methods for physical fitness improvement.', null),
('Sports Analysis', 'Analysis and interpretation of sports performance data.', null),
('Cashier management', 'learn how to use cash register', null),
('cleaning', 'learn how to clean properly', null),
('cooking', 'learn how to cook', null),
('Food Analysis', 'Learn how to differenciate good from bad', null),
('frying', 'learn how to fry', null),
('HR management', 'HR employee management', null),
('management', 'managing employees', null),
('Serving', 'proper serving', null);

INSERT INTO requires VALUES 
(1, 'Coaching'),  
(2, 'Physiotherapy'),  
(3, 'Marketing Management'),  
(4, 'Scouting'),  
(5, 'Sports Psychology'),  
(6, 'Scouting'), 
(7, 'Fitness Coaching'),  
(8, 'Sports Analysis'),
(1, 'Cashier management'),
(2, 'cleaning'),
(3, 'cooking'),
(4, 'Food Analysis'),
(5, 'frying'),
(6, 'HR management'),
(7, 'management'),
(8, 'Serving');
	
CALL rand_times();
