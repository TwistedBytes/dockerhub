#!/bin/bash

#-- help section

#-- end help section, keep 1 line free above

if [[ $( id -u ) -ne 0 ]]; then
  echo "detect userid: $( id -u )"
  echo "please do no use 'user: ' in docker composer for this"
  echo "this docker will switch to the right user itself when using the right ENV vars"
  echo "Use ENV _TB_UIDGID_FROMDIR or _TB_UIDGID for that"
  exit 1
fi

