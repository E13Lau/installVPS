#!/bin/sh

#  DOF.sh
#  
#
#  Created by command.Zi on 16/9/8.
#






find /home/neople/ -name "*.pid"  | xargs rm -f



------
Process is already operated.
------
//stun:打晕
[program:stun]
directory = /home/neople/stun
command = /home/neople/stun/df_stun_r start &



//binding 7200 8200
//Set Relay Server for PVP Channel
//设置中继服务器 PVP 通道
//relay:中继
[program:relay200]
directory = /home/neople/relay/
command = /home/neople/relay/df_relay_r relay_200 relay_215 start &

/**
---------
Called prepareRun
Called run
In loop : port='7215'
Set Relay Server for PVP Channel
succeeded in binding TCP socket port #7215
succeeded in binding UDP socket port #8215
---------
[program:relay215]
directory = /home/neople/relay/
command = /home/neople/relay/df_relay_r relay_215  start &
**/

-------
succeeded in binding UDP socket port! #7000
Start up TCPAcceptThread
Start up TCPThread
succeeded in binding TCP socket port #7000
DB ip='127.0.0.1'
DB id='game'
DB pw='uu5!^%jg'
DB name='d_channel'
Try Mysql Login~~~~
mysql connect success
1.[anton],[10000]
1.[first],[100000]
1.[cain],[2000]
1.[diregie],[3000]
1.[siroco],[4000]
1.[prey],[5000]
1.[casillas],[6000]
1.[hilder],[7000]
1.[ruke],[8000]
1.[seria],[9000]
--------
//bridge:桥梁
[program:bridge]
directory = /home/neople/bridge/
command = /home/neople/bridge/df_bridge_r bridge start &

--------
20160907 025801 : Start Thread rasing
20160907 025801 : The UDP Thread rasing success
20160907 025801 : The TCPAccept Thread rasing success
20160907 025801 : The Check Thread rasing success
20160907 025801 : The TCP Thread rasing success
20160907 025801 : My ID is=3
20160907 025801 : ----------------------------------------------------------
20160907 025801 : -   XX            Channel Server Start Ver1.0              -
20160907 025801 : ----------------------------------------------------------
Start up UDPThread
succeeded in binding UDP socket port! #7001
Start up TCPAcceptThread
succeeded in binding TCP socket port #7001
Start up CheckThread
Start up TCPThread
Epoll init::5000

20160908 151234 : -   XX            Channel Server Start Ver1.0              -
20160908 151234 : ----------------------------------------------------------
Start up UDPThread
Start up CheckThread
Start up TCPThread
Epoll init::5000
Start up TCPAcceptThread
succeeded in binding UDP socket port! #7001
succeeded in binding TCP socket port #7001
[[[[script version='59']]]]
Server Group Count = '10'

--------
//channel:频道
[program:channel]
directory = /home/neople/channel/
command = /home/neople/channel/df_channel_r channel start &


------
Application Init() Success!
Application App Config Load_Table() Success!
Application Server Config Load_Table() Success!
Application Init Frame Count() Success!
Application UDP Handler Create() Success!
Application Server Handler Create() Success!
Application Packet Translater Attach() Success!
Application Packet Decoder Attach() Success!
Application DB Manager Init() Success!
E_MASTER_DB Open Success!
E_ACCOUNT_DB Open Success!
E_GAME_DB Open Success!
E_GAME_DB_2ND Open Success!
E_LOG_DB Open Success!
E_WEB_DB Open Success!
E_SSO_DB Open Success!
E_GUILD_DB Open Success!
E_EVENT_DB Open Success!
E_SE_EVENT_DB Open Success!
E_FRAME_LAG_INDEX_DB Open Success!
DBMW_ALL_DB Open Success
Application Network Thread Begin() Success!
Application Load() Success!
succeeded in binding TCP socket port #20403
Network Thread Start!
------
//guild:公会
[program:dbmw_guild]
directory = /home/neople/dbmw_guild/
command = /home/neople/dbmw_guild/df_dbmw_r dbmw_gld_siro start &



