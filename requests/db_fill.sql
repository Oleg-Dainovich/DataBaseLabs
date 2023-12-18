Use MusicDB

INSERT INTO [User] (Username, Email, PasswordHash, CreatedAt, UpdatedAt) VALUES
('Oleg', 'ol@gmail.com', '12345', '2020-10-01', '2023-02-10'),
('Igor', 'ig@gmail.com', '11111', '2021-02-22', '2023-01-01');
INSERT INTO [User] (Username, Email, PasswordHash, CreatedAt) VALUES
('Zahar', 'za@mail.ru', '54321', '2010-11-11');
INSERT INTO [User] (Username, Email, PasswordHash) VALUES
('Ilya', 'il@mail.ru', '00000');


INSERT INTO Account (UserId, Bio, CreatedAt, UpdatedAt) VALUES
(11, 'cool man', '2022-12-12', '2022-12-22'),
(12, 'not so cool man', '2021-10-10', '2021-12-01');
INSERT INTO Account (UserId, Bio, CreatedAt) VALUES
(13, 'vot ti govorish gorod sila, a tut slabie vse', '2015-03-03');
INSERT INTO Account (UserId) VALUES
(14);


INSERT INTO [Notification] (AccountId, [Message], SentAt, SeenAt) VALUES
(1, 'wassup', '2023-10-03', '2023-10-03'),
(4, 'welcome, user!', '2023-09-25', '2023-09-26');
INSERT INTO [Notification] (AccountId, [Message], SentAt) VALUES
(2, 'never gonna give you up', '2023-10-01'),
(3, 'never gonna let u down', '2023-10-20');
INSERT INTO [Notification] (AccountId, [Message]) VALUES
(3, 'maaaaaaan'),
(1, 'last christmass i gave u my heart');


INSERT INTO Subscription (AccountId, StartDate, EndDate) VALUES 
(1, '2023-10-30', '2023-11-30'),
(3, '2023-10-25', '2023-11-25'),
(4, '2023-10-08', '2023-11-08');


INSERT INTO Playlist (AccountId, [Name], Duration, CreatedAt, UpdatedAt) VALUES
(1, 'Solyanka', '01:45:23', '2022-09-01', '2023-02-02'),
(2, 'scheize', '00:54:36', '2023-05-01', '2023-10-10'),
(4, 'hobbyhorsing', '02:32:11', '2023-08-11', '2023-10-15');
INSERT INTO Playlist (AccountId, [Name], Duration, CreatedAt) VALUES
(3, 'kvadrobika', '01:11:11', '2023-01-02'),
(1, 'smeshariki_hardstyle', '23:12:34', '2023-09-08'),
(1, 'badass', '10:46:12', '2023-10-29');


INSERT INTO Genre ([Name], [Description]) VALUES
('Rock', 'EEEEEE POK'),
('Rap', 'hi my name is'),
('Techno', 'magic people voodoo people'),
('Punk', 'rep govno popsa parasha panki hoi pobeda nasha');
INSERT INTO Genre ([Name]) VALUES
('Pop'),
('Alternative'),
('Indie');


INSERT INTO [Label] ([Name], [Description], ProfitShare) VALUES
('Gazgolder', 'moya igra moya igra ona mne prinadlezhit i takim zhe kak i ya', 20.34),
('BookingMachine', 'ya prishel suda chisto po fanu', 15.10);
INSERT INTO Label ([Name], ProfitShare) VALUES
('BlackStar', 99.99),
('SonyMusic', 45.00),
('АНТИХАЙП', 5.00);


INSERT INTO Artist (LabelId, [Name], Bio) VALUES
(4, 'Michael Jackson', 'ladit s detmi'),
(2, 'Oxxxymiron', 'я все это хаваю у меня нет выбора'),
(3, 'Тимати', 'хлопнул бургер'),
(5, 'Слава КПСС', 'luchshe ya sdohnu e**chim nouneimom');
INSERT INTO Artist (LabelId, [Name]) VALUES
(4, 'GONE.Fludd'),
(1, 'Витя АКА'),
(5, 'Бутер Бродский'),
(5, 'Валентин Дядька');
INSERT INTO Artist ([Name]) VALUES
('Beatles'),
('Гражданская Оборона'),
('Паша Техник'),
('Prodigy'),
('Yann Tiersen');
INSERT INTO Artist ([Name], Bio) VALUES
('Radiohead', 'im a creep'),
('Макулатура', 'крутые ребята'),
('Сплин', 'Александр Васильев отличный поэт');


