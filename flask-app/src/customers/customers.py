from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from src.debug import execute_query


customers = Blueprint('customers', __name__)

# Get all customers from the DB
@customers.route('/', methods=['GET'])
def get_customers():
    query = 'select * from customers'

    return execute_query(query)

# Get customer detail for customer with particular userID
@customers.route('/<userID>', methods=['GET'])
def get_customer(userID):
    query = 'select * from customers where customer_id = {0}'.format(userID)
    
    return execute_query(query)

# Get a customer's invoices for customer with particular userID -- DOES NOT QUERY ALL DESIRED INFORMATION
@customers.route('/<userID>/invoices', methods=['GET'])
def get_customer_invoices(userID):
    query = '''
        SELECT c.customer_id, c.first_name, c.last_name, i.invoice_id
        FROM customers c 
        JOIN invoice i ON c.customer_id = i.customer_id
        WHERE c.customer_id = {0};'''.format(userID)
    
    return execute_query(query)

# Get customer's reviews for customer with particular userID -- DOES NOT QUERY ALL DESIRED INFORMATION
@customers.route('/<userID>/reviews', methods=['GET'])
def get_customer_reviews(userID):
    query = '''
        SELECT c.customer_id, c.first_name, c.last_name, r.review_id
        FROM customers c 
        JOIN reviews r ON c.customer_id = r.customer_id
        WHERE c.customer_id = {0};'''.format(userID)
    
    return execute_query(query)