#!/bin/sh

#  installDOFCentOS.sh
#  
#
#  Created by command.Zi on 16/5/11.
#

function install() {
    echo "腾讯云的朋友，可以一试，确定按照这里的操作无误，还是无法成功，另找他法吧"
    read -p "输入centOS版本，例如5.11，输入5，然后回车：" versionNumber
#TODO:直接取系统版本号判断，再检测文件是否存在，不符合都跳出
    read -p "输入服务器环境，2为国外(需要自行更换证书及pvf文件)，3为自带Server.tar.gz及证书及pvf文件(此项开始前要确保根目录下存在Server.tar.gz、publickey.pem、Script.pvf)，优先选3，然后回车：" networkState
    if (($versionNumber==5)); then
        installSupportLibOnCentOS5
    elif (($versionNumber==6)); then
        installSupportLibOnCentOS6
    else
        echo "其实只有5和6"
        exit 0
    fi
    echo "添加交换空间，耐心等待⌛……"
    addSwap
    installDOF
    deleteRoot6686
    removeTemp
}

function getIP() {
    echo "获取 IP..."
    IP=`curl -s http://v4.ipv6-test.com/api/myip.php`
    if [ -z $IP ]; then
    IP=`curl -s https://www.boip.net/api/myip`
    fi
}

function addSwap() {
    echo "添加 Swap..."
#   if read -n1 -p "请输入虚拟内存大小（正整数、单位为GB、默认6  GB）" answer
#   then
#   /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1000*$answer
    /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=8000
    mkswap /var/swap.1
    swapon /var/swap.1
#   加入开机自动挂载
#   $ 最后一行
#   a 在该指令前面的行数后面插入该指令后面的内容
    sed -i '$a /var/swap.1 swap swap default 0 0' /etc/fstab
    echo "添加 Swap 成功"
}

function installSupportLibOnCentOS5() {
    echo "安装运行库..."
    if (($networkState==3)); then
        wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-5.repo
        yum clean all
        yum makecache
    fi
    yum -y update
    yum -y upgrade
    yum -y install mysql-server
    yum -y install gcc gcc-c++ make zlib-devel
    yum -y install libstdc++
    yum -y install glibc.i686
    yum -y install libc.so.6
#   添加到开机自启动
    chkconfig mysqld on
    service mysqld start
    service mysqld enable
}

function installSupportLibOnCentOS6() {
    echo "安装运行库..."
    if (($networkState==1)); then
        wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
        yum clean all
        yum makecache
    fi
    yum -y update
    yum -y upgrade
    yum -y remove mysql-libs.x86_64
    yum -y install mariadb-server
    yum -y install gcc gcc-c++ make zlib-devel
    yum -y install xulrunner.i686
    yum -y install libXtst.i686
    systemctl start mariadb
    systemctl enable mariadb.service
}

function installDOF() {
    getIP
    echo -n "${IP} 是否是你的外网IP？(如果不是你的外网IP或者出现两条IP地址，请回 n 自行输入) y/n [n] ?"
    read ans
    case $ans in
    y|Y|yes|Yes)
    ;;
    n|N|no|No)
    read -p "输入你的外网IP地址，回车（确保是英文字符的点号）：" myip
    IP=$myip
    ;;
    *)
    ;;
    esac
    cd ~
    echo "下载Server..."
    if (($networkState==5)); then
        cd ~
    #   七牛
    elif (($networkState==3)); then
        cd ~
    else
        wget -O /root/Server.tar.gz https://www.dropbox.com/s/9fz5grju3xf2q8c/Server.tar.gz?dl=0
        wget -O /root/Script.pvf https://www.dropbox.com/s/ofu0d6owm6h3igy/Script.pvf?dl=0
        wget -O /root/publickey.pem https://www.dropbox.com/s/u2q0s5t56wvkk7l/publickey.pem?dl=0
    fi
    cp Server.tar.gz /
    cd /
    tar -zvxf Server.tar.gz
    tar -zvxf var.tar.gz
    cd /home/GeoIP-1.4.8/
    ./configure
    make && make check && make install
    cd /home/neople/
    sed -i "s/192.168.56.10/${IP}/g" `find . -type f -name "*.tbl"`
    sed -i "s/192.168.56.10/${IP}/g" `find . -type f -name "*.cfg"`
    cp /root/Script.pvf /home/neople/game/
    cp /root/publickey.pem /home/neople/game/
    echo "添加防火墙端口..."
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 8000 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 3306 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 10013 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 30303 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 30403 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 10315 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 30603 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 20203 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 7215 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 20303 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 40401 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 30803 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 20403 -j ACCEPT' /etc/sysconfig/iptables
    sed -i '/INPUT.*NEW.*22/a -A INPUT -m state --state NEW -m tcp -p tcp --dport 31100 -j ACCEPT' /etc/sysconfig/iptables
#   端口不全，这里先把防火墙关了
    service iptables stop
#   TODO:关闭防火墙自启动
    service mysqld restart
    systemctl restart mariadb
}

function deleteRoot6686() {
    HOSTNAME="127.0.0.1"
    PORT="3306"
    USERNAME="game"
    PASSWORD="uu5!^%jg"
    DBNAME="mysql"
    TABLENAME="user"
    refresh="flush privileges;";
    delete_user_root6686="delete from mysql.user where user='root9326686' and host='%';"
#  delete_user_cash="delete from mysql.user where user='cash' and host='127.0.0.1';"
    mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${delete_user_root6686}"
#  mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${delete_user_cash}"
    mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${refresh}"
}

function removeTemp() {
    echo -n -t 5 "完成安装，是否删除临时文件 y/n [n] ?"
    read ANS
    case $ANS in
    y|Y|yes|Yes)
    rm -f /root/mysql57*
    rm -f /var.tar.gz
    rm -f /etc.tar.gz
    rm -f /Server.tar.gz
    ;;
    n|N|no|No)
    ;;
    *)
    ;;
    esac
}

install
echo "***********************"
echo " IP = ${IP}"
echo "重启的话需要使用命令 service iptables stop 重新关闭防火墙"
echo "***********************"
