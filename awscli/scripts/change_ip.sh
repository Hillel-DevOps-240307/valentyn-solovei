#!/bin/bash


web_ip_in_ssh_conf=$(grep -A1 web-demo  ~/.ssh/config  |grep -e "hostname.*") #pub  web ip

web_ip_in_aws=$(aws ec2 describe-instances \
                --filters "Name=tag:Name,Values=demo-web-hw4"\
                --query "Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[].Association[].PublicIp" \
                --output text) #pub web ip

db_ip_in_ssh_conf=$(grep -A1 db-demo  ~/.ssh/config  |grep -e "hostname.*") #priv db ip

db_ip_in_aws=$(aws ec2 describe-instances \
               --filter Name=instance-state-code,Values=16 Name=tag:Name,Values=demo-db-hw4 \
                --query "Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddresses[].PrivateIpAddress"\
                --output text) #priv db ip


#sed -i "s/$web_ip_in_ssh_conf/\thostname $web_ip_in_aws/g" ~/.ssh/config
#sed -i "s/$db_ip_in_ssh_conf/\thostname $db_ip_in_aws/g" ~/.ssh/config



[ ! -z "$web_ip_in_aws" ] && sed -i "s/$web_ip_in_ssh_conf/\thostname $web_ip_in_aws/g" ~/.ssh/config
[ ! -z "$db_ip_in_aws" ] &&  sed -i "s/$db_ip_in_ssh_conf/\thostname $db_ip_in_aws/g" ~/.ssh/config
