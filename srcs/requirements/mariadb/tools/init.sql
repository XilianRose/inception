CREATE DATABASE IF NOT EXISTS my_database;
CREATE USER IF NOT EXISTS 'my_user'@'%' IDENTIFIED BY 'my_password';
GRANT ALL PRIVILEGES ON my_database;.* TO 'my_user';
FLUSH PRIVILEGES;