INSERT INTO Album ([Name], ArtistId, ReleaseDate, Duration) VALUES
('Thriller',1 ,'1999-01-10', '02:02:01'),
('Вечный жид',2 ,'1999-01-10', '02:02:01'),
('Красота и уродство',2 ,'1999-01-10', '02:02:01'),
('the boss',3 ,'1999-01-10', '02:02:01'),
('Antihypetrain',4 ,'1999-01-10', '02:02:01'),
('Boys Dont Cry',5 ,'2010-05-15', '01:34:06'),
('Жирный',6 ,'2010-05-15', '01:34:06'),
('Катафалка',7 ,'2010-05-15', '01:34:06'),
('Говорят чо',8 ,'2010-05-15', '01:34:06'),
('Abbey Road',9 ,'2010-05-15', '01:34:06'),
('Yellow Submarine',9 ,'1970-07-23', '10:11:12'),
('Revolver',9 ,'1970-07-23', '10:11:12'),
('Help!',9 ,'1970-07-23', '10:11:12'),
('Зачем Снятся Сны',10 ,'1970-07-23', '10:11:12'),
('Здорово и вечно',10 ,'1970-07-23', '10:11:12'),
('Мышеловка',10 ,'1991-11-11', '20:19:18'),
('Блёвбургер',11 ,'1991-11-11', '20:19:18'),
('Doroga v oblaka',11 ,'1991-11-11', '20:19:18'),
('The Fat of The Land',12 ,'1991-11-11', '20:19:18'),
('Le Phare',13 ,'1991-11-11', '20:19:18'),
('OK Computer',14 ,'2000-12-12', '15:15:15'),
('Лимб',15 ,'2000-12-12', '15:15:15'),
('Сеанс',15 ,'2000-12-12', '15:15:15'),
('Гранатовый альбом',16 ,'2000-12-12', '15:15:15'),
('Сигнал из космоса',16 ,'2000-12-12', '15:15:15');


 INSERT INTO Song (AlbumId, GenreId, [Name], Duration, [Text], ReleaseDate) VALUES
 (11, 5, 'Come Together', '00:03:50', 'text1', '2007-12-12'),
 (11, 5, 'Here Comes The Sun', '00:03:50', 'text2', '2007-12-12'),
 (22, 6, 'Carma Police', '00:03:50', 'text3', '2007-12-12'),
 (22, 6, 'Paranoid Android', '00:03:50', 'text4', '1998-11-05'),
 (22, 6, 'Lucky', '00:03:50', 'text5', '1998-11-05'),
 (25, 1, 'Весь этот бред', '00:03:33', 'text6', '1998-11-05'),
 (25, 1, 'Орбит без сахара', '00:03:33', 'text7', '1998-11-05');
  INSERT INTO Song (AlbumId, GenreId, [Name], Duration, ReleaseDate) VALUES
 (11, 5, 'Octopuss Garden', '00:03:33', '1998-11-05'),
 (11, 5, 'Sun King', '00:04:01', '2003-03-03'),
 (22, 6, 'No Surprises', '00:04:01', '2003-03-03'),
 (25, 1, 'Выхода нет', '00:04:01', '2003-03-03');


INSERT INTO Song_And_Playlist (SongId, PlaylistId) VALUES 
(14, 24),
(15, 25),
(20, 26),
(24, 27),
(16, 26),
(17, 28),
(18, 29),
(23, 24),
(22, 25);


INSERT INTO Song_And_Artist(SongId, ArtistId) VALUES 
(14, 9), (15, 9), (16, 14), (18, 14), (19, 16), (20, 9), (21, 9), (23, 10),
(14, 4), (15, 4), (17, 14), (18, 13), (19, 16), (20, 14), (22, 14), (23, 16);
