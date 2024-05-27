CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'Pa55WD';
SELECT user FROM mysql.user;
create database flask_db;
grant ALL on flask_db.* to 'admin'@'%';
SHOW DATABASES;
