#!/bin/bash

# set -x

if [[ -z ${_TB_START_CMD} ]] || [[ ${_TB_START_CMD} == "/usr/sbin/httpd -DFOREGROUND" ]]; then
  _TB_LAST_COMMAND="gosu www-data /usr/sbin/httpd -DFOREGROUND"
else
  _TB_LAST_COMMAND="${_TB_START_CMD}"
fi

echo ${_TB_LAST_COMMAND} > /command.txt
