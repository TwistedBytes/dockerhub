#!/bin/bash
set -e
# set -x

export _TB_START_CMD="$@"

_TB_LAST_COMMAND="/bin/bash"

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
