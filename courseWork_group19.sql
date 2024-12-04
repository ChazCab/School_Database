--- Enum of dept ---
CREATE TYPE uni_type 
AS ENUM(
    'Educational', 
    'Business');
--- Enum of courses ---
CREATE Type level
AS ENUM(
    'Level 4',
    'Level 5',
    'Level 6',
    'Level 7'
);
--- departments ---
CREATE TABLE departments(
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    dept_type uni_type NOT NULL,
    dept_addr1 VARCHAR(50) NOT NULL,
    dept_addr2 VARCHAR(50),
    dept_building VARCHAR(60) NOT NULL,
    dept_postcode CHAR(8) NOT NULL
);
--- courses ---
CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY,
    dept_id INT NOT NULL,
    course_name VARCHAR(50),
    academic_level level,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
--- students ---
CREATE TABLE students(
    stu_id SERIAL PRIMARY KEY,
    course_id INT NOT NULL,
    stu_first_name VARCHAR(50) NOT NULL,
    stu_last_name VARCHAR(50) NOT NULL,
    stu_email VARCHAR(150) NOT NULL UNIQUE,
    stu_phone_number VARCHAR(15) NOT NULL UNIQUE,
    stu_coutry VARCHAR(60) NOT NULL,
    stu_addr1 VARCHAR(50) NOT NULL,
    stu_addr2 VARCHAR(50),
    stu_city VARCHAR(80) NOT NULL,
    stu_postcode CHAR(8) NOT NULL,
    stu_enroll_date DATE NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
--- modules ---
CREATE TABLE modules(
    module_id SERIAL PRIMARY KEY,
    module_name VARCHAR(100)
);
--- Intersection table between modules and courses ---
CREATE TABLE modules_courses(
    module_id INT NOT NULL,
    course_id INT NOT NULL,
    FOREIGN KEY (module_id) REFERENCES modules(module_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    PRIMARY KEY(module_id, course_id)
);
--- Intersaction table between modules and students ---
CREATE TABLE modules_grades(
    module_id INT NOT NULL,
    stu_id INT NOT NULL,
    cw_id INT NOT NULL,
    grade DECIMAL(5, 2),
    FOREIGN KEY (module_id) REFERENCES modules(module_id),
    FOREIGN KEY (stu_id) REFERENCES students(stu_id),
    PRIMARY KEY(module_id, stu_id, cw_id)
);
--- sessions ---
CREATE TABLE sessions(
    session_id SERIAL PRIMARY KEY,
    module_id INT NOT NULL,
    session_date DATE NOT NULL,
    session_time TIME NOT NULL,
    session_addr1 VARCHAR(50) NOT NULL,
    session_addr2 VARCHAR(50),
    session_building VARCHAR(50) NOT NULL,
    session_postcode CHAR(8) NOT NULL,
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);
--- attendances / sudent_session (between sessions and students) ---
CREATE TABLE attendances(
    stu_id INT NOT NULL,
    session_id INT NOT NULL,
    present BOOLEAN NOT NULL,
    FOREIGN KEY (stu_id) REFERENCES students(stu_id),
    FOREIGN KEY (session_id) REFERENCES sessions (session_id),
    PRIMARY KEY(stu_id, session_id)
);
--- staff_members ---
CREATE TABLE staff_members(
    staff_id SERIAL PRIMARY KEY,
    dept_id INT NOT NULL,
    staff_first_name VARCHAR(50) NOT NULL,
    staff_last_name VARCHAR(50) NOT NULL,
    staff_email VARCHAR(150) NOT NULL UNIQUE,
    staff_phone_number VARCHAR(15) NOT NULL UNIQUE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
--- roles ---
CREATE TABLE roles(
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);
--- Intersaction table between staff_members and roles ---
CREATE TABLE staff_roles(
    role_id INT NOT NULL,
    staff_id INT NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (staff_id) REFERENCES staff_members(staff_id),
    PRIMARY KEY(role_id, staff_id)
);
---Intersaction table between staff_members and sessions---
CREATE TABLE teachers_sessions(
    staff_id INT NOT NULL,
    session_id INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff_members(staff_id),
    FOREIGN KEY (session_id) REFERENCES sessions(session_id),
    PRIMARY KEY(staff_id, session_id)
);
---Insert in departments---
INSERT INTO departments(dept_name, dept_type, dept_addr1, dept_addr2, dept_building, dept_postcode)
VALUES
('Mathematics', 'Educational', 'Fieldstone Lane', '3rd Floor', 'Richmond', 'DS144BB'),
('Computing', 'Educational', 'Sutherland Center', NULL, 'Portland', 'TR168DC'),
('Humanities', 'Educational', 'Armistice Park', NULL, 'FTC', 'CH131C'),
('Arts', 'Educational', 'Porter Place', '4th Floor', 'Anglesea', 'GN133BD'),
('HR', 'Business', 'Hazelcrest Avenue', NULL, 'Park', 'SP129TD'),
('Finance', 'Business', 'Clove Parkway', NULL, 'Learning Center', 'BN223PS');
---Insert in staff_members---
INSERT INTO staff_members(dept_id, staff_first_name, staff_last_name, staff_email, staff_phone_number)
VALUES
----- Mathematics -----
(1, 'Roanne', 'Yexley', 'ryexley0@usda.gov', '196-323-6743'),
(1, 'Erma', 'MacAfee', 'emacafee1@google.ca', '336-386-3763'),
(1, 'Aggy', 'Gomar', 'agomar2@oracle.com', '607-531-8148'),
(1, 'Mead', 'Kleinmann', 'mkleinmann0@twitpic.com', '759-479-1097'),
(1, 'Martyn', 'Duprey', 'mduprey1@myspace.com', '421-458-7916'),
----- Computing -----
(2, 'Addy', 'Imlaw', 'aimlaw3@about.me', '352-974-7010'),
(2, 'Dinah', 'Weeke', 'dweeke4@clickbank.net', '564-854-8534'),
(2, 'Lana', 'MacRory', 'lmacrory5@twitter.com', '409-472-4206'),
(2, 'Jenelle', 'Dahlback', 'jdahlback2@biblegateway.com', '351-514-6881'),
(2, 'Daryl', 'Le Moucheux', 'dlemoucheux3@cloudflare.com', '820-609-2499'),
----- Humanities -----
(3, 'Audie', 'Krauze', 'akrauze6@tinyurl.com', '571-289-7950'),
(3, 'Gilburt', 'McMylor', 'gmcmylor7@tuttocitta.it', '256-867-4543'),
(3, 'Tuck', 'Cockran', 'tcockran8@nydailynews.com', '657-521-4391'),
(3, 'Rozele', 'Runcie', 'rruncie4@slideshare.net', '850-400-8250'),
(3, 'Christyna', 'Lorand', 'clorand5@oakley.com', '245-753-0779'),
----- Arts -----
(4, 'Kalie', 'Joincey', 'kjoincey9@psu.edu', '618-835-8027'),
(4, 'Silas', 'Klimuk', 'sklimuk0@statcounter.com', '659-307-4590'),
(4, 'Frayda', 'Grammer', 'fgrammer1@surveymonkey.com', '735-895-8053'),
(4, 'Dyane', 'Robertucci', 'drobertucci6@omniture.com', '603-929-2952'),
(4, 'Bastien', 'O''Hara', 'bohara7@ucoz.com', '368-517-6421'),
----- HR -----
(5, 'Marja', 'Deelay', 'mdeelay2@bloglines.com', '216-294-0738'),
(5, 'Wilona', 'McGarel', 'wmcgarel3@marriott.com', '488-664-1604'),
(5, 'Mikel', 'Pietruschka', 'mpietruschka4@google.es', '290-714-6428'),
(5, 'Eziechiele', 'Portsmouth', 'eportsmouth8@quantcast.com', '916-704-3075'),
(5, 'Faun', 'Munby', 'fmunby9@dion.ne.jp', '912-282-3780'),
----- Finance -----
(6, 'Christye', 'Seaward', 'cseaward5@1688.com', '263-909-8382'),
(6, 'Drake', 'Nairne', 'dnairne6@arstechnica.com', '968-159-3964'),
(6, 'Dill', 'Mickleburgh', 'dmickleburgh7@posterous.com', '459-275-2222'),
(6, 'Christel', 'Ricardot', 'cricardota@about.me', '739-539-9043'),
(6, 'Ibrahim', 'Muddiman', 'imuddimanb@about.me', '412-968-0486');
--- Insert roles ---
INSERT INTO roles(role_name)
VALUES
('Head Teacher'),
('Teacher'),
('Personal Tutor'),
('Business staff');
--- Insert staff_roles ---
INSERT INTO staff_roles(role_id, staff_id)
VALUES
----- Head Teachers ----
(1, 1), -- Mathematics --
(1, 6), -- Computing --
(1, 11), -- Humanities --
(1, 16), -- Arts --
----- Teachers -----
(2, 2), -- Mathematics --
(2, 3),
(2, 4),
(2, 5), 
(2, 6), -- Computing (Head Teacher as well) --
(2, 7), 
(2, 8),
(2, 9),
(2, 10), 
(2, 12), -- Humanities --
(2, 13),
(2, 14),
(2, 15), 
(2, 16), -- Arts (Head Teacher as well) --
(2, 17), 
(2, 18),
(2, 19),
(2, 20), 
----- Personal Tutors -----
(3, 3), -- Mathematics --
(3, 7), -- Computing --
(3, 11), -- Humanities --
(3, 18), -- Arts --
----- Business Staffs -----
(4, 21), -- HR --
(4, 22), 
(4, 23),
(4, 24),
(4, 25),
(4, 26), -- Finance --
(4, 27), 
(4, 28),
(4, 29),
(4, 30); 
--- Insert in courses ---
INSERT INTO courses(dept_id, course_name, academic_level)
VALUES
----- Educational -----
(1, 'Mathematics with Machine Learning', 'Level 7'), -- Mathematics --
(1, 'Mathematics with Statistics', 'Level 6'),
(2, 'Software Engineering', 'Level 7'), -- Computing --
(2, 'Computer Science', 'Level 7'),
(3, 'Humanistic Counselling', 'Level 5'), -- Humanities --
(3, 'Humanistic Counselling Top-up', 'Level 4'),
(4, 'Fashion Design', 'Level 6'), -- Arts --
(4, 'Graphic Design', 'Level 6'),
----- Business -----
(5, NULL, NULL), -- HR --
(6, NULL, NULL); -- Finance -- 
--- Insert in modules ---
INSERT INTO modules(module_name)
VALUES
----- Mathematics -----
('Applications of Mathematics and Graduate Skills '), -- Both Courses --
('Applied Machine Learning and Data Mining'), -- Mathematics with Machine Learning --
('Statistical Theory and Methods'), -- Mathematics with Statistics --
----- Computing -----
('Data Structures and Algorithms'), -- Both Courses --
('Usability Engineering'), -- Software Engineering --
('Programming Applications And Programming Languages'), -- Computer Science --
----- Humanities -----
('Development of Counselling Skills'), -- Humanistic Counselling --
('Personal Development'), 
('Research Project'), -- Humanistic Counselling Top-up --
('Humanistic Advanced Counselling Skills'), 
----- Arts -----
('Core Skills Fashion and Textiles'), -- Fashion Design --
('Design Fundamentals'), 
('Introduction to Graphic Design'), -- Graphic Design --
('Introduction to Visual Culture');
--- Insert modules_courses ---
INSERT INTO modules_courses(module_id, course_id)
VALUES
----- Mathematics -----
(1, 1), -- Mathematics with Machine Learning --
(1, 2), -- Mathematics with Statistics --
(2, 1), -- Mathematics with Machine Learning --
(3, 2), -- Mathematics with Statistics --
----- Computing -----
(4, 3), -- Software Engineering --
(4, 4), -- Computer Science --
(5, 3), -- Software Engineering --
(6, 4), -- Computer Science --
----- Humanities -----
(7, 5), -- Humanistic Counselling --
(8, 5),
(9, 6), -- Humanistic Counselling Top-up --
(10, 6), 
----- Arts -----
(11, 7), -- Fashion Design --
(12, 7),
(13, 8), -- Graphic Design --
(14, 8);
--- Insert in students ---
INSERT INTO students(course_id, stu_first_name, stu_last_name, stu_email, stu_phone_number, stu_coutry, stu_addr1, stu_addr2, stu_city, stu_postcode, stu_enroll_date)
VALUES
----- Mathematics with Machine Learning -----
(1, 'Blanche', 'Vallance', 'bvallance0@fastcompany.com', '745-514-0880', 'United Kingdom', '6302 Warbler Park', NULL, 'Brampton', 'NR34', '2023-12-13'),
(1, 'Fidel', 'Kenrat', 'fkenrat1@goo.ne.jp', '414-592-4252', 'United Kingdom', '0086 Iowa Pass', '16th Floor', 'London', 'SW1E', '2023-09-16'),
----- Mathematics with Statistics -----
(2, 'Torey', 'Lacaze', 'tlacaze2@livejournal.com', '783-189-2813', 'United Kingdom', '57760 Graceland Hill', 'PO Box 49735', 'Denton', 'M34', '2023-11-22'),
(2, 'Leonidas', 'Izatt', 'lizatt3@51.la', '108-339-7968', 'United Kingdom', '305 Pearson Plaza', NULL, 'London', 'W1F', '2023-12-13'),
----- Software Engineering -----
(3, 'Gwenette', 'Tring', 'gtring4@patch.com', '489-822-0832', 'United Kingdom', '9 Erie Parkway', '16th Floor', 'Stapleford', 'LN6', '2023-11-22'),
(3, 'Lee', 'Fortey', 'lfortey5@alexa.com', '935-734-8272', 'United Kingdom', '5 Hintze Parkway', NULL, 'Halton', 'LS9', '2023-09-12'),
----- Computer Science -----
(4, 'Roberto', 'Mitchely', 'rmitchely6@youku.com', '495-380-0532', 'United Kingdom', '385 3rd Point', NULL, 'Newton', 'IV1', '2023-10-12'),
(4, 'Bonnibelle', 'Mauger', 'bmauger7@photobucket.com', '584-145-1734', 'United Kingdom', '65868 Fulton Park', NULL, 'Kirkton', 'KW10', '2023-09-09'),
----- Humanistic Counselling -----
(5, 'Gustave', 'Covendon', 'gcovendon8@creativecommons.org', '824-352-6326', 'United Kingdom', '780 Schmedeman Drive', NULL, 'Newtown', 'RG20', '2023-10-02'),
(5, 'Marga', 'Norssister', 'mnorssister9@ask.com', '460-704-7765', 'United Kingdom', '0 Cascade Alley', NULL, 'Langley', 'SG4', '2023-12-11'),
----- Humanistic Counselling Top-up -----
(6, 'Licha', 'Leaming', 'lleaminga@plala.or.jp', '937-393-8781', 'United Kingdom', '6 John Wall Crossing', 'Suite 77', 'Milton', 'NG22', '2023-11-25'),
(6, 'Jacynth', 'Bewsey', 'jbewseyb@ox.ac.uk', '522-135-1057', 'United Kingdom', '0230 Sunnyside Junction', 'Apt 1314', 'Belfast', 'BT2', '2023-10-27'),
----- Fashion Design -----
(7, 'Giustina', 'Yourell', 'gyourellc@free.fr', '795-809-7368', 'United Kingdom', '1742 Summer Ridge Point', NULL, 'Norton', 'S8', '2023-12-08'),
(7, 'Maribelle', 'Mabbs', 'mmabbsd@vistaprint.com', '950-704-5539', 'United Kingdom', '048 Sutherland Plaza', NULL, 'Milton', 'NG22', '2023-09-18'),
----- Graphic Design -----
(8, 'Isis', 'Flaherty', 'iflahertye@yahoo.com', '741-435-2699', 'United Kingdom', '316 Red Cloud Terrace', 'PO Box 55520', 'Craigavon', 'BT66', '2023-12-21'),
(8, 'Goldie', 'Chezelle', 'gchezellef@blinklist.com', '112-378-9749', 'United Kingdom', '4 Shopko Crossing', 'PO Box 1362', 'Hatton', 'CV35', '2023-09-15'),
----- Mathematics with Machine Learning -----
(1, 'Shalne', 'Gianasi', 'sgianasi0@geocities.com', '151-959-7918', 'United Kingdom', '0679 Eastwood Road', NULL, 'Preston', 'PR1', '2024-04-15'),
(1, 'Crissie', 'Tumioto', 'ctumioto1@bigcartel.com', '237-697-0877', 'United Kingdom', '9766 Stang Park', 'Apt 1764', 'Dean', 'OX7', '2023-12-29'),
----- Mathematics with Statistics -----
(2, 'Gayle', 'Kenlin', 'gkenlin2@ezinearticles.com', '770-958-3164', 'United Kingdom', '4 Bultman Drive', NULL, 'Wirral', 'CH48', '2024-05-30'),
(2, 'Liza', 'Titcumb', 'ltitcumb3@privacy.gov.au', '509-452-3797', 'United Kingdom', '7 Fallview Point', 'Room 1160', 'Kinloch', 'PH43', '2024-02-17'),
----- Software Engineering -----
(3, 'Hirsch', 'Gunderson', 'hgunderson4@uol.com.br', '447-293-2222', 'United Kingdom', '570 Kedzie Plaza', '18th Floor', 'Belfast', 'BT2', '2024-04-01'),
(3, 'Noell', 'Shawyer', 'nshawyer5@hugedomains.com', '670-545-2424', 'United Kingdom', '7155 South Street', NULL, 'Dean', 'OX7', '2024-03-24'),
----- Computer Science -----
(4, 'Artair', 'Jorio', 'ajorio6@zdnet.com', '690-289-2820', 'United Kingdom', '6695 Mandrake Point', NULL, 'Sheffield', 'S33', '2024-01-15'),
(4, 'Salvatore', 'Pfeffle', 'spfeffle7@imgur.com', '705-985-5420', 'United Kingdom', '79 American Terrace', NULL, 'Tullich', 'AB55', '2024-03-17'),
----- Humanistic Counselling -----
(5, 'Gweneth', 'Fargie', 'gfargie8@nih.gov', '969-731-0546', 'United Kingdom', '7832 Mcbride Plaza', 'PO Box 32272', 'Wootton', 'NN4', '2024-04-06'),
(5, 'Bendicty', 'Storms', 'bstorms9@wp.com', '550-985-3261', 'United Kingdom', '40 La Follette Court', NULL, 'Upton', 'DN21', '2024-03-12'),
----- Humanistic Counselling Top-up -----
(6, 'Charles', 'Becom', 'cbecoma@accuweather.com', '664-463-9272', 'United Kingdom', '5 Farragut Junction', NULL, 'Aberdeen', 'AB39', '2023-11-05'),
(6, 'Noelle', 'Lapides', 'nlapidesb@washington.edu', '943-576-6554', 'United Kingdom', '99 Magdeline Place', NULL, 'Birmingham', 'B12', '2024-02-06'),
----- Fashion Design -----
(7, 'Arabelle', 'Widdowes', 'awiddowesc@telegraph.co.uk', '413-522-0104', 'United Kingdom', '6 Glendale Place', 'Suite 67', 'Sutton', 'RH5', '2023-10-21'),
(7, 'Marney', 'Bertomeu', 'mbertomeud@shutterfly.com', '409-937-0277', 'United Kingdom', '84 Hazelcrest Parkway', 'Suite 75', 'Halton', 'LS9', '2024-01-12'),
----- Graphic Design -----
(8, 'Jean', 'Munnings', 'jmunningse@gov.uk', '507-236-3553', 'United Kingdom', '6 Swallow Junction', '6th Floor', 'Thorpe', 'BD23', '2024-04-19'),
(8, 'Eustace', 'Reiglar', 'ereiglarf@weibo.com', '609-430-7197', 'United Kingdom', '8582 Fairfield Center', NULL, 'Bradford', 'BD7', '2024-05-19');
--- Insert in modules_grades ---
INSERT INTO modules_grades(module_id, stu_id, cw_id, grade)
VALUES
----- Module 1 -----
(1, 1, 1, 80.35), -- Mathematics with Machine Learning cw 1 --
(1, 2, 1, 75.00),
(1, 17, 1, 60.00),
(1, 18, 1, 60.00),
(1, 3, 1, 40.25), -- Mathematics with Statistics cw 1 --
(1, 4, 1, 60.00),
(1, 19, 1, 75.00),
(1, 20, 1, 75.00),
----- Module 2 -----
(2, 1, 1, 95.50), -- Mathematics with Machine Learning cw 1 --
(2, 2, 1, 70.00),
(2, 17, 1, 70.00),
(2, 18, 1, 100.00),
(2, 1, 2, 55.50), -- Mathematics with Machine Learning cw 2 --
(2, 2, 2, 65.00),
(2, 17, 2, 90.00),
(2, 18, 2, 75.00),
----- Module 3 -----
(3, 3, 1, 40.25), -- Mathematics with Statistics  cw 1 --
(3, 4, 1, 60.00),
(3, 19, 1, 60.00),
(3, 20, 1, 60.00),
(3, 3, 2, 100.00), -- Mathematics with Statistics  cw 2 --
(3, 4, 2, 39.00),
(3, 19, 2, 60.00),
(3, 20, 2, 60.00),
----- Module 4 -----
(4, 5, 1, 85.00), -- Software Engineering cw 1 --
(4, 6, 1, 60.00),
(4, 21, 1, 60.00),
(4, 22, 1, 80.00),
(4, 7, 1, 45.00), -- Computer Science cw 1 --
(4, 8, 1, 60.50),
(4, 23, 1, 55.00),
(4, 24, 1, 60.50),
----- Module 5 -----
(5, 5, 1, 85.00), -- Software Engineering cw 1 --
(5, 6, 1, 60.00),
(5, 21, 1, 65.00), 
(5, 22, 1, 86.00),
(5, 5, 2, 46.00), -- Software Engineering cw 2 --
(5, 6, 2, 76.40),
(5, 21, 2, NULL),
(5, 22, 2, NULL),                               
----- Module 6 -----
(6, 7, 1, 66.00), -- Computer Science cw 1 --
(6, 8, 1, 67.50),
(6, 23, 1, 90.00),
(6, 24, 1, 90.00),
(6, 7, 2, 60.50), -- Computer Science cw 2 --
(6, 8, 2, 45.00), 
(6, 23, 2, NULL),
(6, 24, 2, NULL),                          
----- Module 7 -----
(7, 9, 1, 65.00), -- Humanistic Counselling cw 1 --
(7, 10, 1, 65.00),
(7, 25, 1, 97.50),
(7, 26, 1, 97.50),
(7, 9, 2, 40.00), -- Humanistic Counselling cw 2 --
(7, 10, 2, 38.70), 
(7, 25, 2, NULL),
(7, 26, 2, NULL),                                
----- Module 8 -----
(8, 9, 1, 65.00), -- Humanistic Counselling cw 1 --
(8, 10, 1, 65.00),
(8, 27, 1, 88.40),
(8, 28, 1, 88.40),
(8, 9, 2, 40.00), -- Humanistic Counselling cw 2 --
(8, 10, 2, 38.70),
(8, 27, 2, NULL),
(8, 28, 2, NULL),              
----- Module 9 -----
(9, 11, 1, 40.00), -- Humanistic Counselling Top-up  cw 1--
(9, 12, 1, 100.00),
(9, 29, 1, 62.00),
(9, 30, 1, 30.00),
(9, 11, 2, 67.00), -- Humanistic Counselling Top-up cw 2 --
(9, 12, 2, 99.70),
(9, 29, 2, 77.27),
(9, 30, 2, 100.00),
----- Module 10 -----
(10, 11, 1, 55.00), -- Humanistic Counselling Top-up  cw 1--
(10, 12, 1, 66.66),
(10, 29, 1, 62.00),
(10, 30, 1, 30.00),                              
(10, 11, 2, 77.77), -- Humanistic Counselling Top-up cw 2 --
(10, 12, 2, 88.88),
(10, 29, 2, NULL),
(10, 30, 2, NULL), 
----- Module 11 -----
(11, 13, 1, 80.35), -- Fashion Design cw 1 --
(11, 14, 1, 75.00),
(11, 29, 1, 62.00),
(11, 30, 1, 30.00), 
(11, 13, 2, 40.25), -- Fashion Design cw 2 --
(11, 14, 2, 60.00),
(11, 29, 2, NULL),
(11, 30, 2, NULL), 
----- Module 12 -----
(12, 13, 1, 80.35), -- Graphic Design cw 1 --
(12, 14, 1, 75.00),
(12, 31, 1, 60.35), 
(12, 32, 1, 35.00),
(12, 13, 2, 40.25), -- Graphic Design cw 2 --
(12, 14, 2, 60.00),
(12, 31, 2, 80.35),
(12, 32, 2, 75.00),
----- Module 13 -----
(13, 15, 1, 40.00), -- Graphic Design cw 1 --
(13, 16, 1, 100.00),
(13, 31, 1, 80.35),
(13, 32, 1, 75.00),
(13, 15, 2, 67.00), -- Graphic Design cw 2 --
(13, 16, 2, 99.70),
(13, 31, 2, 28.35),
(13, 32, 2, 39.99),
----- Module 14 -----
(14, 15, 1, 35.00), -- Graphic Design cw 1 --
(14, 16, 1, 27.60),
(14, 31, 1, 88.35),
(14, 32, 1, 59.99),
(14, 15, 2, 87.00), -- Graphic Design cw 2 --
(14, 16, 2, 67.30),
(14, 31, 2, NULL),
(14, 32, 2, NULL);                     
--- Insert in sessions ---
INSERT INTO sessions(module_id, session_date, session_time, session_addr1, session_addr2, session_building, session_postcode)
VALUES
(1, '2024-03-16', '4:57:21 PM', '4 Spohn Court', 'Room 386', 'Portland', '3316'), -- Applications of Mathematics and Graduate Skills --
(2, '2024-08-30', '5:42:16 PM', '63687 Warrior Drive', NULL, 'Richmond', 'NR34'), -- Applied Machine Learning and Data Mining --
(3, '2023-08-06', '11:15:20 AM', '6986 Namekagon Drive', 'Room 1268', 'Richmond', '291 88'), -- Statistical Theory and Methods --
(4, '2023-06-08', '1:43:19 PM', '1 Kingsford Pass', NULL, 'Anglesea', '2970-187'), -- Data Structures and Algorithms --
(5, '2024-06-23', '11:16:18 AM', '525 Butterfield Center', 'Suite 32', 'Portland', 'C1B'), -- Usability Engineering --
(6, '2024-01-29', '5:26:04 PM', '9798 Oak Valley Avenue', '4th Floor', 'Richmond', 'CH131C'), -- Programming Applications And Programming Languages --
(7, '2024-04-08', '9:13:15 AM', '8 Florence Center', NULL, 'Anglesea', '2970-079'), -- Development of Counselling Skills --
(8, '2023-07-17', '1:34:51 PM', '8 Sachs Drive', NULL, 'Park', '833 24'), -- Personal Development --
(9, '2024-02-22', '5:46:52 PM', '5173 International Point', 'PO Box 758', 'Portland', 'DS1'), -- Research Project --
(10, '2023-11-20', '3:19:02 PM', '50 Pepper Wood Hill', 'Apt 1720', 'Park', '3224'), -- Humanistic Advanced Counselling Skills --
(11, '2023-08-12', '10:49:30 AM', '90 Stang Way', 'Room 1830', 'Anglesea', '832 47'), -- Core Skills Fashion and Textiles --
(12, '2023-07-11', '11:06:41 AM', '923 Ilene Park', 'PO Box 63275', 'Anglesea', 'TR15'), -- Design Fundamentals --
(13, '2024-05-23', '5:58:36 PM', '2 Rieder Lane', NULL, 'Park', '98-311'), -- Introduction to Graphic Design --
(14, '2024-06-16', '10:55:01 AM', '830 Kropf Park', 'Room 1263', 'Portland', 'HJ92'); -- ntroduction to Visual Culture --
--- Insert in attendances --- 
INSERT INTO attendances(stu_id, session_id, present)
VALUES
----- Mathematics -----
(1, 1, TRUE), -- session 1 --
(2, 1, TRUE),
(3, 1, FALSE),
(4, 1, FALSE),
(17, 1, TRUE),
(18, 1, TRUE),
(19, 1, FALSE),
(20, 1, TRUE),
(1, 2, TRUE), -- session 2 --
(2, 2, FALSE),
(17, 2, TRUE),
(18, 2, TRUE),
(3, 3, TRUE), -- session 3 --
(4, 3, TRUE),
(19, 3, TRUE),
(20, 3, TRUE),
----- Computing -----
(5, 4, TRUE), -- session 4 --
(6, 4, TRUE),
(7, 4, TRUE),
(8, 4, TRUE),
(21, 4, TRUE),
(22, 4, TRUE),
(23, 4, TRUE),
(24, 4, TRUE),
(5, 5, TRUE), -- session 5 --
(6, 5, FALSE),
(21, 5, TRUE),
(22, 5, FALSE),
(7, 6, TRUE), -- session 6 --
(8, 6, FALSE),
(23, 6, TRUE),
(24, 6, TRUE),
----- Humanities -----
(9, 7, TRUE), -- session 7 --
(10, 7, FALSE),
(25, 7, TRUE),
(26, 7, FALSE),
(9, 8, TRUE), -- session 8 --
(10, 8, TRUE),
(25, 8, FALSE),
(26, 8, FALSE),
(11, 9, TRUE), -- session 9 --
(12, 9, TRUE),
(27, 9, TRUE), 
(28, 9, TRUE),
(11, 10, TRUE), -- session 10 --
(12, 10, TRUE),
(27, 10, FALSE), 
(28, 10, TRUE),
----- Arts -----
(13, 11, TRUE), -- session 11 --
(14, 11, TRUE),
(29, 11, FALSE), 
(30, 11, TRUE),
(13, 12, TRUE), -- session 12 --
(14, 12, TRUE),
(29, 12, FALSE), 
(30, 12, TRUE),
(15, 13, FALSE), -- session 13 --
(16, 13, TRUE), 
(31, 13, FALSE), 
(32, 13, TRUE), 
(15, 14, FALSE), -- session 14 --
(16, 14, TRUE),
(31, 14, FALSE), 
(32, 14, TRUE);
--- Insert teachers-sessions ---
INSERT INTO teachers_sessions(staff_id, session_id)
VALUES
(2, 1), -- Mathematics --
(3, 2),
(4, 3),
(5, 2),
(6, 4), -- Computing --
(7, 5),
(8, 6),
(9, 6),
(10, 6),
(11, 7), -- Humanities --
(12, 8),
(13, 9),
(14, 10),
(15, 11), -- Arts --
(16, 12),
(17, 13),
(19, 13),
(18, 14),
(20, 14);