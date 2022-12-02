###
# Main application interface
###

# import the create app function 
# that lives in src/__init__.py
from src import create_app

"""
Routes we need:

/products                       done
/<product-name>                 done
/<product-name>/categories      done
/<product-name>/reviews         done
/<product-name>/sale-data       d

/customers                      done
/<customer-name>                done
/<customer-name>/invoices       done
/<customer-name>/reviews        done

/suppliers                      d
/<supplier-name>                d
/<supplier-name>/products       d
/<supplier-name>/sale-data      d

/invoices                       d
/<invoice-name>                 d

/categories                     done
/categories/<cid>               done
/categories/<cid>/products      done
"""


# create the app object
app = create_app()

if __name__ == '__main__':
    # we want to run in debug mode (for hot reloading) 
    # this app will be bound to port 4000. 
    # Take a look at the docker-compose.yml to see 
    # what port this might be mapped to... 
    app.run(debug = True, host = '0.0.0.0', port = 4000)