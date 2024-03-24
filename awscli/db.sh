#!/bin/bash

apt update
apt install -y mariadb-server awscli

echo "[mysqld]" >> /etc/mysql/my.cnf
echo "bind-address = 0.0.0.0" >> /etc/mysql/my.cnf

systemctcl restart mysql
