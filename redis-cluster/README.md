Redis集群架构使用的是哨兵

全部使用官方镜像，以挂载配置文件的方式配置容器里面的服务。

haproxy服务作为主从切换且是整个服务的入口。暴露6379端口

sentinel 作为redis主从架构的角色切换

启动：
```
docker network create -d overlay redis
docker stack deploy -c docker-compose.yml rediscluster
```
