FROM armhf/debian:jessie
MAINTAINER "Mo" <root@ywclub.org>

RUN apt-get update

RUN apt-get install --no-install-recommends php5-fpm -y && \
sed -i "s#listen = /var/run/php5-fpm.sock#listen = 9000#g" /etc/php5/fpm/pool.d/www.conf && \
mkdir -p /var/www/html && \
apt-get clean all && \
rm -rf /var/lib/apt/lists/*

VOLUME ["/var/www/html"]

CMD ["php5-fpm", "-F"]
