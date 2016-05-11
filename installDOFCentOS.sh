#!/bin/sh

#  installDOFCentOS.sh
#  
#
#  Created by command.Zi on 16/5/11.
#

function get_my_ip() {
    echo "获取 IP..."
    IP=`curl -s checkip.dyndns.com | cut -d' ' -f 6  | cut -d'<' -f 1`
    if [ -z $IP ]; then
    IP=`curl -s ifconfig.me/ip`
    fi
}

function installDOF() {
    cd ~
    echo "下载Server..."
#   下载Server...
    cp Server.tar.gz /
    cd /
    tar -zvxf Server.tar.gz
    tar -zvxf etc.tar.gz
    tar -zvxf var.tar.gz
    cd ~
    wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
    yum -y localinstall mysql-community-release-el7-5.noarch.rpm
    yum -y install mysql-community-server
    systemctl enable mysqld
    systemctl start mysqld
    yum install -y psmisc
    yum install -y gcc gcc-c++ make zlib-devel
    yum install -y xulrunner.i686
    yum install -y libXtst.i686
    cd /home/GeoIP-1.4.8/
    ./configure
    make && make check && make install
    cd /home/neople/
    sed -i "s/192.168.56.10/${IP}/g" `find . -type f -name "*.tbl"`
    sed -i "s/192.168.56.10/${IP}/g" `find . -type f -name "*.cfg"`
}

get_my_ip
installDOF