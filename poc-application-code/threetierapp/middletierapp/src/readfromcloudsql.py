from flask import Flask
from flask_restful import Resource, Api, reqparse
import pandas as pd
import ast
import mysql.connector
from mysql.connector.constants import ClientFlag

config = {
    'user': 'root',
    'password': 'password',
    'host': '10.10.10.10'
}

app = Flask(__name__)
api = Api(app)


class Customers(Resource):
    def get(self):
        cnxn = mysql.connector.connect(**config)
        config['database'] = 'poc_database_1'  # add new database to config dict
        cnxn = mysql.connector.connect(**config)
        cursor = cnxn.cursor()
        cursor.execute("select * from customers")
        myresult = cursor.fetchall()
        return {'data': myresult}, 200  # return data and 200 OK code    pass
    
    def post(self):
        parser = reqparse.RequestParser()  # initialize
        parser.add_argument('namestring', required=True)  # add args
        args = parser.parse_args()  # parse arguments to dictionary

        input = args['namestring']

        cnxn = mysql.connector.connect(**config)
        config['database'] = 'poc_database_1'  # add new database to config dict
        cnxn = mysql.connector.connect(**config)
        cursor = cnxn.cursor()
        name = (input, )
        query = "select * from customers where name = %s"

        count = cursor.execute(query, name)
        myresult = cursor.fetchall()

        if not myresult:
            return {'data': 'Not Found!'}, 200  # return 200 OK code
        else:
            return {'data': myresult}, 200  # return data and 200 OK code

   
api.add_resource(Customers, '/allcustomers')  # '/allcustomers' is the entry point for the api

if __name__ == '__main__':
    app.run(port=5000)  # run Flask app