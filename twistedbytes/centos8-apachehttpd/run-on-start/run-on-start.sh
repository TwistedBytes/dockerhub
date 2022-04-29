#!/bin/bash
set -e
# set -x

export _TB_START_CMD="$@"

if [[ ${_TB_START_CMD} == "/usr/sbin/httpd -DFOREGROUND" ]]; then
  _TB_LAST_COMMAND="gosu www-data /usr/sbin/httpd -DFOREGROUND"
else
  _TB_LAST_COMMAND="${_TB_START_CMD}"
fi


while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
      debug)
          export _TB_DEBUG="-x"
          set ${_TB_DEBUG}
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

exec ${_TB_LAST_COMMAND}
