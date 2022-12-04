#!/bin/bash
#-- help section
# INPUTVAR _TB_INSTALL_PACKAGES
#   value is comma seperated list of packages to install on boot.
#   example: - _TB_INSTALL_PACKAGES=php-pecl-openswoole,php-pecl-ssh2,php-pecl-imagick-im7,php-pecl-event

#-- end help section, keep 1 line free above
if [[ -n ${_TB_INSTALL_PACKAGES} ]]; then
  echo ${_TB_INSTALL_PACKAGES} | sed -r -e 's/,/ /g' | \
  xargs dnf -y install
fi
