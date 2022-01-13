FROM centos:8

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.created="{#date#}" \
      org.opencontainers.image.version="{#date#}{#datebuild#}" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos 8 with base php 8.1 from remi repo"

RUN true \
    && dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
    && dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm \
    && dnf -y module reset php \
    && dnf -y module install php:remi-8.1 \
    && dnf -y install php-common php-bcmath php-dba php-gd php-gmp php-imap php-intl php-mbstring php-mcrypt php-mysqlnd \
                      php-pdo php-pgsql php-process php-soap php-xml php-xmlrpc php-opcache php-fpm php-cli \
                      php-pecl-zip  \
    && dnf clean all \
    && true
