# 部署LNMP

​	集群环境下，自行解决共享存储问题（GFS、NFS），或者注释编排文件中 `placement` 配置

```shell
# 创建lnmp服务使用的网络
docker network create -d overlay lnmp

# 如果定义了容器运行的主机label请使用下面的命令标记，否则忽略
docker node update --label-add lnmp=true node01
docker node update --label-add mysql=true node01

# 部署应用
docker stack deploy -c lnmp.yml lnmp
```

​	服务访问链接：http://${HOSTIP}:10000/index.php

​	数据库管理链接：http://${HOSTIP}:10001

# 删除服务
```
docker stack rm lnmp
```