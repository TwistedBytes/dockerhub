#!/bin/bash
set -e
# set -x

[[ -n $_TB_DEBUG ]] && _TB_DEBUG="-x"

_RUNNING_ON_MAC=$( uname -a | sed -r -e 's/.*(linuxkit).*(aarch64).*/\1 \2/' )
if [[ ${_RUNNING_ON_MAC} == "linuxkit aarch64" ]]; then
  echo RUNNING ON MAC
  export _TB_RUNNING_ON_MAC="yes"
fi

export _TB_START_CMD="$@"

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
