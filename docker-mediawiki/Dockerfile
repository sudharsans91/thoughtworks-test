FROM registry.access.redhat.com/ubi8/ubi:latest

LABEL maintainer="sudharsans91 <sudharsan.s.91@outlook.com>"

# Install required packages
RUN yum install centos-release-scl -y
RUN yum install httpd24-httpd rh-php73 rh-php73-php rh-php73-php-mbstring rh-php73-php-mysqlnd rh-php73-php-gd rh-php73-php-xml mariadb-server mariadb -y



RUN yum install -y httpd httpd-tools php php-cli php-mysqlnd php-json php-gd php-xml php-intl \
php-mbstring php-apcu php-pecl-apcu php-pecl-memcache php-pear \
git mysql mysql-server tar wget

# Install Composer (PHP dependency manager)
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Configure Apache
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/httpd/conf/httpd.conf

# Set up a MediaWiki directory
WORKDIR /var/www/html

# Clone MediaWiki
RUN git clone https://gerrit.wikimedia.org/r/mediawiki/core.git .

# Install MediaWiki
RUN git submodule update --init --recursive
RUN composer install --no-dev

# Configure MySQL
RUN systemctl enable mysqld
RUN systemctl start mysqld
RUN mysql_secure_installation

# Set up MediaWiki database
RUN mysql -u root -e "CREATE DATABASE wikidb;"
RUN mysql -u root -e "GRANT INDEX, CREATE, ALTER, LOCK TABLES, INSERT, UPDATE, DELETE, DROP, SELECT, RELOAD, FILE, CREATE TEMPORARY TABLES ON wikidb.* TO 'wikiuser'@'localhost' IDENTIFIED BY 'wikipassword';"
RUN mysql -u root -e "FLUSH PRIVILEGES;"

# Expose port 8080
EXPOSE 8080

# Start Apache and MediaWiki
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
