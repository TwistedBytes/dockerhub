#!/bin/bash
set -e

/usr/local/bin/autorun.sh

if [[ "$*" =~ "bash" ]]; then
  exec /bin/bash
else
  exec "$@"
fi
