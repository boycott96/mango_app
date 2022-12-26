#!/bin/bash

file_name="yy-auth"
#file_name="yy-gateway"
scp /Users/sun/IdeaProjects/yeyang/yy-app/$file_name/target/$file_name.jar root@172.16.65.30:/home/yy-docker/$file_name/
### 执行远程 操作
ssh root@172.16.65.30 > /dev/null 2>&1 << yyssh
cd /home/yy-docker
docker rm -f $file_name || true
docker rmi $file_name:0.0.1 || true
docker build -t $file_name:0.0.1 ./$file_name
docker-compose up -d $file_name
done
exit
yyssh