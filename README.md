# CS_121_FP

Welcome to the Rejuvenation Station! We are a small local makeup store
run by Meher Banik and Jana Woo!

Our data is sourced from a Kaggle dataset: [Sephora Products and Skincare Reviews](https://www.kaggle.com/datasets/nadyinky/sephora-products-and-skincare-reviews?resource=download)

This dataset includes:
- Beauty product names, brands, categories, and prices
- Customer reviews with ratings and text
- Skincare and makeup metadata

## General instructions:
There are two aspects to load this project: MySQL and Python. First load follow all the MySQL instructions then follow all the Python instructions. 

## Data Souce:
Data comes from Kaggle: https://www.kaggle.com/datasets/nadyinky/sephora-products-and-skincare-reviews?resource=download 

### MySQL instructions:
1. Load in MySQL. If you have not already go to terminal and enter these two commands into the command line.
One: alias mysql='/usr/local/mysql/bin/mysql -u root -p';
Two: mysql --local-infile -u root -p     

2. Load files and database. 
    CREATE database fp_db;
    USE fp_db;
    source setup;
    source load-data.sql;
    source setup-passwords.sql;
    source setup-routines.sql;
    source grant-permissions.sql;
    source queries.sql;

Load in the full path line for the source if need be, here is an example:
    source Desktop/cs121-final-project/setup.sql;

### Python instructions:
If this is your first time working with MySQL and Python, you will want to run this command into your command line:
    pip3 install mysql-connector-python

There are a total of 3 files:
1. app.py
2. app_client.py
3. app_admin.py

**app.py**
Shared Helper Functions & Database Utilities

This file will contain helper functions for executing SQL queries, printing tables, and verifying user roles. Both the client and admin will utilize these functions. Also, implements functions like execute_read_query and execute_write_query to help faciliate the SQL interaction.

**app_client.py**
Client Interface

An interface for customers using the shop.
Features include:
Viewing top-rated products
Searching products by name, brand, or category
Viewing product reviews
Placing orders
Leaving product reviews
Viewing order history

**app_admin.py**
Admin Interface

An interface for admin users who manage the database.
Features include:
Adding, updating, and deleting products
Viewing all customer orders
Viewing all product reviews
Deleting inappropriate or outdated reviews

Thank you! If you have any questions feel free to reach out to [mbanik@caltech.edu](mailto:mbanik@caltech.edu) and [jkwoo@caltech.edu](mailto:jkwoo@caltech.edu).
