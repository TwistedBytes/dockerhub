#!/bin/bash

set -e

APP_USER=$1
APP_GROUP=$2
APP_CODE_PATH_CONTAINER=$3

VHOSTDEVCONF=/etc/httpd/vhosts.d/dev.local.conf
BASEDIR=/var/www/vhost/defaultsite
DATAWEBCONF=${BASEDIR}/config/webservervhost.conf

getRealDocrootDir(){
    local docrootin=$1
    local docrootbase=${BASEDIR}/site/

    if [[ ${docrootin:0:1} == "/" ]]; then
        _DOCROOT=${docrootin}
    else
        _DOCROOT="${docrootbase}${docrootin}"
    fi
}

if [[ -f ${BASEDIR}/config/webservervhost.conf ]]; then
    . ${DATAWEBCONF}
    if [[ ! -z $DOCROOT ]]; then
        getRealDocrootDir $DOCROOT
        echo "using alternative docroot: ${_DOCROOT}"
    fi
fi

if [[ -z $_DOCROOT ]]; then
    _DOCROOT=${BASEDIR}/site/docroot
fi

mkdir -p ${BASEDIR}/site
if [ ! -e  ${_DOCROOT} ]; then
    mkdir -p ${BASEDIR}/site/docroot
else
    echo "Skipping creation of ${BASEDIR}/site/docroot, it already exists"
fi
mkdir -p ${BASEDIR}/{private{/bin,/databasedumps,/php-sessions,/php-tmp,/proxy-cache},logs{/web,/php},config,bin}

chown ${APP_USER}:${APP_GROUP} ${BASEDIR}
chown ${APP_USER}:${APP_GROUP} ${BASEDIR}/site
chown ${APP_USER}:${APP_GROUP} ${_DOCROOT}
chown ${APP_USER}:${APP_GROUP} ${BASEDIR}/{private{/bin,/databasedumps,/php-sessions,/php-tmp,/proxy-cache},logs{/web,/php},config,bin}
