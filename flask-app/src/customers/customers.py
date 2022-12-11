from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from src.utils import execute_query, add_item, calc_product_rating

customers = Blueprint('customers', __name__)

# Get all customers from the DB
@customers.route('/', methods=['GET'])
def get_customers():
    query = 'select * from customer'

    return execute_query(query)

# Get customer detail for customer with particular userID
@customers.route('/<userID>', methods=['GET'])
def get_customer(userID):
    query = 'select * from customer where customer_id = {0}'.format(userID)
    
    return execute_query(query)

# Get a customer's invoices for customer with particular userID -- DOES NOT QUERY ALL DESIRED INFORMATION
@customers.route('/<userID>/invoices', methods=['GET'])
def get_customer_invoices(userID):
    query = '''
        SELECT p.product_id, p.product_name, il.quantity, i.total, i.date
        FROM customer c 
        JOIN invoice i on c.customer_id = i.customer_id
        JOIN invoice_line il on i.invoice_id = il.invoice_id
        JOIN product p on il.product_id = p.product_id
        WHERE c.customer_id = {0};'''.format(userID)
    
    return execute_query(query)

# Get customer's reviews for customer with particular userID -- DOES NOT QUERY ALL DESIRED INFORMATION
@customers.route('/<userID>/reviews', methods=['GET'])
def get_customer_reviews(userID):
    query = '''
        SELECT c.customer_id, c.first_name, c.last_name, r.review_id
        FROM customer c 
        JOIN review r ON c.customer_id = r.customer_id
        WHERE c.customer_id = {0};'''.format(userID)
    
    return execute_query(query)

# post a review
@customers.route('/post-review', methods=['POST'])
def post_customer_review():
    
    params = ['product_id','customer_id','title', 'description','rating']
    values = []
    for p in params:
        values.append(request.form.get(p))

    values_line = '({0},{1},\'{2}\',\'{3}\',{4})'.format(values[0], values[1], values[2], values[3], values[4])

    try:
        add_item('review', params, values_line)
    except:
        return 'failed to add review'
        
    return calc_product_rating(values[0])