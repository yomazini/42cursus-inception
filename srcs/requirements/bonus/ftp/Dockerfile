FROM debian:bookworm

RUN apt -qqy update && apt -qqy upgrade && apt -qqy install vsftpd

RUN mkdir -p /var/run/vsftpd/empty

COPY --chmod=755 tools/ftp.sh /usr/local/bin/

COPY conf/ftp.conf /etc/vsftpd.conf

ENTRYPOINT [ "ftp.sh" ]

