#!/bin/sh

#  installCentOSSSWithSSpanel.sh
#  
#
#  Created by command.Zi on 16/7/24.
#
#  php5.x mysql5.x
#  https://github.com/maxidea-com/ss-panel

#https://mos.meituan.com/library/19/how-to-install-lnmp-on-centos6/
#https://github.com/lasyman/lasyman_setup_ss
#https://github.com/maxidea-com/ss-panel/wiki/v3-Guide

wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
#http://blog.csdn.net/hualusiyu/article/details/8487089
yum -y install redis
yum --enablerepo=remi,remi-test install mysql-server
#http://m.blog.csdn.net/article/details?id=49250455
#http://www.linuxidc.com/Linux/2012-07/65098.htm
service mysqld start
mysql -u root -p #空密码
mysql>CREATE DATABASE sspanel character SET utf8;
mysql>CREATE user 'ssuser'@'localhost' IDENTIFIED BY 'sspasswd';
mysql>GRANT ALL privileges ON sspanel.* TO 'ssuser'@'localhost';
mysql>FLUSH PRIVILEGES;
mysql>quit
yum -y install git curl nginx
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum -y install --enablerepo=remi --enablerepo=remi-php56 php php-mysql php-fpm php-guzzle
#https://www.bxl.me/8634.html
yum install -y python-pip m2crypto
pip install --upgrade pip
pip install --upgrade setuptools
pip install cymysql
cd /opt
git clone -b manyuser https://github.com/mengskysama/shadowsocks.git
cd ./shadowsocks/shadowsocks
mysql -u ssuser -psspasswd sspanel < ./shadowsocks.sql

sed -i "/^MYSQL_HOST/ s#'.*'#'localhost'#" ./Config.py
sed -i "/^MYSQL_PORT/ s#'.*'#'3306'#" ./Config.py
sed -i "/^MYSQL_USER/ s#'.*'#'ssuser'#" ./Config.py
sed -i "/^MYSQL_PASS/ s#'.*'#'sspasswd'#" ./Config.py
sed -i "/^MYSQL_DB/ s#'.*'#'sspanel'#" ./Config.py

vi config.json
{
"server":"0.0.0.0", #除了容器以外，VPS等云主机一般需要设置为公网IP地址
"server_ipv6": "[::]",
"server_port":8388,
"local_address": "127.0.0.1",
"local_port":1080,
"password":"m",
"timeout":300,
"method":"aes-256-cfb"
}

cd /opt
git clone https://github.com/maxidea-com/ss-panel.git
curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer
cd /opt/ss-panel/
composer install
chmod -R 777 storage

cp .env.example .env
vi .env
//  ss-panel v3 配置
//
// !!! 修改此key为随机字符串确保网站安全 !!!
key = '@$@%#fdDWERW@#FDF#$#'
debug =  'false'  //  正式环境请确保为false #如果启动站点出现“Slim Application Error”，则把debug设置为‘true’，即可在页面上查看错误日志。
appName = 'ss控制平台v3.0'             //站点名称
baseUrl = 'http://ss.glrou.xyz'            // 站点地址
timeZone = 'PRC'        // RPC 中国时间  UTC 格林时间
pwdMethod = 'sha256'       // 密码加密   可选 md5,sha256
salt = ''               // 密码加密用，从旧版升级请留空
theme    = 'default'   // 主题
authDriver = 'redis'   // 登录验证存储方式,推荐使用Redis   可选: cookie,redis
sessionDriver = 'redis'
cacheDriver   = 'redis'

// 邮件
mailDriver = 'mailgun'   // mailgun or smtp #如需使用邮件提醒，例如邮件找回密码，请注册mailgun账号并设置 （https://mailgun.com/）

// 用户签到设置
checkinTime = '22'      // 签到间隔时间 单位小时
checkinMin = '93'       // 签到最少流量 单位MB
checkinMax = '97'       // 签到最多流量

//
defaultTraffic = '50'      // 用户初始流量 单位GB

// 注册后获得的邀请码数量 #建议禁用，设置为0，以后邀请码从admin后台手工生成
inviteNum = '0'

# database 数据库配置
db_driver = 'mysql'
db_host = 'localhost'
db_database = 'sspanel'
db_username = 'ssuser'
db_password = 'sspasswd'
db_charset = 'utf8'
db_collation = 'utf8_general_ci'
db_prefix = ''

# redis
redis_scheme = 'tcp'
redis_host = '127.0.0.1'
redis_port = '6379'
redis_database = '0'
.........

mysql -u ssuser -psspasswd sspanel < db-160212.sql

/opt/ss-panel# php xcat createAdmin
add admin/ 创建管理员帐号.....Enter your email/输入管理员邮箱: 1234567890@gmail.com
Enter password for: 1234567890@gmail.com / 为 1234567890@gmail.com 添加密码 1234567890pw
Email: 1234567890@gmail.com, Password: 1234567890pw! Press [Y] to create admin..... 按下[Y]确认来确认创建管理员账户..... Y


iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 1025 -j ACCEPT


vi /etc/nginx/conf.d/ss.conf
server {

    listen 80;
    server_name ss.glrou.xyz;
    root /opt/ss-panel/public;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ \.php$ {
        #        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        #       # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
        #
        #       # With php5-cgi alone:
        fastcgi_pass 127.0.0.1:9000;
        #       # With php5-fpm:
        #       fastcgi_pass unix:/var/run/php-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}


service nginx restart
service php-fpm restart
service redis restart
service mysqld start
