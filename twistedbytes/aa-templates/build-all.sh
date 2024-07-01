#!/bin/bash

# sudo podman run --rm --privileged multiarch/qemu-user-static --reset -p yes

bash build-centos.sh
bash build-rpmbuild.sh
bash build-apache.sh
bash build-php.sh
bash build-phpfpm.sh

