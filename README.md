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

The database is located in the witteck_zhao.sql file of the db folder. The other files in the db folder are unused.

It contains the tables:

1. supplier           - entries represent the suppliers of the products on our app
2. product            - entries represent the products posted for sale on our app
3. product_image      - entries represent images of products
4. company            - entries represent the companies that suppliers are associated with
5. sales_rep          - entries represent the 'moderators' of our app
6. supplier_rep       - entries represent relations between suppliers and sales_reps
7. customer           - entries represent customers who use our app
8. invoice            - entries represent customer purchases of products
9. invoice_line       - entries represent items that are a part of a certain invoice
10. category          - entries represent the categories that a product could be a part of
11. category_product  - entries represent relations between categories and products
12. review            - entries represent reviews that customers have posted about products


### The Code

The code is located in the flask-app folder. In it contains the src directory, where the heart of code is; the app.py file, which contains the main method and some route documentation; and the Dockerfile, which handles building an image of the app.

#### app.py

This contains the main method of our app and a list of all the routes that we have created for the app.

We have created the following routes:

    1. products/                    
    2. products/browse              
    3. products/unapproved          
    4. products/<pid>               
    5. products/<pid>/categories    
    6. products/<pid>/reviews       
    7. products/<pid>/sales-data    
    8. products/add-product         
    9. products/change-<param>      
    10. products/approve-product    
    11. products/unapprove-product
    
    12. categories/

    13. customers/                  
    14. customers/<cid>             
    15. customers/<cid>/invoices    
    16. customers/<cid>/reviews     
    17. customers/post-review       

    18. suppliers/                  
    19. suppliers/<sid>             
    20. suppliers/<sid>/products    
    21. suppliers/<sid>/company     
    22. suppliers/<sid>/sales-data  

    23. users/customers/iem-map
    24. users/suppliers/iem-map     
    25. users/sales-rep/iem-map     

#### Dockerfile

This contains the Docker instructions to build our app.

#### src

This contains the files:

    1. __init__.py
    2. requirements.txt
    3. utils.py
    4. users.py
    5. suppliers/suppliers.py
    6. customers/customers.py
    7. products/products.py
    8. products/categories.py
    9. The other files are unused or only exist for debugging purposes

##### __init__.py

This contains the code to initialize the app.

##### requirements.txt

This contains the packages required by the app. It is used by Docker when building the app image. 

##### utils.py

This file contains generally useful functions.

It contains functions to:

1. Execute sql queries (execute_query)
2. Update parameter values (update_table_entry)
3. Calculate a product's rating from the average of its reviews (calc_product_rating)

##### users.py

This file contains the code to create the routes we use for our mock login system.

##### suppliers/suppliers.py

This file contains the code for the /suppliers routes.

##### customers/customers.py

This file contains the code for the /customers routes.

##### products/products.py

This file contains the code for the /products routes.

##### products/categories.py

This file contains the code for the /categories routes.
