#!/usr/bin/env bash

set -o errexit
set -o xtrace
set -o nounset

# https://gist.github.com/drogus/6718448

apt-get remove mysql-common mysql-server-5.5 mysql-server-core-5.5 mysql-client-5.5 mysql-client-core-5.5
apt-get autoremove
apt-get install libaio1
wget -O mysql-5.6.14.deb http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.14-debian6.0-x86_64.deb/from/http://cdn.mysql.com/
dpkg -i mysql-5.6.14.deb
cp /opt/mysql/server-5.6/support-files/mysql.server /etc/init.d/mysql.server
ln -s /opt/mysql/server-5.6/bin/* /usr/bin/
# some config values were changed since 5.5
cat /etc/mysql/my.cnf
sed -i'' 's/table_cache/table_open_cache/' /etc/mysql/my.cnf
sed -i'' 's/log_slow_queries/slow_query_log/' /etc/mysql/my.cnf
#sed -i'' 's/basedir[^=]\\+=.*$/basedir = \\/opt\\/mysql\\/server-5.6/' /etc/mysql/my.cnf

ls -l /etc/init.d/mysql.server
service mysql stop || true
/etc/init.d/mysql.server start
