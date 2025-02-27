#!/bin/bash

# Start MariaDB
echo "Starting MariaDB..."
service mariadb start

sleep 5

# Setup MariaDB
echo "Running additional database setup..."
mariadb -u root << EOF
USE my_database;
CREATE TABLE IF NOT EXISTS users (
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(50) NOT NULL,
	password VARCHAR(12) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
);
ON DUPLICATE KEY UPDATE
	username = VALUES(username),
	password = VALUES(password),
	email = VALUES(email);
EOF

mariadb -u root shutdown

echo "Database setup complete."
