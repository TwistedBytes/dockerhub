#!/bin/bash

# set -e
# set -x

MYDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

buildDir(){
  local DIR=$1
  
  if [ ! -f "${DIR}/Dockerfile" ]; then
    echo "!!! No Dockerfile in dir ${DIR}/"
    exit;
  fi 
  
  getParent ${DIR}
  existsParent ${PARENT}
  if [ $? -eq 1 ]; then
    echo ${PARENTPARTS[0]} | grep -q 'twistedbytes'
    if [ $? -eq 0 ]; then
    echo first building parent: ${PARENTPARTS[0]}
     echo ----- 
        
        ./build.sh ${PARENTPARTS[0]}
    else
        docker pull ${PARENT}
    fi 
  fi 

  getVersion ${DIR}
  local VERSION=$VERSION

  docker build --rm -t "${DIR}:${VERSION}" "${DIR}" \
  && \
  docker tag "${DIR}:${VERSION}" "${DIR}:latest"
}

function getVersion(){
  local DIR=$1
  
  # echo ${DIR}
  VERSION=`grep -e 'org.opencontainers.image.version' "${DIR}/Dockerfile" | awk -F '"' '{print $2}'`
}

function existsParent(){
    PARENT=$1
    
    IFS=':' read -a PARENTPARTS <<< "${PARENT}"
    docker images | grep "^${PARENTPARTS[0]}" | awk '{print $1$2}' | grep -q "^${PARENTPARTS[0]}${PARENTPARTS[1]}\$"
    return $?
}

function getParent(){
  local DIR=$1
  
	local FROMLINE=`grep -e '^FROM' "${DIR}/Dockerfile"`
	IFS=' ' read -a PARTS <<< "$FROMLINE"
	if [ ${#PARTS[@]} -le 1 ]; then
		echo "!!! No from found in file: ${DIR}/Dockerfile, VersionLine: ${FROMLINE}"
		exit; 
	fi
	PARENT=${PARTS[1]}
}

function fixParent(){
  local DIR=$1
  getParent ${DIR}

  if [[ $PARENT =~ ^(twistedbytes.*): ]]; then
    local PARENT_DIR=${BASH_REMATCH[1]}
    fixParent $PARENT_DIR
  else
    return
  fi
  getParent ${DIR}
  if [[ $PARENT =~ ^(twistedbytes.*): ]]; then
    local PARENT_DIR=${BASH_REMATCH[1]}

    getVersion ${PARENT_DIR}
    grep -q "^FROM $PARENT_DIR:${VERSION}" $DIR/Dockerfile
    if [[ $? -ne 0 ]]; then
      echo "SET PARENT ($PARENT_DIR) of ${DIR} to VERSION: ${VERSION}"

      sed -i -r -e "/^FROM/s/:.*/:${VERSION}/" $DIR/Dockerfile
    fi
  fi
}

function fixParents(){
  for i in twistedbytes/*; do
    fixParent $i;
  done
}


usage() { 
  echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; 
}

# http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt
# read the options
TEMP=`getopt -o a::d:f:: --long arga::,dir:,fix-parents:: -n 'test.sh' -- "$@"`
eval set -- "$TEMP"

while true ; do
  case "$1" in
    -a|--arga)
      case "$2" in
          "") ARG_A='some default value' ; shift 2 ;;
          *) ARG_A=$2 ; shift 2 ;;
      esac ;;
    -d|--dir)
      DIR=1 ; 
      shift ;;
    -f|--fix-parents)
      fixParents
      exit 0
      shift ;;
    -c|--argc)
      case "$2" in
          "") shift 2 ;;
          *) ARG_C=$2 ; shift 2 ;;
      esac ;;
    --) shift ; break ;;
    *) echo "Internal error!" ; exit 1 ;;
  esac
done

buildDir $1

exit
