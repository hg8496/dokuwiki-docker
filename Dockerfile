FROM hg8496/apache

MAINTAINER hg8496@cstolz.de
ENV HOME /root

RUN apt-get update \
    && apt-get install wget -y \
    && a2enmod rewrite \
    && wget http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz \
    && tar xf dokuwiki-stable.tgz -C /var/www/html/ --strip-components=1 \
    && rm dokuwiki-stable.tgz \
    && rm /var/www/html/index.html \
    && mkdir -p /opt/dokuwiki \
    && mv /var/www/html/data /opt/dokuwiki && ln -s /opt/dokuwiki/data /var/www/html/data \
    && mv /var/www/html/conf /opt/dokuwiki/ && ln -s /opt/dokuwiki/conf /var/www/html/conf \
    && mv /var/www/html/lib/tpl /opt/dokuwiki && ln -s /opt/dokuwiki/tpl /var/www/html/lib/tpl \
    && mv /var/www/html/lib/plugins /opt/dokuwiki && ln -s /opt/dokuwiki/plugins /var/www/html/lib/plugins \
    && chown -R www-data:www-data /var/www/html /opt/dokuwiki \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD apache-site.conf /etc/apache2/sites-enabled/000-default.conf
ADD htaccess /var/www/html/.htaccess
VOLUME ["/opt/dokuwiki"]

