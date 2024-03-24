#!/bin/bash

aws s3 cp s3://courses-buck/init.sql /root/init.sql --region eu-central-1

sleep 10

mysql < /root/init.sql
