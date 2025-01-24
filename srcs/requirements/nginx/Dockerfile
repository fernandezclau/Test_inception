FROM	debian:bullseye

EXPOSE	443

RUN		apt update && apt install -y --no-install-recommends --no-install-suggests \
		nginx \
		openssl && \
		rm -rf /var/lib/apt/lists/*

ARG		/etc/nginx/certs/ /etc/nginx/certs/claferna.crt /etc/nginx/certs/claferna.key ES MA Madrid 42 42 claferna.42.fr

RUN mkdir -p /etc/nginx/certs/ && \
	openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/certs/claferna.crt \
    -keyout /etc/nginx/certs/claferna.key \
    -subj "/C=ES/ST=MA/L=Madrid/O=42/OU=42/CN=claferna.42.fr"

COPY	conf/nginx.conf	/etc/nginx/
COPY	conf/server.conf	/etc/nginx/conf.d/

RUN		mkdir -p /var/www/
RUN		chown -R www-data:www-data /var/www/

CMD		["nginx", "-g", "daemon off;"]