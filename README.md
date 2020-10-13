# best-cf-ip

## intro

配合 cloudflare & v2ray 使用

在 docker 运行，可以自动化定时更新 CloudFlare CDN 到自己设备最高速的 IP

运行原理是，容器开启时运行一次 best-cf-ip.sh，然后 crontab 每小时运行一次 best-cf-ip.sh

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
