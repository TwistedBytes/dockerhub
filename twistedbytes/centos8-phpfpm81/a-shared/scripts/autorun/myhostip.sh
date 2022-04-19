#!/bin/bash

echo -n "My Hostname: `hostname -a` "
echo    "My IP: `ip a | grep 172\. | awk '{print $2}' | awk -F / '{print $1}'`"
