FROM debian:8
MAINTAINER Werner Dijkerman <ikben@werner-dijkerman.nl>

ENV ZABBIX_VERSION=3.0 \
    ZABBIX_VERSION_LONG=3.0-1

RUN apt-get update && \
    apt-get install -y curl bash && \
    curl -sSLo /tmp/zabbix-release_${ZABBIX_VERSION_LONG}+wheezy_all.deb http://repo.zabbix.com/zabbix/${ZABBIX_VERSION}/debian/pool/main/z/zabbix-release/zabbix-release_${ZABBIX_VERSION_LONG}+wheezy_all.deb && \
    cd /tmp && \
    dpkg -i zabbix-release_${ZABBIX_VERSION_LONG}+wheezy_all.deb && \
    apt-get update && \
    apt-get install zabbix-frontend-php mysql-client -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /etc/apache2/sites-enabled/*

EXPOSE 80
ADD zabbix-web.sh /bin/zabbix-web.sh
RUN chmod +x /bin/zabbix-web.sh

ENV SHELL /bin/bash

CMD ["/bin/zabbix-web.sh"]
