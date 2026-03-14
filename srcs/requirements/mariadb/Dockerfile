FROM debian:bookworm

RUN apt -qqy update && apt -qqy upgrade && apt -qqy install mariadb-server

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/99-mariadb.cnf

COPY --chmod=755 tools/mariadb.sh /usr/local/bin/

ENTRYPOINT [ "mariadb.sh" ]