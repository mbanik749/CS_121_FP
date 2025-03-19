"""
AUTHORS:
Meher Banik [mbanik@caltech.edu]
Jana Woo [jkwoo@caltech.edu]

An interface for client users who interact with the Rejuvenation Station.
This file is dependent on MySQL and app.py helper functions.

Features:
- View top-rated products
- Search for products by name, category, or brand
- View product reviews
- Place orders
- Leave reviews for products
- View personal order history
"""

import sys
import mysql.connector
import mysql.connector.errorcode as errorcode

from app import *
from datetime import datetime

DEBUG = False

def main_menu(cursor, username):
    """
    Displays the main menu for the application and prompts the user to select an option.
    """
    def list_options():
        print("\nWhat would you like to do?")
        print("  1 - View Top-Rated Products")
        print("  2 - Search for a Product")
        print("  3 - View Product Reviews")
        print("  4 - Place an Order")
        print("  5 - Leave a Review")
        print("  6 - View My Orders")
        print("  7 - Quit")

    list_options()
    choice = input("Enter a choice (1 - 7): ")
    while choice != '7':
        if choice == '1':
            view_top_rated_products(cursor)
        elif choice == '2':
            search_product(cursor)
        elif choice == '3':
            view_product_reviews(cursor)
        elif choice == '4':
            place_order(cursor)
        elif choice == '5':
            leave_review(cursor, username)
        elif choice == '6':
            view_orders(cursor, username)
        else:
            print("Invalid input. Please choose a number between 1 and 7.")
        list_options()
        choice = input("Enter a choice (1 - 7): ")
    bye_bye_user()


def view_top_rated_products(cursor):
    """
    Displays the top-rated beauty products.
    """
    query = """
        SELECT name, brand, category, average_rating
        FROM products
        ORDER BY average_rating DESC
        LIMIT 5;
    """
    rows = execute_read_query(cursor, query)
    if rows:
        print("\nTop-Rated Products:")
        print(f"{'Name':<30}{'Brand':<25}{'Category':<15}{'Rating'}")
        for row in rows:
            print(f"{row[0]:<30}{row[1]:<25}{row[2]:<15}{row[3]}")
    else:
        print("No products found.")


def search_product(cursor):
    """
    Allows users to search for a product by name, category, or brand.
    Prompts for search input and displays matching products.
    """
    print("\nSearch by:")
    print("  1 - Product Name")
    print("  2 - Category")
    print("  3 - Brand")
    option = input("Enter option (1-3): ").strip()

    if option == "1":
        keyword = input("Enter product name to search: ")
        like_pattern = f"%{keyword}%"
        query = f"""
            SELECT product_id, name, brand, category
            FROM products
            WHERE name LIKE '{like_pattern}';
        """
    elif option == "2":
        keyword = input("Enter category to search: ")
        like_pattern = f"%{keyword}%"
        query = f"""
            SELECT product_id, name, brand, category
            FROM products
            WHERE category LIKE '{like_pattern}';
        """
    elif option == "3":
        keyword = input("Enter brand to search: ")
        like_pattern = f"%{keyword}%"
        query = f"""
            SELECT product_id, name, brand, category
            FROM products
            WHERE brand LIKE '{like_pattern}';
        """
    else:
        print("Invalid option. Returning to menu.")
        return

    rows = execute_read_query(cursor, query)

    if rows:
        print(f"\nResults for '{keyword}':")
        print(f"{'Product ID':<12}{'Name':<25}{'Brand':<20}{'Category'}")
        for row in rows:
            print(f"{row[0]:<12}{row[1]:<25}{row[2]:<20}{row[3]}")
    else:
        print("No matching products found.")


def view_product_reviews(cursor):
    """
    Allows users to view reviews for a specific product.
    Prompts for a product ID and displays associated reviews.
    """
    product_id = input("Enter Product ID to view reviews: ")
    query = f"""
        SELECT u.username, r.rating, r.review_text, r.created_at
        FROM reviews r
        JOIN users u ON r.user_id = u.user_id
        WHERE r.product_id = {product_id}
        ORDER BY r.created_at DESC;
    """
    rows = execute_read_query(cursor, query)
    if rows:
        print(f"\nReviews for product {product_id}:")
        print(f"{'User':<15}{'Rating':<7}{'Date':<20}  Comment")
        for row in rows:
            print(f"{row[0]:<15}{row[1]:<7}{str(row[3]):<20}  {row[2]}")

    else:
        print("No reviews found for this product.")


