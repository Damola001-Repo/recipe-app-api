#!/bin/sh

set -e

envsubst < /etc/ngnix/default.conf.tpl > /etc/nginx/conf.d/default.conf
nginx -g 'daemon off;'
