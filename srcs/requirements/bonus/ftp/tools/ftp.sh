#!/bin/bash
set -e

if [ ! -f /etc/.flag_true ]; then
  export FTP_PASSWORD=$(cat /run/secrets/ftp_password)

  useradd -m "$FTP_USER"
  echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

  chown -R "$FTP_USER" /var/www/html

  touch /etc/.flag_true
fi

exec vsftpd /etc/vsftpd.conf
