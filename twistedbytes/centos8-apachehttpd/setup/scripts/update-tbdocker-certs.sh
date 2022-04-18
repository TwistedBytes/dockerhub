#!/bin/bash

# set -x

CERTIFICATEFILE=/etc/ssl/tbdocker.xyz/cert.pem
CERTIFICATE_DOWNLOAD=https://tbdev.xyz/tbdocker-certs.tgz

function getCertDates(){
    CURRENTSTARTDATE=`date --date="$(openssl x509 -in ${CERTIFICATEFILE} -noout -startdate | cut -d= -f 2)" +%s`
    CURRENTENDDATE=`date --date="$(openssl x509 -in ${CERTIFICATEFILE} -noout -enddate | cut -d= -f 2)" +%s`
    CURRENTDATE=`date +%s`
    CURRENTVALIDDAYS=$(( (${CURRENTENDDATE} - ${CURRENTDATE})/86400 ))
    CURRENTVALIDMINUTES=$(( ((${CURRENTENDDATE} - ${CURRENTDATE}) % 86400) / 60 ))
}

[[ -d /etc/ssl/tbdocker.xyz ]] && getCertDates

if [[ ${CURRENTVALIDDAYS} -lt 15 ]] || [[ ! -d /etc/ssl/tbdocker.xyz ]]; then

    cd /etc/ssl
    wget -q ${CERTIFICATE_DOWNLOAD}
    _EXIT_CODE=$?
    if [[ $_EXIT_CODE -eq 0 ]]; then
        rm -Rf ./tbdocker.xyz
        tar xzf tbdocker-certs.tgz
        rm -f tbdocker-certs.tgz
        echo "updated certificate";
    else
        echo "update certificate not found";
    fi

fi

chown -Rf www-data:www-data /etc/ssl/tbdocker.xyz
