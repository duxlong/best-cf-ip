FROM alpine

RUN apk update && \
    apk add --no-cache curl bash && \
    curl https://raw.githubusercontent.com/duxlong/best-cf-ip/master/best-cf-ip.sh > /root/best-cf-ip.sh && \
    chmod +x /root/best-cf-ip.sh && \
    echo "* * * * * /bin/bash /root/best-cf-ip.sh" > /var/spool/cron/crontabs/root && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

WORKDIR /root

# 必须 -f 前台运行
CMD crond -f
