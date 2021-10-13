## follow these steps to setup the web-tier app on the instance

#!/bin/bash
apt update
apt install -y apache2
systemctl enable apache2.service
## copy and replace index.html to instance at /var/www/html/
systemctl start apache2.service