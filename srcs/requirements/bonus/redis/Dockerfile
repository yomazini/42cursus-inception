FROM debian:bookworm

RUN  apt -qqy update && apt -qqy upgrade && apt -qqy install redis-server

COPY --chmod=755 tools/redis.sh /usr/local/bin

ENTRYPOINT [ "redis.sh" ]
