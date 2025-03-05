#!/bin/bash
set -e

#Export env variables from script
source /home/ec2-user/.env

#Retrive credentials from secrets manager to MySql DB
SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id "$MYSQL_SECRET_ARN" --query 'SecretString' --output text)

MYSQL_USER=$(echo $SECRET_VALUE | jq -r '.username')
MYSQL_PASSWORD=$(echo $SECRET_VALUE | jq -r '.password')

#Change variables in apache configuration file
echo "WORDPRESS_DB=$WORDPRESS_DB" >> /etc/environment
echo "MYSQL_HOST=$MYSQL_HOST" >> /etc/environment
echo "MYSQL_PORT=$MYSQL_PORT" >> /etc/environment
echo "MYSQL_USER=$MYSQL_USER" >> /etc/environment
echo "MYSQL_PASSWORD=$MYSQL_PASSWORD" >> /etc/environment

systemctl restart httpd

mysql -h $MYSQL_HOST --password=$MYSQL_PASSWORD -u $MYSQL_USER --port=$MYSQL_PORT -D mysql -e "CREATE DATABASE IF NOT EXISTS \`${WORDPRESS_DB}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

