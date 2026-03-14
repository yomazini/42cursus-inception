
FROM debian:bookworm


RUN apt -qqy update && apt -qqy upgrade && apt -qqy install php php-mysql


WORKDIR /var/adminer/

ADD https://www.adminer.org/latest.php index.php
 

ENTRYPOINT [ "php", "-S", "0.0.0.0:8080" ]
