FROM textar/sshd_ubuntu:14.04
MAINTAINER textar
ENV DEBIAN FRONTED noninteractive
RUN apt-get update && \
  apt-get -yq install mysql-server-5.6 pwgen && \
  rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/mysql/*
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf
ADD import_sql.sh /import_sql.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ENV MYSQL_USER admin
ENV MYSQL_PASS **Random**
ENV REPLICATION_MASTER **False**
ENV REPLICATION_SLAVE **False**
ENV REPLICATION_USER replica
ENV REPLICATION_PASS replica
VOLUME ["/etc/mysql","/var/lib/mysql"]
EXPOSE 3306
CMD ["/run.sh"]
