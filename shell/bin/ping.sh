#!/bin/bash

# 检查 v2ray 的日志，在所有走代理的连接中，找出可以直接访问的域名

function try_ping() {
    if ping -c 10 -W 3 "$1" >>/dev/null 2>&1; then
        echo "$1"
    fi
}

ORIGINAL_IFS="$IFS"
IFS=$'\n'
HOSTNAMES=($(sudo cat /var/log/v2ray/access.log | grep proxy | awk '{ print $5 }' | awk '-F:' '{ print $2 }' | sort -u))
IFS="$ORIGINAL_IFS"

for hostname in ${HOSTNAMES[*]}; do
    try_ping "$hostname" &
done

wait
