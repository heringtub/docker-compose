```
docker network create -d overlay lnmp
mkdir mysql
docker node update --label-add lnmp=true node01
docker node update --label-add mysql=true node01
docker stack deploy -c lnmp.yml lnmp
```