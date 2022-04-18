#!/bin/bash

set -e

CDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p /run/httpd
rm -Rf /etc/httpd
cp -Rf ${CDIR}/../config/httpd /etc/httpd
ln -s /var/log/httpd /etc/httpd/logs && \
  ln -s /usr/lib64/httpd/modules /etc/httpd/modules && \
  ln -s /run/httpd /etc/httpd/run





