#!/bin/bash

#-- help section

#-- end help section, keep 1 line free above
# =

# all paths need to be of www-data:www-data
# /var/log/php-fpm, /run/php-fpm, /var/lib/php

mkdir -p /var/log/php-fpm /run/php-fpm /var/lib/php /var/lib/php/session
chown -Rf www-data:www-data /var/log/php-fpm /run/php-fpm /var/lib/php /var/lib/php/session
chmod 755 /var/log/php-fpm /run/php-fpm /var/lib/php /var/lib/php/session
