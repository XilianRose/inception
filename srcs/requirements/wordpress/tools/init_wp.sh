#!/bin/sh

# Download WordPress via CLI
echo "Downloading WordPress CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

echo "Downloading WordPress core files..."
wp core download --path=/var/www/html/wordpress --allow-root

chmod -R 755 /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress

# Configure WordPress
echo "Configuring WordPress..."
cd /var/www/html/wordpress
if [ ! -f /wp-config.php ]; then
	wp config create --dbhost=$DB_HOST --dbname=$DB_NAME --dbuser=$DB_ADMIN_USER --dbpass=$DB_ADMIN_PASSWORD --allow-root
	if [ $? -ne 0 ]; then
		echo "Error creating wp-config.php"
		exit 1
	fi
else
	echo "wp-config.php already exists."
fi

echo "Installing WordPress..."
wp core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
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
