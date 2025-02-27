#!/bin/sh

# Download WordPress via CLI
echo "Downloading WordPress CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

chown -R www-data:www-data /var/www/wordpress

echo "Downloading WordPress core files..."
wp core download --path=/var/www/wordpress --allow-root

# Configure WordPress
echo "Configuring WordPress..."
wp config create --dbhost=$DB_HOST --dbname=$DB_NAME --dbuser=$DB_ADMIN_USER --dbpass=$DB_ADMIN_PASSWORD --allow-root

echo "Installing WordPress..."
wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
wp user create $WP_USER_1 $WP_EMAIL_1 --role=$WP_ROLE_1 --user_pass=$WP_PASSWORD_1 --allow-root
echo "WordPress setup complete."

# Start PHP
echo "Starting PHP setup..."
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf
if [ ! -d "/run/php" ]; then
	mkdir /run/php
fi
echo "PHP setup complete."
exec /usr/sbin/php-fpm7.4 -F
