Use MusicDB

SELECT Playlist.[Name] AS PlaylistName, Genre.[Name] AS GenreName,
COUNT(Genre.Id) AS GenreCount
FROM Playlist
INNER JOIN Song_And_Playlist ON Playlist.Id = Song_And_Playlist.PlaylistId
INNER JOIN Song ON Song.Id = Song_And_Playlist.SongId
INNER JOIN Genre ON Genre.Id = Song.GenreId
GROUP BY Playlist.[Name], Genre.[Name]
ORDER BY Playlist.[Name]

SELECT PlaylistName, GenreName, Popularity
FROM (
SELECT Playlist.[Name] AS PlaylistName, 
Genre.[Name] AS GenreName,
FIRST_VALUE(COUNT(Genre.Id)) 
	OVER (PARTITION BY Playlist.[Name] ORDER BY Playlist.[Name], COUNT(Genre.Id) DESC) AS Popularity,
ROW_NUMBER() 
	OVER (PARTITION BY Playlist.[Name] ORDER BY Playlist.[Name]) AS RowNum
FROM Playlist
INNER JOIN Song_And_Playlist ON Playlist.Id = Song_And_Playlist.PlaylistId
INNER JOIN Song ON Song.Id = Song_And_Playlist.SongId
INNER JOIN Genre ON Genre.Id = Song.GenreId
GROUP BY Playlist.[Name], Genre.[Name]
) AS SubRequest
WHERE RowNum = 1
