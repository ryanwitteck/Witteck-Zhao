###
# Main application interface
###

# import the create app function 
# that lives in src/__init__.py
from src import create_app

'''
    Routes:

    products/                   GET
    products/browse             GET
    products/unapproved         GET
    products/<pid>              GET
    products/<pid>/categories   GET
    products/<pid>/reviews      GET
    products/<pid>/sales-data   GET
    products/add-product        POST
    products/change-<param>     POST
    products/approve-product    POST
    products/unapprove-product  POST

    customers/                  GET
    customers/<cid>             GET
    customers/<cid>/invoices    GET
    customers/<cid>/reviews     GET
    customers/post-review       POST

    suppliers/                  GET
    suppliers/<sid>             GET
    suppliers/<sid>/products    GET
    suppliers/<sid>/company     GET
    suppliers/<sid>/sales-data  GET

    users/customers/iem-map     GET
    users/suppliers/iem-map     GET
    users/sales-rep/iem-map     GET
'''

# create the app object
app = create_app()

if __name__ == '__main__':
    # we want to run in debug mode (for hot reloading) 
    # this app will be bound to port 4000. 
    # Take a look at the docker-compose.yml to see 
    # what port this might be mapped to... 
    app.run(debug = True, host = '0.0.0.0', port = 4000)