from flask import Blueprint, request, jsonify, make_response
import json
from src import db
from src.debug import execute_query


suppliers = Blueprint('suppliers', __name__)

# Get all the suppliers from the database
@suppliers.route('/', methods=['GET'])
def get_suppliers():
    query = 'select * from supplier'

    return execute_query(query)

# get the data for a specific supplier from the database using its id
@suppliers.route('/<sid>')
def get_specific_supplier(sid):
    query = '''
        SELECT s.*, c.company_id, c.company_name FROM supplier s
        NATURAL JOIN company c
        WHERE s.supplier_id = {0};'''.format(sid)

    return execute_query(query)

# get the data for a specific supplier's products from the database using the supplier id
@suppliers.route('/<sid>/products')
def get_supplier_products(sid):
    query = '''
        SELECT s.supplier_id, p.product_id, p.product_name, p.rating FROM supplier s
        NATURAL JOIN products p
        WHERE s.supplier_id = {0};'''.format(sid)

    return execute_query(query)

# get the data for a specific supplier's company from the database using the supplier id
@suppliers.route('/<sid>/company')
def get_supplier_company(sid):
    query = '''
        SELECT c.* FROM supplier s
        NATURAL JOIN company c
        WHERE s.supplier_id = {0};'''.format(sid)

    return execute_query(query)

# Get a suppliers's sales data using its id -- DOES NOT QUERY ALL DESIRED INFORMATION
@suppliers.route('/<sid>/sales-data', methods=['GET'])
def get_product_sales(sid):
    query = '''
        SELECT s.supplier_id, p.product_id, p.product_name, il.quantity, il.unit_price, i.total, i.date, i.customer_id
        FROM supplier s
        JOIN company c ON s.supplier_id = c.supplier_id
        JOIN products p ON s.supplier_id = p.supplier_id
        JOIN invoice_line il ON p.product_id = il.product_id
        JOIN invoice i ON il.invoice_id = i.invoice_id
        WHERE s.supplier_id = {0};'''.format(sid)
    
    return execute_query(query)