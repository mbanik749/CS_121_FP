"""
AUTHORS:
Meher Banik [mbanik@caltech.edu]
Jana Woo [jkwoo@caltech.edu]

Used by both the client and admin interfaces of the Rejuvenation. 
Originally adapted from a code demo (Final Project Lecture 22wi) 
for an animal adoption agency database.

This file is dependent on MySQL and supports database connection, login flow,
authentication, user greeting, and general query execution for reusable operations.

Features:
- Connect to MySQL database
- Execute read/write SQL queries
- Handle login and user authentication
- Determine and route user type (client/admin)
- Display exit messages for users and admins
"""

import sys  # to print error messages to sys.stderr
import mysql.connector
# To get error codes from the connector, useful for user-friendly
# error-handling
import mysql.connector.errorcode as errorcode
import hashlib
import os

# Debugging flag to print errors when debugging that shouldn't be visible
# to an actual client. Set to False when done testing.
DEBUG = False

def get_conn(user, password):
    """"
    Returns a connected MySQL connector instance, if connection is successful.
    If unsuccessful, exits.
    """
    try:
        conn = mysql.connector.connect(
          host='localhost',
          user=user,
          # Find port in MAMP or MySQL Workbench GUI or with
          # SHOW VARIABLES WHERE variable_name LIKE 'port';
          port='3306',
          password=password,
          database='ecommerce_db'
        )
        print('Successfully connected.')
        return conn
    except mysql.connector.Error as err:
        # Remember that this is specific to _database_ users, not
        # application users. So is probably irrelevant to a client in your
        # simulated program. Their user information would be in a users table
        # specific to your database.
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR and DEBUG:
            sys.stderr('Incorrect username or password when connecting to DB.')
        elif err.errno == errorcode.ER_BAD_DB_ERROR and DEBUG:
            sys.stderr('Database does not exist.')
        elif DEBUG:
            sys.stderr(err)
        else:
            sys.stderr('An error occurred, please contact the administrator.')
        sys.exit(1)


def bye_bye_user():
    """Exits the program with a goodbye message to the user."""
    print("\nGoodbye! Thank you for shopping at Rejuvenation Station!")
    print("\nHope to see you again soon!")
    exit()


def bye_bye_admin():
    """Exits the program with a goodbye message to the admin."""
    print("\nGoodbye!")
    exit()


def greet_user(username, user_type):
    '''
    Greets the user if the login is successful! The greeting is specific to the user type.
    '''
    if user_type == "client":
        print(f"\nLogin successful! \n\nWelcome to the Rejuvenation Station, {username}.")
        print("\n-------------------------------------------------")
        print("Message from the owners Meher Banik and Jana Woo:")
        print("We hope you have a great shopping experience!\n")
    elif user_type == "admin":
        print(f"\nWelcome back, {username}!")
        print("You now have access to the Admin Panel.")
    else:
        print("You are neither a client nor admin. Try logging in again.")
        bye_bye_user()


def check_user_type(connection, username):
    '''
    Return the type of user. The options are client and admin.
    '''
    cursor = connection.cursor()
    query = f"SELECT user_type FROM users WHERE username = '{username}';"
    result = execute_read_query(cursor, query)
    if result:
        return result[0][0]
    return None


def authenticate_user(connection, username, password):
    '''
    User authentication to check that the user exists and the pasword is correct.
    '''
    cursor = connection.cursor()
    query = f"SELECT authenticate('{username}', '{password}');"
    result = execute_read_query(cursor, query)
    return result and result[0][0] == 1


def input_length_check(input, input_type, length):
    if len(input) > length:
        print("Your " + input_type + " input is " + str(len(input) - length) + " characters too long.")
        return False
    return True


def is_username_unique(cursor, username):
    query = f"SELECT 1 FROM users WHERE username = '{username}';"
    result = execute_read_query(cursor, query)
    return len(result) == 0


def is_email_unique(cursor, email):
    query = f"SELECT 1 FROM users WHERE email = '{email}';"
    result = execute_read_query(cursor, query)
    return len(result) == 0


