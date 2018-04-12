# 部署LNMP
```
docker network create -d overlay lnmp
mkdir mysql
docker node update --label-add lnmp=true node01
docker node update --label-add mysql=true node01
docker stack deploy -c lnmp.yml lnmp
```
# 更新 Nginx 配置文件

替换nginx目录下的nginx.conf

```
docker service update lnmp_nginx --force -d
```

# 更新 Nginx 版本
```
docker service update --image nginx:1.13.8 --force -d lnmp_nginx
```

# 更新 PHP 配置文件

替换nginx目录下的nginx.conf

```
docker service update lnmp_php --force -d
```

# 更新 PHP 版本
```
docker service update --image php:7.2.4-fpm-alpine3.7 --force -d lnmp_php
```