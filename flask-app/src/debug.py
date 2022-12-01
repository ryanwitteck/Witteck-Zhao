from flask import Blueprint, request, jsonify, make_response
import json
from src import db

debug = Blueprint('debug', __name__)

# This is a sample route for the /test URI.  
# as above, it just returns a simple string. 
@debug.route('/debug')
def tester():
    return "<h1>hello world!</h1>"

# Get customer detail for customer with particular userID
@debug.route('/debug/<tableName>', methods=['GET'])
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