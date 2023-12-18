 CREATE OR ALTER PROCEDURE InsertNewAccountProc (@Id INT, @CreatedAt DATE)
 AS 
 BEGIN     
    INSERT INTO Account (UserId, CreatedAt)
    VALUES (@Id, @CreatedAt);
END

CREATE OR ALTER TRIGGER InsertNewAccount ON [User]
AFTER INSERT 
AS
BEGIN 
	CREATE TABLE #InsertedData (
        Id INT,
        CreatedAt DATE
    );
	INSERT INTO #InsertedData (Id, CreatedAt)
    SELECT Id, CreatedAt
    FROM inserted;

	DECLARE @Id INT
	DECLARE @CreatedAt DATE
	DECLARE cursorInsert CURSOR FOR
    SELECT Id, CreatedAt
    FROM #InsertedData;

	OPEN cursorInsert;
    FETCH NEXT FROM cursorInsert INTO @Id, @CreatedAt;

	WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Вызов процедуры для каждой строки
        EXEC InsertNewAccountProc @Id, @CreatedAt;
        
        FETCH NEXT FROM cursorInsert INTO @Id, @CreatedAt;
    END
    
    CLOSE cursorInsert;
    DEALLOCATE cursorInsert;

    DROP TABLE #InsertedData;
END

--INSERT INTO [User] (Username, Email, PasswordHash, CreatedAt) VALUES
--('test8', 'test8@mail.ru', 'testpass8', CAST(GETDATE() AS DATE)), 
--('test9', 'test9@mail.ru', 'testpass9', CAST(GETDATE() AS DATE))
	
 CREATE OR ALTER PROCEDURE UpdateUserProc (@UserId INT, @UpdatedAt DATE)
 AS 
 BEGIN     
    UPDATE [User]
	SET UpdatedAt = @UpdatedAt 
	WHERE Id = @UserId
END

CREATE OR ALTER TRIGGER UpdateUser ON [Account]
AFTER UPDATE
AS 
BEGIN 
	CREATE TABLE #InsertedData (
        UserId INT,
        UpdatedAt DATE
    );
	INSERT INTO #InsertedData (UserId, UpdatedAt)
    SELECT UserId, UpdatedAt
    FROM inserted;

	DECLARE @UserId INT
	DECLARE @UpdatedAt DATE
	DECLARE cursorInsert CURSOR FOR
    SELECT UserId, UpdatedAt
    FROM #InsertedData;

	OPEN cursorInsert;
    FETCH NEXT FROM cursorInsert INTO @UserId, @UpdatedAt;

	WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Вызов процедуры для каждой строки
        EXEC UpdateUserProc @UserId, @UpdatedAt;
        
        FETCH NEXT FROM cursorInsert INTO @UserId, @UpdatedAt;
    END
    
    CLOSE cursorInsert;
    DEALLOCATE cursorInsert;

    DROP TABLE #InsertedData;
END

UPDATE Account 
SET Bio = 'test bio', UpdatedAt = CAST(GETDATE() AS DATE)
WHERE Id = 10

CREATE OR ALTER PROCEDURE UpdateAlbumDurationProc (@AlbumId INT)
AS 
BEGIN 
	DECLARE @DurationSum FLOAT
	SELECT @DurationSum = (SELECT SUM(Duration) FROM Song WHERE AlbumId = @AlbumId)
	IF @DurationSum IS NULL
		UPDATE Album
		SET Duration = 0
		WHERE @AlbumId = Id
	ELSE
		UPDATE Album
		SET Duration = @DurationSum
		WHERE @AlbumId = Id
END

CREATE OR ALTER TRIGGER UpdateAlbumDurationAfterInsert ON Song
AFTER INSERT
AS 
BEGIN 
	CREATE TABLE #InsertedData (
        AlbumId INT
    );
	INSERT INTO #InsertedData (AlbumId)
    SELECT AlbumId
    FROM inserted;

	DECLARE @AlbumId INT
	DECLARE cursorInsert CURSOR FOR
    SELECT AlbumId
    FROM #InsertedData;

	OPEN cursorInsert;
    FETCH NEXT FROM cursorInsert INTO @AlbumId;

	WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Вызов процедуры для каждой строки
        EXEC UpdateAlbumDurationProc @AlbumId;
        
        FETCH NEXT FROM cursorInsert INTO @AlbumId;
    END
    
    CLOSE cursorInsert;
    DEALLOCATE cursorInsert;

    DROP TABLE #InsertedData;
END

--INSERT INTO Song (AlbumId, GenreId, [Name], Duration, ReleaseDate) VALUES
-- (28, 5, 'test song3', '9999.99', '1111-11-11'),
-- (28, 5, 'test song4', '1.11', '1111-11-11')

CREATE OR ALTER TRIGGER UpdateAlbumDurationAfterDelete ON Song
AFTER DELETE
AS 
BEGIN 
	CREATE TABLE #DeletedData (
        AlbumId INT
    );
	INSERT INTO #DeletedData (AlbumId)
    SELECT AlbumId
    FROM deleted;

	DECLARE @AlbumId INT
	DECLARE cursorInsert CURSOR FOR
    SELECT AlbumId
    FROM #DeletedData;

	OPEN cursorInsert;
    FETCH NEXT FROM cursorInsert INTO @AlbumId;

	WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Вызов процедуры для каждой строки
        EXEC UpdateAlbumDurationProc @AlbumId;
        
        FETCH NEXT FROM cursorInsert INTO @AlbumId;
    END
    
    CLOSE cursorInsert;
    DEALLOCATE cursorInsert;

    DROP TABLE #DeletedData;
END

--DELETE FROM Song
--WHERE Id = 36

CREATE OR ALTER PROCEDURE UpdateArtistProfitProc (@LabelId INT)
AS 
BEGIN
	DECLARE @ProfitShare FLOAT
	SELECT @ProfitShare = (SELECT ProfitShare FROM [Label] WHERE Id = @LabelId)
	UPDATE Artist
	SET Profit = Profit - Profit * @ProfitShare / 100
	WHERE LabelId = @LabelId AND Profit IS NOT NULL
END

CREATE OR ALTER TRIGGER UpdateArtistProfit ON [Label]
AFTER UPDATE
AS
BEGIN
CREATE TABLE #InsertedData (
        Id INT
    );
	INSERT INTO #InsertedData (Id)
    SELECT Id
    FROM inserted;

	DECLARE @Id INT
	DECLARE cursorInsert CURSOR FOR
    SELECT Id
    FROM #InsertedData;

	OPEN cursorInsert;
    FETCH NEXT FROM cursorInsert INTO @Id;

	WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Вызов процедуры для каждой строки
        EXEC UpdateArtistProfitProc @Id;
        
        FETCH NEXT FROM cursorInsert INTO @Id;
    END
    
    CLOSE cursorInsert;
    DEALLOCATE cursorInsert;

    DROP TABLE #InsertedData;
END

--UPDATE [Label]
--SET ProfitShare = 15.15
--WHERE Id = 4