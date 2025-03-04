#!/bin/sh

# Start MariaDB
service mariadb start

sleep 10

# Setup MariaDB
echo "Running database setup..."
mariadb -u root -p$DB_ROOT_PASSWORD << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
CREATE USER IF NOT EXISTS '$DB_ADMIN_USER'@'%' IDENTIFIED BY '$DB_ADMIN_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_ADMIN_USER';
FLUSH PRIVILEGES;
USE $DB_NAME;
CREATE TABLE IF NOT EXISTS users (
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(50) NOT NULL,
	password VARCHAR(12) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL
);
EOF

# Stop MariaDB
mariadb-admin -u root -p$DB_ROOT_PASSWORD shutdown

# Restart MariaDB in the foreground
echo "Restarting MariaDB in the foreground..."
exec mysqld_safe
echo "Database setup complete."
