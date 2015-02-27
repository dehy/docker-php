FROM debian:wheezy
MAINTAINER Arnaud de Mouhy <arnaud@flyingpingu.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 \
    libapache2-mod-php5 php5-mysql php5-gd php5-intl

RUN a2enmod php5

ADD init-php.sh /usr/local/bin/init-php.sh
ADD run-apache.sh /usr/local/bin/run-apache.sh

RUN chmod +x /usr/local/bin/init-php.sh
RUN chmod +x /usr/local/bin/run-apache.sh

ENV PHP_DATE_TIMEZONE Europe/Paris
ENV PHP_SHORT_OPEN_TAG Off
ENV APACHE_ERROR_LOG console
ENV APACHE_ACCESS_LOG console

# Expose port.
EXPOSE 80

CMD ["usr/local/bin/run-apache.sh", "-D", "FOREGROUND"]
