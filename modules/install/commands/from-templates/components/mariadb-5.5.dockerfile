## MariaDB 5.5 ----------------------------------------------------------------

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
    echo 'deb http://nyc2.mirrors.digitalocean.com/mariadb/repo/5.5/ubuntu trusty main' >> /etc/apt/sources.list && \
    echo 'deb-src http://nyc2.mirrors.digitalocean.com/mariadb/repo/5.5/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y -q install mariadb-server

EXPOSE 3306

RUN /deploy/dockerfile-templates-master/rerun config:component mariadb-5.5 --export-to /configs/

