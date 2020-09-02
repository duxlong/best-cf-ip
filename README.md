# best-cf-ip

## 
定期（每小时）运行 best-cf-ip 以维护 ip.txt 保持高速 IP


```
docker run -d \
    -v /volume1/docker/best-cf-ip:/root \
    --name="best-cf-ip" \
    duxlong/best-cf-ip
```
