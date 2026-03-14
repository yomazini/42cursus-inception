FROM debian:bookworm


RUN apt -qqy update && apt -qqy upgrade

ADD https://github.com/portainer/portainer/releases/download/2.33.1/portainer-2.33.1-linux-amd64.tar.gz /tmp/portainer.tar.gz

WORKDIR /usr/local/bin/

RUN tar -xzf /tmp/portainer.tar.gz && chmod +x /usr/local/bin/portainer && rm /tmp/portainer.tar.gz && echo "extracted mann"

ENTRYPOINT [ "portainer/portainer" ] 
