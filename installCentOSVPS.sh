#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

clear
echo "#############################################################"
echo "# Install My config in Ubuntu"
echo "#"
echo "#############################################################"
echo ""

function install_vps() {
    rootness
    get_my_ip
    install_SS
    setup_SS
    installAria2
    addSwap
}

# Make sure only root can run our script
function rootness() {
    if [[ $EUID -ne 0 ]]; then
    echo "Error:This script must be run as root!" 1>&2
    exit 1
    fi
}

# Get IP address of the server
function get_my_ip() {
    echo "获取 IP..."
    IP=`curl -s checkip.dyndns.com | cut -d' ' -f 6  | cut -d'<' -f 1`
    if [ -z $IP ]; then
    IP=`curl -s ifconfig.me/ip`
    fi
}

function install_SS() {
    yum -y update
    echo "安装 shadowsocks..."
    yum install -y python-setuptools
    easy_install pip
    pip install shadowsocks
}

function setup_SS() {
    echo "配置 shadowsocks..."
    /sbin/ifconfig|sed -n '/inet addr/s/^[^:]*:\([0-9.]\{7,15\}\) .*/\1/p'
    cat > /etc/shadowsocks.json << EOF
{
    "server":"${IP}",
    "port_password":{
    "8381":"LyzLyz123",
    "8382":"LyzLyz123",
    "8481":"CylCyl"
    },
    "timeout":300,
    "method":"rc4-md5",
    "fast_open":true,
    "workers":1
}
EOF

# 启动服务
    echo "后台启动 shadowsocks..."
    ssserver -c /etc/shadowsocks.json -d start
    echo 'ssserver -c /etc/shadowsocks.json -d start' >> /etc/rc.local
}

function install_Aria2() {
    echo "安装 Aria2..."
    yum install aria2 -y
    mkdir /root/Downloads
    touch /root/Downloads/aria2.conf
    touch /root/Downloads/aria2.session
    cat << EOF > /root/Downloads/aria2.conf
#允许rpc
enable-rpc=true
#允许所有来源, web界面跨域权限需要
rpc-allow-origin-all=true
#允许非外部访问
rpc-listen-all=true
#RPC端口, 仅当默认端口被占用时修改
#rpc-listen-port=6800
rpc-user=command
rpc-passwd=LyzLyz
#最大同时下载数(任务数), 路由建议值: 3
max-concurrent-downloads=10
#断点续传
continue=true
#同服务器连接数
max-connection-per-server=10
#最小文件分片大小, 下载线程数上限取决于能分出多少片, 对于小文件重要
min-split-size=10M
#单文件最大线程数, 路由建议值: 5
split=10
#下载速度限制
max-overall-download-limit=0
#单文件速度限制
max-download-limit=0
#上传速度限制
max-overall-upload-limit=0
#单文件速度限制
max-upload-limit=0
#断开速度过慢的连接
#lowest-speed-limit=0
#验证用，需要1.16.1之后的release版本
#referer=*
input-file=/root/Downloads/aria2.session
save-session=/root/Downloads/aria2.session
#定时保存会话，需要1.16.1之后的release版
#save-session-interval=60
#文件保存路径, 默认为当前启动位置
dir=/root/Downloads
#文件缓存, 使用内置的文件缓存, 如果你不相信Linux内核文件缓存和磁盘内置缓存时使用, 需要1.16及以上版本
#disk-cache=0
#另一种Linux文件缓存方式, 使用前确保您使用的内核支持此选项, 需要1.15及以上版本(?)
#enable-mmap=true
#文件预分配, 能有效降低文件碎片, 提高磁盘性能. 缺点是预分配时间较长
#所需时间 none < falloc ? trunc << prealloc, falloc和trunc需要文件系统和内核支持
file-allocation=prealloc
#启用本地节点查找
bt-enable-lpd=true
#添加额外的tracker
#bt-tracker=<URI>,…
#单种子最大连接数
#bt-max-peers=55
#强制加密, 防迅雷必备
#bt-require-crypto=true
#当下载的文件是一个种子(以.torrent结尾)时, 自动下载BT
follow-torrent=true
#BT监听端口, 当端口屏蔽时使用
#listen-port=6881-6999
#不确定是否需要，为保险起见，need more test
enable-dht=false
bt-enable-lpd=false
enable-peer-exchange=false
#修改特征
user-agent=uTorrent/2210(25130)
peer-id-prefix=-UT2210-
#修改做种设置, 允许做种
seed-ratio=0
#保存会话
#force-save=
bt-hash-check-seed=true
bt-seed-unverified=true
bt-save-metadata=true
#定时保存会话，需要1.16.1之后的某个release版本（比如1.16.2）
save-session-interval=60
EOF
}

