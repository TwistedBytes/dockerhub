#!/bin/bash

_TARGET_DIR=$1

if [[ ${_TB_FORCE_USE_DIR} != "Y" ]] && [[ `find $_TARGET_DIR | tail -n 1` != $_TARGET_DIR ]];then
  echo directory is not empty, will do nothing.
  exit 1
fi

CDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir ${_TARGET_DIR}/src  || true

cp ${CDIR}/.env ${CDIR}/docker-compose.yml ${_TARGET_DIR}/  || true
echo ".idea/" > ${_TARGET_DIR}/.gitignore

if [[ -n ${_TB_UIDGID} ]]; then
  uid=`echo "${_TB_UIDGID}" | cut -d: -f 1`
  gid=`echo "${_TB_UIDGID}" | cut -d: -f 2`

  sed -r -i \
    -e "s/APP_USER_ID=.*/APP_USER_ID=${uid}/"  \
    -e "s/APP_GROUP_ID=.*/APP_GROUP_ID=${gid}/"  \
    -e "s/_TB_UIDGID=.*/_TB_UIDGID=${_TB_UIDGID}/"  \
    ${_TARGET_DIR}/.env
fi
