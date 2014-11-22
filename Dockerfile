FROM hg8496/apache

MAINTAINER hg8496@cstolz.de
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get update && apt-get install wget -y && apt-get clean && a2enmod rewrite && wget http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz && tar xf dokuwiki-stable.tgz -C /var/www/html/ --strip-components=1 && rm dokuwiki-stable.tgz && chown -R www-data:www-data /var/www/html && rm /var/www/html/index.html && mkdir -p /opt/dokuwiki && mv /var/www/html/data /opt/dokuwiki && ln -s /opt/dokuwiki/data /var/www/html/data && mv /var/www/html/conf/local.php.dist /opt/dokuwiki && ln -s /opt/dokuwiki/local.php /var/www/html/conf/local.php
ADD apache-site.conf /etc/apache2/sites-enabled/000-default.conf
ADD keys.pub /tmp/your_key.pub
ADD htaccess /var/www/html/.htaccess
RUN cat /tmp/your_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/your_key.pub && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
VOLUME ["/opt/dokuwiki"]
CMD ["/sbin/my_init"]
