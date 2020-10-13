#!/bin/bash

# 必须 -f 前台运行
/root/best-cf-ip.sh && crond -f
