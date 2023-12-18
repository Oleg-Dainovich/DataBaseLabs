Use MusicDB

SELECT [User].Username, Account.Bio, Account.CreatedAt
FROM [User] 
	INNER JOIN Account ON [User].Id = Account.UserId
WHERE Account.CreatedAt BETWEEN '2016-01-01' AND '2023-01-01'
GROUP BY [User].Username, Account.Bio, Account.CreatedAt
HAVING Account.Bio IS NOT NULL

SELECT Song.[Name], Album.[Name]
FROM Song
	FULL JOIN Album ON Song.AlbumId = Album.Id 

SELECT Artist.[Name], [Label].Id, Album.[Name],
	SUM([Label].ProfitShare) AS AvgProfitShare
FROM Artist 
	LEFT JOIN [Label] ON Artist.LabelId = [Label].Id
	RIGHT JOIN Album ON Artist.Id = Album.ArtistId
	GROUP BY Artist.[Name], [Label].Id, Album.[Name]

SELECT [Name], COUNT(*) AS count_names
FROM Playlist
GROUP BY [Name]
HAVING COUNT(*) > 1

SELECT Album.[Name], Album.ReleaseDate, Artist.[Name]
FROM Album
JOIN Artist ON Album.ArtistId = Artist.Id
WHERE DATEDIFF(day, Album.ReleaseDate, CAST(GETDATE() AS DATE)) > 
	(SELECT AVG(DATEDIFF(day, Album.ReleaseDate, CAST(GETDATE() AS DATE)))
	FROM Album)

SELECT [Name], Duration,
ROW_NUMBER() OVER (
	PARTITION BY [Name]
	ORDER BY [Name]
) AS [Row]
FROM Playlist

SELECT [Name]
FROM Playlist
UNION ALL
SELECT Username
FROM [User]

SELECT TOP 1 [Name], 'В составе лейбла' AS Answer
FROM Artist
WHERE EXISTS (
	SELECT *
	FROM Artist
	WHERE Artist.LabelId IS NOT NULL
) AND Artist.LabelId IS NOT NULL
ORDER BY [Name]

SELECT [Name],
CASE
	WHEN LabelId IS NOT NULL THEN 'В составе лейбла'
	ELSE 'Не в лейбле'
	END AS Label_Belong
FROM Artist

--SET SHOWPLAN_TEXT ON;
--GO

--SELECT *
--FROM [User];

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Test') 
	CREATE TABLE Test (
		row1 VARCHAR(20),
		row2 VARCHAR(20)
	);
ELSE 
	PRINT 'Table already exists';

INSERT INTO Test (row1, row2)
SELECT Username, Email
FROM [User]
