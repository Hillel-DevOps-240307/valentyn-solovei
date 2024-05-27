FROM python:3.9.19-alpine

WORKDIR /app



RUN apk update --no-cache \
    && apk add \
    git \
    py3-pip \
    mariadb-connector-c-dev \
    gcc \
    g++ \
    pkgconfig \
    --no-cache    \
    && apk -v cache clean

RUN git clone -b orm https://github.com/saaverdo/flask-alb-app.git . && \
    pip install -r requirements.txt --break-system-packages --no-cache-dir

ENV MYSQL_USER="admin" \
    MYSQL_PASSWORD="Pa55WD" \
    MYSQL_DB="flask_db" \
    MYSQL_HOST="db_server" \
    FLASK_CONFIG=mysql

EXPOSE 8000

ENTRYPOINT [ "gunicorn", "-b", "0.0.0.0", "appy:app" ]
