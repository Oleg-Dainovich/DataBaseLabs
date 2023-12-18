import pypyodbc
from datetime import datetime

# ===================================================================
# CONNECTION TO SQL SERVER

myServer = "DESKTOP-NF2VTMR\SQLEXPRESS"
myDB = "MusicDB"

sql = pypyodbc.connect('Driver={SQL Server};'
                       'Server=' + myServer + ';'
                       'Database=' + myDB + ';')


# ===================================================================

# ===================================================================
# AUTHORIZATION

def register_user():
    print("Registration:")
    username = input("Enter your username: ")
    email = input("Enter your email: ")
    password = input("Enter your password: ")

    try:
        cursor = sql.cursor()
        cursor.execute(
            "INSERT INTO [User] (Username, Email, PasswordHash, CreatedAt) VALUES (?, ?, ?, CAST(GETDATE() AS DATE))",
            (username, email, password))
        cursor.close()

        cursor1 = sql.cursor()
        cursor1.execute("SELECT Id FROM [User] WHERE Username = ? AND PasswordHash = ?", (username, password))
        user_id = cursor1.fetchone()
        cursor1.close()

        sql.commit()
        print(f"Registration successful! Your user ID is {user_id[0]}.")
        return user_id

    except Exception as e:
        print(f"Error: Unable to register user\n{e}")
        return None


def login_user():
    username = input("Enter your username: ")
    password = input("Enter your password: ")

    try:
        cursor = sql.cursor()
        cursor.execute("SELECT Id FROM [User] WHERE Username = ? AND passwordHash = ?", (username, password))
        user_id = cursor.fetchone()
        cursor.close()

        if user_id:
            print(f"Login successful! Your Id is {user_id[0]}.")
            return user_id
        else:
            print("Login failed. Invalid username or password.")
            return None

    except Exception as e:
        print(f"Error: Unable to log in\n{e}")
        return None


# ===================================================================

# ===================================================================
# VIEW FUNCTIONS

def view_profile(user_id):
    try:
        with sql.cursor() as cursor:
            cursor.execute("""SELECT Account.UserId, [User].Username, [User].Email, Account.Bio, Account.CreatedAt, [User].UpdatedAt
                                FROM [User] 
	                            INNER JOIN Account ON [User].Id = Account.UserId
	                            WHERE Account.UserId = ?
	                            GROUP BY Account.UserId, [User].Username, [User].Email, Account.Bio, Account.CreatedAt, [User].UpdatedAt""",
                           user_id)
            profile = cursor.fetchone()

            if profile:
                print("\nYOUR PROFILE:")
                print(f"\nUser Id: {profile[0]}")
                print(f"Username: {profile[1]}")
                print(f"Email: {profile[2]}")
                print(f"Account Bio: {profile[3]}")
                print(f"Created At: {profile[4]}")
                print(f"Updated At: {profile[5]}")
            else:
                print("Profile not found.")

    except Exception as e:
        print(f"Error: Unable to view profile\n{e}")


def view_playlists(user_id):
    try:
        with sql.cursor() as cursor:
            cursor.execute("""SELECT Playlist.[Name], Playlist.Duration, Playlist.CreatedAt
                                FROM Playlist
                                INNER JOIN Account ON Playlist.AccountId = Account.Id
                                WHERE Account.UserId = ?
                                GROUP BY Playlist.[Name], Playlist.Duration, Playlist.CreatedAt""", user_id)
            playlists = cursor.fetchall()

            if playlists:
                print("\nYOUR PLAYLISTS:")
                for playlist in playlists:
                    print(f"\nName: {playlist[0]}")
                    print(f"Duration: {round(playlist[1], 2)} min")
                    print(f"Created At: {playlist[2]}")
            else:
                print("Playlists not found.")

    except Exception as e:
        print(f"Error: Unable to view playlists\n{e}")


