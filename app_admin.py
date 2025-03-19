import sys
import mysql.connector
import mysql.connector.errorcode as errorcode

from app import *
from datetime import datetime

DEBUG = False

def admin_menu(cursor):
    """
    Displays the admin menu and handles admin options.
    """
    def list_options():
        print("\nAdmin Panel - What would you like to do?")
        print("  1 - Add Product")
        print("  2 - Update Product Info")
        print("  3 - Delete Product")
        print("  4 - View All Orders")
        print("  5 - View All Reviews")
        print("  6 - Delete a Review")
        print("  7 - Quit")

    list_options()
    choice = input("Enter a choice (1 - 7): ").strip()

    while choice != '7':
        if choice == '1':
            add_product(cursor)
        elif choice == '2':
            update_product(cursor)
        elif choice == '3':
            delete_product(cursor)
        elif choice == '4':
            view_all_orders(cursor)
        elif choice == '5':
            view_all_reviews(cursor)
        elif choice == '6':
            delete_review(cursor)
        else:
            print("Invalid option. Please choose a number between 1-7.")
        list_options()
        choice = input("Enter a choice (1 - 7): ").strip()

    bye_bye_user()









def main(cursor):
    """
    Main function for starting things up.
    """
    admin_menu(cursor)

if __name__ == '__main__':
    conn = get_conn('admin', 'adminpw')
    user_id = login_flow(conn)
    main(conn.cursor())
