#!/bin/bash

# 修改为自己的文件位置
DIR_IP='/volume1/docker/best-cf-ip/ip.txt'
DIR_CONFIG='/volume1/docker/v2fly/config.json'

ip_new=`cat $DIR_IP`

ip_old=`cat config.json | grep address | cut -d\" -f4`

if [ ip_old = ip_new ]
then
    echo "毋需更换 IP"
else
    echo "需要更换 IP"
    # sed 使用双引号才能识别变量 $ip ; 双引号内部的双引号需要转义
    sed -i "s/\(\"address\":\)\(.*\)\(\",\)/\1${ip_new}\3/" $DIR_CONFIG
    # 重启 v2ray 使配置生效
    docker restart v2fly
    echo "已更换最新 IP"
fi
