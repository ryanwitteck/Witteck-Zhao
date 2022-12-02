###
# Main application interface
###

# import the create app function 
# that lives in src/__init__.py
from src import create_app

"""
Routes:

/products                       done
/<product-id>                   done
/<product-id>/categories        done
/<product-id>/reviews           done
/<product-id>/sale-data         done

/customers                      done
/<customer-id>                  done
/<customer-id>/invoices         done
/<customer-id>/reviews          done

/suppliers                      done
/<supplier-id>                  done
/<supplier-id>/products         done
/<supplier-id>/company          done
/<supplier-id>/sale-data        done

/invoices                       d
/<invoice-id>                   d

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