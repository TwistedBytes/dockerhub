#!/bin/bash

#-- help section

#-- end help section, keep 1 line free above

#if [[ ${_TB_PHPFPM} != Y ]]; then
#  exit 0
#fi

GOSU_VERSION=1.14

case `arch` in
  x86_64)
    _ARCH=amd64
  ;;
  *)
    _ARCH=`arch`
  ;;
esac

if [[ ! -f /usr/local/bin/gosu ]]; then

  curl -sSLo /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-${_ARCH}" \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

fi
