#!/bin/bash
#-- help section
# INPUTVAR _TB_INSTALL_PHPEXT
#     Value is a list comma and no space, Option to install extra php extensions, without php-, run this docker with env: _TB_INSTALL_PHPEXT_LIST=y
# INPUTVAR _TB_INSTALL_PHPEXT_LIST
#   Only value is Y, shows current php packages and available for install with _TB_INSTALL_PHPEXT

#-- end help section, keep 1 line free above

_PHP_PREFIX=php-

if [[ ${_TB_INSTALL_PHPEXT_LIST} == "y" ]]; then
  echo "currently installed:"
  rpm -qa | grep ^php

  echo "available packages: "
  ${YUMDNF} -y -q search ${_PHP_PREFIX} | grep ^${_PHP_PREFIX}
  exit
fi

if [[ -n ${_TB_INSTALL_PHPEXT} ]]; then
  package_list=()
  IFS=,
  for package in $_TB_INSTALL_PHPEXT; do
    package_list+=(${_PHP_PREFIX}${package})
  done

  echo "Installing ${package_list}"
  # shellcheck disable=SC2068
  ${YUMDNF} install -y ${package_list[@]}
fi
