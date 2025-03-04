FROM debian:bullseye-slim

# Install mariadb
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends mariadb-server mariadb-client && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Temporary environment variables for testing
# ENV DOMAIN_NAME=mstegema.42.fr
# ENV DB_NAME=my_database
# ENV DB_ADMIN_USER=user_0
# ENV DB_ADMIN_PASSWORD=password_0

# Copy the mariadb configuration file & script to initialize the database
COPY ./conf/99-custom.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf
COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/init_db.sh

# Change the permissions of the script
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh

# Run the script to initialize the database
ENTRYPOINT ["sh", "/docker-entrypoint-initdb.d/init_db.sh"]
