#!/bin/sh

#  test.sh
#  
#
#  Created by command.Zi on 16/9/15.
#

yum groupinstall -y "Development tools"
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel wget
wget http://mirrors.sohu.com/python/2.7.12/Python-2.7.12.tgz
tar zxf Python-2.7.12.tgz
cd Python-2.7.12
./configure
make && make install
cd ~
wget --no-check-certificate https://bootstrap.pypa.io/ez_setup.py
python ez_setup.py --insecure
easy_install supervisor
echo_supervisord_conf > /etc/supervisord.conf






///

[unix_http_server]
file=/tmp/supervisor.sock

[inet_http_server]
port=*:9001


[supervisord]
logfile=/tmp/supervisord.log ; (main log file;default $CWD/supervisord.log)
logfile_maxbytes=50MB        ; (max main logfile bytes b4 rotation;default 50MB)
logfile_backups=10           ; (num of main logfile rotation backups;default 10)
loglevel=info                ; (log level;default info; others: debug,warn,trace)
pidfile=/tmp/supervisord.pid ; (supervisord pidfile;default supervisord.pid)
nodaemon=false               ; (start in foreground if true;default false)
minfds=1024                  ; (min. avail startup file descriptors;default 1024)
minprocs=200                 ; (min. avail process descriptors;default 200)

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///tmp/supervisor.sock ; use a unix:// URL  for a unix socket
serverurl=http://0.0.0.0:9001 ; use an http:// url to specify an inet socket

[program:stun]
directory = /home/neople/stun
command = /home/neople/stun/df_stun_r start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:relay200]
directory = /home/neople/relay/
command = /home/neople/relay/df_relay_r relay_200 relay_215 start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:bridge]
directory = /home/neople/bridge/
command = /home/neople/bridge/df_bridge_r bridge start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:channel]
directory = /home/neople/channel/
command = /home/neople/channel/df_channel_r channel start
exitcommand = /home/neople/channel/df_channel_r channel stop
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:dbmw_guild]
directory = /home/neople/dbmw_guild/
command = /home/neople/dbmw_guild/df_dbmw_r dbmw_gld_siro start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:guild]
directory = /home/neople/guild
command = /home/neople/guild/df_guild_r gld_siro start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:dbmw_mnt]
directory = /home/neople/dbmw_mnt/
command = /home/neople/dbmw_mnt/df_dbmw_r dbmw_mnt_siro start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:manager]
directory = /home/neople/manager/
command = /home/neople/manager/df_manager_r manager start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:monitor]
directory = /home/neople/monitor/
command = /home/neople/monitor/df_monitor_r mnt_siro start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:dbmw_stat]
directory = /home/neople/dbmw_stat
command = /home/neople/dbmw_stat/df_dbmw_r dbmw_stat_siro start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:auction]
directory = /home/neople/auction
command = /home/neople/auction/df_auction_r ./cfg/auction_siro.cfg start ./df_auction_r
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:point]
directory = /home/neople/point
command = /home/neople/point/df_point_r ./cfg/point_siro.cfg start df_point_r
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:statics]
directory = /home/neople/statics
command = /home/neople/statics/df_statics_r stat_siro start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:coserver]
directory = /home/neople/coserver
command = /home/neople/coserver/df_coserver_r coserver start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:community]
directory = /home/neople/community
command = /home/neople/community/df_community_r community start
autostart = false     ; 在 supervisord 启动的时候也自动启动

[program:gunnersvr]
directory = /home/neople/secsvr/gunnersvr
command = /home/neople/secsvr/gunnersvr/gunnersvr -t30 -i1

[program:secagent]
directory = /home/neople/secsvr/zergsvr
command = /home/neople/secsvr/zergsvr/secagent

[program:zergsvr]
directory = /home/neople/secsvr/zergsvr
command = /home/neople/secsvr/zergsvr/zergsvr -t30 -i1

[program:siroco]
directory = /home/neople/game
command = /home/neople/game/df_game_r siroco11 siroco52 siroco56 start
autostart = false     ; 在 supervisord 启动的时候也自动启动

