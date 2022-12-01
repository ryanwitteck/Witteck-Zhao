###
# Main application interface
###

# import the create app function 
# that lives in src/__init__.py
from src import create_app
# from src import db

# create the app object
app = create_app()

###
#@app.route('/db_test')
#def db_testing():
#   cur = db.get_db().cursor()
#   cur.execute('select * from products')
#   row_headers = [x[0] for x in cur.description]
#   json_data = []
#   theData = cur.fetchall()
#   for row in theData:
#       json_data.append(dict(zip(row_headers, row)))
#   return jsonify(json_data)
###

if __name__ == '__main__':
    # we want to run in debug mode (for hot reloading) 
    # this app will be bound to port 4000. 
    # Take a look at the docker-compose.yml to see 
    # what port this might be mapped to... 
    app.run(debug = True, host = '0.0.0.0', port = 4000)