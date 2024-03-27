#!/bin/bash
apt update
apt install -y git python3-pip awscli mariadb-client default-libmysqlclient-dev build-essential pkg-config


git clone -b orm https://github.com/saaverdo/flask-alb-app.git /home/ubuntu/flask-alb-app

chown -R ubuntu:ubuntu /home/ubuntu/flask-alb-app

aws s3 cp s3://courses-buck/web/change_param.sh /home/ubuntu/change_param.sh

su -c "bash /home/ubuntu/change_param.sh" ubuntu

chown ubuntu:ubuntu /home/ubuntu/change_param.sh

su -c "pip install -r /home/ubuntu/flask-alb-app/requirements.txt"

su -c "cd /home/ubuntu/flask-alb-app && gunicorn -b 0.0.0.0 appy:app" ubuntu &
