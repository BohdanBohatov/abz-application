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

chown apache:apache /etc/httpd/conf/httpd.conf
systemctl restart httpd


#Create DB for WordPress
mysql -h $MYSQL_HOST --password=$MYSQL_PASSWORD -u $MYSQL_USER --port=$MYSQL_PORT -D mysql -e "CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

#Installing and activating cache plugin
#wp core install --url=$WORDPRESS_URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --path=/var/www/html
#sudo -u ec2-user -i -- wp plugin install w3-total-cache --activate --path=/var/www/html