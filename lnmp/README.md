# 部署LNMP

​	集群环境下，配置文件必须分发到所有 `lnmp=true` 的节点上，否则会出现文件挂在不上的问题，或者使用nfs也可以。

```shell
# 创建lnmp服务使用的网络
docker network create -d overlay lnmp
# 创建mysql数据目录
mkdir -p mysql/data
# 标记实例运行的节点
docker node update --label-add lnmp=true node01
docker node update --label-add mysql=true node01
# 部署应用
docker stack deploy -c lnmp.yml lnmp
```

​	服务访问链接：http://HOSTIP:80/phpinfo.php

​	数据库管理链接：http://HOSTIP:3000



# 更新 Nginx 版本

修改lnmp.yml中 Nginx 服务的Image字段，然后执行
```
docker stack deploy -c lnmp.yml lnmp
```
或者，执行下面的命令
```
docker service update --image nginx:1.13.8 --force -d lnmp_nginx
```

# 更新 Nginx 配置文件
替换 `nginx/nginx.conf` 并执行下面的命令
```
docker service update lnmp_nginx --force -d
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

# 更新 PHP 配置文件
修改 `php/php.ini` 或 将新文件放在 `php/ext` 目录下并执行下面的命令
```
docker service update lnmp_php --force -d
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