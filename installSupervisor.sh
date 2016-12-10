#!/bin/sh

#  installSupervisor.sh
#  
#
#  Created by command.Zi on 16/9/15.
#

yum -y install wget

wget http://dl.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm
rpm -ivh epel-release-5-4.noarch.rpm

wget https://raw.github.com/scalp42/python-2.7.x-on-Centos-5.x/master/install_python27.sh --no-check-certificate
sh ./install_python27.sh
