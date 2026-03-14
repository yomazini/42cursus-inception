#!/bin/bash

set -e

sed -i "s|bind 127.0.0.1|bind 0.0.0.0|g" /etc/redis/redis.conf

sed -i "s|# maxmemory <bytes>|maxmemory 120mb|g" /etc/redis/redis.conf

echo "maxmemory-policy allkeys-lru" >>/etc/redis/redis.conf

exec redis-server --protected-mode no
