#!/bin/bash
rpm -i https://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm


wget https://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+xenial_all.deb
dpkg -i zabbix-release_3.0-1+xenial_all.deb
apt update
apt-get install zabbix-agent

sed -i "s/^Server=.*/Server=10.0.3.11/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^ServerActive=.*/ServerActive=10.0.3.11/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^Hostname=.*/Hostname=Docker02/g" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^#.UnsafeUserParameters=.*/UnsafeUserParameters=1/g" /etc/zabbix/zabbix_agentd.conf
systemctl start zabbix-agent.service


HOST=$(docker service ps $1 --filter desired-state=running | awk '/Running/{print $4}')
ssh root@${HOST} "docker ps | awk \"/\$1/{print \$1}\""