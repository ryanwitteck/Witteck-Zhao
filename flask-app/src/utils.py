from flask import Blueprint, request, jsonify, make_response
import json
from src import db

# execute querry on the database
def execute_query(query):
    cursor = db.get_db().cursor()
    try:
        cursor.execute(query)
    except:
        return '<h1>Failed Query</h1>'

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

