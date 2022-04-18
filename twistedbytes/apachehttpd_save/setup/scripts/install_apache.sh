#!/bin/bash

set -e

CDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

dnf clean all && \
  dnf -y --setopt=tsflags=nodocs install \
  epel-release.noarch \

cat << 'EOT' > /etc/yum.repos.d/twistedbytes.repo
[twistedbtyesrepo]
name=twistedbtyes centos 7 repo
baseurl=http://repository.twistedbytes.eu/centos/$releasever/
enabled=1
gpgcheck=0
priority=99
module_hotfixes=1

[twistedbtyesrepo-test]
name=twistedbtyes centos 7 repo test
baseurl=http://repository.twistedbytes.eu/centos/$releasever-test/
enabled=1
gpgcheck=0
priority=1
module_hotfixes=1

EOT

dnf clean all && \
  dnf -y --setopt=tsflags=nodocs install \
  httpd httpd-tools mod_ssl mod_http2 wget openssl

mkdir -p /run/httpd
rm -Rf /etc/httpd
cp -Rf ${CDIR}/../config/httpd /etc/httpd
ln -s /var/log/httpd /etc/httpd/logs && \
  ln -s /usr/lib64/httpd/modules /etc/httpd/modules && \
  ln -s /run/httpd /etc/httpd/run



