#!/bin/bash

# bash build-centos.sh
bash build-rpmbuild.sh
bash build-apache.sh
bash build-php.sh
bash build-phpfpm.sh

