#!/bin/bash

if [[ $VERSION -ge 8 ]]; then
  echo "fastestmirror=True
max_parallel_downloads=10
" >> /etc/dnf/dnf.conf
fi
