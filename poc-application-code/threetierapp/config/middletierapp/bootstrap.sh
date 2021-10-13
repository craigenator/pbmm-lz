## Update the Authorized networks in Cloud SQL
## to allow this instance to connect to the database 
## then follow the below steps to setup the middle-tier app on the instance

#!/bin/bash
apt update
apt install -y python3-pip gcc python-dev python-setuptools libffi-dev nginx
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
## copy nginx.conf to instance
service nginx stop
service nginx start
## copy middletierapp/requirements.txt to instance 
pip3 install -r requirements.txt
## copy readfromcloudsql.py to instance
python3 readfromcloudsql.py     # start flask to serve api