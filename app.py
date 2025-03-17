import sys

def main_menu():
    """
    Displays the main menu for the application and prompts the user to select an option.
    """
    print("Welcome to the Beauty Product Database!")
    print("1. View Top-Rated Products")
    print("2. Search for a Product")
    print("3. View Product Reviews")
    print("4. Place an Order")
    print("5. Exit")
    
    choice = input("Enter your choice (1-5): ")
    if choice == "1":
        view_top_rated_products()
    elif choice == "2":
        search_product()
    elif choice == "3":
        view_product_reviews()
    elif choice == "4":
        place_order()
    elif choice == "5":
        sys.exit("Exiting application...")
    else:
        print("Invalid choice. Please try again.")
        main_menu()

def view_top_rated_products():
    """
    Displays the top-rated beauty products.
    Mock output: "Showing top-rated products..."
    """
    print("Showing top-rated products...")

def search_product():
    """
    Allows users to search for a product by name, category, or brand.
    Prompts for search input and displays matching products.
    Mock output: "Displaying search results..."
    """
    query = input("Enter product name, category, or brand to search: ")
    print(f"Displaying search results for '{query}'...")

def view_product_reviews():
    """
    Allows users to view reviews for a specific product.
    Prompts for a product ID and displays associated reviews.
    Mock output: "Displaying reviews for product {product_id}..."
    """
    product_id = input("Enter Product ID to view reviews: ")
    print(f"Displaying reviews for product {product_id}...")

def place_order():
    """
    Allows users to place an order for a product.
    Prompts for product ID and quantity, then confirms order.
    Mock output: "Order placed successfully for {quantity} of product {product_id}..."
    """
    product_id = input("Enter Product ID to order: ")
    quantity = input("Enter quantity: ")
    print(f"Order placed successfully for {quantity} of product {product_id}...")