FROM debian:bookworm-slim

# Install mariadb
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends mariadb-server mariadb-client && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* \

# Copy the mariadb configuration file & script to initialize the database
COPY ./conf/99-custom.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf
COPY ./tools/init.sql /docker-entrypoint-initdb.d/init.sql
COPY ./tools/init_db.sh /docker-entrypoint-initdb.d/init_db.sh

# Change the permissions of the script
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh
