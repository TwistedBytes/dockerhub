#!/bin/sh

#-- help section

#-- end help section, keep 1 line free above
# =

if [[ ${_TB_PHPFPM} != Y ]]; then
  exit 0
fi

# all paths need to be off www-data:www-data
# /var/log/php-fpm, /run/php-fpm, /var/lib/php

mkdir -p /var/log/php-fpm /run/php-fpm /var/lib/php
chown -Rf www-data:www-data /var/log/php-fpm /run/php-fpm /var/lib/php
