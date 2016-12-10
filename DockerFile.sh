#!/bin/sh

#  DockerFile.sh
#  
#
#  Created by command.Zi on 16/9/10.
#

yum -y install wget
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-5.noarch.rpm
rpm -ivh epel-release-latest-5.noarch.rpm
yum -y install mysql55-mysql-server gcc gcc-c++ make zlib-devel libc.so.6 libstdc++ glibc.i686
chkconfig mysql55-mysqld on
?


//update python
wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tar.xz
yum -y install xz
unxz Python-2.7.9.tar.xz
tar -xvf Python-2.7.9.tar
cd Python-2.7.9
./configure
make
make install





//update python
wget --no-check-certificate https://raw.github.com/scalp42/python-2.7.x-on-Centos-5.x/master/install_python27.sh