"""
Code demo from Final Project Lecture 22wi, providing
an example of using MySQL with Python for an animal adoption
agency database (inspired by 21wi midterm).
"""
import sys  # to print error messages to sys.stderr
import mysql.connector
# To get error codes from the connector, useful for user-friendly
# error-handling
import mysql.connector.errorcode as errorcode

# Debugging flag to print errors when debugging that shouldn't be visible
# to an actual client. Set to False when done testing.
DEBUG = False
NUM_PAGES = 10

# ----------------------------------------------------------------------
# SET UP
# ----------------------------------------------------------------------
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
    # TODO might need to see if user is client then app-client.py is run
    # TODO might need to see if user is admin then app-admin.py is run
    '''
    Greets the user if the login is successful!
    '''
    if user_type == "client":
        print(f"\nLogin successful! \n\nWelcome to the Rejuvenation Station, {username}.")
        print("\n-------------------------------------------------")
        print("Message from the owners Meher Banik and Jana Woo:")
        print("We hope you have a great shopping experience!\n")
    elif user_type == "admin":
        print(f"\nWelcome back, Admin {username}!")
        print("You now have access to the Admin Panel.")
    else:
        print("You are neither a client nor admin. Try logging in again.")
        bye_bye_user()


def check_user_type(connection, username):
    cursor = connection.cursor()
    query = f"SELECT user_type FROM users WHERE username = '{username}';"
    result = execute_read_query(cursor, query)
    if result:
        return result[0][0]
    return None


def authenticate_user(connection, username, password):
    cursor = connection.cursor()
    query = f"SELECT authenticate('{username}', '{password}');"
    result = execute_read_query(cursor, query)
    return result and result[0][0] == 1


def login_flow(connection):
    '''
    Goes through login flow. Checks to see if the user wants 
    to login to the shop. If not they are exited from shopping.
    '''
    while True:
        procedural = input("To shop you must be logged in.\nWould you like to login[y/n]? ")
        if (procedural == "n"):
            bye_bye_user()
        
        username = input("Username: ")
        pwd = input("Password: ")
        if authenticate_user(connection, username, pwd):
            greet_user(username, check_user_type(connection, username))
            return username
        print("Invalid credentials. Please try again.")


# ----------------------------------------------------------------------
# Queries
# ----------------------------------------------------------------------

def execute_read_query(cursor, query):
    """Executes a read-only SQL query and returns the results."""
    try:
        cursor.execute(query)
        return cursor.fetchall()
    except mysql.connector.Error as e:
        if DEBUG:
            print(e, file=sys.stderr)
            sys.exit(1)
        print("Query failed. Contact system administrator.", file=sys.stderr)


def execute_write_query(connection, cursor, query, params=None):
    """Executes a write/update SQL query with optional parameters and commits changes."""
    try:
        cursor.execute(query, params or ())
        connection.commit()
    except mysql.connector.Error as e:
        if DEBUG:
            print(e, file=sys.stderr)
            sys.exit(1)
        print("Database update failed. Contact system administrator.", file=sys.stderr)

# ----------------------------------------------------------------------
# TODO: Formatting related things and pagination - might not even need to do
# ----------------------------------------------------------------------
