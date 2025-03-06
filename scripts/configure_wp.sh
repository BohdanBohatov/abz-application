#!/bin/bash
set -e

#Export env variables from script
source /home/ec2-user/.env

#Retrive credentials from secrets manager to MySql DB
SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id "$MYSQL_SECRET_ARN" --query 'SecretString' --output text)
MYSQL_USER=$(echo $SECRET_VALUE | jq -r '.username')
MYSQL_PASSWORD=$(echo $SECRET_VALUE | jq -r '.password')

#Change variables in apache configuration file, these variables used by PHP
sed -i "s/\$WORDPRESS_DB/${WORDPRESS_DB}/"  /etc/httpd/conf/httpd.conf
sed -i "s/\$MYSQL_HOST/${MYSQL_HOST}/"  /etc/httpd/conf/httpd.conf
sed -i "s/\$MYSQL_PORT/${MYSQL_PORT}/"  /etc/httpd/conf/httpd.conf
sed -i "s/\$MYSQL_USER/${MYSQL_USER}/"  /etc/httpd/conf/httpd.conf
sed -i "s/\$MYSQL_PASSWORD/${MYSQL_PASSWORD}/"  /etc/httpd/conf/httpd.conf
sed -i "s/\$REDIS_URL/${REDIS_URL}/"  /etc/httpd/conf/httpd.conf

#TODO check variables before adding them to /etc/environment
echo "WORDPRESS_DB=$WORDPRESS_DB" >> /etc/environment
echo "MYSQL_HOST=$MYSQL_HOST" >> /etc/environment
echo "MYSQL_PORT=$MYSQL_PORT" >> /etc/environment
echo "MYSQL_USER=$MYSQL_USER" >> /etc/environment
echo "MYSQL_PASSWORD='$MYSQL_PASSWORD'" >> /etc/environment

source /etc/environment

chown apache:apache /etc/httpd/conf/httpd.conf
chown apache:apache /var/www/html/wp-config.php
systemctl restart httpd

#Create database for WordPress if it is not created
mysql -h $MYSQL_HOST --password=$MYSQL_PASSWORD -u $MYSQL_USER --port=$MYSQL_PORT -D mysql -e "CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

#Installing and configuring wordpress
#TODO store password in secrets manager
sudo -u apache wp core install --url=example.com --title=Title --admin_user=admin --admin_password=passwd --admin_email=example@example.com --path=/var/www/html
sudo -u apache wp plugin install redis-cache --activate --path=/var/www/html
sudo -u apache wp redis enable --path=/var/www/html