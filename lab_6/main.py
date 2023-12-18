from db_functions import *

# ===================================================================
# CONSTANTS INITIALIZATION

FUNCTIONS_LIST = {
    '1': view_profile,
    '2': view_playlists,
    '3': view_artists,
    '4': view_songs,
    '5': view_albums,
    '6': update_account,
    '7': update_label_share,
    '8': insert_song,
    '9': delete_song
}


# ===================================================================

def main():
    userId = None

    while True:
        print("\nMenu:")

        if userId:
            print("1. View Profile")
            print("2. View Playlists")
            print("3. View Artists")
            print("4. View Songs")
            print("5. View Albums")
            print("6. Update Account")
            print("7. Update Label Profit Share")
            print("8. Add Song")
            print("9. Delete Song")
            print("0. Logout")
        else:
            print("1. Register")
            print("2. Login")
            print("0. Exit")

        choice = input("\nEnter your choice: ")

        if not userId:
            if choice == '1':
                userId = register_user()
            elif choice == '2':
                userId = login_user()
            elif choice == '0':
                break
            else:
                print("Invalid choice. Please try again.")

        else:
            if choice in ['1', '2', '3', '4', '5', '6', '7', '8', '9']:

                if choice in ['1', '2', '6']:
                    FUNCTIONS_LIST[choice](userId)
                else:
                    FUNCTIONS_LIST[choice]()

            elif choice == '0':
                userId = None
                print("\nYou logged out.")

            else:
                print("Invalid choice. Please try again.")


if __name__ == "__main__":
    main()
