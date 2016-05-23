#!/bin/sh

#  installDOFCentOS.sh
#  
#
#  Created by command.Zi on 16/5/11.
#

function install {
    addSwap
    installDOF
    deleteRoot6686
    removeTemp
}

function addSwap() {
    echo "添加 Swap..."
#   if read -n1 -p "请输入虚拟内存大小（正整数、单位为GB、默认6  GB）" answer
#   then
#   /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1000*$answer
    /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=6000
    mkswap /var/swap.1
    swapon /var/swap.1
#   加入开机自动挂载
#   $ 最后一行
#   a 在该指令前面的行数后面插入该指令后面的内容
    sed -i '$a /var/swap.1 swap swap default 0 0' /etc/fstab
    echo "添加 Swap 成功"
    else
    echo "没有添加 Swap"
    fi
}

function installDOF() {
    echo "获取 IP..."
    IP=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
#    IP=`curl -s checkip.dyndns.com | cut -d' ' -f 6  | cut -d'<' -f 1`
#   if [ -z $IP ]; then
#   IP=`curl -s ifconfig.me/ip`
#   fi
    cd ~
    echo "安装运行库..."
    yum -y remove mysql-libs.x86_64
#   yum -y install mysql-server mysql mysql-devel
    yum -y install mariadb-server
    yum -y install gcc gcc-c++ make zlib-devel
    yum -y install xulrunner.i686
    yum -y install libXtst.i686
    chkconfig mysqld on
#    service mysqld start
    systemctl start mariadb
#   添加到开机自启动
    systemctl enable mariadb.service
    echo "下载Server..."
#   修改过的
#    wget -O /root/Server.tar.gz https://www.dropbox.com/s/32nht49ufisn3bh/Server.tar.gz?dl=0
#   原版
#    wget -O /root/Server.tar.gz https://www.dropbox.com/s/9fz5grju3xf2q8c/Server.tar.gz?dl=0

#    wget -O /root/Script.pvf https://www.dropbox.com/s/ofu0d6owm6h3igy/Script.pvf?dl=0
#    wget -O /root/publickey.pem https://www.dropbox.com/s/u2q0s5t56wvkk7l/publickey.pem?dl=0

#   七牛
    wget -O /root/publickey.pem http://o7bu9t1dx.bkt.clouddn.com/publickey.pem
    wget -O /root/Script.pvf http://o7bu9t1dx.bkt.clouddn.com/Script.pvf
    wget -O /root/Server.tar.gz http://o7bu9t1dx.bkt.clouddn.com/Server.tar.gz
#   下载Server...
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
#    service iptables restart

#    service mysqld restart
    systemctl restart mariadb
}

#{
#   mkdir /mnt/disk
#   echo >> /etc/fstab
#   echo /dev/vdb1 /mnt/disk ext4 defaults,noatime 0 0 >> /etc/fstab
#   mount /mnt/disk
#}


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
    echo -n -t 5 "完成安装，是否删除临时文件 y/n [y] ?"
    read ANS
    case $ANS in
    y|Y|yes|Yes)
    rm -f /root/Script.pvf
    rm -f /root/mysql57*
    rm -f /root/publickey.pem
    rm -f /root/Server.tar.gz
    rm -f /var.tar.gz
    rm -f /etc.tar.gz
    rm -f /Server.tar.gz
    rm -f /root/installDOFCentOS.sh
    ;;
    n|N|no|No)
    exit 0
    ;;
    *)
    exit 0
    ;;
    esac
}

install
