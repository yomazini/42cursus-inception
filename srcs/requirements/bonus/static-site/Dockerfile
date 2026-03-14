FROM debian:bookworm

RUN apt -qqy update && apt -qqy upgrade && apt -qqy install nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log


COPY conf/index.html /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]
