#!/bin/sh

#  runs.sh
#  
#
#  Created by command.Zi on 16/9/16.
#

find /home/neople/ -name "*.pid"  | xargs rm -f

cd /home/neople/stun
/home/neople/stun/df_stun_r start &
sleep 4
cd /home/neople/relay/
/home/neople/relay/df_relay_r relay_200 relay_215 start &
sleep 4
cd /home/neople/relay/
/home/neople/relay/df_relay_r relay_215  start &
sleep 4
cd /home/neople/bridge/
/home/neople/bridge/df_bridge_r bridge start &
sleep 4
cd /home/neople/channel/
/home/neople/channel/df_channel_r channel start &
sleep 4
cd /home/neople/dbmw_guild/
/home/neople/dbmw_guild/df_dbmw_r dbmw_gld_siro start &
sleep 4
cd /home/neople/guild
/home/neople/guild/df_guild_r gld_siro start &
sleep 4
cd /home/neople/dbmw_mnt/
/home/neople/dbmw_mnt/df_dbmw_r dbmw_mnt_siro start &
sleep 4
cd /home/neople/manager/
/home/neople/manager/df_manager_r manager start &
sleep 4
cd /home/neople/monitor/
/home/neople/monitor/df_monitor_r mnt_siro start &
sleep 4
cd /home/neople/dbmw_stat
/home/neople/dbmw_stat/df_dbmw_r dbmw_stat_siro start &
sleep 4
cd /home/neople/auction
/home/neople/auction/df_auction_r ./cfg/auction_siro.cfg start ./df_auction_r &
sleep 4
cd /home/neople/point
/home/neople/point/df_point_r ./cfg/point_siro.cfg start df_point_r &
sleep 4
cd /home/neople/statics
/home/neople/statics/df_statics_r stat_siro start &
sleep 4
cd /home/neople/coserver
/home/neople/coserver/df_coserver_r coserver start &
sleep 4
cd /home/neople/community
/home/neople/community/df_community_r community start &
sleep 4
cd /home/neople/secsvr/gunnersvr
/home/neople/secsvr/gunnersvr/gunnersvr -t30 -i1  &
sleep 4
cd /home/neople/secsvr/zergsvr
/home/neople/secsvr/zergsvr/secagent &
sleep 4
cd /home/neople/secsvr/zergsvr
/home/neople/secsvr/zergsvr/zergsvr -t30 -i1  &
sleep 4
cd /home/neople/game
/home/neople/game/df_game_r siroco11 siroco52 siroco56 start &












