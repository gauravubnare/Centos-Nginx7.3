FROM centos:latest
RUN yum update -y && yum install epel-release -y && rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && yum --enablerepo=remi-php73 install php nginx php-fpm php-common php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml -y 
COPY application.conf /etc/nginx/conf.d
RUN mkdir -p /run/php-fpm && touch /run/php-fpm/php-fpm.pid
EXPOSE 8080 80 9000
RUN mkdir -p /application_1/public
COPY index.php /application_1/public
COPY nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT /sbin/nginx && php-fpm && /bin/bash
