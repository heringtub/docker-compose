FROM armhf/debian:jessie
MAINTAINER "Mo" <root@ywclub.org>

RUN apt-get update

RUN apt-get install --no-install-recommends nginx -y  \
	&& rm -rf /etc/nginx/sites-enabled/* \
	&& sed -i "s/worker_processes 4;/worker_processes auto;/g" /etc/nginx/nginx.conf \
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& apt-get clean all \
	&& rm -rf /var/lib/apt/lists/*

COPY default.conf /etc/nginx/sites-enabled/

VOLUME ["/var/www/html"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
