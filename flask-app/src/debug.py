from flask import Blueprint, request, jsonify, make_response
import json
from src import db

debug = Blueprint('debug', __name__)

# This is a sample route for the /test URI.  
# as above, it just returns a simple string. 
@debug.route('/')
def tester():
    return "<h1>hello world!</h1>"

# execute querry on the database
def execute_query(query):
    cursor = db.get_db().cursor()
    cursor.execute(query)
       # grab the column headers from the returned data
    row_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get customer detail for customer with particular userID
@debug.route('/<tableName>', methods=['GET'])
def get_table(tableName):
    query = 'select * from {0}'.format(tableName)

    return execute_query(query)