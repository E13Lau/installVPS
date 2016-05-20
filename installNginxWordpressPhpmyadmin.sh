#!/bin/sh

#  installNginxWordpressPhpmyadmin.sh
#  
#
#  Created by command.Zi on 16/5/18.
#

function installAll() {
    install_mysql-server
    install_PHP
    install_nginx
    install_wordpress
    install_phpmyadmin
    install_ss-panel
}

function install_mysql-server() {
    yum -y install mysql-server
}


function install_PHP() {
    rpm -Uvh http://ftp.iij.ad.jp/pub/linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
    rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
    yum -y install --enablerepo=remi --enablerepo=remi-php56 php php-opcache php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pecl-xhprof
    yum -y install php-fpm php-mysql
    service php-fpm start
    chkconfig php-fpm on
    mkdir /var/lib/php/session/
    chown -R apache:apache /var/lib/php/session/
}

function install_nginx() {
    yum -y install nginx
    service nginx start
    chkconfig nginx on
    touch /etc/nginx/conf.d/wordpress.conf
    cat > /etc/nginx/conf.d/wordpress.conf << EOF
server {
    listen 80;
    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    root /usr/share/wordpress;
    location / {
        index index.php index.html index.htm;
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
#        root           /usr/share/wordpress;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
}
EOF

    touch /etc/nginx/conf.d/phpmyadmin.conf
    cat > /etc/nginx/conf.d/phpmyadmin.conf << EOF
server {
    listen 80;
    server_name mysqld.glrou.xyz;
    root /usr/share/phpmyadmin;
    location ~ \.php$ {
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }
}
EOF

    touch /etc/nginx/conf.d/ss-panel.conf
    cat > /etc/nginx/conf.d/ss-panel.conf << EOF
server {
    listen 80;
    server_name sspanel.glrou.xyz;
    root /usr/share/ss-panel/public;
    location ~ \.php$ {
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }
}
EOF

    service nginx reload;
}

function install_wordpress() {

}

function install_phpmyadmin() {

}

function install_ss-panel() {
    cd /usr/share
    git clone https://github.com/orvice/ss-panel.git
    chown -R nginx:nginx ss-panel
    cd ss-panel
    curl -sS https://getcomposer.org/installer | php
    php composer.phar  install
    cp .env.example .env
    chmod -R 777 storage
}