def place_order(cursor):
    """
    Allows users to place an order for a product.
    Prompts for product ID and quantity, then confirms order.
    """
    try:
        user_id = input("Enter your user ID: ")
        product_id = input("Enter Product ID to order: ")
        quantity = input("Enter quantity: ")
        address = input("Enter shipping address: ")

        call_proc = """
            CALL sp_place_order(%s, %s, %s, %s, @output_order_id);
        """
        params = (user_id, product_id, address, quantity)
        execute_write_query(conn, cursor, call_proc, params)

        result = execute_read_query(cursor, "SELECT @output_order_id;")
        order_id = result[0][0]

        print(f"Order placed successfully! Order ID: {order_id}")
    except mysql.connector.Error as err:
        print(f"Failed to place order: {err}")


def leave_review(cursor, username):
    """
    Allows users to leave a review for a product. Prompts for a 
    product ID, rating, and review text, looks up the user_id 
    from the username, then asks the user to confirm before 
    inserting it into the database.
    """
    try:
        user_query = f"SELECT user_id FROM users WHERE username = '{username}';"
        user_result = execute_read_query(cursor, user_query)
        
        if not user_result:
            print(f"No user found with username '{username}'. Review submission canceled.")
            return
        
        user_id = user_result[0][0] 

        product_id = input("Enter Product ID to review: ").strip()
        rating = input("Enter rating (1-5): ").strip()
        review_text = input("Enter your review: ").strip()

        print("\nReview Summary:")
        print(f"  Product ID : {product_id}")
        print(f"  Rating     : {rating}")
        print(f"  Review     : {review_text}")

        confirm = input("\nSubmit this review? (y/n): ").lower()
        if confirm != 'y':
            print("Review submission canceled.")
            return

        query = """
            INSERT INTO reviews (user_id, product_id, rating, review_text)
            VALUES (%s, %s, %s, %s);
        """
        params = (user_id, product_id, rating, review_text)
        execute_write_query(conn, cursor, query, params)
        print("Review submitted successfully!")
    except mysql.connector.Error as err:
        print(f"Failed to submit review: {err}")


def view_orders(cursor, username):
    """
    Displays all orders placed by a specific user.
    """
    query = f"""
        SELECT o.order_id, o.product_id, o.address, o.quantity, o.order_date
        FROM orders o
        JOIN users u ON o.user_id = u.user_id
        WHERE u.username = '{username}'
        ORDER BY o.order_date DESC;
    """
    
    rows = execute_read_query(cursor, query)
    
    if rows:
        print(f"\nOrders for user: {user_id} - ")
        print(f"\n{'Order ID':<12}{'Order Date':<25}{'Product ID':<12}{'Quantity':<10}{'Address'}")
        for row in rows:
            print(f"{row[0]:<12}{str(row[4]):<25}{row[1]:<12}{row[3]:<10}{row[2]}")
        print(f"\nTotal number of orders: {len(rows)}")
    else:
        print("No orders found for this user.")


def main(cursor, username):
    """
    Main function for starting things up.
    """
    main_menu(cursor, username)


def verify_client(username, cursor):
    """Checks if a user is a client using the MySQL is_client function."""
    query = "SELECT is_client(%s);"
    try:
        result = execute_read_query(cursor, query, (username,))
        return result and result[0][0] == 1
    except mysql.connector.Error as err:
        if DEBUG:
            print(err, file=sys.stderr)
        else:
            print("Error checking client status.", file=sys.stderr)
        return False


if __name__ == '__main__':
    # This conn is a global object that other functinos can access.
    # You'll need to use cursor = conn.cursor() each time you are
    # about to execute a query with cursor.execute(<sqlquery>)
    conn = get_conn('client', 'clientpw')
    user_id = login_flow(conn, "client")
    main(conn.cursor(), user_id)