def view_artists():
    try:
        with sql.cursor() as cursor:
            cursor.execute("""SELECT TOP 10 Artist.[Name], Artist.Profit, [Label].[Name], [Label].ProfitShare,
                                    CASE
                                        WHEN LabelId IS NOT NULL THEN 'In Label'
                                        ELSE 'Independent Artist'
                                        END AS Label_Belong
                                    FROM Artist
                                    LEFT JOIN [Label] ON Artist.LabelId = [Label].Id """)
            artists = cursor.fetchall()

            if artists:
                print("\nLIST OF ARTISTS:")
                print("{:<20} {:<13} {:<19} {:<7}".format("ArtistName", "ArtistProfit", "Label", "LabelShare\n"))
                for artist in artists:
                    print("{:<20} {:<13} {:<19} {:<7}".format(artist[0], round(artist[1], 5),
                                                              artist[2] if artist[2] else artist[4],
                                                              f"{artist[3]}%" if artist[2] else "0%"))
            else:
                print("Artists not found.")

    except Exception as e:
        print(f"Error: Unable to view artists\n{e}")


def view_songs():
    try:
        with sql.cursor() as cursor:
            cursor.execute("""SELECT Song.[Name], Song.Duration, Genre.[Name], Album.[Name]
                                FROM Song
                                    LEFT JOIN Album ON Song.AlbumId = Album.Id
                                    INNER JOIN Genre ON Song.GenreId = Genre.Id""")
            songs = cursor.fetchall()

            if songs:
                print("\nLIST OF SONGS:")
                print("{:<20} {:<11} {:<12} {:<17}".format("SongName", "Duration", "Genre", "Album\n"))
                for song in songs:
                    print("{:<20} {:<11} {:<12} {:<17}".format(song[0], f"{round(song[1], 2)} min", song[2], song[3]))
            else:
                print("Songs not found.")

    except Exception as e:
        print(f"Error: Unable to view songs\n{e}")


def view_albums():
    try:
        with sql.cursor() as cursor:
            cursor.execute("""SELECT Album.[Name], Album.Duration,  Artist.[Name],
                                CASE
                                    WHEN Song.[Name] IS NOT NULL THEN Song.[Name]
                                    ELSE 'No Songs'
                                END AS Any_songs
                                FROM Album
                                LEFT JOIN Song ON Song.AlbumId = Album.Id
                                INNER JOIN Artist ON Album.ArtistId = Artist.Id
                                ORDER BY Album.[Name]""")
            albums = cursor.fetchall()

            if albums:
                print("\nLIST OF ALBUMS:")
                print("{:<20} {:<11} {:<20} {:<20}".format("AlbumName", "Duration", "Author", "Songs"))

                album_name = None
                for album in albums:
                    if album_name == album[0]:
                        print("{:<20} {:<11} {:<20} {:<20}".format("", "", "", album[3]))
                    else:
                        print("---------------------------------------------------------------------------------")
                        print("{:<20} {:<11} {:<20} {:<20}".format(album[0], f"{round(album[1], 2)} min", album[2], album[3]))
                    album_name = album[0]
            else:
                print("Albums not found.")

    except Exception as e:
        print(f"Error: Unable to view albums\n{e}")


# ===================================================================

# ===================================================================
# UPDATE FUNCTIONS

def update_account(user_id):
    while True:
        print("\nEdit Account:")
        print("1. Change username")
        print("2. Change Email")
        print("3. Change password")
        print("4. Change account bio")
        print("0. Back\n")

        choice = input("Enter your choice: ")

        try:
            with sql.cursor() as cursor:
                if choice == '1':
                    new_username = input("Enter new username: ")
                    cursor.execute(f"UPDATE [User] SET Username = '{new_username}' WHERE Id = ?", user_id)
                    sql.commit()
                    cursor.execute("UPDATE Account SET UpdatedAt = CAST(GETDATE() AS DATE) WHERE UserId = ?", user_id)
                    sql.commit()
                    print("Username changed.")
                elif choice == '2':
                    new_email = input("Enter new Email: ")
                    cursor.execute(f"UPDATE [User] SET Email = '{new_email}' WHERE Id = ?", user_id)
                    cursor.execute("UPDATE Account SET UpdatedAt = CAST(GETDATE() AS DATE) WHERE UserId = ?", user_id)
                    sql.commit()
                    print("Email changed.")
                elif choice == '3':
                    new_pass = input("Enter new password: ")
                    cursor.execute(f"UPDATE [User] SET PasswordHash = '{new_pass}' WHERE Id = ?", user_id)
                    cursor.execute("UPDATE Account SET UpdatedAt = CAST(GETDATE() AS DATE) WHERE UserId = ?", user_id)
                    sql.commit()
                    print("Password changed.")
                elif choice == '4':
                    new_bio = input("Enter new account bio: ")
                    cursor.execute(
                        f"UPDATE Account SET Bio = '{new_bio}', UpdatedAt = CAST(GETDATE() AS DATE) WHERE UserId = ?",
                        user_id)
                    sql.commit()
                    print("Account bio changed.")
                elif choice == '0':
                    print("Back to the menu.")
                    return
                else:
                    print("Invalid choice. Please try again.")
        except Exception as e:
            print(f"Error: Unable to edit account\n{e}")