//CONNECTION FAIL IP =192.168.56.10, PORT =20403, reason =Network is unreachabletcpSock.connect Fail!
-----------
Application OpenTcpService(fd:11,ip:127.0.0.1,port:20403) Success!
Application Load() Success!
Accept GameServer(Port : 24)
Network Thread Start!
CPacketTranslater::OnTcpServerLogin(TYPE:9, sock:24)
-----------
//guild:公会
[program:guild]
directory = /home/neople/guild
command = /home/neople/guild/df_guild_r gld_siro start &




--------------------
E_MASTER_DB Open Success!
E_ACCOUNT_DB Open Success!
E_GAME_DB Open Success!
E_GAME_DB_2ND Open Success!
E_LOG_DB Open Success!
E_WEB_DB Open Success!
E_SSO_DB Open Success!
E_GUILD_DB Open Success!
E_EVENT_DB Open Success!
E_SE_EVENT_DB Open Success!
E_FRAME_LAG_INDEX_DB Open Success!
DBMW_ALL_DB Open Success
Application Network Thread Begin() Success!
Application Load() Success!
succeeded in binding TCP socket port #20203
---------------
//mnt:??
//siro:赛络
[program:dbmw_mnt]
directory = /home/neople/dbmw_mnt/
command = /home/neople/dbmw_mnt/df_dbmw_r dbmw_mnt_siro start &

-----------
//binding TCP 40401
//Application Init() Success!
//Application App Config Load_Table() Success!
//Application Server Config Load_Table() Success!
//Application Init Frame Count() Success!
//Application UDP Handler Create() Success!
//Application Server Handler Create() Success!
//Application Packet Translater Attach() Success!
//Application Packet Decoder Attach() Success!
//Application Network Thread Begin() Success!
//Application Load() Success!
//succeeded in binding TCP socket port #40401
-----------
//manager:管理者
[program:manager]
directory = /home/neople/manager/
command = /home/neople/manager/df_manager_r manager start &


//CONNECTION FAIL IP =192.168.56.10, PORT =20203, reason =Network is unreachabletcpSock.connect Fail!
-------
[!] Service Date (16-09-07/03:06)
Application Init() Success!
Application Stop!
succeeded in binding TCP socket port #30303
Accept GameServer(Port : 15)
Application OpenTcpService(fd:15,ip:127.0.0.1,port:40401) Success!
Application OpenTcpService(fd:17,ip:127.0.0.1,port:20203) Success!
Application Load() Success!
Accept GameServer(Port : 23)
m_queTask pop size(2)
Network Thread Start!
CPacketTranslater::OnTcpServerLogin(TYPE:3, sock:15)
CPacketTranslater::OnTcpServerLogin(TYPE:10, sock:23)
m_queTask pop size(1)
--------
//monitor:监控
[program:monitor]
directory = /home/neople/monitor/
command = /home/neople/monitor/df_monitor_r mnt_siro start &


!!!!
--------
E_EVENT_DB Open Success!
E_SE_EVENT_DB Open Success!
E_FRAME_LAG_INDEX_DB Open Success!
DBMW_ALL_DB Open Success
Application Network Thread Begin() Success!
Application Load() Success!
succeeded in binding TCP socket port #20303
--------
//统计
[program:dbmw_stat]
directory = /home/neople/dbmw_stat
command = /home/neople/dbmw_stat/df_dbmw_r dbmw_stat_siro start &



-------
Udp Port binding fail, 192.168.56.10 , 30803

=====================DB config check=========================
Game DB IP      : 127.0.0.1
Game DB PORT    : 3306
Game DB Account : game
Game DB Password: 20e35501e56fcedbe8b10c1f8bc3595be8b10c1f8bc3595b
Game DB Name    : taiwan_cain_2nd
Auction DB IP      : 127.0.0.1
Auction DB PORT    : 3306
Auction DB Account : game
Auction DB Password: 20e35501e56fcedbe8b10c1f8bc3595be8b10c1f8bc3595b
Auction DB Name    : taiwan_cain_auction_gold
=====================DB config check=========================

