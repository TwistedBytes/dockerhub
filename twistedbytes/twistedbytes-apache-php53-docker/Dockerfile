FROM centos:centos6

#VERSION 20221205

RUN rm -Rvf /etc/yum.repos.d/* \
    && cd /etc/yum.repos.d/ \
    && curl -O https://gist.githubusercontent.com/amotl/0f001cfd1fee574e0e49e19b585d7b17/raw/8221ce3abd22181aad8a6cc0ffad2c86c305a119/CentOS6-Vault.repo

RUN yum -y install rpmdevtools.noarch rpm-build autoconf \
  	cpp gcc-c++ cmake git psmisc {binutils,boost,jemalloc,freetype}-devel \
	{sqlite,tbb,bzip2,openldap,readline,elfutils-libelf,gmp,lz4,pcre}-devel \
	lib{xslt,event,yaml,vpx,png,zip,icu,mcrypt,memcached,cap,dwarf,jpeg-turbo}-devel \
	{unixODBC,expat,mariadb}-devel lib{edit,curl,xml2,xslt}-devel \
	glog-devel oniguruma-devel ocaml make ImageMagick-devel glib2-devel \
	prelink flex bison libc-client-devel \
	pam-devel gd-devel fastlz-devel fribidi-devel \
	wget httpd-tools httpd-devel httpd vim mysql-devel postgresql-devel

# RUN curl -O https://mail.gnome.org/archives/xml/2012-August/txtbgxGXAvz4N.txt
RUN curl -O https://museum.php.net/php5/php-5.3.29.tar.gz
RUN tar xzfv php-5.3.29.tar.gz && rm -f php-5.3.29.tar.gz
RUN cd php* \
    && ./configure --with-apxs2 \
      --with-pgsql --with-pdo-pgsql \
      --with-mysql --with-mysqli --with-pdo-mysql --with-libdir=lib64 \
    && make -j 2 \
    && make install \
    && true

RUN echo "DirectoryIndex index.html index.php" >>  /etc/httpd/conf/httpd.conf
RUN echo "AddHandler application/x-httpd-php .php" >>  /etc/httpd/conf/httpd.conf

EXPOSE 80

RUN cd /usr/local/bin \
    && curl -O https://raw.githubusercontent.com/docker-library/httpd/master/2.4/httpd-foreground \
    && chmod 777 httpd-foreground

STOPSIGNAL SIGWINCH

# CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
CMD ["httpd-foreground"]


