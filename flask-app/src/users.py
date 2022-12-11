from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from src.utils import execute_query

users = Blueprint('users', __name__)

# Get a map of customer ids to emails
@users.route('/customers/iem-map', methods=['GET'])
def get_customer_id_em_map():
    query = 'select email as label, customer_id as value from customer'
    
    return execute_query(query)

# get the map of supplier ids to emails
@users.route('/suppliers/iem-map', methods=['GET'])
def get_supplier_id_em_map():
    query = 'SELECT email as label, supplier_id as value FROM supplier'

    return execute_query(query)

# get the map of sales-rep ids to emails
@users.route('/sales-rep/iem-map', methods=['GET'])
def get_sales_rep_id_em_map():
    query = 'SELECT email as label, sales_rep_id as value FROM sales_rep'

    return execute_query(query)