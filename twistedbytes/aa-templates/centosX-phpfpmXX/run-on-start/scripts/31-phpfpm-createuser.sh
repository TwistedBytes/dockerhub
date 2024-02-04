#!/bin/bash

#-- help section
# INPUTVAR _TB_UIDGID
#     Value: "<uid>:<gid>", ex: 1000:100. Sets the uid and gid for the internal www-data user. Created files will be owned by that user
# INPUTVAR _TB_UIDGID_FROMDIR
#     Value: A path, alternative for _TB_UIDGID to get the uid/gid from that dir in the docker. Need to set a volume to use
# INPUTVAR TB_IS_MAC
#     Value: Y or N. Set to Y when running on Mac and permissions on files are set to mac user running this.

#-- end help section, keep 1 line free above

if [[ -d ${_TB_UIDGID_FROMDIR} ]]; then
  uid=$(stat -c '%u' "$_TB_UIDGID_FROMDIR")
  gid=$(stat -c '%g' "$_TB_UIDGID_FROMDIR")

  export _TB_UIDGID=${uid}:${gid}
fi

if [[ ${_TB_RUNNING_ON_MAC} == "yes" ]]; then
  export _TB_UIDGID=1000:1000
fi

if [[ -z ${_TB_UIDGID} ]] ; then
  echo no environment var _TB_UIDGID found
  exit 1
fi

APP_USER=www-data
APP_GROUP=www-data
APP_USER_ID=`echo "${_TB_UIDGID}" | cut -d: -f 1`
APP_GROUP_ID=`echo "${_TB_UIDGID}" | cut -d: -f 2`

new_user_id_exists=$(id ${APP_USER_ID} > /dev/null 2>&1 || echo 1)
if [ "$new_user_id_exists" = "0" ]; then
    (>&2 echo "ERROR: APP_USER_ID $APP_USER_ID already exists - Aborting!");
    exit 0;
fi

new_group_id_exists=$(getent group ${APP_GROUP_ID} > /dev/null 2>&1 || echo 1)
if [ "$new_group_id_exists" = "0" ]; then
    (>&2 echo "ERROR: APP_GROUP_ID $APP_GROUP_ID already exists - Aborting!");
    exit 0;
fi

old_user_id=$(getent passwd ${APP_USER} | cut -d: -f3)
old_user_exists=$(getent passwd ${APP_USER} > /dev/null 2>&1 || echo 1)
old_group_id=$(getent group ${APP_GROUP} | cut -d: -f3)
old_group_exists=$(getent group ${APP_GROUP} > /dev/null 2>&1 || echo 1)

if [ "$old_group_id" != "${APP_GROUP_ID}" ]; then
    # create the group
    groupadd -f ${APP_GROUP}
    # and the correct id
    groupmod -o -g ${APP_GROUP_ID} ${APP_GROUP}
#    if [ "$old_group_exists" = "0" ]; then
#        # set the permissions of all "old" files and folder to the new group
#        find / -group $old_group_id -exec chgrp -h ${APP_GROUP} {} \; || true
#    fi
fi

if [ "$old_user_id" != "${APP_USER_ID}" ]; then
    if [[ ${_TB_CONTAINER_TYPE} == "podman" ]]; then
      _usermod_args="--non-unique"
      echo "doing a podman fix with uid"
    else
      _usermod_args=""
    fi

    # create the user if it does not exist
    if [ "$old_user_exists" != "0" ]; then
        useradd ${_usermod_args} -u ${APP_USER_ID} ${APP_USER} -g ${APP_GROUP}
    fi

    # make sure the home directory exists with the correct permissions
    mkdir -p /home/${APP_USER} && chmod 755 /home/${APP_USER} && chown ${APP_USER}:${APP_GROUP} /home/${APP_USER}

    # change the user id, set the home directory and make sure the user has a login shell
    usermod ${_usermod_args} -u ${APP_USER_ID} -m -d /home/${APP_USER} ${APP_USER} -s $(which bash)
#
#    if [ "$old_user_exists" = "0" ]; then
#        # set the permissions of all "old" files and folder to the new user
#        find / -user $old_user_id -exec chown -h ${APP_USER} {} \; || true
#    fi
fi
