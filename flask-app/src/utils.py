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

# add a new item into the given table
def add_item(table_name, params, values_line):

    param_line = ','.join(map(str, params))

    command = 'INSERT INTO {0} ({1}) VALUES {2};'.format(table_name, param_line, values_line)

    cursor = db.get_db().cursor()

    try:
        cursor.execute(command)
        cursor.execute('COMMIT')
    except:
        return 'execution error'

    try:
        cursor.execute('SELECT {0}_id FROM {0} ORDER BY {0}_id DESC LIMIT 1;'.format(table_name))
        id_str = str(cursor.fetchone())
        return int(id_str[1:len(id_str) - 2])
    except:
        return 'query error'

# edit an entry in a table
def update_table_entry(table_name, param, value, id_str, id):

    command = 'UPDATE {0} SET {1} = {2} WHERE {3} = {4};'.format(table_name, param, value, id_str, id)

    cursor = db.get_db().cursor()

    try:
        cursor.execute(command)
        cursor.execute('COMMIT')
        return 'success'
    except:
        return 'error'