# 设置ELK运行主机
```
docker node update --label-add elk=true Docker-Work01
docker node update --label-add elk=true Docker-Work02
docker node update --label-add elk=true Docker-Work03
```

# 配置内核参数（elk节点，如上Docker-Work01、Docker-Work02、Docker-Work03折三个节点需要设置）
```
cat > /etc/sysctl.d/elk.conf << EOF
fs.file-max = 65536
vm.max_map_count = 262144
EOF
sysctl -p /etc/sysctl.d/elk.conf
```

# 配置资源限制参数，elk用户是Elasticsearch运行的用户（elk节点，如上Docker-Work01、Docker-Work02、Docker-Work03折三个节点需要设置）
```
cat > /etc/security/limits.d/elk.conf << EOF
*                soft    nofile          65536
*                hard    nofile          131072
*                soft    nproc           2048
*                hard    nproc           4096
EOF
echo "*          soft    nproc     4096" > /etc/security/limits.d/20-nproc.conf
```

# 修改数据目录所有者（共享存储）
```
chown -R 1000:1000 elasticsearch/data logstash/data
```

# 部署
```
docker network create -d overlay elk
docker stack deploy -c elk.yml elk
```