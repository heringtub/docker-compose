#!/bin/bash
docker stack rm splunk

HOST_LIST=(
    'root@172.16.0.12'
    'root@172.16.0.13'
    'root@172.16.0.14'
)
for HOST in ${HOST_LIST[*]};
do
    ssh ${HOST} 'rm -rf /opt/splunk'
    ssh ${HOST} 'mkdir -p /opt/splunk/etc /opt/splunk/var'
done

docker stack deploy -c splunk_cluster.yml splunk

ECHO=0
while true
do
    N=$(docker service logs splunk_server 2> /dev/null | grep "Waiting for web server at" 2> /dev/null | wc -l)
    if [[  ${N} -ge 3 ]]; then
        break
    else
        if [[  ${ECHO} -eq 0 ]]; then
            echo "Wait for the splunk server initialization to complete."
            ECHO=1
        fi
    fi
    sleep 1
done
sleep 5
docker service scale splunk_indexer01=1 splunk_indexer02=1 -d
