# best-cf-ip

## intro

配合 cloudflare & v2ray 使用

在 docker 运行，可以自动化定时更新 CloudFlare CDN 到自己设备最高速的 IP

运行原理是，容器开启时运行一次 best-cf-ip.sh，然后 crontab 每小时运行一次 best-cf-ip.sh

ip-total.txt 网友总结的 cloudflare ips

ip-core.txt 我排除了一些对我来说肯定没速度的 ips

## github

https://github.com/duxlong/best-cf-ip

## docker hub

https://hub.docker.com/r/duxlong/best-cf-ip

## usage

docker pull
```
docker pull duxlong/best-cf-ip:latest
```

docker run（根据自己的情况修改）
```
docker run -d \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -v /volume1/docker/v2fly:/root/v2ray \
    --name="best-cf-ip" \
    duxlong/best-cf-ip
```

 `-v /var/run/docker.sock:/var/run/docker.sock:ro` 是为了在容器内操作其他容器

`-v /volume1/docker/v2fly:/root/v2ray` 为了方便修改 v2ray config 文件