def create_account(connection, user_type_input):
    """
    Creates a new user account.
    - Stores the secure hashed password in user_info using sp_add_user.
    - Also inserts the user into the users table with a default 'client' role.
    """
    cursor = connection.cursor()

    print("\n--- Create a New Account ---")
    user_type = input("Are you a client or admin? ").strip()
    if user_type != "client" and user_type != "admin":
        print("Invalid input.")
        print("You will get one more try before you are exited from our platform.")
        user_type = input("Are you a client or admin? ").strip()

    if user_type == "admin":
        if user_type != user_type_input:
            print("The type of your user must match the python file running.")
            print("Currently they do not match.\n")
            print("You will be exited from our platform.")
            return False
        company_type = input("What company do you work for? ")
        reasoning = input("What are you using admin privileges for? ")
    elif user_type == "client":
        if user_type != user_type_input:
            print("The type of your user must match the python file running.")
            print("Currently they do not match.\n")
            print("You will be exited from our platform.")
            return False
    elif user_type != "admin" and user_type != "client":
        print("Invalid input.")
        return False

    username = input("Enter a new username (max 50 characters): ").strip()
    if not is_username_unique(cursor, username):
        print("You entered an username that already exists in the system. You get one more try.")
        username = input("Enter a new username (max 50 characters): ").strip()
        if not is_username_unique(cursor, username):
            print("You entered an username that already exists in the system again.")
            print("You will be exited from our platform.")
            return False
    if not input_length_check(username, "username", 50):
        print("You will get one more try before you are exited from our platform.")
        username = input("Enter a new username (max 50 characters): ").strip()

        if not is_username_unique(cursor, username):
            print("You entered an username that already exists in the system.")
            print("You will be exited from our platform.")
            return False
        if not input_length_check(username, "username", 50):
            print("Invalid input.")
            return False
    
    password = input("Enter a new password(max 255 characters): ").strip()
    if not input_length_check(password, "password", 255):
        print("You will get one more try before you are exited from our platform.")
        username = input("Enter a new password(max 255 characters): ").strip()
        if not input_length_check(password, "password", 255):
            print("Invalid input.")
            return False

    email = input("Enter your email(max 100 characters): ").strip()
    if not is_email_unique(cursor, email):
        print("You entered an email that already exists in the system. Please try again.")
        email = input("Enter your email(max 100 characters): ").strip()
        if not is_email_unique(cursor, email):
            print("You entered an email that already exists in the system again.")
            print("You will be exited from our platform.")
            return False
    if not input_length_check(email, "email", 100):
        print("You will get one more try before you are exited from our platform.")
        email = input("Enter your email(max 100 characters): ").strip()
        if not input_length_check(email, "email", 100):
            print("Invalid input.")
            return False
        if not is_email_unique(cursor, email):
            print("You entered an email that already exists in the system.")
            print("You will be exited from our platform.")
            return False

    try:
        cursor.callproc("sp_add_user", [username, password])
        connection.commit()

        insert_user_query = """
            INSERT INTO users (username, email, password_hash, user_type)
            VALUES (%s, %s, %s, %s);
        """
        params = (username, email, password, user_type)
        execute_write_query(connection, cursor, insert_user_query, params)

        print("Account successfully created!")

    except mysql.connector.Error as err:
        print(f"Error during account creation: {err}")
    
    return True


def login_flow(connection, user_type):
    '''
    Goes through login flow. Checks to see if the user wants 
    to login to the shop. If not they are exited from shopping.
    '''
    print("To shop you must be logged in.\n")
    print("  c - Create Account")
    print("  l - Login")
    print("  q - Quit")
    procedural = input("\nEnter a choice (c, l or q): ").strip()
    
    while procedural != "c" and procedural != "l" and procedural != 'q':
        print("Invalid input.\n")
        print("  c - Create Account")
        print("  l - Login")
        print("  q - Quit")
        procedural = input("\nEnter a choice (c, l or q): ").strip()
    
    if procedural == "c":
        if not create_account(connection, user_type):
            bye_bye_user()
    elif procedural == 'q':
        bye_bye_user()
    
    while True:
        username = input("Username: ")
        pwd = input("Password: ")
        if authenticate_user(connection, username, pwd):
            if user_type != check_user_type(connection, username):
                print("The type of your user must match the python file running.")
                print("Currently they do not match.\n")
            else:
                greet_user(username, user_type)
                return username
        print("Invalid credentials. Please try again.")


def execute_read_query(cursor, query):
    """Executes a read-only SQL query and returns the results."""
    try:
        cursor.execute(query)
        return cursor.fetchall()
    except mysql.connector.Error as e:
        if DEBUG:
            print(e, file=sys.stderr)
            sys.exit(1)
        print("Uh oh lipstick is leaking everywhere!! Contact makeup artist!", file=sys.stderr)


def execute_write_query(connection, cursor, query, params=None):
    """Executes a write/update SQL query with optional parameters and commits changes."""
    try:
        cursor.execute(query, params or ())
        connection.commit()
    except mysql.connector.Error as e:
        if DEBUG:
            print(e, file=sys.stderr)
            sys.exit(1)
        print("Uh oh lipstick is leaking everywhere!! Contact makeup artist!", file=sys.stderr)

