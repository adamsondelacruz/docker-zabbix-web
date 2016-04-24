#!/usr/bin/env bash


cat <<EOF > /etc/zabbix/web/zabbix.conf.php
<?php
// Zabbix GUI configuration file.
global \$DB;

\$DB['TYPE']     = 'MYSQL';
\$DB['SERVER']   = '${DBSERVER:-localhost}';
\$DB['PORT']     = '${DBPORT:-3306}';
\$DB['DATABASE'] = '${DBNAME:-zabbix}';
\$DB['USER']     = '${DBUSER:-zabbix}';
\$DB['PASSWORD'] = '${DBPASSWORD:-zabbix}';

// Schema name. Used for IBM DB2 and PostgreSQL.
\$DB['SCHEMA'] = '';

\$ZBX_SERVER      = '${ZBXSERVER:-localhost}';
\$ZBX_SERVER_PORT = '${ZBXSERVERPORT:-10051}';
\$ZBX_SERVER_NAME = '${ZBXSERVERNAME:-Zabbix}';

\$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>
EOF

# Create VHOST
cat <<EOF > /etc/apache2/sites-enabled/zabbix.conf
NameVirtualHost *:80

<VirtualHost *:80>
  ServerName ${ZABBIX_URL}
  DocumentRoot "/usr/share/zabbix"
#    <IfModule mod_alias.c>
#        Alias /zabbix /usr/share/zabbix
#    </IfModule>

    <Directory "/usr/share/zabbix">
        Options FollowSymLinks
        AllowOverride None
        Order allow,deny
        Allow from all

        <IfModule mod_php5.c>
            php_value max_execution_time ${APACHE_MAX_EXECUTION_TIME:-300}
            php_value memory_limit ${APACHE_MEMORY_LIMIT:-128M}
            php_value post_max_size ${APACHE_POST_MAX_SIZE:-16M}
            php_value upload_max_filesize ${APACHE_UPLOAD_MAX_FILESIZE:-2M}
            php_value max_input_time ${APACHE_MAX_INPUT_TIME:-300}
            php_value always_populate_raw_post_data ${APACHE_ALWAYS_POPULATE_RAW_POST_DATA:--1}
            php_value date.timezone ${APACHE_TIMEZONE:-Europe/Amsterdam}
        </IfModule>
    </Directory>

    <Directory "/usr/share/zabbix/conf">
        Order deny,allow
        Deny from all
        <files *.php>
            Order deny,allow
            Deny from all
        </files>
    </Directory>

    <Directory "/usr/share/zabbix/app">
        Order deny,allow
        Deny from all
        <files *.php>
            Order deny,allow
            Deny from all
        </files>
    </Directory>

    <Directory "/usr/share/zabbix/include">
        Order deny,allow
        Deny from all
        <files *.php>
            Order deny,allow
            Deny from all
        </files>
    </Directory>

    <Directory "/usr/share/zabbix/local">
        Order deny,allow
        Deny from all
        <files *.php>
            Order deny,allow
            Deny from all
        </files>
    </Directory>
</VirtualHost>

EOF

chown www-data:www-data /etc/zabbix/web/zabbix.conf.php
chown www-data:www-data /etc/apache2/sites-enabled/zabbix.conf

sed -i 's/IncludeOptional /IncludeOptional \/etc\/apache2\//g' /etc/apache2/apache2.conf

cd /etc/apache2
apachectl -d . -f /etc/apache2/apache2.conf -e info -DFOREGROUND