def view_labels_id():
    try:
        with sql.cursor() as cursor:
            cursor.execute("SELECT Id, [Name], ProfitShare FROM [Label]")
            labels = cursor.fetchall()

            if labels:
                print("\nLIST OF LABELS:")
                print("{:<4} {:<20} {:<10}".format("Id", "Name", "ProfitShare\n"))
                for label in labels:
                    print("{:<4} {:<20} {:<10}".format(label[0], label[1], f"{label[2]}%"))
            else:
                print("Labels not found.")

    except Exception as e:
        print(f"Error: Unable to view labels\n{e}")


def update_label_share():
    view_labels_id()
    label_id = input("\nEnter label Id: ")

    try:
        with sql.cursor() as cursor:
            new_share = input("Enter new label profit share: ")
            cursor.execute("UPDATE [Label] SET ProfitShare = ? WHERE Id = ?", (new_share, label_id))
            sql.commit()
            print("Label profit share changed.")

    except Exception as e:
        print(f"Error: Unable to update label profit share. Check chosen value.\n{e}")


# ===================================================================

# ===================================================================
# SONG INSERT AND DEL FUNCTIONS

def view_albums_id():
    try:
        with sql.cursor() as cursor:
            cursor.execute("SELECT Id, [Name] FROM Album")
            albums = cursor.fetchall()

            if albums:
                print("\nLIST OF ALBUMS:")
                print("{:<4} {:<20}".format("Id", "Name\n"))
                for album in albums:
                    print("{:<4} {:<20}".format(album[0], album[1]))
            else:
                print("Albums not found.")

    except Exception as e:
        print(f"Error: Unable to view albums\n{e}")


def view_genres_id():
    try:
        with sql.cursor() as cursor:
            cursor.execute("SELECT Id, [Name] FROM Genre")
            genres = cursor.fetchall()

            if genres:
                print("\nLIST OF GENRES:")
                print("{:<4} {:<20}".format("Id", "Name\n"))
                for genre in genres:
                    print("{:<4} {:<20}".format(genre[0], genre[1]))
            else:
                print("Genres not found.")

    except Exception as e:
        print(f"Error: Unable to view genres\n{e}")


def insert_song():
    view_albums_id()
    view_genres_id()

    print("\nSong Parameters:")
    name = input("Enter song name: ")
    duration = input("Enter duration time: ")
    release_date = input("Enter release date: ")
    album_id = input("Enter album Id: ")
    genre_id = input("Enter genre Id: ")

    try:
        cursor = sql.cursor()
        cursor.execute(
            "INSERT INTO Song ([Name], Duration, ReleaseDate, AlbumId, GenreId) VALUES (?, ?, ?, ?, ?)",
            (name, duration, release_date, album_id, genre_id))
        sql.commit()
        cursor.close()

        print(f"\nSong added successfully.")

    except Exception as e:
        print(f"Error: Unable to add song\n{e}")


def view_songs_id():
    try:
        with sql.cursor() as cursor:
            cursor.execute("SELECT Id, [Name] FROM Song")
            songs = cursor.fetchall()

            if songs:
                print("\nLIST OF SONGS:")
                print("{:<4} {:<20}".format("Id", "Name\n"))
                for song in songs:
                    print("{:<4} {:<20}".format(song[0], song[1]))
            else:
                print("Songs not found.")

    except Exception as e:
        print(f"Error: Unable to view songs\n{e}")


def delete_song():
    view_songs_id()

    song_id = input("Enter song Id u want to delete: ")

    try:
        cursor = sql.cursor()
        cursor.execute(f"DELETE FROM Song WHERE Id = {song_id}")
        sql.commit()
        cursor.close()

        print(f"\nSong deleted successfully.")

    except Exception as e:
        print(f"Error: Unable to delete song\n{e}")
