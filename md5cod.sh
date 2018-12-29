#!/bin/bash
# By:cadi
#MD5验证

web="/home/wwwroot/default/"
one="/boot"
two="/usr"
three="/lib"
four="/etc"
webcod="/md5/web.cod"
datacod="/md5/data.cod"
webdb="/md5/web"
datadb="/md5/data"
webmd5="/md5/web.md5"
datamd5="/md5/data.md5"
rm -rf $webcod $datacod $webmd5 $datamd5
if [ ! -s $webdb -o ! -s $datadb ] ; then
echo "MD5源文件丢失，请生成源文件。"
exit 2
fi
#-------------监控文件
find $web  -type f | grep -E  "\.css|\.js|\.php" | xargs  md5sum > $webcod
find $one $two $three $four  -type f -print0 | xargs -0   md5sum > $datacod
if [ ! -s $webcod -o ! -s $datacod ] ; then
echo "获取MD5异常，请检查脚本是否出错。"
exit 2
fi
diff $webdb $webcod > $webmd5
diff $datadb $datacod > $datamd5
#------------对比结果
errorweb=`cat $webmd5`
errordata=`cat $datamd5`
if [ -s $webdm5 -o -s $datamd5 ] ; then
echo -e "WEB:\n$errorweb\nDATA:\n$errordata"
#------------异常处理（飞信，邮箱都可以）
#/usr/local/fx/fetion --mobile=123456 --pwd=123456 --to=123456 --msg-utf8="$error"
echo -e "WEB:\n$errorweb\nDATA:\n$errordata" | mail -s 警告:文件被修改
exit 2
fi
echo "Safety!!" | mail -s 安全:文件反馈
exit 0
