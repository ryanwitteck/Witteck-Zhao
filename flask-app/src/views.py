from flask import Blueprint, request, jsonify, make_response
import json
from src import db

views = Blueprint('views', __name__)

# This is a base route
# we simply return a string.  
@views.route('/')
def home():
    return ('<h1>Hello from your web app!!</h1>')

# This is a sample route for the /test URI.  
# as above, it just returns a simple string. 
@views.route('/test')
def tester():
    return "<h1>this is a test!</h1>"

# Get customer detail for customer with particular userID
@views.route('/test/<tableName>', methods=['GET'])
def get_table(tableName):
    cursor = db.get_db().cursor()
    cursor.execute('select * from {0}'.format(tableName))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response