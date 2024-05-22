#!/bin/bash

env_file=/usr/local/bin/flask-app.env

# MYSQL_PASSWORD="Pa55WD"
# MYSQL_USER="admin"
# MYSQL_DB="flask_db"
# MYSQL_HOST=172.16.30.116
MYSQL_PASSWORD=$(aws ssm get-parameter --name "MYSQL_PASSWORD"  --region eu-central-1 --with-decryption --query "Parameter.Value"  --output text)
MYSQL_USER=$(aws ssm get-parameter --name "MYSQL_USER"  --region eu-central-1 --with-decryption --query "Parameter.Value"  --output text)
MYSQL_DB=$(aws ssm get-parameter --name "MYSQL_DB"  --region eu-central-1 --with-decryption --query "Parameter.Value"  --output text)
MYSQL_HOST=$(aws ssm get-parameter --name "MYSQL_HOST"  --region eu-central-1 --with-decryption --query "Parameter.Value"  --output text)


echo "MYSQL_PASSWORD="$MYSQL_PASSWORD > $env_file
echo "MYSQL_USER="$MYSQL_USER >> $env_file
echo "MYSQL_DB="$MYSQL_DB >> $env_file
echo "MYSQL_HOST="$MYSQL_HOST >> $env_file
