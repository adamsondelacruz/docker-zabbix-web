# docker-zabbix-web

# Introduction

This docker container only contains the Zabbix Web package. This container can be used next to the `wdijkerman/zabbix-server` container.

### Dockerfile
- `0.0.1`, `latest` [(Dockerfile)](https://github.com/dj-wasabi/docker-zabbix-web/blob/master/Dockerfile)

### Zabbix

Current version: 3.0

# Install the container

Just run the following command to download the container:

```bash
docker pull wdijkerman/zabbix-web
```

# Using the container

Basic usage of the container:

```bash
docker run  -p 80:80 --name zabbix-web \
            -e ZABBIXURL=zabbix.example.com \
            -e ZBXSERVERNAME=vserver-151 \
            -e ZBXSERVER=192.168.1.151 \
            -e DBHOST=192.168.1.153 -e DBUSER=zabbix \
            -e DBPASSWORD="zabbix-pass" \
            -e DBPORT=3306 -e DBNAME=zabbix wdijkerman/zabbix-web
```

You'll have to pass environment parameters to the container. 

| Variable      | Description|
| --------------|-------------|
| ZABBIXURL     | The FQDN on which the web interface is available.|
| ZBXSERVERNAME | The name of the Zabbix server.|
| ZBXSERVER     | The ip or FQDN to the zabbix-server instance.|
| DBHOST        | The host on which the database is running. |
| DBUSER        | The username to use for accassing the MySQL database|
| DBPASSWORD    | The password for the DBUSER. |
| DBPORT        | The port on which MySQL is running. Default: 3306 |
| DBNAME        | The name of the database. Default: zabbix|

# License

The MIT License (MIT)

See file: License

# Issues

Please report issues at https://github.com/dj-wasabi/docker-zabbix-web/issues 

Pull Requests are welcome!
