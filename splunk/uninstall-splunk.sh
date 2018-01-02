#!/bin/bash
docker stack rm splunk

HOST_LIST=(
    'root@10.3.236.50'
    'root@10.3.236.51'
    'root@10.3.236.52'
)
for HOST in ${HOST_LIST[*]};
do
    ssh ${HOST} 'rm -rf /opt/splunk'
    ssh ${HOST} 'mkdir -p /opt/splunk/etc /opt/splunk/var'
done

docker stack deploy -c splunk.yml splunk

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
