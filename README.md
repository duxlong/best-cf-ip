# best-cf-ip

## best-cf-ip.sh

docker best-cf-ip 中，每 1 小时运行，整点运行；

维护 ip.txt，保持高速 IP

## best-cf-ip-nas.sh

拷贝到 NAS 中，每 1 小时运行，首次运行时间 00:07，最后运行时间 23:07；

判断 IP 是否更新，如果更新了，则把新 IP 写入 config.json 再重启 docker v2fly

## github

https://github.com/duxlong/best-cf-ip

## docker hub

https://hub.docker.com/r/duxlong/best-cf-ip

## usage

docker pull
```
docker pull duxlong/best-cf-ip:latest
```

docker run
```
docker run -d \
    -v [your nas volume]:/root/res \
    --name="best-cf-ip" \
    duxlong/best-cf-ip
```
