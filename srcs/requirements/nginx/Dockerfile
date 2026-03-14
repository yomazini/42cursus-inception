FROM debian:bookworm

RUN apt -qqy update && apt -qqy upgrade && apt -qqy install openssl nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY conf/nginx.conf /etc/nginx/sites-available/default


COPY --chmod=755 tools/nginx.sh /usr/local/bin/

ENTRYPOINT [ "nginx.sh"]
