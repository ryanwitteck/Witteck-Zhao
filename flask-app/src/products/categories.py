from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from src.debug import execute_query


categories = Blueprint('categories', __name__)

# Get all the categories from the database
@categories.route('/', methods=['GET'])
def get_categories():
    query = 'select * from category'

    return execute_query(query)

# get the data for a specific category from the database using its id
@categories.route('/<cid>')
def get_specific_category(cid):
    query = '''
        SELECT * FROM category
        WHERE category_id = {0};
    '''.format(cid)

    return execute_query(query)

# Get the products of a category using the category id -- NOT FULLY TESTED
@categories.route('/<cid>/products', methods=['GET'])
def get_category_products(cid):
    query = '''
        SELECT c.name as category, p.product_id, p.product_name
        FROM category c
        NATURAL JOIN category_product
        NATURAL JOIN products p
        WHERE c.category_id = {0};'''.format(cid)
    
    return execute_query(query)