127.0.0.1 taiwan_cain_2nd SUCCESS
127.0.0.1 taiwan_cain_auction_gold SUCCESS
TCPThread ???? ????-0x92f2058
------------------------------------------
-		Server Frame Start Ver1.0       -
------------------------------------------
Start up TCPThread
Epoll init::6000
succeeded in binding TCP socket port #30803
--------
//auction:拍卖
[program:auction]
directory = /home/neople/auction
command = /home/neople/auction/df_auction_r ./cfg/auction_siro.cfg start ./df_auction_r &


-----------
Udp Port binding fail, 192.168.56.10 , 30603
Start up TCPSendThread-0x8eb07b8

=====================DB config check=========================
Game DB IP      : 127.0.0.1
Game DB PORT    : 3306
Game DB Account : game
Game DB Password: 20e35501e56fcedbe8b10c1f8bc3595be8b10c1f8bc3595b
Game DB Name    : taiwan_cain_2nd
Auction DB IP      : 127.0.0.1
Auction DB PORT    : 3306
Auction DB Account : game
Auction DB Password: 20e35501e56fcedbe8b10c1f8bc3595be8b10c1f8bc3595b
Auction DB Name    : taiwan_cain_auction_cera
=====================DB config check=========================

127.0.0.1 taiwan_cain_2nd SUCCESS
127.0.0.1 taiwan_cain_auction_cera SUCCESS
TCPThread ???? ????-0x8eb1028
------------------------------------------
-		Server Frame Start Ver1.0       -
------------------------------------------
Start up TCPThread
Epoll init::6000
succeeded in binding TCP socket port #30603
--------
//point:点？？
[program:point]
directory = /home/neople/point
command = /home/neople/point/df_point_r ./cfg/point_siro.cfg start df_point_r &






------------
[!] Service Date (16-09-07/03:15)
Application Stop!
Application Init() Success!
Application Load() Success!
---Time : 3, 16 ----
avgPing(0, 0, 0)
avgPing Res(0)
avgPing(0, 0, 0)
avgPing Res(0)
----------
//statics:静力学
//stat:统计
[program:statics]
directory = /home/neople/statics
command = /home/neople/statics/df_statics_r stat_siro start &



------
[!] Service Date (16-09-07/03:17)
Application Stop!
Application Init() Success!
Application Load() Success!
AppThread Thread Start!
AppThread Thread Start!
AppThread Thread Start!
Network Thread Start!
AppThread Thread Start!
AppThread Thread Start!
AppThread Thread Start!
AppThread Thread Start!
AppThread Thread Start!
AppThread Thread Start!
AppThread Thread Start!
Network Thread Start!
Network Thread Start!
Network Thread Start!
Network Thread Start!
Network Thread Start!
Network Thread Start!
Network Thread Start!
Network Thread Start!
Network Thread Start!
Network Thread Start!
---Time : 3, 18 ----
avgPing(0, 0, 0)
avgPing Res(0)
-------
//co server:公司服务器
[program:coserver]
directory = /home/neople/coserver
command = /home/neople/coserver/df_coserver_r coserver start &


-------
./pid/community.pid
[03:21:22] Listen Socket IP:(null), PORT:31100
Community Server(IP:(null), PORT:31100)
Start
-------
//community = 团体、群落
[program:community]
directory = /home/neople/community
command = /home/neople/community/df_community_r community start &



---------
2016-09-07 03:23:07.925968[INFO][framework] gunnersvr start init
2016-09-07 03:23:07.926375[INFO][framework] change work dir to /home/neople/secsvr/gunnersvr
2016-09-07 03:23:07.934744[INFO][framework] cfgsdk init succ. start task succ
2016-09-07 03:23:07.936445[INFO]Comm_Svrd_Config: load framework config succ.
2016-09-07 03:23:08.001648[DEBUG][framework] ZEN_Reactor and ZEN_Epoll_Reactor initialized.
2016-09-07 03:23:08.140011[INFO][framework] MMAP Pipe init success,gogogo.The more you have,the more you want.
2016-09-07 03:23:08.150202[DEBUG]log instance finalize .
---------
//gunner:炮手
[program:gunnersvr]
directory = /home/neople/secsvr/gunnersvr
command = /home/neople/secsvr/gunnersvr/gunnersvr -t30 -i1  &


