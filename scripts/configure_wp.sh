#!/bin/bash
set -e

#TODO Modify wordpress
#1. Select language maybe set wp_config.php file?
#2. Create WP user (store password in secrets?)
#3. Modify database file
#4. Enalbe cache plugin
#5. Set redis to support cache
#Page cache
#Database cache
#Object cache


#Export env variables to script
echo "Start script" > /var/log/debug.log
source /home/ec2-user/codedeployscripts/.env

#Retrive credentials from secrets manager to MySql DB
echo "Retrive secrets" > /var/log/debug.log
SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id "$MYSQL_SECRET_ARN" --query 'SecretString' --output text)

MYSQL_USER=$(echo $SECRET_VALUE | jq -r '.username')
MYSQL_PASSWORD=$(echo $SECRET_VALUE | jq -r '.password')

echo "Move apache config file and change variables to correct" > /var/log/debug.log
#Move apache configuration file to conf folder
sudo mv /home/ec2-user/codedeployscripts/application/httpd.conf /etc/httpd/conf/httpd.conf
sudo sed -i "s/\$WORDPRESS_DB/${WORDPRESS_DB}/"  /etc/httpd/conf/httpd.conf
sudo sed -i "s/\$MYSQL_HOST/${MYSQL_HOST}/"  /etc/httpd/conf/httpd.conf
sudo sed -i "s/\$MYSQL_PORT/${MYSQL_PORT}/"  /etc/httpd/conf/httpd.conf
sudo sed -i "s/\$MYSQL_USER/${MYSQL_USER}/"  /etc/httpd/conf/httpd.conf
sudo sed -i "s/\$MYSQL_PASSWORD/${MYSQL_PASSWORD}/"  /etc/httpd/conf/httpd.conf

#sudo systemctl restart httpd

echo "Create database for wordpress" > /var/log/debug.log
#Create DB for WordPress
mysql -h $MYSQL_HOST --password=$MYSQL_PASSWORD -u $MYSQL_USER --port=$MYSQL_PORT -D mysql -e "CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

echo "Script ending" > /var/log/debug.log
#Installing and activating cache plugin
#sudo -u ec2-user -i -- wp plugin install w3-total-cache --activate --path=/var/www/html