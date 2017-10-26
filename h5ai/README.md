# h5ai

```
docker-compose -p h5ai -f docker-compose.yaml up -d
chmod 777 www/_h5ai/private/cache www/_h5ai/public/cache
mkdir www/share/.ssh
touch authorized_keys

scp -P 2222 filename root@xxx.xxx.xxx.xxx:/root/
```
