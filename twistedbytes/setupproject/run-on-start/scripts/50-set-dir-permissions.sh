#!/bin/bash

_TB_UIDGID_FROMDIR=/projectroot

if [[ -z ${_TB_UIDGID} ]] && [[ -d ${_TB_UIDGID_FROMDIR} ]]; then
  uid=$(stat -c '%u' "$_TB_UIDGID_FROMDIR")
  gid=$(stat -c '%g' "$_TB_UIDGID_FROMDIR")

  export _TB_UIDGID=${uid}:${gid}
fi

chown -Rf ${_TB_UIDGID} /projectroot
