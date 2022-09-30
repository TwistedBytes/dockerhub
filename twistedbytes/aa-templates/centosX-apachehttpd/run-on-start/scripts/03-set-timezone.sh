#!/bin/bash
#-- help section
# INPUTVAR _TB_Z
#   Set timezone in docker, eg: UTC, Europe/Amsterdam, America/New_York

#-- end help section, keep 1 line free above

if [[ -n $_TB_TZ ]] && [[ $( id -u ) -eq 0 ]]; then
  ln -snf /usr/share/zoneinfo/$_TB_TZ /etc/localtime && echo $_TB_TZ > /etc/timezone
fi
