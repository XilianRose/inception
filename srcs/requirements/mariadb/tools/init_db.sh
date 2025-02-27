#!/bin/sh

# Start MariaDB
service mariadb start

sleep 5

# Setup MariaDB
echo "Running database setup..."
mariadb -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
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
service mariadb stop

# Restart MariaDB in the foreground
echo "Restarting MariaDB in the foreground..."
exec mysqld_safe
echo "Database setup complete."
