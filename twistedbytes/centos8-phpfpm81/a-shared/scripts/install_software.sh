#!/bin/sh

_SCRIPTDIR=$1

set -e

cat << 'EOT' > /etc/yum.repos.d/twistedbytes.repo
[twistedbtyesrepo]
name=twistedbtyes centos repo
baseurl=http://repository.twistedbytes.eu/centos/$releasever/
enabled=1
gpgcheck=0
priority=99
[twistedbtyesrepo-test]
name=twistedbtyes centos repo test
baseurl=http://repository.twistedbytes.eu/centos/$releasever-test/
enabled=1
gpgcheck=0
priority=1

EOT

dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \

dnf -y --setopt=tsflags=nodocs install \
 bind-utils curl \
 iproute sudo ca-certificates

cat << 'EOT' > /etc/sudoers.d/10-www-data
Defaults:www-data !requiretty
www-data  ALL=(ALL) NOPASSWD: ALL

EOT

mkdir -p /bin/docker-entrypoint/ \
 && cp ${_SCRIPTDIR}/docker-entrypoint/* /bin/docker-entrypoint/ \
 && chmod +x -R /bin/docker-entrypoint/ \
;

mkdir -p /usr/local/bin/autorun
cp ${_SCRIPTDIR}/autorun.sh /usr/local/bin/

cp ${_SCRIPTDIR}/autorun/myhostip.sh /usr/local/bin/autorun
cp ${_SCRIPTDIR}/autorun/chown-logdirs.sh /usr/local/bin/autorun

#cp ${_SCRIPTDIR}/autorun/fixhostip.sh /usr/local/bin/autorun
#chmod 755 /usr/local/bin/autorun/fixhostip.sh
#chmod 666 /etc/hosts
