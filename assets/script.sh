#!/bin/bash

sh ./copy.sh
### 执行远程 操作
ssh root@172.16.65.30 > /dev/null 2>&1 << yyssh
cd /home/yy-docker
docker rm -f yy-auth || true
docker rmi yy-auth:0.0.1 || true
docker build -t yy-auth:0.0.1 ./yy-auth
docker-compose up -d yy-auth
done
exit
yyssh