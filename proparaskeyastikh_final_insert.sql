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
('pogba6', 'password12', 'Paul', 'Pogba', '2016-06-14 21:00:00', 'paul.pogba@gmail.com');

INSERT INTO etaireia VALUES 
('278291092', 'A', 'Manchester United', '2610123456', 'Amerikhs', 23, 'Patras', 'Greece'),
('864267923', 'B', 'FC Bayern', '2610789123', 'Mezonos', 45, 'Patras', 'Greece'),
('456789012', 'C', 'Real Madrid', '2610345678', 'Agiou Nikolaou', 12, 'Patras', 'Greece');

INSERT INTO evaluator VALUES 
('messi10', 15, '278291092'), 
('ronaldo7', 20, '864267923'), 
('neymarjr11', 5, '456789012'), 
('modric10', 10, '278291092'), 
('salah11', 8, '864267923'), 
('kane9', 12, '456789012'); 

INSERT INTO job VALUES 
(NULL, '2016-03-15', 35000, 'Head Coach', 'Amerikhs 23, Patras, Greece', 'messi10', '2016-03-01 08:00:00', '2016-04-01'),
(NULL, '2017-08-22', 25000, 'Physiotherapist', 'Mezonos 45, Patras, Greece', 'ronaldo7', '2017-08-15 10:30:00', '2017-09-15'),
(NULL, '2019-05-10', 30000, 'Marketing Manager', 'Agiou Nikolaou 12, Patras, Greece', 'neymarjr11', '2019-05-01 12:15:00', '2019-06-01'),
(NULL, '2016-11-28', 38000, 'Head of Scouting', 'Amerikhs 23, Patras, Greece', 'modric10', '2016-11-15 14:45:00', '2016-12-15'),
(NULL, '2018-06-05', 32000, 'Team Psychologist', 'Mezonos 45, Patras, Greece', 'salah11', '2018-05-30 17:30:00', '2018-07-01'),
(NULL, '2015-10-19', 27000, 'Scout', 'Agiou Nikolaou 12, Patras, Greece', 'kane9', '2015-10-01 20:00:00', '2015-11-01'),
(NULL, '2020-02-15', 20000, 'Fitness Coach', 'Amerikhs 23, Patras, Greece', 'mbappe7', '2020-02-01 09:30:00', '2020-03-01'),
(NULL, '2017-12-08', 30000, 'Sports Analyst', 'Mezonos 45, Patras, Greece', 'kroos8', '2017-11-30 11:15:00', '2018-01-01');

INSERT INTO employee VALUES 
('mbappe7', 'Young and talented forward with speed and technical skills. World Cup winner with France.', 'L.o.R from Didier Deschamps.', 'UEFA Pro License'),
('kroos8', 'Midfield maestro known for passing accuracy. Key player for Real Madrid and Germany.', 'L.o.R from Zinedine Zidane.', 'UEFA Pro License'),
('debruyne17', 'Versatile midfielder with excellent vision. A key figure for Manchester City and Belgium.', 'L.o.R from Pep Guardiola.', 'UEFA Pro License'),
('lewandowski9', 'Prolific striker, goal-scoring machine. A leader for Bayern Munich and Poland national team.', 'L.o.R from Hansi Flick.', 'UEFA Pro License'),
('hazard10', 'Skillful winger with flair. Played for Chelsea and Real Madrid. Known for his dribbling.', 'L.o.R from Carlo Ancelotti.', 'UEFA Pro License'),
('pogba6', 'Dynamic midfielder with physical presence. A World Cup winner with France.', 'L.o.R from Didier Deschamps.', 'UEFA Pro License');

INSERT INTO applies VALUES 
('mbappe7', 1), 
('kroos8', 2),
('debruyne17', 3), 
('lewandowski9', 4),  
('hazard10', 5), 
('pogba6', 6);  

INSERT INTO subject VALUES 
('Coaching', 'Skills and techniques for coaching sports teams.', 'unknown'),
('Physiotherapy', 'Physical therapy and rehabilitation techniques.', 'Coaching'),
('Marketing Management', 'Management principles applied to marketing.', 'unknown'),
('Scouting', 'Techniques for player scouting and talent identification.', 'unknown'),
('Sports Psychology', 'Psychological principles in sports and athletics.', 'unknown'),
('Languages', 'Study of various languages and their structures.', 'unknown'),
('Fitness Coaching', 'Training methods for physical fitness improvement.', 'Sports Analysis'),
('Sports Analysis', 'Analysis and interpretation of sports performance data.', 'unknown');

INSERT INTO requires VALUES 
(1, 'Coaching'),  
(2, 'Physiotherapy'),  
(3, 'Marketing Management'),  
(4, 'Scouting'),  
(5, 'Sports Psychology'),  
(6, 'Scouting'), 
(7, 'Fitness Coaching'),  
(8, 'Sports Analysis');  

INSERT INTO languages VALUES 
('mbappe7', 'FR,EN'),  
('kroos8', 'GE,EN'),
('debruyne17', 'EN,FR,GE'),  
('pogba6', 'FR,EN,SP'); 

INSERT INTO project VALUES 
('mbappe7', 1, 'Injury Prevention Course', 'https://www.iman.com/injury_prevention'),
('kroos8', 2, 'Marketing Campaign', 'https://www.iman.com/marketing_campaign'),
('debruyne17', 3, 'Scouting South America', 'https://www.iman.com/scouting_sa'),
('lewandowski9', 4, 'Data Analysis Project', 'https://www.iman.com/data_analysis'),
('kroos8', 5, 'Graphic Design Project', 'https://www.iman.com/graphic_design'),
('pogba6', 6, 'Tactics Integration', 'https://www.iman.com/tactics_integration'),
('hazard10', 7, 'Football Coaching Program', 'https://www.iman.com/coaching_program');

INSERT INTO degree VALUES 
('Computer Science Bachelor', 'Stanford University', 'BSc'),
('Marketing Management Master', 'Harvard University', 'MSc'),
('Sports Psychology PhD', 'University of Manchester', 'PhD'),
('Graphic Design Bachelor', 'Paris-Sorbonne University', 'BSc'),
('Language Studies Master', 'University of Barcelona', 'MSc'),
('Data Analysis PhD', 'ETH Zurich', 'PhD');

INSERT INTO has_degree VALUES 
('Computer Science Bachelor', 'Stanford University', 'mbappe7', 2010, 8.2),
('Marketing Management Master', 'Harvard University', 'kroos8', 2015, 8.1),
('Sports Psychology PhD', 'University of Manchester', 'pogba6', 2005, 9.0),
('Language Studies Master', 'University of Barcelona', 'hazard10', 2018, 6.9);



    
    
    
	
	