------
2016-09-07 03:25:24.230917[INFO][framework] secagent start init
2016-09-07 03:25:24.231275[INFO][framework] change work dir to /home/neople/secsvr/zergsvr
2016-09-07 03:25:24.242952[INFO][framework] cfgsdk init succ. start task succ
2016-09-07 03:25:24.262906[INFO]Comm_Svrd_Config: load framework config succ.
2016-09-07 03:25:24.366093[DEBUG][framework] ZEN_Reactor and ZEN_Epoll_Reactor initialized.
2016-09-07 03:25:24.584365[INFO][framework] MMAP Pipe init success,gogogo.The more you have,the more you want.
2016-09-07 03:25:24.584692[DEBUG]log instance finalize .
------
//zerg:虫族
//sec agent:秒的代理
[program:secagent]
directory = /home/neople/secsvr/zergsvr
command = /home/neople/secsvr/zergsvr/secagent &




!!!!!
------
2016-09-07 03:26:30.510102[INFO][framework] zergsvr start init
2016-09-07 03:26:30.510160[INFO][framework] change work dir to /home/neople/secsvr/zergsvr
2016-09-07 03:26:30.510747[INFO][framework] cfgsdk init succ. start task succ
2016-09-07 03:26:30.598771[DEBUG][framework] ZEN_Reactor and ZEN_Epoll_Reactor initialized.
2016-09-07 03:26:30.599265[INFO][framework] MMAP Pipe init success,gogogo.The more you have,the more you want.
2016-09-07 03:26:30.599693[DEBUG]log instance finalize .
-------
[program:zergsvr]
directory = /home/neople/secsvr/zergsvr
command = /home/neople/secsvr/zergsvr/zergsvr -t30 -i1  &



[program:siroco]
directory = /home/neople/game
command = /home/neople/game/df_game_r siroco11 siroco52 siroco56 start &








cd /home/neople/stun
/home/neople/stun/df_stun_r start
cd /home/neople/relay/
/home/neople/relay/df_relay_r relay_200 relay_215 start
cd /home/neople/bridge/
/home/neople/bridge/df_bridge_r bridge start
cd /home/neople/channel/
/home/neople/channel/df_channel_r channel start
cd /home/neople/dbmw_guild/
/home/neople/dbmw_guild/df_dbmw_r dbmw_gld_siro start
cd /home/neople/guild
/home/neople/guild/df_guild_r gld_siro start
cd /home/neople/dbmw_mnt/
/home/neople/dbmw_mnt/df_dbmw_r dbmw_mnt_siro start
cd /home/neople/manager/
/home/neople/manager/df_manager_r manager start
cd /home/neople/monitor/
/home/neople/monitor/df_monitor_r mnt_siro start
cd /home/neople/dbmw_stat
/home/neople/dbmw_stat/df_dbmw_r dbmw_stat_siro start
cd /home/neople/auction
/home/neople/auction/df_auction_r ./cfg/auction_siro.cfg start ./df_auction_r
cd /home/neople/point
/home/neople/point/df_point_r ./cfg/point_siro.cfg start df_point_r
cd /home/neople/statics
/home/neople/statics/df_statics_r stat_siro start
cd /home/neople/coserver
/home/neople/coserver/df_coserver_r coserver start
cd /home/neople/community
/home/neople/community/df_community_r community start
cd /home/neople/secsvr/gunnersvr
/home/neople/secsvr/gunnersvr/gunnersvr -t30 -i1
cd /home/neople/secsvr/zergsvr
/home/neople/secsvr/zergsvr/secagent
cd /home/neople/secsvr/zergsvr
/home/neople/secsvr/zergsvr/zergsvr -t30 -i1
cd /home/neople/game
/home/neople/game/df_game_r siroco11 siroco52 siroco56 start