function install_DOF() {
    cd ~
    echo "下载Server..."
#   下载Server...
    aria2c -c -s10 -k1M -x10 -o 'Server.tar.gz' --header "User-Agent: netdisk;5.3.4.5;PC;PC-Windows;5.1.2600;WindowsBaiduYunGuanJia"  --header "Referer: http://pan.baidu.com/disk/home"  --header "Cookie: BDUSS=nA0Wn5OVkhVNWJwRWtvcFJySmJ6ZG5PNGQtNkZHMUt4dEphWUJWZX5OU2FuMDlYQVFBQUFBJCQAAAAAAAAAAAEAAAAqmT8lbGtkODg2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJoSKFeaEihXd;pcsett=1462974954-1c669b501ce839aa29af09cf430e70a5"  "http://d.pcs.baidu.com/file/5e5780ee4ae0c534c4111cb993ef6900?fid=2569102560-250528-597905699960375&time=1462888569&rt=sh&sign=FDTAERV-DCb740ccc5511e5e8fedcff06b081203-enQ1CEPjHmHF9%2BMGnpyA4OvhvGU%3D&expires=8h&chkv=1&chkbd=0&chkpc=&dp-logid=3036265092391645472&dp-callid=0&r=271625130"
    aria2c -c -s10 -k1M -x10 -o 'Script.pvf' --header "User-Agent: netdisk;5.3.4.5;PC;PC-Windows;5.1.2600;WindowsBaiduYunGuanJia"  --header "Referer: http://pan.baidu.com/disk/home"  --header "Cookie: BDUSS=nA0Wn5OVkhVNWJwRWtvcFJySmJ6ZG5PNGQtNkZHMUt4dEphWUJWZX5OU2FuMDlYQVFBQUFBJCQAAAAAAAAAAAEAAAAqmT8lbGtkODg2AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJoSKFeaEihXd;pcsett=1462975025-a9b2de48fa3b5485e4a2edfcbce69f44"  "http://d.pcs.baidu.com/file/086a2cceef43b363ad2fc055d4c51d93?fid=2569102560-250528-183038949702254&time=1462888675&rt=sh&sign=FDTAERV-DCb740ccc5511e5e8fedcff06b081203-I3gYK7OPUJxzRx0iLcnp%2BXCKSdM%3D&expires=8h&chkv=1&chkbd=0&chkpc=&dp-logid=3036293766884338079&dp-callid=0&r=887282186"

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

function addSwap() {
    echo "添加 Swap..."
    /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=6144
    /sbin/mkswap /var/swap.1
    /sbin/swapon /var/swap.1
    echo '/sbin/swapon /var/swap.1' >> /etc/rc.local
}

function install_net-speeder() {
    wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    rpm -ivh epel-release-6-8.noarch.rpm
    yum -y install libnet libpcap libnet-devel libpcap-devel
    yum -y install zip unzip
    wget https://github.com/snooda/net-speeder/archive/master.zip
    unzip master.zip
    cd net-speeder-master
    sh build.sh
    cp ./net_speeder /usr/bin
    nohup /usr/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &
    echo 'nohup /usr/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &' >> /etc/rc.local
    echo "net-speeder 启动成功..."
}

function install_Dropbox() {
    cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    ~/.dropbox-dist/dropboxd
    ~/.dropbox-dist/dropboxd &
}
#function removeTemp() {
#
#}
#google authentication

install_vps


