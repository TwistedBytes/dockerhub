FROM centos:8

MAINTAINER Twisted Bytes <info@twistedbytes.nl>
LABEL com.company.key="Twisted Bytes B.V."
LABEL org.opencontainers.image.created="{#date#}"
LABEL org.opencontainers.image.url="https://www.twistedbytes.nl"
LABEL org.opencontainers.image.title="Centos 8 with base php 8.1 from remi repo"

RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
RUN dnf -y module reset php
RUN dnf -y module install php:remi-8.1
