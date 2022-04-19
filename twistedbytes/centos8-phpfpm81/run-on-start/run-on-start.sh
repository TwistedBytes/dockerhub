#!/bin/bash
set -e
# set -x

# IF _TB_RUNONSTART  then only start bash
if [[ $_TB_RUNONSTART == N ]]; then
  exec /bin/bash
  exit 0
fi

export _TB_START_CMD="$@"

_TB_LAST_COMMAND="/bin/bash"

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
      debug)
          export _TB_DEBUG="-x"
          set ${_TB_DEBUG}
      ;;
      phpfpm)
          _TB_LAST_COMMAND="exec gosu www-data php-fpm -F -O"
          if [[ ${_TB_PHPFPM} != Y ]]; then
            echo "make sure to set the _TB_PHPFPM env variable to Y"
            exit 0
          fi
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

${_TB_LAST_COMMAND}
