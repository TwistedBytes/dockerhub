#!/bin/bash
set -e
# set -x

[[ -n $_TB_DEBUG ]] && _TB_DEBUG="-x"

_RUNNING_ON_MAC=$( uname -a | sed -r -e 's/.*(linuxkit).*(aarch64|x86_64).*/\1 \2/' )
if [[ ${_RUNNING_ON_MAC} == "linuxkit aarch64" ]]; then
  echo RUNNING ON MAC M1
  export _TB_RUNNING_ON_MAC="yes"
fi
if [[ ${_RUNNING_ON_MAC} == "linuxkit x86_64" ]]; then
  echo RUNNING ON MAC Intel
  export _TB_RUNNING_ON_MAC="yes"
fi

_TB_CONTAINER_TYPE=unknown
[[ ${container} == oci ]] && _TB_CONTAINER_TYPE=docker
[[ ${container} == podman ]] && _TB_CONTAINER_TYPE=podman
export _TB_CONTAINER_TYPE
# echo Container type: ${_TB_CONTAINER_TYPE}

export _TB_START_CMD="$@"

. /etc/os-release
if [[ $VERSION_ID -eq 7 ]]; then
  export YUMDNF=yum
else
  export YUMDNF=dnf
fi

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
      help)
          grep -h -A1  -e '^# INPUTVAR' /aa-run-on-start/scripts/*.sh | sed -e 's/^#//g'
          exit 0
      ;;
      *)
      ;;
  esac
  shift # past argument or value
done

[[ -f /command.txt ]] && rm /command.txt

if [[ -d /aa-run-on-start/scripts ]]; then
  for i in /aa-run-on-start/scripts/*.sh; do
    [[ -n $_TB_DEBUG ]] && echo running $i;
    bash -e ${_TB_DEBUG} $i
    # sleep 0.1
  done
fi

exec $( cat /command.txt )
