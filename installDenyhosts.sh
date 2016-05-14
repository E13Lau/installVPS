#!/bin/sh

#  installDenyhosts.sh
#  
#
#  Created by command.Zi on 16/5/14.
#

{
yum -y install denyhosts

/etc/denyhosts.conf

/etc/hosts.deny

service denyhosts start
service denyhosts restart
}

{
SECURE_LOG = /var/log/secure
#ssh 日志文件，它是根据这个文件来判断的。
HOSTS_DENY = /etc/hosts.deny
#控制用户登陆的文件
PURGE_DENY = 1d
#过多3天后清除已经禁止的
BLOCK_SERVICE  = sshd
#禁止的服务名
DENY_THRESHOLD_INVALID = 1
#允许无效用户失败的次数
DENY_THRESHOLD_VALID = 3
#允许普通用户登陆失败的次数
DENY_THRESHOLD_ROOT = 3
#允许root登陆失败的次数
HOSTNAME_LOOKUP=NO
#是否做域名反解
#ADMIN_EMAIL = chn.lyzasd@gmail.com
#管理员邮件地址,它会给管理员发邮件
DAEMON_LOG = /var/log/denyhosts
#自己的日志文件
}