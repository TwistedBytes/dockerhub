#!/bin/sh

rm -Rf /tmp/scripts

#yum -y remove \
# perl \


yum clean all

cd /var/lib/yum
for i in *; do rm $i/* -Rf; done

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# remove under tmp directory
rm -rf /tmp/*
rm -rf /var/tmp/yum-*

