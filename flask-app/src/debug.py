from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from src.utils import execute_query

debug = Blueprint('debug', __name__)

# This is a sample route for the /test URI.  
# as above, it just returns a simple string. 
@debug.route('/')
def tester():
    return "<h1>hello world!</h1>"

# Select all from given table
@debug.route('/<tableName>', methods=['GET'])
def get_table(tableName):
    query = 'select * from {0}'.format(tableName)

    return execute_query(query)