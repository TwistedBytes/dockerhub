#!/bin/bash

#-- help section
# INPUTVAR _TB_PHPFPM
#     Only value is Y, if Y then php-fpm config is created

#-- end help section, keep 1 line free above

if [[ ${_TB_PHPFPM} != Y ]]; then
  exit 0
fi

if [[ $( id -u ) -ne 0 ]]; then
  echo "please do no use 'user: ' in docker composer for this"
  echo "this docker will switch to the right user itself when using the right ENV vars"
  echo "Use ENV _TB_UIDGID_FROMDIR or _TB_UIDGID for that"
  exit 1
fi

export _TB_PHPFPM_CREATEUSER=Y
