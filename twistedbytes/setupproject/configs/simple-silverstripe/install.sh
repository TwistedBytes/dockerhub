#!/bin/bash

_TARGET_DIR=$1

if [[ `find $_TARGET_DIR | tail -n 1` != $_TARGET_DIR ]];then
  echo directory is not empty, will do nothing.
  exit 1
fi

CDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p ${_TARGET_DIR}/logs/{httpd,phpfpm} || true
echo "*.log" > ${_TARGET_DIR}/logs/httpd/.gitignore
echo "*.log" > ${_TARGET_DIR}/logs/phpfpm/.gitignore

mkdir ${_TARGET_DIR}/src  || true

cp ${CDIR}/.env ${CDIR}/docker-compose.yml ${_TARGET_DIR}/  || true

composer create-project silverstripe/installer ${_TARGET_DIR}/src/

