#!/bin/sh

set -e

rm -Rf /tmp/scripts

dnf clean all

cd /var/lib/dnf
for i in *; do rm $i/* -Rf; done

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# remove under tmp directory
rm -rf /tmp/*
rm -rf /var/tmp/yum-*
rm -rf /var/tmp/dnf-*

