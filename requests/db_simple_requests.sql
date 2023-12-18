Use MusicDB

SELECT [Name], ReleaseDate
FROM Song
WHERE ReleaseDate = '1998-11-05'

SELECT
[Name] + '(' + [Text] + ')' AS SongText,
Duration
FROM Song
WHERE [Text] IS NOT NULL

SELECT DISTINCT ReleaseDate
FROM Album

SELECT TOP 3 
[Name]
FROM Playlist
ORDER BY [Name] DESC

SELECT [Name], Id
FROM Artist 
ORDER BY [Name] 
	OFFSET 5 ROWS
	FETCH NEXT 7 ROWS ONLY

SELECT [Name]
FROM [Label]
WHERE [Name] LIKE '%ac%'

SELECT [User].Username, Account.Bio, Account.CreatedAt
FROM [User] 
	INNER JOIN Account ON [User].Id = Account.UserId
WHERE Account.CreatedAt BETWEEN '2016-01-01' AND '2023-01-01'

SELECT DISTINCT [Username]
FROM [User]
ORDER BY [Username] DESC
