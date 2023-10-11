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

export _TB_START_CMD="$@"

_TB_LAST_COMMAND="/bin/bash"
export _TB_FORCE_USE_DIR="N"

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
      debug)
          export _TB_DEBUG="-x"
          set ${_TB_DEBUG}
      ;;
      --uidgid | -u)
        export _TB_UIDGID="$2"
        shift # past argument
      ;;
      --projecttype | -p)
        export _TB_CONFIG="$2"
        shift # past argument
      ;;
      --forcedir | -f)
        export _TB_FORCE_USE_DIR=Y
      ;;

      help)
          grep -h -A1  -e '^# INPUTVAR' /aa-run-on-start/scripts/*.sh | sed -e 's/^#//g'
          exit 0
      ;;
      *)
      ;;
  esac
  shift # past argument or value
done

if [[ -d /aa-run-on-start/scripts ]]; then
  for i in /aa-run-on-start/scripts/*.sh; do
    [[ -n $_TB_DEBUG ]] && echo running $i;
    bash -e ${_TB_DEBUG} $i
    # sleep 0.1
  done
fi

# ${_TB_LAST_COMMAND}
