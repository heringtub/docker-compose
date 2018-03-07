# 基于Docker Swarm Cluster部署Splunk Cluster

如何安装Docker：略

如何配置Docker Swarm Cluster：略


节点：

Docker-Swarm-Splunk（主节点,10.3.236.31）

Docker-Swarm-index01（idnexer01节点）

Docker-Swarm-index02（idnexer02节点）

替换编排文件中的 `10.3.236.31` 为你的 `Splunk Master Node` IP地址

启动方法，查看 `uninstall-splunk.sh` 与 `uninstall-universalforwarder.sh` 脚本逻辑
