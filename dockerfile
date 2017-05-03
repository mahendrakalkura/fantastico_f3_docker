FROM ubuntu:16.04

RUN /usr/bin/apt-get update

RUN /usr/bin/apt-get --yes upgrade

RUN /usr/bin/apt-get --yes install language-pack-en-base software-properties-common

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN /usr/bin/add-apt-repository --yes ppa:ondrej/php

RUN /usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv 4F4EA0AAE5267A6C

RUN /usr/bin/apt-get update

RUN /usr/bin/apt-get --yes upgrade

RUN /usr/bin/apt-get --yes install \
    apache2 \
    binutils \
    build-essential \
    ca-certificates \
    curl \
    gettext \
    git \
    htop \
    libapache2-mod-php5.6 \
    libmysqlclient-dev \
    mariadb-client \
    mariadb-server \
    ncdu \
    nload \
    php5.6 \
    php5.6-bcmath \
    php5.6-bz2 \
    php5.6-cgi \
    php5.6-cli \
    php5.6-common \
    php5.6-curl \
    php5.6-dba \
    php5.6-dev \
    php5.6-enchant \
    php5.6-fpm \
    php5.6-gd \
    php5.6-gmp \
    php5.6-imap \
    php5.6-interbase \
    php5.6-intl \
    php5.6-json \
    php5.6-ldap \
    php5.6-mbstring \
    php5.6-mcrypt \
    php5.6-mysql \
    php5.6-odbc \
    php5.6-opcache \
    php5.6-pgsql \
    php5.6-phpdbg \
    php5.6-pspell \
    php5.6-readline \
    php5.6-recode \
    php5.6-soap \
    php5.6-sqlite3 \
    php5.6-sybase \
    php5.6-tidy \
    php5.6-xml \
    php5.6-xmlrpc \
    php5.6-xsl \
    php5.6-zip \
    python3-pip \
    ssh \
    tmux \
    tree \
    unzip \
    vim \
    wget

RUN /usr/sbin/a2enmod php5.6 proxy proxy_fcgi

RUN /usr/sbin/phpenmod \
    bz2 \
    curl \
    dba \
    enchant \
    gd \
    gmp \
    imap \
    interbase \
    intl \
    json \
    ldap \
    mbstring \
    mcrypt \
    odbc \
    opcache \
    pgsql \
    pspell \
    readline \
    recode \
    soap \
    sqlite3 \
    tidy \
    xml \
    xmlrpc \
    xsl \
    zip

RUN /bin/mkdir --parents \
    /root/public_html \
    /var/lib/php/sessions \
    /var/lib/php/sessions/administrators \
    /var/lib/php/sessions/visitors

RUN /bin/echo 'root:root' | /usr/sbin/chpasswd

RUN /bin/chmod 755 /root /root/public_html

COPY files/etc/apache2/ports.conf /etc/apache2/ports.conf
COPY files/etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY files/etc/init.d/php5.6-fpm /etc/init.d/php5.6-fpm
COPY files/etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY files/etc/php/5.6/fpm/pool.d/www.conf /etc/php/5.6/fpm/pool.d/www.conf
COPY files/etc/php/5.6/php.ini /etc/php/5.6/apache2/php.ini
COPY files/etc/php/5.6/php.ini /etc/php/5.6/cgi/php.ini
COPY files/etc/php/5.6/php.ini /etc/php/5.6/cli/php.ini
COPY files/etc/php/5.6/php.ini /etc/php/5.6/fpm/php.ini
COPY files/etc/php/5.6/php.ini /etc/php/5.6/phpdbg/php.ini
COPY files/etc/ssh/sshd_config /etc/ssh/sshd_config
COPY files/root/my.cnf /root/my.cnf
COPY files/root/run.sh /root/run.sh

RUN /bin/chmod 755 /etc/init.d/php5.6-fpm

RUN /usr/bin/touch /etc/development

EXPOSE 80

ENV HOME /root

WORKDIR /root

ENTRYPOINT ["/bin/bash", "/root/run.sh"]
