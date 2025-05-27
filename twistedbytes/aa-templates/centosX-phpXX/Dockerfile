ARG CENTOS_VERSION
ARG FROM_VERSION

FROM twistedbytes/centos${CENTOS_VERSION}-stream:${FROM_VERSION}

# repeat ARGS because ARGS before from will not work
ARG PHP_VERSION_MAJOR
ARG PHP_VERSION_MINOR
ARG PHP_VERSION_MAJOR_MINOR
ARG CENTOS_VERSION
ARG IMAGE_VERSION
ARG YUMDNF
ARG REMI_EXTRAVERSION

LABEL org.opencontainers.image.authors="info@twistedbytes.nl" \
      org.opencontainers.image.vendor="Twisted Bytes B.V." \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.url="https://www.twistedbytes.nl" \
      org.opencontainers.image.description="Centos ${CENTOS_VERSION} with base php ${PHP_VERSION_MAJOR_MINOR} from remi repo"

RUN true \
    && ${YUMDNF} -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-${CENTOS_VERSION}.noarch.rpm \
    && ${YUMDNF} -y install https://rpms.remirepo.net/enterprise/remi-release-${CENTOS_VERSION}${REMI_EXTRAVERSION}.rpm \
    && ${YUMDNF} -y module reset php \
    && ${YUMDNF} -y module install php:remi-${PHP_VERSION_MAJOR_MINOR} \
    && ${YUMDNF} -y --setopt=tsflags=nodocs install unzip \
    && ${YUMDNF} -y --setopt=tsflags=nodocs install \
      php-common php-bcmath php-dba php-gd php-gmp php-imap php-intl php-mbstring php-mysqlnd \
      php-pdo php-pgsql php-process php-soap php-xml php-opcache php-fpm php-cli \
      php-pecl-zip php-sodium php-pecl-redis5 \
    && true

RUN if [[ ${PHP_VERSION_MAJOR} -eq 7 ]]; then ${YUMDNF} -y --setopt=tsflags=nodocs install php-mcrypt php-xmlrpc; fi
RUN if [[ ${PHP_VERSION_MAJOR} -ge 8 ]]; then ${YUMDNF} -y --setopt=tsflags=nodocs install php-pecl-mcrypt; fi
# only <= 8.3
RUN if [[ ${PHP_VERSION_MAJOR} -eq 8 ]] && [[ ${PHP_VERSION_MINOR} -le 3 ]]; then ${YUMDNF} -y --setopt=tsflags=nodocs install php-pecl-xmlrpc; fi

RUN true \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer1 --1 \
    && ${YUMDNF} clean all \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/yum \
    && rm -rf /var/cache/dnf \
    && find /var/log -type f -name '*.log' -delete \
    && true
