#!/bin/bash

fping_count=30

start_seconds=$(date +%s)

echo "测试旧 IP 是否满足 30Mb/s"
if [ -f ip.txt ]; then
    ip=$(cat ip.txt)
    speed=$(($(curl --resolve speed.cloudflare.com:443:$ip https://speed.cloudflare.com/__down?bytes=1000000000 -o /dev/null -s -w '%{speed_download}\n' --connect-timeout 5 --max-time 15 | sed "s/.000//") / 1024 / 1024 * 8))
    if [ $speed -gt 30 ]; then
        echo "旧 IP 速度 ${speed}Mb/s 满足要求！"
        exit 1
    else
        speed=$(($(curl --resolve apple.freecdn.workers.dev:443:$ip https://apple.freecdn.workers.dev/105/media/us/iphone-11-pro/2019/3bd902e4-0752-4ac1-95f8-6225c32aec6d/films/product/iphone-11-pro-product-tpl-cc-us-2019_1280x720h.mp4 -o /dev/null -s -w '%{speed_download}\n' --connect-timeout 5 --max-time 15 | sed "s/.000//") / 1024 / 1024 * 8))
        if [ $speed -gt 30 ]; then
            echo "旧 IP 速度 ${speed}Mb/s 满足要求！"
            exit 1
        fi
    fi
fi

echo "初始化文件"
rm ip-random.txt
rm ip-100.txt
rm ip-3.txt
rm ip-tmp.txt
rm ip
rm /tmp/*

echo "1.依据 ip-core.txt 制造随机 ip 并保存到 ip-random.txt"
for ip in $(cat ip-core.txt); do
    r=$((($RANDOM * 2 + 1) % 255))
    echo $ip | sed "s/.$/$r/" >>ip-random.txt
done

echo "2.使用 fping 选取 100 个丢包最少的 IP"
fping -f ip-random.txt -c $fping_count -i 0 | grep "\[$(($fping_count - 1))\]" | sort -n -k 10 | head -100 >ip-100.txt

echo "3.使用 curl 下载到 /tmp 的方法找到最快的 3 个 IP"
for ip in $(cat ip-100.txt | awk '{print $1}'); do
    curl --resolve speed.cloudflare.com:443:$ip https://speed.cloudflare.com/__down?bytes=1000000000 -o /tmp/$ip -s --connect-timeout 2 --max-time 10 &
    sleep 0.5
done
sleep 10
ls -S /tmp | head -3 >ip-3.txt
rm -rf /tmp/*

echo "4.使用 curl 对 ip-3.txt 测速两次，保存到 ip-tmp.txt"
for ip in $(cat ip-3.txt); do
    curl --resolve speed.cloudflare.com:443:$ip https://speed.cloudflare.com/__down?bytes=1000000000 -o /dev/null -s -w '%{speed_download}\n' --connect-timeout 5 --max-time 15 | sed "s/.000/\t$ip/" >>ip-tmp.txt
    sleep 0.5
    curl --resolve apple.freecdn.workers.dev:443:$ip https://apple.freecdn.workers.dev/105/media/us/iphone-11-pro/2019/3bd902e4-0752-4ac1-95f8-6225c32aec6d/films/product/iphone-11-pro-product-tpl-cc-us-2019_1280x720h.mp4 -o /dev/null -s -w '%{speed_download}\n' --connect-timeout 5 --max-time 15 | sed "s/.000/\t$ip/" >>ip-tmp.txt
    sleep 0.5
done

echo "5.从 ip-tmp.txt 中选择最快的 IP"
last=$(cat ip-tmp.txt | sort -r -n -k 1 | head -1)
last_ip=$(echo $last | awk '{print $2}')
last_speed=$(($(echo $last | awk '{print $1}') / 1024 / 1024 * 8))
echo $last_ip >ip.txt

# 修改

end_seconds=$(date +%s)
echo "$last_ip 满足要求，速度是 ${last_speed}Mb/s，耗时 $(($end_seconds - $start_seconds)) 秒！"
