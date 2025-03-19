"""
AUTHORS:
Meher Banik [mbanik@caltech.edu]
Jana Woo [jkwoo@caltech.edu]

An interface for admin users who manage the database for Rejuvenation 
Station. This file is dependent on MySQL and app.py helper functions.

Features:
- Add new products to the database
- Update existing product information
- Delete products
- View all customer orders
- View all product reviews
- Delete reviews
"""

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

    bye_bye_admin()


def add_product(cursor):
    """
    Admin tool to add a new product to the catalog.
    Prompts for input, displays a summary, and asks for confirmation.
    """
    name = input("Enter product name: ").strip()
    brand = input("Enter brand name: ").strip()
    category = input("Enter product category: ").strip()
    price = input("Enter product price: ").strip()
    ingredients = input("Enter ingredients (optional): ").strip()

    print("\nProduct Summary:")
    print(f"  Name       : {name}")
    print(f"  Brand      : {brand}")
    print(f"  Category   : {category}")
    print(f"  Price      : {price}")
    print(f"  Ingredients: {ingredients if ingredients else '(None)'}")

    confirm = input("\nAdd this product? (y/n): ").lower()
    if confirm != 'y':
        print("Product addition canceled.")
        return

    query = """
        INSERT INTO products (name, brand, category, price, ingredients)
        VALUES (%s, %s, %s, %s, %s);
    """
    params = (name, brand, category, price, ingredients)
    execute_write_query(conn, cursor, query, params)
    print("Product added successfully.")


def update_product(cursor):
    """
    Admin tool to update existing product information.
    """
    product_id = input("Enter Product ID to update: ").strip()

    print("\nWhat would you like to update?")
    print("  1 - Name")
    print("  2 - Brand")
    print("  3 - Category")
    print("  4 - Price")
    print("  5 - Ingredients")

    choice = input("Enter choice (1-5): ").strip()
    fields = {
        "1": "name",
        "2": "brand",
        "3": "category",
        "4": "price",
        "5": "ingredients"
    }

    if choice not in fields:
        print("Invalid field choice.")
        return

    new_value = input(f"Enter new value for {fields[choice]}: ").strip()
    query = f"""
        UPDATE products
        SET {fields[choice]} = %s
        WHERE product_id = %s;
    """
    params = (new_value, product_id)
    execute_write_query(conn, cursor, query, params)
    print("Product updated successfully.")


def delete_product(cursor):
    """
    Admin tool to delete a product from the catalog.
    Shows product details before confirming deletion.
    """
    product_id = input("Enter Product ID to delete: ").strip()

    query = f"SELECT name, brand, category, price, ingredients FROM products WHERE product_id = {product_id};"
    result = execute_read_query(cursor, query)

    if not result:
        print(f"No product found with ID {product_id}.")
        return

    product = result[0]
    print("\nProduct Details:")
    print(f"  Name       : {product[0]}")
    print(f"  Brand      : {product[1]}")
    print(f"  Category   : {product[2]}")
    print(f"  Price      : {product[3]}")
    print(f"  Ingredients: {product[4] if product[4] else '(None)'}")

    confirm = input(f"\nAre you sure you want to delete this product (ID: {product_id})? (y/n): ").lower()
    if confirm != 'y':
        print("Product deletion cancelled.")
        return

    delete_query = "DELETE FROM products WHERE product_id = %s;"
    execute_write_query(conn, cursor, delete_query, (product_id,))
    print("Product deleted successfully.")


def view_all_orders(cursor):
    """
    Admin tool to view all customer orders.
    """
    query = """
        SELECT o.order_id, u.username, o.product_id, o.quantity, o.address, o.order_date
        FROM orders o
        JOIN users u ON o.user_id = u.user_id
        ORDER BY o.order_date DESC;
    """
    rows = execute_read_query(cursor, query)

    if rows:
        print("\nAll Orders:")
        print(f"{'Order ID':<12}{'Username':<15}{'Product ID':<12}{'Qty':<6}{'Address':<35}{'Order Date'}")
        for row in rows:
            print(f"{row[0]:<12}{row[1]:<15}{row[2]:<12}{row[3]:<6}{row[4]:<35}{str(row[5])}")
        print(f"\nTotal Orders: {len(rows)}")
    else:
        print("No orders found.")


def view_all_reviews(cursor):
    """
    Admin tool to view all product reviews.
    """
    query = """
        SELECT r.review_id, u.username, r.product_id, r.rating, r.review_text, r.created_at
        FROM reviews r
        JOIN users u ON r.user_id = u.user_id
        ORDER BY r.created_at DESC;
    """
    rows = execute_read_query(cursor, query)

    if rows:
        print("\nAll Reviews:")
        print(f"{'Review ID':<12}{'Username':<15}{'Product ID':<12}{'Rating':<10}{'Date':<25}Comment")
        for row in rows:
            print(f"{row[0]:<12}{row[1]:<15}{row[2]:<12}{row[3]:<10}{str(row[5]):<25}{row[4]}")
        print(f"\nTotal Reviews: {len(rows)}")
    else:
        print("No reviews found.")


def delete_review(cursor):
    """
    Admin tool to delete a review.
    Displays review details before confirming deletion.
    """
    review_id = input("Enter Review ID to delete: ").strip()

    query = f"""
        SELECT r.review_id, u.username, r.product_id, r.rating, r.review_text, r.created_at
        FROM reviews r
        JOIN users u ON r.user_id = u.user_id
        WHERE r.review_id = {review_id};
    """
    result = execute_read_query(cursor, query)

    if not result:
        print(f"No review found with ID {review_id}.")
        return

    review = result[0]
    print("\nReview Details:")
    print(f"  Review ID : {review[0]}")
    print(f"  Username  : {review[1]}")
    print(f"  Product ID: {review[2]}")
    print(f"  Rating    : {review[3]}")
    print(f"  Comment   : {review[4]}")
    print(f"  Date      : {review[5]}")

    confirm = input("\nAre you sure you want to delete this review? (y/n): ").strip().lower()
    if confirm != 'y':
        print("Review deletion cancelled.")
        return

    delete_query = "DELETE FROM reviews WHERE review_id = %s;"
    execute_write_query(conn, cursor, delete_query, (review_id,))
    print("Review deleted successfully.")


def main(cursor):
    """
    Main function for starting things up.
    """
    admin_menu(cursor)


if __name__ == '__main__':
    # This conn is a global object that other functinos can access.
    # You'll need to use cursor = conn.cursor() each time you are
    # about to execute a query with cursor.execute(<sqlquery>)
    conn = get_conn('admin', 'adminpw')
    user_id = login_flow(conn, "admin")
    main(conn.cursor())

