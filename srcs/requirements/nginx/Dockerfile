FROM debian:bookworm-slim

# Install nginx and openssl
RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends nginx openssl && \
	mkdir -p /etc/nginx/ssl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Generate a self-signed certificate & key
RUN openssl genpkey -algorithm ed25519 -out /etc/nginx/ssl/inception.key && \
	openssl req -new -x509 -key /etc/nginx/ssl/inception.key \
	-out /etc/nginx/ssl/inception.crt \
	-subj "/C=NL/O=42/CN=mstegema.42.fr/UID=mstegema" && \
	chmod 600 /etc/nginx/ssl/inception.key

# Copy the nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# EXPOSE 443

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
