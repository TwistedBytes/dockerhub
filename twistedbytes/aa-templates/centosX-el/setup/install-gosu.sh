#!/bin/bash

GOSU_VERSION=1.14

set -e
set -x

case `arch` in
  x86_64)
    _ARCH=amd64
  ;;
  aarch64)
    _ARCH=arm64
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
