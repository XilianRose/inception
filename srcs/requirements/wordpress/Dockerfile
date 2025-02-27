FROM debian:bookworm-slim

# Install wordpress & php
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends php php-mysql php8.4-fpm curl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Copy script to download and initialize wordpress
COPY ./tools/init_wp.sh /tmp/init_wp.sh

# Change the permissions of the script
RUN chmod +x /tmp/init_wp.sh

# Run the script to download and initialize wordpress
ENTRYPOINT ["sh", "/tmp/init_wp.sh"]
