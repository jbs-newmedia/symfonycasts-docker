FROM debian:bullseye

LABEL maintainer="js@jbs-newmedia.de"
LABEL description="SFC-P001"

#main
RUN apt update
RUN apt -y upgrade
RUN apt -y install apache2
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
ENV APACHE_DOCUMENT_ROOT=/var/www/html/project/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN apt -y install git php wget nano curl
RUN apt -y install libapache2-mod-php php-bcmath php-gd php-sqlite3 php-mysqli php-curl php-xml php-mbstring php-zip php-intl php-xdebug php-apcu
RUN git config --global user.email "info@juergen-schwind.de"
RUN git config --global user.name "jschwind"
RUN cd /tmp; php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN cd /tmp; php composer-setup.php
RUN cd /tmp; php -r "unlink('composer-setup.php');"
RUN cd /tmp; mv composer.phar /usr/bin/composer
RUN cd /tmp; wget https://get.symfony.com/cli/installer -O - | bash
RUN cd /tmp; mv /root/.symfony5/bin/symfony /usr/local/bin/symfony
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt -y install nodejs
RUN npm install --global yarn
#RUN symfony server:ca:install

#environment
RUN apt -y install locales
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen
RUN sed -i '/de_DE.UTF-8/s/^# //g' /etc/locale.gen
RUN locale-gen
RUN a2enmod rewrite
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
EXPOSE 80
CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]

#restart apache
RUN apache2ctl restart