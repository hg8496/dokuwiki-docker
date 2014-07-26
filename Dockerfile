FROM hg8496/apache

MAINTAINER hg8496@cstolz.de
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get update && apt-get install wget -y && apt-get clean

RUN wget http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz && tar xf dokuwiki-stable.tgz -C /var/www/html/ --strip-components=1 && rm dokuwiki-stable.tgz
RUN chown -R www-data:www-data /var/www/html
RUN rm /var/www/html/index.html
ADD apache-site.conf /etc/apache2/sites-enabled/000-default.conf
RUN a2enmod rewrite
ADD keys.pub /tmp/your_key.pub
RUN cat /tmp/your_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/your_key.pub
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/sbin/my_init"]
