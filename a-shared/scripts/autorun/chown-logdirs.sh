#!/bin/bash

for i in `cat /etc/logdirs.txt`; do
  sudo chown -R www-data:www-data $i;
done
