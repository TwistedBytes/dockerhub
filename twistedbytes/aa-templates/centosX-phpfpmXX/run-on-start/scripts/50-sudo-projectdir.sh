#!/bin/sh

#-- help section

#-- end help section, keep 1 line free above
# =

if [[ $_TB_SUDO_TOFROMDIR == "Y" ]] && [[ -d $_TB_UIDGID_FROMDIR ]]; then

  cd ${_TB_UIDGID_FROMDIR}

  gosu www-data bash
  exit 1

fi
