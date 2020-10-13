FROM alpine

ENV DOCKERNAME="your-docker-v2ray-name"

RUN apk update && \
    apk add --no-cache bash curl fping docker && \
    curl https://raw.githubusercontent.com/duxlong/best-cf-ip/master/ip-core.txt > /root/ip-core.txt && \
    curl https://raw.githubusercontent.com/duxlong/best-cf-ip/master/best-cf-ip.sh > /root/best-cf-ip.sh && \
    chmod +x /root/best-cf-ip.sh && \
    echo "*/60 * * * * /bin/bash /root/best-cf-ip.sh" > /var/spool/cron/crontabs/root && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

WORKDIR /root

CMD /root/best-cf-ip.sh && crond -f
