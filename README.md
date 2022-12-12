# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 2 docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the `webapp` user. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## For setting up a Conda Web-Dev environment:

1. `conda create -n webdev python=3.9`
1. `conda activate webdev`
1. `pip install flask flask-mysql flask-restful cryptography flask-login`


## Our video presentation of our Final Project

(https://www.youtube.com/watch?v=RErvMTdOHKY)
The video runs a bit long due to some ngrok errors.


## Code Overview

### The Database

The database is located in the witteck_zhao.sql file of the db folder.

It contains the tables:
1. supplier           \t-entries represent the suppliers of the products on our app
2. product            \t-entries represent the products posted for sale on our app
3. product_image      \t-entries represent images of products
4. company            \t-entries represent the companies that suppliers are associated with
5. sales_rep          \t-entries represent the 'moderators' of our app
6. supplier_rep       \t-entries represent relations between suppliers and sales_reps
7. customer           \t-entries represent customers who use our app
8. invoice            \t-entries represent customer purchases of products
9. invoice_line       \t-entries represent items that are a part of a certain invoice
10. category          \t-entries represent the categories that a product could be a part of
11. category_product  \t-entries represent relations between categories and products
12. review            \t-entries represent reviews that customers have posted about products

### The Code

The code is located in the flask-app folder. In it contains the src directory, where the heart of code is; the app.py file, which contains the main method and some route documentation; and the Dockerfile, which handles building an image of the app.

#### app.py

This contains the main method of our app and a list of all the routes that we have created for the app.

We have created the following routes and their type:
    1. products/                    \tGET
    2. products/browse              \tGET
    3. products/unapproved          \tGET
    4. products/<pid>               \tGET
    5. products/<pid>/categories    \tGET
    6. products/<pid>/reviews       \tGET
    7. products/<pid>/sales-data    \tGET
    8. products/add-product         \tPOST
    9. products/change-<param>      \tPOST
    10. products/approve-product    \tPOST
    11. products/unapprove-product  \tPOST

    12. customers/                  \tGET
    13. customers/<cid>             \tGET
    14. customers/<cid>/invoices    \tGET
    15. customers/<cid>/reviews     \tGET
    16. customers/post-review       \tPOST

    17. suppliers/                  \tGET
    18. suppliers/<sid>             \tGET
    19. suppliers/<sid>/products    \tGET
    20. suppliers/<sid>/company     \tGET
    21. suppliers/<sid>/sales-data  \tGET

    22. users/customers/iem-map     \tGET
    23. users/suppliers/iem-map     \tGET
    24. users/sales-rep/iem-map     \tGET

#### Dockerfile

This contains the Docker instructions to build our app.

#### src




