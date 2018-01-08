# 基于Docker Swarm Cluster部署Splunk Cluster



如何安装Docker：略

如何配置Docker Swarm Cluster：略

安装NFS：略

挂载NFS目录：略



节点：

Docker-Swarm-Splunk（主节点）

Docker-Swarm-index01（idnexer01节点）

Docker-Swarm-index02（idnexer02节点）

Docker-Swarm-NFS（后端存储）



Docker-Swarm-NFS搭建NFS服务，挂载点为`/nfs`

Docker-Swarm-Splunk，Docker-Swarm-index01，Docker-Swarm-index02节点挂载NFS服务器的`/nfs`目录

启动方法，查看 `uninstall-splunk.sh` 与 `uninstall-universalforwarder.sh` 脚本逻辑



