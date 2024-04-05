#!/bin/bash

### using for instance user-data

aws ssm put-parameter --name "MYSQL_HOST" --value "$(hostname -I)" --overwrite --region eu-central-1
