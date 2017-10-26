# h5ai

```
docker-compose -p h5ai -f docker-compose.yaml up -d
chmod 777 www/_h5ai/private/cache www/_h5ai/public/cache
mkdir www/share/.ssh
touch authorized_keys
```
# 上传文件命令
```
scp -P 2222 authorized_keys root@xxx.xxx.xxx.xxx:/root/
```
