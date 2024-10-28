#!/bin/bash

if [[ ${_RUN_PHP_ROOT} != "Y" ]]; then
  if [[ -d /aa-run-on-start/scripts ]]; then
    for i in /aa-run-on-start/scripts/user-switch/*.sh; do
      [[ -n $_TB_DEBUG ]] && echo running $i;
      bash -e ${_TB_DEBUG} $i
      # sleep 0.1
    done
  fi
fi