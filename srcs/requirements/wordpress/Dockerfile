FROM debian:bookworm

WORKDIR /var/www/html

RUN apt -qqy update && apt -qqy upgrade && apt install -qqy php php-fpm php-mysql php-phar && apt remove apache2 -qqy

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

COPY --chmod=755 tools/wordpress.sh /usr/local/bin/

ENTRYPOINT [ "wordpress.sh" ]
