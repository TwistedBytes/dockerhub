#!/bin/bash

# set -x

if [[ -z ${_TB_START_CMD} ]]; then
  _TB_LAST_COMMAND="gosu www-data php-fpm -F -O"
else
  _TB_LAST_COMMAND="${_TB_START_CMD}"
fi

echo ${_TB_LAST_COMMAND} > /command.txt
