#!/bin/bash

_ERROR=0

if [[ -z $_TB_CONFIG ]] || [[ ! -d /configs/$_TB_CONFIG ]]; then
  echo "I need a valid projecttype, use --projecttype argument, options:"
  echo
  ls -d /configs/* | sed -r -e 's#/configs/#  #g' | sort -n
  echo
  _ERROR=1
fi

if [[ -z $_TB_UIDGID ]]; then
  echo "I need a uid and gid with argument --uidgid, try this: --uidgid \$( id -u ):\$( id -g )"

  _ERROR=1
fi

if [[ $_ERROR -ne 0  ]]; then
  exit 1
fi
