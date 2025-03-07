#!/bin/bash
set -e

#Export env variables from script, it contains secrets arn for MySql, Wordpress Admin, Mysql, url for Redis, MySql
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

#Env variables to be used by user
declare -A ENV_VARS
ENV_VARS=(
    ["WORDPRESS_DB"]=$WORDPRESS_DB
    ["MYSQL_HOST"]=$MYSQL_HOST
    ["MYSQL_PORT"]=$MYSQL_PORT
    ["MYSQL_USER"]=$MYSQL_USER
    ["MYSQL_PASSWORD"]=$MYSQL_PASSWORD
    ["REDIS_URL"]=$REDIS_URL
)

# Loop through each key-value pair in the array, and check does /etc/environment has it, then add or replace value witn new value
for VAR_VALUE in "${!ENV_VARS[@]}"; do
    NEW_VALUE="${ENV_VARS[$VAR_VALUE]}"

    # Check if the variable already exists in /etc/environment
    if grep -q "^$VAR_VALUE=" /etc/environment; then
        # Extract the current value
        CURRENT_VALUE=$(grep "^$VAR_VALUE=" /etc/environment | cut -d'=' -f2-)

        # Only update if the value is different
        if [ "$CURRENT_VALUE" != "$NEW_VALUE" ]; then
            sed -i "s|^$VAR_VALUE=.*|$VAR_VALUE=$NEW_VALUE|" /etc/environment
        fi
    else
        echo "$VAR_VALUE=$NEW_VALUE" | sudo tee -a /etc/environment
    fi
done

source /etc/environment

chown apache:apache /etc/httpd/conf/httpd.conf
chown apache:apache /var/www/html/wp-config.php
systemctl restart httpd

#Create database for WordPress if it is not created
mysql -h $MYSQL_HOST --password=$MYSQL_PASSWORD -u $MYSQL_USER --port=$MYSQL_PORT -D mysql -e "CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

#Installing and configuring wordpress
ADMIN_SECRET=$(aws secretsmanager get-secret-value --secret-id "$WORDPRESS_CREDENTIALS_SECRET_ARN" --query 'SecretString' --output text)
ADMIN_USER=$(echo $ADMIN_SECRET | jq -r '.admin_name')
ADMIN_PASSWORD=$(echo $ADMIN_SECRET | jq -r '.admin_password')

sudo -u apache wp core install --url=alphabetagamazeta.site --title=Title --admin_user=admin --admin_password=passwd --admin_email=example@example.com --path=/var/www/html
sudo -u apache wp plugin install redis-cache --activate --path=/var/www/html
sudo -u apache wp redis enable --path=/var/www/html