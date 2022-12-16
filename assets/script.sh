#!/bin/bash

sh ./copy.sh
### 执行远程 操作
ssh root@172.16.65.30 > /dev/null 2>&1 << yyssh
cd /home/yy-docker
docker rm -f yy-gateway || true
docker rmi yy-gateway:0.0.1 || true
docker build -t yy-gateway:0.0.1 ./yy-gateway
docker-compose up -d yy-gateway
done
exit
yyssh