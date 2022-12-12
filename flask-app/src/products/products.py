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

# Get approved products from the database
@products.route('/browse', methods=['GET', 'POST'])
def get_approved():
    likeness = request.form.get('like_str')

    query = 'select * from product where is_approved'
    if likeness != None:
        query += ' and product_name LIKE \'%{0}%\''.format(likeness)

    return execute_query(query)

# get all products that are pending approval
@products.route('/unapproved', methods=['GET'])
def get_unapproved():
    query = 'select * from product where is_approved = 0'

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
        SELECT p.*, pi.image_url FROM product p
        JOIN product_image pi ON p.product_id = pi.product_id
        WHERE p.product_id = {0};
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

    # add image
    try:
        image_data = '({0},\'{1}\')'.format(pid, request.form.get('image_url'))
        add_item('product_image', ['product_id','image_url'], image_data)
    except:
        return 'failed to add image'

    # create new category relations
    try:
        for v in request.form.get('categories')[1::2]:
            id_data = '({0},{1})'.format(pid, v)
            add_item('category_product', ['product_id','category_id'], id_data)

        return 'successfully added product: {0}, pid: {1}'.format(values[0], pid)
    except:
        return 'failed to add category relations'

# Change the price of a product
@products.route('/change-price', methods=['POST'])
def change_price():
    new_price = request.form.get('unit_price')
    pid = request.form.get('product_id')

    return update_table_entry('product', 'unit_price', new_price, 'product_id', pid)


# Change the name of a product
@products.route('/change-name', methods=['POST'])
def change_name():
    new_name = request.form.get('product_name')
    pid = request.form.get('product_id')

    return update_table_entry('product', 'product_name', new_name, 'product_id', pid)


# Change the description of a product
@products.route('/change-desc', methods=['POST'])
def change_desc():
    new_desc = request.form.get('desc')
    pid = request.form.get('product_id')

    return update_table_entry('product', 'description', new_desc, 'product_id', pid)


# Change the quantity of a product
@products.route('/change-quantity', methods=['POST'])
def change_quant():
    new_quant = request.form.get('quantity')
    pid = request.form.get('product_id')

    return update_table_entry('product', 'quantity', new_quant, 'product_id', pid)

# Approve a product
@products.route('/approve-product', methods=['POST'])
def approve_product():
    pid = request.form.get('product_id')
    return update_table_entry('product', 'is_approved', 1, 'product_id', pid)

# Unapprove a product
@products.route('/unapprove-product', methods=['POST'])
def unapprove_product():
    pid = request.form.get('product_id')
    return update_table_entry('product', 'is_approved', 0, 'product_id', pid)