#!/bin/bash
set -e

#Export env variables from script
source /home/ec2-user/.env

#Retrive credentials from secrets manager to MySql DB
SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id "$MYSQL_SECRET_ARN" --query 'SecretString' --output text)

MYSQL_USER=$(echo $SECRET_VALUE | jq -r '.username')
MYSQL_PASSWORD=$(echo $SECRET_VALUE | jq -r '.password')

#Change variables in apache configuration file
sed -i "s/\$WORDPRESS_DB/${WORDPRESS_DB}/"  /etc/httpd/conf/httpd.conf
sed -i "s/\$MYSQL_HOST/${MYSQL_HOST}/"  /etc/httpd/conf/httpd.conf
sed -i "s/\$MYSQL_PORT/${MYSQL_PORT}/"  /etc/httpd/conf/httpd.conf
sed -i "s/\$MYSQL_USER/${MYSQL_USER}/"  /etc/httpd/conf/httpd.conf
sed -i "s/\$MYSQL_PASSWORD/${MYSQL_PASSWORD}/"  /etc/httpd/conf/httpd.conf

#Set Redis URL in config file for W3 Total Cache
sed -i "s/\$REDIS_URL/${REDIS_URL}/"  /home/ec2-user/w3-cache-settings.json

chown apache:apache /etc/httpd/conf/httpd.conf
chown apache:apache /var/www/html/wp-config.php
systemctl restart httpd

mysql -h $MYSQL_HOST --password=$MYSQL_PASSWORD -u $MYSQL_USER --port=$MYSQL_PORT -D mysql -e "CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

#Installing and configuring wordpress
#TODO store password in secrets manager
wp core install --url=example.com --title=Title --admin_user=admin --admin_password=passwd --admin_email=example@example.com --path=/var/www/html --allow-root
wp plugin install w3-total-cache --activate --path=/var/www/html --allow-root