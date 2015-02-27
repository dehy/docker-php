#!/bin/bash

if [ "x" != "x${ENABLE_PHP_MODULES}" ]; then
    php5enmod ${ENABLE_PHP_MODULES}
fi

if [ "x${APACHE_ACCESS_LOG}" == "xconsole" ]; then
    APACHE_ACCESS_LOG="/proc/self/fd/1"
fi
if [ "x${APACHE_ERROR_LOG}" == "xconsole" ]; then
    APACHE_ERROR_LOG="/proc/self/fd/1"
fi

sed -i -e "s%CustomLog .*$%CustomLog ${APACHE_ACCESS_LOG} combined%g" /etc/apache2/sites-available/*
sed -i -e "s%ErrorLog .*$%ErrorLog ${APACHE_ERROR_LOG}%g" /etc/apache2/sites-available/*

sed -i -r -e "s%^\s*;?\s*date.timezone\s*=.*$%date.timezone = "${PHP_DATE_TIMEZONE}"%g" /etc/php5/*/php.ini
sed -i -r -e "s%^\s*;?\s*short_open_tag\s*=.*$%short_open_tag = ${PHP_SHORT_OPEN_TAG}%g" /etc/php5/*/php.ini
