#!/bin/sh

#  installDOFCentOS.sh
#  
#
#  Created by command.Zi on 16/5/11.
#

function installDOF() {
    cd ~
    echo "下载Server..."
#   下载Server...
    cp Server.tar.gz /
    cd /
    tar -zvxf Server.tar.gz
    tar -zvxf etc.tar.gz
    tar -zvxf var.tar.gz
# yum remove mysql-libs
    cd ~
    wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
    rpm -ivh mysql-community-release-el7-5.noarch.rpm
    yum makecache
    yum install mysql-community-server-5.6.25-2.el7.x86_64 -y
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


installDOF