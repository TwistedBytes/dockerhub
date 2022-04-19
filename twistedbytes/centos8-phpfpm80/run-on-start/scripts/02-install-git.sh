#!/bin/bash
#-- help section
# INPUTVAR _TB_INSTALL_GIT
#   Only value is Y, installs git when set to y

#-- end help section, keep 1 line free above
if [[ ${_TB_INSTALL_GIT} == y ]]; then
  rpm -qa | grep -q ^git || dnf -y install git
fi
