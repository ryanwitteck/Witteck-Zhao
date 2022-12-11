from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from src.utils import execute_query
from src.utils import add_item, update_table_entry


products = Blueprint('products', __name__)

# Get all the products from the database
@products.route('/', methods=['GET'])
def get_products():
    query = 'select * from product'

    return execute_query(query)

# get the top 5 products from the database -- NOT FULLY TESTED
@products.route('/top5')
def get_most_pop_products():
    query = '''
        SELECT p.product_id, product_name, sum(il.quantity) as totalOrders
        FROM product p JOIN invoice_line il on p.product_id = il.product_id
        WHERE p.is_approved
        GROUP BY p.product_id, product_name
        ORDER BY totalOrders DESC
        LIMIT 5;
    '''
    
    return execute_query(query)

# get the data for a specific product from the database using its id
@products.route('/<productID>')
def get_specific_product(productID):
    query = '''
        SELECT * FROM product
        WHERE product_id = {0};
    '''.format(productID)

    return execute_query(query)

# Get a products's categories using its id -- NOT FULLY TESTED
@products.route('/<pid>/categories', methods=['GET'])
def get_product_categories(pid):
    query = '''
        SELECT p.product_id, p.product_name, c.name as category
        FROM product p
        NATURAL JOIN category_product
        NATURAL JOIN category c
        WHERE p.product_id = {0};'''.format(pid)
    
    return execute_query(query)

# Get a products's reviews using its id -- DOES NOT QUERY ALL DESIRED INFORMATION
@products.route('/<pid>/reviews', methods=['GET'])
def get_product_reviews(pid):
    query = '''
        SELECT p.product_id, p.product_name, r.review_id
        FROM product p 
        JOIN reviews r ON p.product_id = r.product_id
        WHERE p.product_id = {0};'''.format(pid)
    
    return execute_query(query)

# Get a products's sale data using its id -- DOES NOT QUERY ALL DESIRED INFORMATION
@products.route('/<pid>/sales-data', methods=['GET'])
def get_product_sales(pid):
    query = '''
        SELECT p.product_id, p.product_name, il.quantity, il.unit_price, i.total, i.date, i.customer_id
        FROM product p 
        JOIN invoice_line il ON p.product_id = il.product_id
        JOIN invoice i ON il.invoice_id = i.invoice_id
        WHERE p.product_id = {0};'''.format(pid)
    
    return execute_query(query)

# Add a new product to the database
@products.route('/add-product', methods=['POST'])
def add_product():
    # create new tuple in products
    params = ['product_name','supplier_id','description','unit_price','quantity']
    values = []
    for p in params:
        values.append(request.form.get(p))
    
    values_line = '(\'{0}\',{1},\'{2}\',{3},{4})'.format(values[0], values[1], values[2], values[3], values[4])

    try:
        pid = add_item('product', params, values_line)
    except:
        return 'failed to add product'

    # create new category relations
    try:
        log = ""
        for v in request.form.get('categories')[1::2]:
            id_data = '({0},{1})'.format(pid, v)
            r = add_item('category_product', ['product_id','category_id'], id_data)
            log += '(' + ','.join(map(str, ['product_id','category_id'])) + ') ' + id_data + ' ' + r + '\n'

        return 'successfully added product: {0}, pid: {1}\nlog:\n{2}'.format(values[0], pid, log)
    except:
        return 'failed to add category relations'

# Change the price of a product
@products.route('/change-price', methods=['POST'])
def change_price():
    new_price = request.form.get('unit_price')
    pid = request.form.get('product_id')

    return update_table_entry('product', 'unit_price', new_price, 'product_id', pid)