#!/bin/bash


MYSQL_USER=$(aws ssm get-parameter --name "MYSQL_USER" --query "Parameter.Value"  --region eu-central-1)
MYSQL_PASSWORD=$(aws ssm get-parameter --name "MYSQL_PASSWORD" --query "Parameter.Value"  --region eu-central-1 --with-decryption)
MYSQL_DB=$(aws ssm get-parameter --name "MYSQL_DB" --query "Parameter.Value"  --region eu-central-1)
MYSQL_HOST=$(aws ssm get-parameter --name "MYSQL_HOST" --query "Parameter.Value"  --region eu-central-1)
if [ -f ~/.app_env ]
then
        echo "export MYSQL_USER=$MYSQL_USER" > ~/.app_env
        echo "export MYSQL_PASSWORD=$MYSQL_PASSWORD" >> ~/.app_env
        echo "export MYSQL_DB=$MYSQL_DB" >> ~/.app_env
        echo "export MYSQL_HOST=$MYSQL_HOST" >> ~/.app_env
else
        echo ". ~/.app_env" >> ~/.bashrc
        echo "export MYSQL_USER=$MYSQL_USER" > ~/.app_env
        echo "export MYSQL_PASSWORD=$MYSQL_PASSWORD" >> ~/.app_env
        echo "export MYSQL_DB=$MYSQL_DB" >> ~/.app_env
        echo "export MYSQL_HOST=$MYSQL_HOST" >> ~/.app_env
fi
source ~/.bashrc
