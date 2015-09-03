FROM library/ubuntu:latest

RUN \
  apt-get update -y && \
  apt-get install -y nginx php5-fpm php5-cli php5-mcrypt git && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# PHP not to try to execute a similar named script if the requested file name cannot be found.
RUN echo "cgi.fix_pathinfo=0" >> /etc/php5/fpm/php.ini
RUN echo "cgi.fix_pathinfo=0" >> /etc/php5/cli/php.ini

# enable MCrypt
RUN \
  php5enmod mcrypt && \
  service php5-fpm restart

# Bug (link with sites-available configuration)
RUN echo "listen = 127.0.0.1:9000" >> /etc/php5/fpm/pool.d/www.conf

# to copy confs
#

COPY ./nginx-default/www/ /var/www/
COPY ./nginx-default/sites-available/* /etc/nginx/sites-available/

RUN \
  service nginx reload && \
  service php5-fpm restart


# restart the service nginx
# service nginx restart

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled","/etc/nginx/sites-available","/etc/nginx/certs","/etc/nginx/conf.d","/var/log/nginx","/var/www"]

# Define working directory.
WORKDIR /etc/nginx

COPY ./docker-start.sh /etc/nginx/
RUN chmod 751 /etc/nginx/docker-start.sh

# Define default command.
ENTRYPOINT ["/etc/nginx/docker-start.sh"]

# Expose ports.
EXPOSE 80
EXPOSE 443
