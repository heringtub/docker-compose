# 部署LNMP
```
docker network create -d overlay lnmp
mkdir -p mysql/data
docker node update --label-add lnmp=true node01
docker node update --label-add mysql=true node01
docker stack deploy -c lnmp.yml lnmp
```
# 更新 Nginx 配置文件
替换nginx目录下的nginx.conf

```
docker service update lnmp_nginx --force -d
```
# 更新 PHP 配置文件
替换nginx目录下的nginx.conf

```
docker service update lnmp_php --force -d
```

# 更新 Nginx 版本
修改lnmp.yml中 Nginx 服务的Image字段，然后执行
```
docker stack deploy -c lnmp.yml lnmp
```
或者，执行下面的命令
```
docker service update --image nginx:1.13.8 --force -d lnmp_nginx
```

# 更新 PHP 版本
修改lnmp.yml中 PHP 服务的Image字段，然后执行
```
docker stack deploy -c lnmp.yml lnmp
```
或者，执行下面的命令
```
docker service update --image php:7.2.4-fpm-alpine3.7 --force -d lnmp_php
```

# 迁移
准备新主机，并搭建好Swarm集群，然后在本项目上级目录执行命令
```
tar -zvcf lnmp.tar.gz lnmp
```

将压缩文件上传到新主机解压，并参考 `部署LNMP` 步骤，跳过第二步(mkdir -p mysql/data)，配置集群并部署环境
```
tar -zvxf lnmp.tar.gz
```
# 删除服务
```
docker stack rm lnmp
```
