#!/bin/bash
#By:cadi
#生成全盘md5

rm -rf /md5
mkdir /md5
#-------------项目路径
web="/home/wwwroot/default/"
one="/boot"
two="/usr"
three="/lib"
four="/etc"
#-------------监控文件
find $web  -type f  | grep -E  "\.css|\.js|\.php" | xargs  md5sum > /md5/web
find $one $two $three $four  -type f -print0 | xargs -0   md5sum > /md5/data
